Received: from eggs.gnu.org ([2001:4830:134:3::10]:54520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXB2-0000B8-LB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXB1-00010w-Ie
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:45:44 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b1085a4-cc9b-f1cc-cc4b-c768879bb7ee@redhat.com>
Date: Tue, 16 Jan 2018 13:45:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Y06rrUnG5BoGtgHCbqpqZZMfhIMpZqK4A"
Subject: Re: [Qemu-devel] [RFC PATCH 08/10] util: Add
 qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y06rrUnG5BoGtgHCbqpqZZMfhIMpZqK4A
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <7b1085a4-cc9b-f1cc-cc4b-c768879bb7ee@redhat.com>
Subject: Re: [RFC PATCH 08/10] util: Add qemu_opts_to_qdict_filtered()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-9-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> This allows, given a QemuOpts for a QemuOptsList that was merged from
> multiple QemuOptsList, to only consider those options that exist in one=

> specific list. Block drivers need this to separate format-layer create
> options from protocol-level options.

Someday it would be nice to not have to rely so much on QemuOpts. But in
the meantime, this glue makes sense.

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/option.h |  2 ++
>  util/qemu-option.c    | 28 +++++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
>=20

It would be nice to add direct testsuite coverage of the new function,
in addition to the indirect coverage it gets when list is NULL.


> +++ b/util/qemu-option.c
> @@ -1009,9 +1009,10 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDic=
t *qdict, Error **errp)
>   * TODO We'll want to use types appropriate for opt->desc->type, but
>   * this is enough for now.
>   */

Does this comment need any tweaking...

> -QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
> +QDict *qemu_opts_to_qdict_filtered(QemuOpts *opts, QDict *qdict,
> +                                   QemuOptsList *list, bool del)
>  {
> -    QemuOpt *opt;
> +    QemuOpt *opt, *next;
> =20
>      if (!qdict) {
>          qdict =3D qdict_new();

> =20
> +QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)

=2E..or this moved declaration need a comment?

> +{
> +    return qemu_opts_to_qdict_filtered(opts, qdict, NULL, false);
> +}
> +
>  /* Validate parsed opts against descriptions where no
>   * descriptions were provided in the QemuOptsList.
>   */
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Y06rrUnG5BoGtgHCbqpqZZMfhIMpZqK4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeVl4ACgkQp6FrSiUn
Q2p1yQf/XGOJxubbmyV4tyCfvLveUL6hZRkJmHpym63rMzv9lRoFXi3xX0fDJ6ev
h07S4IMFTMWSAgtjuwV+8C+PYohDCLnDwJ6bopoevAze0IgmRgpLKhKuVBX3dkzy
63+rl44m6meEBRupgvz0qHseDltndCndgmEviKb7v81+EANJSTX0xhfowqbSp7R7
uT7vcFlQNIJUY6hYVOxJaM0MHUU5cduA8A7tpFm/MZSnxLOxuSPbqyw4olNB9N3L
BS8m1QLb/z9HFdLAckxNQFLX7k7nLOhPz8qfr6GWmbqV3pHo+ckiM/arJVcZoaBf
X8trrh83p+ZlxzcCMlxSymd8/oIg7A==
=WH92
-----END PGP SIGNATURE-----

--Y06rrUnG5BoGtgHCbqpqZZMfhIMpZqK4A--
