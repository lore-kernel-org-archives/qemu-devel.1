Received: from eggs.gnu.org ([2001:4830:134:3::10]:52242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGTUg-0001Pm-IA
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGTUf-0005d0-1V
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:07:14 -0400
References: <20180503225648.13153-1-jsnow@redhat.com>
	<df5d75a1-6855-c462-6f05-662a42f50f39@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5c8e8a3e-9347-ec7b-3b5d-ad626b2dbb30@redhat.com>
Date: Wed, 9 May 2018 20:07:01 +0200
MIME-Version: 1.0
In-Reply-To: <df5d75a1-6855-c462-6f05-662a42f50f39@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FNk3JqKgwbyzbt1sjHxgHuak3idlH9GTr"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] qemu-img: make subcommand
 usage docstrings consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FNk3JqKgwbyzbt1sjHxgHuak3idlH9GTr
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <5c8e8a3e-9347-ec7b-3b5d-ad626b2dbb30@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/5] qemu-img: make subcommand usage
 docstrings consistent
References: <20180503225648.13153-1-jsnow@redhat.com>
 <df5d75a1-6855-c462-6f05-662a42f50f39@redhat.com>
In-Reply-To: <df5d75a1-6855-c462-6f05-662a42f50f39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-04 03:03, John Snow wrote:
> On 05/03/2018 06:56 PM, John Snow wrote:
>> I'm working on a project to attempt to autogenerate all of this, but
>> until then let's just do a bit of the usual kinds of tidying.
>>
>> ______________________________________________________________________=
__________
>>
>> For convenience, this branch is available at:
>> https://github.com/jnsnow/qemu.git branch trivial-qemu-img
>> https://github.com/jnsnow/qemu/tree/trivial-qemu-img
>>
>> This version is tagged trivial-qemu-img-v1:
>> https://github.com/jnsnow/qemu/releases/tag/trivial-qemu-img-v1
>>
>> John Snow (5):
>>   qemu-img-commands.hx: argument ordering fixups
>>   qemu-img.texi: fix command ordering
>>   qemu-img: remove references to GEN_DOCS
>>   qemu-img: Make documentation between .texi and .hx consistent
>>   qemu-img-cmds.hx: add passive-aggressive note
>>
>>  qemu-img-cmds.hx       | 13 +++++----
>>  qemu-img.c             |  2 --
>>  qemu-img.texi          | 78 ++++++++++++++++++++++++++---------------=
---------
>>  qemu-options-wrapper.h |  1 -
>>  4 files changed, 48 insertions(+), 46 deletions(-)
>>
>=20
> Possessed by some kind of malevolent phantasm, I documented the followi=
ng:
>=20
> amend	 [--object objectdef] [--image-opts] [-q] [-f fmt]      filename
> bench                                        [-q] [-f fmt] [-U] filenam=
e
> check    [--object objectdef] [--image-opts] [-q] [-f fmt] [-U] filenam=
e
> commit   [--object objectdef] [--image-opts] [-q] [-f fmt]      filenam=
e
> compare  [--object objectdef] [--image-opts] [-q] [-f fmt] [-U] filenam=
e
> convert  [--object objectdef] [--image-opts] [-q] [-f fmt] [-U] filenam=
e
> create   [--object objectdef]                [-q] [-f fmt]      filenam=
e
> dd                            [--image-opts]      [-f fmt] [-U]
> info     [--object objectdef] [--image-opts]      [-f fmt] [-U] filenam=
e
> map      [--object objectdef] [--image-opts]      [-f fmt] [-U] filenam=
e
> measure  [--object objectdef] [--image-opts]      [-f fmt]      filenam=
e
> snapshot [--object objectdef] [--image-opts] [-q]          [-U] filenam=
e
> rebase   [--object objectdef] [--image-opts] [-q] [-f fmt] [-U] filenam=
e
> resize   [--object objectdef] [--image-opts] [-q] [-f fmt]      filenam=
e
>=20
> These are the largely universal set of options we support on most
> commands, except sometimes some commands don't support them. Maybe
> that's intentional, Maybe it isn't:
>=20
> - Maybe we don't really want -U on commands that are opened RDWR.

Sounds reasonable to me.

> - Maybe -f fmt isn't useful on snapshot or amend (which only work for
> qcow2?)

But amend does have -f fmt.  I suppose snapshot should as well.

> - Maybe -q is inherently pretty useless for commands like info, map, or=

> measure whose job is to show you something.

I suppose so, too.  If it was an option, it just wouldn=E2=80=99t do anyt=
hing.
That=E2=80=99s OK to me if you plan to add it as a global option, but it =
isn=E2=80=99t
really useful.

> Less clear to me:
>=20
> - Is there no place for --image-opts for create?

Not yet.  When x-blockdev-create loses its x-, it might be the time to
change that.

The same holds true for convert, by the way.  Its --image-opts is only
usable for the source, but there is no --target-image-opts.  That=E2=80=99=
s
because currently you always need a filename for image creation, and you
just can give some creation options in addition (through -o).

It might be useful for bench, but that=E2=80=99s debugging anyway, so I d=
on=E2=80=99t
really care.

> - Or --object for dd?

I=E2=80=99d rather not see any changes to dd.  Actually, I=E2=80=99d rath=
er not see dd
at all, but that=E2=80=99s a personal opinion.

I=E2=80=99ve always wanted to merge dd=E2=80=99s functionality into conve=
rt, so the less
it can do until then, the better, I suppose.  (Though of course I=E2=80=99=
ve
never had the time to attack this issue, as usual.)

> - Or either of these two for bench?

Again, it=E2=80=99s solely for debugging, so feel free to go wild, but th=
ere=E2=80=99s
no actual need to support it until any of us developers wants to use it
with luks.

Shouldn=E2=80=99t be that hard, anyway.

Max

> The thought, though, is to define some core set of options that will
> always apply to all commands. It might not always be perfect, but the
> arguments listed here are a start for what probably makes sense for mos=
t
> commands. Maybe it's a bad idea; but maybe individual parsers could opt=

> out of the common set of arguments on an as-needed basis instead.
>=20
> Might help the documentation along to be able to point to some
> definitely universal core group of options.
>=20
> --js
>=20
>=20



--FNk3JqKgwbyzbt1sjHxgHuak3idlH9GTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrzOMUACgkQ9AfbAGHV
z0AR3QgAi6cPfIlmqx1hiNFBCW4tuCJclWJ7vsTOza92L+Ye4zmmj/iSBunkoopu
HrNWT3pNEGkEJCa+ay4IHdocFNT2js/w0CZaERCoMz+FeG7bWWd2NrtT1bmnFg+7
tKyLFPTSBFDPlVlBksvcJ2dPbv4sriMptNeylV8p/nKX/5Fd1lqtGPigqQ9rgfTG
iuPGmUAg85bpAkL2zKcvbJaLzWzZknA3lMCvcJHArqxrj+8JSmY3db37zWLqk6Ls
3gjfAnZby3QUdbgv0/XVTdJXRbjr8iVE/yERdRD7nTyObgwDnJd0zFBEs5kTBWBJ
Mrhm2qVv+d/Y1LzonlGrysUHOWwIvQ==
=UPrk
-----END PGP SIGNATURE-----

--FNk3JqKgwbyzbt1sjHxgHuak3idlH9GTr--
