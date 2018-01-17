Received: from eggs.gnu.org ([2001:4830:134:3::10]:45536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebpcL-0004BH-NT
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebpcK-0000Cg-L7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:27:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebpcK-0000BV-Bo
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:27:08 -0500
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5deda3ef-d5e4-c2a7-5556-4c46c26045ad@redhat.com>
Date: Wed, 17 Jan 2018 09:26:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180116231824.27114-1-shaun.reitan@ndchost.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2OXlecnFV3reS3czd9GPn72lR9FlG2r3D"
Subject: Re: [Qemu-devel] [PATCH] Add ability to provide ifname when using
 netdev bridge or tap helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shaun Reitan <shaun.reitan@ndchost.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2OXlecnFV3reS3czd9GPn72lR9FlG2r3D
From: Eric Blake <eblake@redhat.com>
To: Shaun Reitan <shaun.reitan@ndchost.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <5deda3ef-d5e4-c2a7-5556-4c46c26045ad@redhat.com>
Subject: Re: [PATCH] Add ability to provide ifname when using netdev bridge or
 tap helper
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
In-Reply-To: <20180116231824.27114-1-shaun.reitan@ndchost.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 05:18 PM, Shaun Reitan wrote:
> This patch replaces the patch I sent yesturday. This one fixes
> a bug in my original code as well as corrects a few styling
> issues. Hopfully this one comes out correct!  Sorry for the
> inconvienece.

This paragraph belongs...

> =20
> When currently using -netdev bridge or -netdev tap with a helper
> you are unable to set an ifname. This patch adds that ability so
> that you can now specify an ifname.
>=20
> Signed-off-by: Shaun Reitan <shaun.reitan@ndchost.com>
> ---

=2E..here, after the --- separator.  It is useful for reviewers reading
the list, but pointless in the git log a year from now.

>  net/tap.c            | 33 ++++++++++++++++++++++++---------
>  qapi/net.json        |  1 +
>  qemu-bridge-helper.c | 11 +++++++++--
>  qemu-options.hx      |  2 +-
>  4 files changed, 35 insertions(+), 12 deletions(-)

> +++ b/qapi/net.json
> @@ -402,6 +402,7 @@
>  { 'struct': 'NetdevBridgeOptions',
>    'data': {
>      '*br':     'str',
> +    '*ifname': 'str',

Missing documentation (including a '(since 2.12)' tag) of the new field.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2OXlecnFV3reS3czd9GPn72lR9FlG2r3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfaz8ACgkQp6FrSiUn
Q2oaVgf9EWLveAA2kjfnsjqSDGLVSVRFwYK7C6IsdkoWLEUKkO2C4cnDKKEKRBuA
7sIJLDLv5PLv6SIG1Psc7SzhOknOmbpLQJQapGXbfe0LADGa/2jCde4gnF5rDMCB
ULGKKIgpC6rV9B1nzLjtfO5nS6BPznK9eniy5RECHOhQZfQTo7k1KLTLLozLwKau
dl7FS5V0sQJLCPdfG1ABni83vDbURHAAMnk2a62yzdlN71D4yQsMvyMX7A3cc7QJ
rBllvG/lEe+rEFTAanlF7iB4rEY4mdgCH8+7+uqXhcqmMIkFupVpFUfDYbCHgHwn
Q44zsik4wegPbYAyow1nOKAyzgO88w==
=ovzJ
-----END PGP SIGNATURE-----

--2OXlecnFV3reS3czd9GPn72lR9FlG2r3D--
