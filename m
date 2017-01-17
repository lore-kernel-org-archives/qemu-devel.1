Received: from eggs.gnu.org ([2001:4830:134:3::10]:34801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTSok-0007Da-Vc
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTSoh-0007cD-4c
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:24:50 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:34585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTSog-0007c6-Vh
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:24:47 -0500
Received: by mail-ua0-x231.google.com with SMTP id 35so101369836uak.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 04:24:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87h94x99e4.fsf@dusky.pond.sub.org>
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	<87pojmjdep.fsf@dusky.pond.sub.org>
	<CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
	<87h94x99e4.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 12:24:25 +0000
Message-ID: <CAFEAcA8vRw=13Lj_98A+3NovSeTg6e0xBopdz9EcdEeUMjjZow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2017 at 12:08, Markus Armbruster <armbru@redhat.com> wrote:
> Right now, that'll make no difference whatsoever, because the programs
> that choke on -D generate no output for the commands using the variable
> defined with -D.  All they do is gripe.
>
> Three possible solutions, in increasing order of complexity:
>
> 1. Live with the warning from old versions.  If a new version comes
> around that does something with @subtitle, it'll just work.
>
> 2. Suppress the warning with @iftex-hammer.  No change in output now.
> If a new version comes around that does something with @subtitle, we
> won't profit unless we take out the @iftex.
>
> 3. Replace -D by @set, either by preprocessing .texi, or by including a
> generated snippet.  No change in output now.  If a new version comes
> around that does something with @subtitle, it'll just work.
>
> My order of preference is aligned with decreasing complexity, i.e. first
> 1., then 2., then 3.
>
> Please tell me what you want.
>
> If you want 3., I can certainly live with it, but I'd rather do 1. or
> 2. now, to get my rather conflict-prone pull request in, then do 3. as a
> follow-up patch.

Yeah, I think it's reasonable to apply this now and then
fix up the warnings afterwards, since they don't break the
build. I'll do that.

In terms of what I'd like for the VERSION issue:

(1) if it doesn't actually cause a change in the output, we
should either just delete the use of VERSION entirely, or move
it to somewhere outside of @subtitle which does actually
appear somewhere. There's no point in putting in the version
info if it doesn't get into the final output, whether
it generates a warning or not.

(2) If we want to display VERSION then we need to use @set,
it looks like.

thanks
-- PMM
