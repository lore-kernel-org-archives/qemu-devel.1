Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguth-0000lw-4K
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgutb-00012S-LP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:01:33 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:32915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgutb-00012M-Fq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:01:27 -0500
Received: by mail-wr0-x242.google.com with SMTP id s27so4223690wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:01:27 -0800 (PST)
Date: Thu, 23 Feb 2017 15:01:23 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223150123.GV30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760173178.31154.10880735541217141085.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TG7lY2/6mW/akb80"
Content-Disposition: inline
In-Reply-To: <148760173178.31154.10880735541217141085.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 22/29] 9pfs: local: link: don't follow
 symlinks
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


--TG7lY2/6mW/akb80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:42:11PM +0100, Greg Kurz wrote:
> The local_link() callback is vulnerable to symlink attacks because it cal=
ls:
>=20
> (1) link() which follows symbolic links for all path elements but the
>     rightmost one
> (2) local_create_mapped_attr_dir()->mkdir() which follows symbolic links
>     for all path elements but the rightmost one
>=20
> This patch converts local_link() to rely on opendir_nofollow() and linkat=
()
> to fix (1), mkdirat() to fix (2).
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   86 ++++++++++++++++++++++++++++++++++------------=
------
>  1 file changed, 57 insertions(+), 29 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TG7lY2/6mW/akb80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvlDAAoJEJykq7OBq3PIvzEH/RxtEEIB/6J0AK0aCCt8Fecr
D5AaDAh9oR1PmsoZew0vs/XcsUaa4z3XPTZCVeuT9MD+4dsc3323Ml9myL3YroNV
j2KTl+zXGoh2qGQVyL4SQGd6fUKM9xkjS+BaUdot0OxMuQcrxY9TdVPMxF/9FFYB
kvXj5Ir2Ak1rJn10ZEUDRI+g+SSzIgKBqKsuYE3qxakNk6JOvFiUT1ZhXR5JFHtQ
AiqcgK6JM/gf2yk1Ar44/ObjGNVKz9wWanqXCEZYFlQu2tYUa6nT6Y4ivtVhcxcV
AxjsNZpYB9paXE+8gp8v8r/Z6oIxpOnLgPftsV4HxuPD6IPWNcyCru7IfIFpSnw=
=Jauw
-----END PGP SIGNATURE-----

--TG7lY2/6mW/akb80--
