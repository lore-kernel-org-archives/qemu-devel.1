Received: from eggs.gnu.org ([2001:4830:134:3::10]:55032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfjsZ-0002Hi-Ha
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfjsY-0003dm-AF
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:35:47 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfjsX-0003dA-TC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:35:46 -0400
Received: by mail-wm0-x233.google.com with SMTP id f15so17362314wmg.1
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 02:35:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org>
	<87mv7aumav.fsf@linaro.org>
	<8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
	<87fud0vmak.fsf@linaro.org>
	<3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2017 10:35:24 +0100
Message-ID: <CAFEAcA80HQXTgLUUb4LjM+Vw=7ZTj09rbCsiyvC07GN+NywM_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/47] MAINTAINERS: add missing TCG entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 9 August 2017 at 22:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> I wonder if I'm understanding correctly what the MAINTAINERS file is for =
and
> how to use it.
>
> From an submitter view I feel a bit confused. I thought ./get_maintainer.=
pl
> would give me the list of person to email the changes I did on some file
> from the repository. This script seems correctly named, I'm looking for s=
ome
> ./get_reviewers.pl instead, to know who I'v to keep updated, apart from t=
he
> ./get_maintainer.pl.
>
> currently we have:
> "M: Mail patches to: FullName <address@domain>"
> Does this imply FullName is a maintainer?

Does it matter? As a contributor, what you want to know is
"who cares enough about this file to be worth cc'ing, if anybody",
and get_maintainer.pl does that for you.
Hopefully at least one of those people is also in a position
to shepherd the patch through into git master, but that doesn't
affect what you need to do as a patch submitter.
If anybody cares enough about a particular area of the codebase
to want to be cc'd on all patches so they can review them, then
to my mind that makes them effectively a co-maintainer on those
files, and they can be listed in MAINTAINERS.

> If so is it ok I do this change:
>
> -    M: Mail patches to: FullName <address@domain>
> +    M: Maintainer: FullName <address@domain>
> +       These maintainers must be mailed on patches.
>      R: Designated reviewer: FullName <address@domain>
>         These reviewers should be CCed on patches.
>
>
> actual default for un-matched: "recent contributors" + qemu-devel@
>
>   $ ./scripts/get_maintainer.pl -f disas.c
>   get_maintainer.pl: No maintainers found, printing recent contributors.
>   get_maintainer.pl: Do not blindly cc: them on patches!  Use common sens=
e.
>   Peter Maydell <peter.maydell@linaro.org> (commit_signer:2/3=3D67%)
>   Richard Henderson <rth@twiddle.net> (commit_signer:1/3=3D33%)
>   Thomas Huth <thuth@redhat.com> (commit_signer:1/3=3D33%)
>   Michael Tokarev <mjt@tls.msk.ru> (commit_signer:1/3=3D33%)
>   Julian Brown <julian@codesourcery.com> (commit_signer:1/3=3D33%)
>   qemu-devel@nongnu.org (open list:All patches CC here)
>
> I find the un-matched "recent contributors" list often confuse, due to fi=
les
> being moved, header updated, checkpatch indented.

Yes, the recent-contributors list is often unhelpful, which
is partly why the script warns about them. We might perhaps
switch the default to --no-git-fallback".

> Anyway I now understand these recent contributors are not maintainers but
> no-designated reviewers, unwilling to be maintainers (else they'd have ad=
ded
> a section/entry by themselves).

They're just people who touched a file more often, that's all;
the script does a little of the git log mining for you in
case it's useful (often it isn't).

The underlying problem, as Cornelia points out, is that some
parts of QEMU have no maintainer at all, or have a theoretical
maintainer who in practice doesn't these days have enough time
to do code reviews very promptly, or have a email listed that
actually bounces because they changed employer 3 years ago and
stopped working on QEMU, etc. Changing wording in the
MAINTAINERS file is not going to help with this :-(

thanks
-- PMM
