Received: from eggs.gnu.org ([2001:4830:134:3::10]:53951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcir-0002Fy-QK
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcir-0005Tt-0Y
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:34:53 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJciq-0005Td-Rg
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:34:52 -0400
Received: by mail-oi0-x242.google.com with SMTP id a6-v6so6685627oia.2
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 03:34:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <291b8b6f-1692-a5ee-f44c-4f8c4dd614fa@twiddle.net>
References: <20180513090613.27960-1-sw@weilnetz.de>
	<cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
	<CAFEAcA9kcKb28uQJOnqCAC4Gf9b7Hnu0wJbG1nHQLF4U1T9sKA@mail.gmail.com>
	<99693ba4-c282-a10b-e811-697617f7ee06@weilnetz.de>
	<CAFEAcA81y1r5N2zi5fPoV5iZ9dd0YBeThcX=qXdJXdNSNO8nsA@mail.gmail.com>
	<291b8b6f-1692-a5ee-f44c-4f8c4dd614fa@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 11:34:31 +0100
Message-ID: <CAFEAcA_REPB2kdppWCo+YbBekLp+FfPVr_rvWVQU2F=H1EsOCA@mail.gmail.com>
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
>> That said, I think we're planning to deprecate vixl now we have the
>> capstone support. Richard, what's the status here? Could we just remove
>> the vixl code now?
>
> We could just remove vixl, yes.  I'd like to see updates to capstone to support
> instructions post v8.0, but it's not like we have those with vixl either...

Just to check my understanding: with QEMU at the moment, you
always get the capstone disassembler unless you specifically
turn it off by passing --disable-capstone to configure, right
(since we provide it as a submodule)?

We put that in in September last year, and we haven't had a
pile of complaints about the disassembly (or indeed any
complaints that I can recall), so I think we can consider it
a success, and remove both vixl and the ancient binutils arm
disassembler.

It would also be interesting to try interacting with capstone
upstream about adding support for newer instructions (for
instance they don't do the v8M insns). Do you know if capstone
deals with new insns via resync from LLVM or if they've
entirely forked and just make changes locally by hand?

thanks
-- PMM
