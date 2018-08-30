Received: from eggs.gnu.org ([2001:4830:134:3::10]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1fvB8B-0003RU-RG
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 20:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1fvB88-0008Pi-F8
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 20:48:15 -0400
Received: from resqmta-po-09v.sys.comcast.net
	([2001:558:fe16:19:96:114:154:168]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eager@eagerm.com>) id 1fvB88-0008PZ-95
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 20:48:12 -0400
From: Michael Eager <eager@eagerm.com>
References: <f38111ad-3fbb-210e-e7ec-49ae675ea65e@eagerm.com>
Message-ID: <a57fdd27-7a86-3f31-341c-e98101d17b9a@eagerm.com>
Date: Wed, 29 Aug 2018 17:48:07 -0700
MIME-Version: 1.0
In-Reply-To: <f38111ad-3fbb-210e-e7ec-49ae675ea65e@eagerm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V - Dynamic parameterization of
 RISC-V memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Eager <eager@eagercon.com>

Whoops.  I just noticed that this patch is against the riscv-qemu
repo on github, not the qemu.org repo.  I will rework it for the 
qemu.org repo.  Meanwhile, I welcome any comments.

On 08/29/2018 05:21 PM, Michael Eager wrote:
> Memory parameters for RISC-V boards can be read from a configuration
> file using the -readconfig command line option.  The configuration file
> should have a section for the board and memory.  The configuration for
> the VirtIO board has the following configuration variables:
> [riscv-virt-mem]
>    debug-base   = "0x0"
>    debug-size   = "0x100"
>    mrom-base    = "0x1000"
>    mrom-size    = "0x11000"
>    test-base    = "0x100000"
>    test-size    = "0x1000"
>    clint-base   = "0x2000000"
>    clint-size   = "0x10000"
>    plic-base    = "0xc000000"
>    plic-size    = "0x4000000"
>    uart0-base   = "0x10000000"
>    uart0-size   = "0x100"
>    virtio-base  = "0x10001000"
>    virtio-size  = "0x1000"
>    dram-base    = "0x80000000"
>    dram-size    = "0x0"
> 
> Values must be enclosed within quotes.
> 
> Signed-off-by: Michael Eager <eager@eagercon.com>
> 

-- 
Michael Eager    eager@eagerm.com
1960 Park Blvd., Palo Alto, CA 94306
