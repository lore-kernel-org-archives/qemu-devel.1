Received: from eggs.gnu.org ([209.51.188.92]:43871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw9U4-0007iK-Bc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw9U2-0007tG-Ee
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:47:08 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw9U0-0007kV-LG
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:47:05 -0500
Received: by mail-ot1-x343.google.com with SMTP id t7so19244082otk.8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20190215192302.27855-1-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 17:46:38 +0000
Message-ID: <CAFEAcA8vxWuhv5Nkz+EhmH5fw7bLCe0WGOF1ZbqgER-8bT7NRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/8] target/arm: Implement
 ARMv8.3-JSConv & ARMv8.2-FHM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 15 Feb 2019 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
>
> Changes since v3:
>
> Rebased on master, and combined the JSConv and FHM patch sets.
> There were a number of patch conflicts which needed fixing up.
>
> Changes since v2:
>
> Patch 2 splits out vfp_helper.c, which I wrote for something else.
> But while rebasing it occured to me that helper_vjcvt is better placed
> in vfp_helper.c than op_helper.c, so why not include it here and now.
>
> Patch 3 corresponds to the v2 patch 1, but totally rewritten.  What
> I missed the first time around is that register Sn is encoded differenly
> than Dn, so merely setting dp = 0 doesn't help because we've already
> decoded the register number incorrectly.  Therefore, replace some really
> ugly if conditions and set some variables as appropriate.
>
> Patch 4 is adjusted to match the change in decode from patch 2, and
> putting the aa32 flags in the right place.

I've applied patches 1-4 to target-arm.next; patches 5, 6, 8 I've
commented on. 7 I'll leave until you've dealt with the fpstatus
stuff in your next version of the patchset.

thanks
-- PMM
