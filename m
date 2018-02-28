Received: from eggs.gnu.org ([2001:4830:134:3::10]:55705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er8GU-00060F-N6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er8GT-0005I4-QT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:23:50 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
	<f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
	<2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
Message-ID: <c9e243ba-7eea-95bc-c36a-aa8af6751182@redhat.com>
Date: Wed, 28 Feb 2018 21:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DdlzxikwxMom9hfWWB9gVaKNW4Hw3UoLF"
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DdlzxikwxMom9hfWWB9gVaKNW4Hw3UoLF
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <c9e243ba-7eea-95bc-c36a-aa8af6751182@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
References: <20180226170313.8178-1-mreitz@redhat.com>
 <20180227161743.GC32480@stefanha-x1.localdomain>
 <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
 <2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
In-Reply-To: <2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-02-28 21:11, Max Reitz wrote:
> On 2018-02-28 19:08, Max Reitz wrote:

[...]

> In any case it's interesting to see that even the current qemu-img
> convert takes longer to read sparsely allocated qcow2/raw files from xf=
s
> than fully allocated images...

(That's because I didn't drop the caches after the qemu-io run...  If I
do that, reading the full image takes its four seconds.  But that
doesn't make the full results better, and the sparse results don't
change much.)

Max


--DdlzxikwxMom9hfWWB9gVaKNW4Hw3UoLF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqXD74SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A104H/Rae9dqehu3WhYuPab3Z3wHn30sRF6d0
IlG5mOcFVmHowSQaTaIExALiRNxn5BovZtrphQ217kuVx4OU6xjhtpc+mBfiVzkf
+/Y9g8PDE3oxmFAe+7Qt87BeXd3W+nHjEsgtcTRuviOWhwa+zaACQtW6a7Kbvtw6
rEiWhOnU2MR2D91ozGpsANxMN1pYDBieCo/f0qMJUxuTkH5DwwaSzkC81EBjXoCx
4JwEMD0Tb/CsFo66sdbxmovjEkQyDhdHJpL3SQmIVvBR0NgouifbJiGkDBf6HwB2
CLxccoaYAppLUyWwyCYNzs3MXZyJTMe2i17X9i9yF+OBNnAX9n+FzCE=
=NvKd
-----END PGP SIGNATURE-----

--DdlzxikwxMom9hfWWB9gVaKNW4Hw3UoLF--
