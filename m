Received: from eggs.gnu.org ([2001:4830:134:3::10]:43164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=687e870ee=anthony.perard@citrix.com>)
	id 1fQFEq-0003o7-2V
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=687e870ee=anthony.perard@citrix.com>)
	id 1fQFEm-0003XO-Rc
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:55:16 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:26132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=687e870ee=anthony.perard@citrix.com>)
	id 1fQFEm-0003Uc-Ib
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:55:12 -0400
Date: Tue, 5 Jun 2018 17:55:07 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180605165507.GB2165@perard.uk.xensource.com>
References: <20180601175910.28146-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180601175910.28146-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [RFC] xen: Don't use
 memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Fri, Jun 01, 2018 at 06:59:10PM +0100, Peter Maydell wrote:
> The xen pci_assign_dev_load_option_rom() currently creates a RAM
> memory region with memory_region_init_ram_nomigrate(), and then
> manually registers it with vmstate_register_ram(). In fact for
> its only callsite, the 'owner' pointer we use for the init call
> and the '&dev->qdev' pointer we use for the vmstate_register_ram()
> call refer to the same object. Simplify the function to only
> take a pointer to the device once instead of twice, and use
> memory_region_init_ram() which automatically does the vmstate
> register for us.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is a fairly trivial no-behaviour-change code cleanup, but
> I've marked it as RFC because I don't have a setup for doing
> more than just compile-testing Xen related patches.
> This was found as part of a sweep through for code using
> the _nomigrate versions of functions.

That patch looks fine, and seams fine after hacking my way into testing
the change.

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
