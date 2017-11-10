Received: from eggs.gnu.org ([2001:4830:134:3::10]:34030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDEBX-0005Xb-D1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDEBU-0001ij-9J
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:37:47 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eDEBU-0001iS-2P
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:37:44 -0500
Date: Fri, 10 Nov 2017 13:37:41 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171110183741.GA23011@flamenco>
References: <cover.1510263731.git.alistair.francis@xilinx.com>
	<b2df555986423d225a0a79fb58e2a93054ac5300.1510263731.git.alistair.francis@xilinx.com>
	<20171110180722.GA17844@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171110180722.GA17844@flamenco>
Subject: Re: [Qemu-devel] [PATCH for 2.11 v2 2/2] xlnx-zcu102: Add an info
 message deprecating the EP108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, ehabkost@redhat.com, f4bug@amsat.org

On Fri, Nov 10, 2017 at 13:07:22 -0500, Emilio G. Cota wrote:
> On Thu, Nov 09, 2017 at 13:49:35 -0800, Alistair Francis wrote:
> > The EP108 was an early access development board that is no longer used.
> > Add an info message to convert any users to the ZCU102 instead. On QEMU
> > they are both identical.
> > 
> > This patch also updated the qemu-doc.texi file to indicate that the
> > EP108 has been deprecated.
> > 
> > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> 
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> 
> Note to potential reviewers: This patch is meant to be applied after the
> patch that updates ep108's max_cpus from 1 to NR_APUS + NR_RPUS, for
> otherwise the message added here won't be seen unless -smp == 1.
> This other patch is already in target-arm.next:
>  https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg06537.html

Correction: that patch does updates the zcu102, not the ep108.

I think we should update max_cpus for ep108 as well.

		Emilio
