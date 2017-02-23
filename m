Received: from eggs.gnu.org ([2001:4830:134:3::10]:58750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgu3C-00012Z-7p
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgu37-0001h3-Aw
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:07:18 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgu37-0001gy-4l
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:07:13 -0500
Received: by mail-wr0-x244.google.com with SMTP id s27so4050732wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:07:13 -0800 (PST)
Date: Thu, 23 Feb 2017 14:07:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223140709.GI30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760163084.31154.3895291117452367500.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
In-Reply-To: <148760163084.31154.3895291117452367500.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 09/29] 9pfs: local: llistxattr: don't
 follow symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:40:30PM +0100, Greg Kurz wrote:
> The local_llistxattr() callback is vulnerable to symlink attacks because
> it calls llistxattr() which follows symbolic links in all path elements b=
ut
> the rightmost one.
>=20
> This patch converts local_llistxattr() to rely on opendir_nofollow() and
> flistxattrat_nofollow() instead.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-xattr.c |   30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYruyNAAoJEJykq7OBq3PItjsIAK7PIQcsikzm5MpfHmiLkNIV
HKkZp4exYz7F86eB69UgKLu1yVDeZ67NkMPPS/KyG4YiyvBzyaGB5JOUfj02KvHp
Fl9M4MFOzPcibpceonKhMGIeFhNLrMg+K+7ysuQbU7IwafTUZJYdKW1byBt+y0fk
gW1iDke9xApOUPcsuZQsOh9IgPobKJhW+G7/RfotSNgbZoOjcKD+VZyXmhyi/aVs
L8SwQfrIDIT7F45JqeC0xA/7TrBSgY5wxDQAk/6JJBoraFElV6H5Pc3ox1cxJWy3
9NybFC0ujYSd4ZM4PsKCZOUwhcRjNKwZnlRVqgivGuzZzbSZUoyu9WSg0ppXQqU=
=FSX6
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--
