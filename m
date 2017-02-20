Received: from eggs.gnu.org ([2001:4830:134:3::10]:51269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsingharora@gmail.com>) id 1cfgpW-0001vV-Nj
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 00:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsingharora@gmail.com>) id 1cfgpW-00040e-5d
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 00:48:10 -0500
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 20 Feb 2017 16:47:56 +1100
Message-ID: <20170220054756.GB661@balbir.ozlabs.ibm.com>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-3-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487563478-22265-3-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 02/10] target/ppc:
 Fix LPCR DPFD mask define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On Mon, Feb 20, 2017 at 03:04:30PM +1100, Suraj Jitindar Singh wrote:
> The DPFD field in the LPCR is 3 bits wide. This has always been defined
> as 0x3 << shift which indicates a 2 bit field, which is incorrect.
> Correct this.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
