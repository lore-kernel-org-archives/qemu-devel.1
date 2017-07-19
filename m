Received: from eggs.gnu.org ([2001:4830:134:3::10]:55997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXrnC-0005hO-MG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXrnB-0003yG-Or
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:25:42 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXrnB-0003xK-4c
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:25:41 -0400
Received: by mail-wm0-x234.google.com with SMTP id l81so1261946wmg.1
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 09:25:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3fe1df9e-6b49-621f-53b6-271fd2f77305@adacore.com>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<bb8781a1-602b-d77d-a103-6f8d23d7ff5f@adacore.com>
	<20170719122943.GJ2103@work-vm>
	<3fe1df9e-6b49-621f-53b6-271fd2f77305@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 17:25:19 +0100
Message-ID: <CAFEAcA83H+9b2t2MhE0wDCDK_-DuPSuBZrzbQrevhjCh1SEBDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 19 July 2017 at 17:22, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
> Scary.. Yes your right. I still think it doesn't need to be
> migrated.. But how..
>
> BTW taking a look at this I found the comment below which seems
> to implies that the content won't be migrated?

That's a comment that I added just recently under a
slight misapprehension. Once we've figured out what
the right thing is we can fix it, or make the code do
what the comment says.

The actual current situation is "this function does nothing
to ensure the RAMBlock is correctly migrated, so if you
do nothing then you'll wind up with migration being silently
broken, if more than one thing is doing this at once in
the system, but if one and only one RAMblock is in this
situation then it'll work by luck". Which is definitely not
behaviour we are doing on purpose :-)

thanks
-- PMM
