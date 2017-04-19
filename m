Received: from eggs.gnu.org ([2001:4830:134:3::10]:50673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0m5R-0002Ng-V5
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0m5N-00036b-Vj
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:39:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d0m5N-000364-NM
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:39:41 -0400
Date: Wed, 19 Apr 2017 11:39:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170419093937.GA5826@noname.redhat.com>
References: <CACaajQtOS+=G4yHfymqFJiCZBtMfR=qUbfVi6n5quTRtffULjA@mail.gmail.com>
	<20170418171457.GN21261@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20170418171457.GN21261@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] qemu and own disk driver writing questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Vasiliy Tolstov <v.tolstov@selfip.ru>, qemu-devel <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.04.2017 um 19:14 hat Stefan Hajnoczi geschrieben:
> On Thu, Apr 13, 2017 at 01:57:17PM +0300, Vasiliy Tolstov wrote:
> > Hi! If i want to develop some sort of qemu network block driver to own
> > storage. I can write qemu driver or tcmu / scst userspace driver and
> > attach to qemu block device (i'm use linux)
> > So in theory what path have minimal overhead in case of memory copy
> > and performance?
> > Where i can find some info how qemu works with data that needs to be
> > written or readed from block device passed to vm?
>=20
> The best approach depends on your requirements.  If you want the code to
> be merged into qemu.git it's important to discuss the requirements first
> so that everyone is on board with adding another block driver.
>=20
> Three options:
>=20
> 1. Implement iSCSI, NBD, or NFS on your storage server.  Doesn't require
>    new QEMU code and users don't need to upgrade QEMU.
>=20
> 2. Implement a block driver in block/.  See iSCSI and other network
>    protocol drivers for examples.  Useful if your storage system offers
>    snapshot features.
>=20
> 3. Implement vhost-user-scsi in your storage server.  You need to write
>    a virtio-scsi backend that runs in a separate userspace process on
>    the host.  You are limited to supporting the virtio-scsi device - no
>    IDE, SATA, virtio-blk, etc.  vhost-user-scsi is still under active
>    development and you may need to contribute to it if you hit
>    limitations/bugs.  Requires low-level knowledge of virtio.

Maybe also worth noting that 3. bypasses the block layer in QEMU, so you
can't use any features that it provides, like block jobs, backing files,
non-raw image formats, etc.

Kevin

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY9zBZAAoJEH8JsnLIjy/WtV0QAJJsliiiA2fAWBo6o16E3dtH
UPH/HuD1t4K+CdyxpY7s3RqPA/ymuw1O1+hfjTFNkZ8OMF2oFOsCs/Bi2UtnuZhk
iOy7Th/ymp5wUvOteWANkaKD7FVc7JZTNTT9yC7b1I3vLGabT5DcU/6vS2KgwFiY
gcKKCMB1FlYyIBfGXfRMaT9Goqp+W9u40tIXry59uByJ3d/G8P+RRmpt/sWlYm4Y
GKB5PU5Yns1YGsB7Wec2ToE5vjq1/r4wrITcruwBTv2BUY+uV/H+UsPZQ05aJnYc
Cxn3TU2QJxveOqylCqV15a8eDHNi0oOvhUJkJ3R3q3fWRLJjkISH12bi3SUH0YDh
Guw/cSFFOBtMNFGudiLDHXYeHIVlaR5CjOq3WjzUfv7o97tSuCUOMazshcnnXrKi
mUlJue9Uu2acIA+ostYyvUlbLNZzZX722QTroK7CKIts6IgnxYXP38DCGhDrLMNm
XRTcvJ30Mqc33TVmkZPM39tfXXGg49yUYgcGTeTFXlgO0LMNs1IROGEAjw98BtQp
LXDiJHFbIYWlLgGIk5G6DY/gYZWjH1tCotv0NqB6gFnN90bG4cJh3+sD9HY6S9YL
c0kqa+wfiA2TqLxWU2ZAp6OdZkzmLhmz/KeZzJ0KsxpEmakm7nCgDmvcWF4GT9yJ
3R8RH1zL/Mbfjm0jxwvY
=Zo5r
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
