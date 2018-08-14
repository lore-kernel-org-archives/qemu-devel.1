Received: from eggs.gnu.org ([2001:4830:134:3::10]:36890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fpWNz-0002Ua-2k
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fpWNu-00073o-JT
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:17:11 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fpWNu-00073M-AO
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:17:06 -0400
Received: by mail-wm0-x241.google.com with SMTP id n11-v6so11623735wmc.2
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 03:17:06 -0700 (PDT)
References: <1528768140-17894-1-git-send-email-cota@braap.org>
	<20180813200116.GA18755@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180813200116.GA18755@flamenco>
Date: Tue, 14 Aug 2018 11:17:03 +0100
Message-ID: <87d0ulfe1s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/14] fp-test + hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Jun 11, 2018 at 21:48:46 -0400, Emilio G. Cota wrote:
>> Sending this respin (little more than a rebase) in case there's
>> reviewer bandwidth available until the soft-freeze in 3 weeks.
>
> *ping*
>
> Would be great to get this in for 3.1.

I would like this merged by 3.1 as well. However I think there is still
some work to be done on the testing side. IIRC the fptest case works
with whitelists and I'd like to understand more about why we can't use
the whole test corpus? Is it testing features we don't have on all
architectures or just because it wouldn't pass because of holes in our
current softfloat?

Our experience of SVE has shown that despite the fairly extensive
testing we did there are still a bunch of corner cases we missed.
Hopefully the last few patches have fixed that but I guess it pays to be
exhaustive.

We now have the check-tcg infrastructure in place so it would be nice to
have proper native tests in place for each architecture. My experience
of the fcvt.c test case however is you end up using inline assembler to
ensure you exercise the right guest opcodes which makes it hard to
generalise for lots of architectures. I had written a bunch of patches
against the fptest to get it built under check-tcg but it was painful:

  * a bit hacky to build as unit test and as tcg test
  * needed a lot of boilerplate for each new operation

> BTW I have a paper under submission that covers this work among
> other improvements to QEMU. Reading this paper might ease a
> subsequent review of this patch series; ask me privately if
> you want to get a copy.
>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
