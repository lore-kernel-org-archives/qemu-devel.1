Received: from eggs.gnu.org ([2001:4830:134:3::10]:58050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDDnC-0000v2-9f
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDDn8-0008EO-R2
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:12:38 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eDDn8-0008DU-Mj
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:12:34 -0500
Date: Fri, 10 Nov 2017 13:12:33 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171110181233.GB17844@flamenco>
References: <cover.1510263731.git.alistair.francis@xilinx.com>
	<e23ac66f6ca0ac1b1bf89350e2b3a36a13e52957.1510263731.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23ac66f6ca0ac1b1bf89350e2b3a36a13e52957.1510263731.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH for 2.11 v2 1/2] xlnx-zynqmp: Properly
 support the smp command line option
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

On Thu, Nov 09, 2017 at 13:49:33 -0800, Alistair Francis wrote:
> Allow the -smp command line option to control the number of CPUs we
> create.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>
Tested-by: Emilio G. Cota <cota@braap.org>

As I said in the other thread, this is much better than fiddling with
MachineClass -- thanks!

I'll send now a proper series with the fixes we discussed in the other
thread:
  https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00502.html

		Emilio
