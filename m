Received: from eggs.gnu.org ([2001:4830:134:3::10]:56131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIZxL-00060i-0m
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIZxJ-00034P-6I
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:25:30 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIZxI-000344-Vx
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:25:29 -0400
Received: by mail-oi0-x244.google.com with SMTP id k17-v6so113993oih.5
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:25:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <99693ba4-c282-a10b-e811-697617f7ee06@weilnetz.de>
References: <20180513090613.27960-1-sw@weilnetz.de>
	<cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
	<CAFEAcA9kcKb28uQJOnqCAC4Gf9b7Hnu0wJbG1nHQLF4U1T9sKA@mail.gmail.com>
	<99693ba4-c282-a10b-e811-697617f7ee06@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 14:25:07 +0100
Message-ID: <CAFEAcA81y1r5N2zi5fPoV5iZ9dd0YBeThcX=qXdJXdNSNO8nsA@mail.gmail.com>
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
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 15 May 2018 at 14:13, Stefan Weil <sw@weilnetz.de> wrote:
> This is fixed in upstream vixl, in fact:
>
> https://git.linaro.org/arm/vixl.git/commit/?id=de326f850f736c3a337fda52845ed3d2e620cc02
>
> That fix will work for the moment, but is not sufficient for the future
> because it only supports gcc 7.x, but not gcc 8.x or later:
>
> +#elif __GNUC__ == 7
>
> How do we proceed with the code in QEMU? Do you have a plan to update the
> vixl code? As vixl is obviously no longer maintained on GitHub, I am not
> sure whom I could contact.

The github page points you to the linaro repo which is the new upstream.
That said, I think we're planning to deprecate vixl now we have the
capstone support. Richard, what's the status here? Could we just remove
the vixl code now?

> And what about my other question / suggestion:
>
> "I suggest to add and use a similar macro QEMU_FALLTHROUGH() for the rest of
> the code and can provide a patch if that's fine for everyone."
>
> gcc gives lots of fallthrough warnings, and many code locations don't
> contain a comment stating that the fall through is fine.

I guess that having the compiler check is better than finding them
later with coverity. It's a shame gcc doesn't support the standard
mechanism of using /* fallthrough */ to mark these, though.

thanks
-- PMM
