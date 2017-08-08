Received: from eggs.gnu.org ([2001:4830:134:3::10]:39828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Tr-0000ra-B6
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Tn-0006T1-59
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:19 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1df1Tm-0006Sb-UH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:15 -0400
Received: by mail-wm0-x22b.google.com with SMTP id t201so3119169wmt.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 03:11:14 -0700 (PDT)
Date: Tue, 8 Aug 2017 11:11:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808101111.GF16801@stefanha-x1.localdomain>
References: <20170804213625.3756-1-ehabkost@redhat.com>
	<20170804213625.3756-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline
In-Reply-To: <20170804213625.3756-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/5] qmp-shell: Accept QMP command
 as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 06:36:24PM -0300, Eduardo Habkost wrote:
> This is useful for testing QMP commands in scripts.
>=20
> Example usage, combined with 'jq' for filtering the results:
>=20
>   $ ./scripts/qmp/qmp-shell /tmp/qmp qom-list path=3D/ | jq -r .return[].=
name
>   machine
>   type
>   chardevs
>   backend
>   $
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiY4/AAoJEJykq7OBq3PI/hwIAII+V5JS8GiXb2MzRKeKx6Nt
cEwOxJpxBjx19BT9KUb5I45FTQXjrHxxehPInG+x+WefoC5iO6BW3neKJJHO9yRe
6tH7UrL9dcAlaycHEFFJknxo3lools+Lc0PbXZMkdQ3T4zqxzdlB2Cr0C35LDR9y
wgT906KAyvAJ41784Bn01C8e8tyZuHudQjQFb/tOy9WwUPdnS8nGTJTOCBFhYat8
6EP8OyMlTNlCyKkIvaTJ2f1jFHw3lZJvGWpaK1Jwm/VrM+gvDJ08l+NXpKk5uH+f
hwpEzyzdnjbrFsYAdiq+XXuab1PGfwAtbHiQzFpFXQbXsFmU24tUG3cnoiNuTyE=
=9/fQ
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--
