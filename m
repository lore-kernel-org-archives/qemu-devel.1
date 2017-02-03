Received: from eggs.gnu.org ([2001:4830:134:3::10]:53112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZguU-0000Oa-1l
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZguT-0005oV-1p
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:40:30 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZguS-0005nT-Pq
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:40:28 -0500
Received: by mail-wm0-x234.google.com with SMTP id r141so35212634wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 08:40:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 16:40:07 +0000
Message-ID: <CAFEAcA8Q3Z60HK3Swt+Z18naZP=VJw4nxdrnpUJbTu-UhiQsog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 0/7] ARM BE8/BE32 big-endian system-mode
 fixes (semihosting, gdbstub)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 16:30, Julian Brown <julian@codesourcery.com> wrote:
> This is the third iteration of a series of patches to implement
> semihosting/gdbstub support for big-endian ARM system mode. The previous
> series started here:
>
>   http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00972.html
>
> I've (hopefully!) addressed all the comments from the second round of
> reviews, apologies in advance if I've missed anything.
>
> Thanks,
>
> Julian
>
> Julian Brown (7):
>   Add cfgend parameter for ARM CPU selection.
>   Honour reset_sctlr EE/B bits during reset.
>   Move target_memory_rw_debug function.
>   ARM big-endian semihosting support.
>   ARM big-endian system-mode gdbstub support.
>   Fix Thumb-1 BE32 execution and disassembly.
>   ARM BE32 watchpoint fix.

So to summarise:
I'm taking patches 1 (with some tweaks), 6 and 7 into target-arm.next.
2 isn't required. 3 is OK but should go in with the patches that
use it. 4 and 5 still need some work.

thanks
-- PMM
