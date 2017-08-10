Received: from eggs.gnu.org ([2001:4830:134:3::10]:52263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfjgU-0005Na-3N
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfjgS-0005Gp-S0
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:23:18 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfjgS-0005GC-LJ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:23:16 -0400
Received: by mail-wm0-x22e.google.com with SMTP id i66so17118947wmg.0
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 02:23:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170810104604.342af354.cohuck@redhat.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org>
	<87mv7aumav.fsf@linaro.org>
	<8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
	<87fud0vmak.fsf@linaro.org>
	<3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
	<20170810104604.342af354.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2017 10:22:54 +0100
Message-ID: <CAFEAcA-GP53g+vfgDH1mNQnPHcrNULb+gkQk4JeJhb=8UCt+YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 18/47] MAINTAINERS: add missing TCG entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 10 August 2017 at 09:46, Cornelia Huck <cohuck@redhat.com> wrote:
> The root problem is "some files have no maintainers". The reasons range
> from "forgot to include the file in the pattern" (easily fixed), over
> "file is updated via a script" (the linux-headers case), to "nobody
> feels up to the task" (which is the worst case).
>
> In most cases, I don't think the recent contributors list is very
> helpful. Somebody who simply did a tree-wide rename is unlikely to be
> able to make a good judgment about a complicated logic change. Just
> printing qemu-devel as the address to send this to is probably better;
> unfortunately, it may cause patches to languish on the list if nobody
> takes pity on them.
>
> Do we need someone collecting non-trivial patches like that, who either
> pesters others or picks up the patches themselves?

The problem is that if nobody's feeling up to the task of taking
on a particular single file which has no maintainer, then it's
definitely true that nobody's going to feel up to taking on
the entire collection of unmaintained files...

I think the UI (giving no consideration to how we might implement
this!) would ideally be something like:
 * if anybody mails a patch which touches an "unmaintained" file,
   a robot should send a reply along the lines of "thanks for the
   patch; unfortunately file X is not maintained so it may be
   tricky to get patch review for this. You'll need to be
   persistent and do more of the legwork than if you were patching
   a file that did have an active maintainer" so contributors
   know when they've wandered into the swamp
 * some mechanism for easily finding patches to unmaintained
   files which haven't got review yet, so that anybody with some
   spare time and interest can move some of them along (the idea
   being to spread the load rather than trying to designate a
   particular "owner" for this headache)
 * ditto for finding patches to unmaintained files which have got
   review but which haven't been committed

thanks
-- PMM
