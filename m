Received: from eggs.gnu.org ([2001:4830:134:3::10]:51841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIbJ7-0007FR-Ha
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIbJ6-0008QO-Mc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:52:05 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIbJ6-0008Pl-Hn
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:52:04 -0400
Received: by mail-ot0-x243.google.com with SMTP id t1-v6so495986oth.8
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 07:52:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <291b8b6f-1692-a5ee-f44c-4f8c4dd614fa@twiddle.net>
References: <20180513090613.27960-1-sw@weilnetz.de>
	<cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
	<CAFEAcA9kcKb28uQJOnqCAC4Gf9b7Hnu0wJbG1nHQLF4U1T9sKA@mail.gmail.com>
	<99693ba4-c282-a10b-e811-697617f7ee06@weilnetz.de>
	<CAFEAcA81y1r5N2zi5fPoV5iZ9dd0YBeThcX=qXdJXdNSNO8nsA@mail.gmail.com>
	<291b8b6f-1692-a5ee-f44c-4f8c4dd614fa@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:51:42 +0100
Message-ID: <CAFEAcA_WPidxh81a9vgCTm2fe3G_zKybNTfA0PFGYn=UKFfxGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] disas/libvixl: Fix VIXL_FALLTHROUGH macro
 for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 15 May 2018 at 15:46, Richard Henderson <rth@twiddle.net> wrote:
> On 05/15/2018 06:25 AM, Peter Maydell wrote:
>> I guess that having the compiler check is better than finding them
>> later with coverity. It's a shame gcc doesn't support the standard
>> mechanism of using /* fallthrough */ to mark these, though.
>
> It does.  Apparently not by default anymore, however:
>
> @item @option{-Wimplicit-fallthrough=0} disables the warning altogether.
>
> @item @option{-Wimplicit-fallthrough=1} matches @code{.*} regular
> expression, any comment is used as fallthrough comment.
>
> @item @option{-Wimplicit-fallthrough=2} case insensitively matches
> @code{.*falls?[ \t-]*thr(ough|u).*} regular expression.
>
> @item @option{-Wimplicit-fallthrough=3} case sensitively matches one of the
> following regular expressions:
> ...
>
> I think either =2 or =1 would work for us in QEMU.

1 sounds too broad, we don't want any old comment to count.
2 is probably what we want.

thanks
-- PMM
