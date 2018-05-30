Received: from eggs.gnu.org ([2001:4830:134:3::10]:58332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO3co-0006pv-TE
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO3co-0002jA-0a
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:06:58 -0400
Date: Wed, 30 May 2018 17:06:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530160647.GD5973@stefanha-x1.localdomain>
References: <20180529055959.32002-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20180529055959.32002-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/10] qemu-img convert with copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, eblake@redhat.com


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 01:59:49PM +0800, Fam Zheng wrote:
> v7: Fix qcow2.
>=20
> v6: Pick up rev-by from Stefan and Eric.
>     Tweak patch 2 commit message.
>=20
> v5: - Fix raw offset/bytes check for read. [Eric]
>     - Fix qcow2_handle_l2meta. [Stefan]
>     - Add coroutine_fn whereever appropriate. [Stefan]
>=20
> v4: - Fix raw offset and size. [Eric]
>     - iscsi: Drop unnecessary return values and variables in favor of
>       constants. [Stefan]
>     - qcow2: Handle small backing case. [Stefan]
>     - file-posix: Translate ENOSYS to ENOTSUP. [Stefan]
>     - API documentation and commit message. [Stefan]
>     - Add rev-by to patches 3, 5 - 10. [Stefan, Eric]
>=20
> This series introduces block layer API for copy offloading and makes use =
of it
> in qemu-img convert.
>=20
> For now we implemented the operation in local file protocol with
> copy_file_range(2).  Besides that it's possible to add similar to iscsi, =
nfs
> and potentially more.
>=20
> As far as its usage goes, in addition to qemu-img convert, we can emulate
> offloading in scsi-disk (handle EXTENDED COPY command), and use the API in
> block jobs too.

Fails to compile on Fedora 28.

Oops, I guess my glibc is too new.  This type of bug doesn't happen very
often :D :D :D.

block/file-posix.c:1452:14: error: static declaration of =E2=80=98copy_file=
_range=E2=80=99 follows non-static declaration
 static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
              ^~~~~~~~~~~~~~~
In file included from /home/stefanha/qemu/include/qemu/osdep.h:75,
                 from block/file-posix.c:25:
/usr/include/unistd.h:1107:9: note: previous declaration of =E2=80=98copy_f=
ile_range=E2=80=99 was here
 ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
         ^~~~~~~~~~~~~~~

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDswXAAoJEJykq7OBq3PIG70H/0rZKyzpx5yrKGHRiRnNFlzc
8GdVPMAYjiCupplS73aCH6lwq2irMbvCMF56vkT/3ohXDTUh+O8zYgdffEcqHTkg
YRp3MUTjqocTWn8+TRvjUl4yR0n0IxtLhMWg+AtwFNmTFunX6k6tpbkOo7j3Xj7U
NMVPJjA6AwCFAR9q58doeN5ewihqeJboTqVeyDQjYOLTeafeWkgyZsuVAQWkIJun
Ijkxlwzyi8NCNSz24XkUQMCFt23YySNtOp9YbBIrCxBge0Z10J3qJBqKsgYlRcjt
IpPtcgzhNi6JpRNSJZsKFguxcIZfC/9jKtt5UK/ok2MRVqQISYSZ8PvyPNp8G9w=
=3S7A
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
