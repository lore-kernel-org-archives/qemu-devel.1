Received: from eggs.gnu.org ([2001:4830:134:3::10]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfj6f-0000sZ-R5
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfj6c-0000wX-MT
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:46:17 -0400
Date: Thu, 10 Aug 2017 10:46:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170810104604.342af354.cohuck@redhat.com>
In-Reply-To: <3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org>
	<87mv7aumav.fsf@linaro.org>
	<8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
	<87fud0vmak.fsf@linaro.org>
	<3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 9 Aug 2017 18:30:25 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> [I added mails of other person who reply to this series, this mail is=20
> not directly addressed to Alex]

Hey, a maintainership discussion! I don't think we had one before 8)

>=20
> On 08/09/2017 11:38 AM, Alex Benn=C3=A9e wrote:
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes: =20
> [...]
> >> Do you think there should be another entry in "Block QAPI, monitor,
> >> command line"?
> >> or this file (and related include) rather deserves an own section
> >> (possibly tagged Odd Fixes) to unburden Richard? =20
> >=20
> > Well the default for un-matched files is qemu-devel right? It would be
> > nice for it to be properly maintained but that requires someone to
> > step-up to the plate. =20
>=20
> I wonder if I'm understanding correctly what the MAINTAINERS file is for=
=20
> and how to use it.

The blurb at the start of MAINTAINERS should describe this; I'm
wondering how much it reflects current reality, though (the 'ownership'
part).

>=20
>  From an submitter view I feel a bit confused. I thought=20
> ./get_maintainer.pl would give me the list of person to email the=20
> changes I did on some file from the repository. This script seems=20
> correctly named, I'm looking for some ./get_reviewers.pl instead, to=20
> know who I'v to keep updated, apart from the ./get_maintainer.pl.
>=20
> currently we have:
> "M: Mail patches to: FullName <address@domain>"
> Does this imply FullName is a maintainer?
> If so is it ok I do this change:
>=20
> -    M: Mail patches to: FullName <address@domain>
> +    M: Maintainer: FullName <address@domain>
> +       These maintainers must be mailed on patches.

This line seems to have originally come from the Linux kernel's
MAINTAINERS file. But I like your version better.

>       R: Designated reviewer: FullName <address@domain>
>          These reviewers should be CCed on patches.

I'm wondering whether we need some more detailed descriptions about the
roles of maintainers and reviewers, i.e.
- maintainers are responsible for an area; they review and pick up
  patches; a non-trivial patch merged through someone else needs at
  least an ack from them
- reviewers are interested in an area, the entries are mostly there so
  that they are sure to get cc:ed on patches; while their feedback
  (like everyone's) is valued, it is not essential to getting a change
  merged

>=20
>=20
> actual default for un-matched: "recent contributors" + qemu-devel@
>=20
>    $ ./scripts/get_maintainer.pl -f disas.c
>    get_maintainer.pl: No maintainers found, printing recent contributors.
>    get_maintainer.pl: Do not blindly cc: them on patches!  Use common sen=
se.
>    Peter Maydell <peter.maydell@linaro.org> (commit_signer:2/3=3D67%)
>    Richard Henderson <rth@twiddle.net> (commit_signer:1/3=3D33%)
>    Thomas Huth <thuth@redhat.com> (commit_signer:1/3=3D33%)
>    Michael Tokarev <mjt@tls.msk.ru> (commit_signer:1/3=3D33%)
>    Julian Brown <julian@codesourcery.com> (commit_signer:1/3=3D33%)
>    qemu-devel@nongnu.org (open list:All patches CC here)
>=20
> I find the un-matched "recent contributors" list often confuse, due to=20
> files being moved, header updated, checkpatch indented.
> Most of the time you get the list of queue maintainers since they accept=
=20
> patches and sign-of the pull request.
>=20
> Having to use 'git log --follow' and 'git blame' to figure out is not=20
> bad, to be aware of who modified this file before you, but there are=20
> some files I already hit 3 times in different series, and wondered about=
=20
> how avoid those manual steps.
>=20
> Anyway I now understand these recent contributors are not maintainers=20
> but no-designated reviewers, unwilling to be maintainers (else they'd=20
> have added a section/entry by themselves).

The root problem is "some files have no maintainers". The reasons range
from "forgot to include the file in the pattern" (easily fixed), over
"file is updated via a script" (the linux-headers case), to "nobody
feels up to the task" (which is the worst case).

In most cases, I don't think the recent contributors list is very
helpful. Somebody who simply did a tree-wide rename is unlikely to be
able to make a good judgment about a complicated logic change. Just
printing qemu-devel as the address to send this to is probably better;
unfortunately, it may cause patches to languish on the list if nobody
takes pity on them.

Do we need someone collecting non-trivial patches like that, who either
pesters others or picks up the patches themselves?

>=20
> I also understand why Fam said it sounds weird to add an new section as=20
> "Orphan".
>=20
> For the linux-headers case, if people want to be notified of changes the=
=20
> easiest seems to modify the update-linux-headers.sh script.

The approach I like the most for this is to add a pattern that covers
both the script and the directories updated by it. If someone
explicitly wants notifications for header changes that are used by
their code, they can add it to their files as well, but I don't think
that should be the default.

>=20
> I'll review the whole series thinking differently and resend when 2.11=20
> opens.
>=20
> Regards,
>=20
> Phil.
