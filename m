Received: from eggs.gnu.org ([2001:4830:134:3::10]:60441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diiOs-0001Sq-9a
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diiOp-0007iB-0u
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:37:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1diiOo-0007i1-RM
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:37:22 -0400
Date: Fri, 18 Aug 2017 15:37:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170818143707.GE2222@work-vm>
References: <85cdeb9f-a6ea-5530-edcd-10ed3853026f@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <85cdeb9f-a6ea-5530-edcd-10ed3853026f@exactcode.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] QXL: always show default cursor,
 even for unsupported chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>, kraxel@redhat.com
Cc: qemu-devel@nongnu.org

cc'ing in Gerd

* Ren=E9 Rebe (rene@exactcode.com) wrote:
> Hi,
>=20
> I was testing a Windows 10 guest with HiDPI scaling which
>=20
> actually made the cursor disappear and only multiple chunks
>=20
> warnings being printed.
>=20
> When the cursor is using currently unsupported multiple chunks, the
> builtin-left cursor is better than none.
>=20
> PS: if TB damages the white-space just let me know, only recently start=
ed
> using it, ...
>=20
>   - Ren=E9 Rebe <rene@exactcode.de>
>=20
> diff -u -ur qemu-2.10.0-rc3/hw/display/qxl-render.c
> qemu-2.10.0-rc3-fixed/hw/display/qxl-render.c
> --- qemu-2.10.0-rc3/hw/display/qxl-render.c    2017-08-15 20:39:41.0000=
00000
> +0200
> +++ qemu-2.10.0-rc3-fixed/hw/display/qxl-render.c    2017-08-17
> 13:42:37.108953910 +0200
> @@ -270,9 +270,10 @@
>          }
>          if (cursor->chunk.data_size !=3D cursor->data_size) {
>              fprintf(stderr, "%s: multiple chunks\n", __FUNCTION__);
> -            return 1;
> +            c =3D NULL; /* fall back to built-in left cursor */
> +        } else {
> +            c =3D qxl_cursor(qxl, cursor);
>          }
> -        c =3D qxl_cursor(qxl, cursor);
>          if (c =3D=3D NULL) {
>              c =3D cursor_builtin_left_ptr();
>          }
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
