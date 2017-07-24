Received: from eggs.gnu.org ([2001:4830:134:3::10]:39151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dZZnK-0002s7-TZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dZZnH-0001ZN-N1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:36:54 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:40627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dZZnH-0001YE-GF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:36:51 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 494631164B9
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:36:42 +0200 (CEST)
Date: Mon, 24 Jul 2017 11:36:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170724113631.16be0baa@bahia.lan>
In-Reply-To: <20170717081152.17153-10-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-10-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/e_5IFXq5_kZGYI.klQZ=LhE";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 9/9] checkpatch: add virtio_error and
 virtqueue_error to error funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

--Sig_/e_5IFXq5_kZGYI.klQZ=LhE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jul 2017 10:11:52 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> Two more error functions that should not contain newlines.
>=20
> Suggested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  scripts/checkpatch.pl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4e91122..2cd2713 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2540,7 +2540,9 @@ sub process {
>  				info_vreport|
>  				error_report|
>  				warn_report|
> -				info_report}x;
> +				info_report|
> +				virtio_error|
> +				virtqueue_error}x;
> =20
>  	if ($rawline =3D~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>  		ERROR("Error messages should not contain newlines\n" . $herecurr);


--Sig_/e_5IFXq5_kZGYI.klQZ=LhE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll1v58ACgkQAvw66wEB28J/mACgh3iW38RKWZPSpbONqpIX1E7E
mokAnir+wfj74NKkQsFzMMZOEhw7ZOqj
=FhBt
-----END PGP SIGNATURE-----

--Sig_/e_5IFXq5_kZGYI.klQZ=LhE--
