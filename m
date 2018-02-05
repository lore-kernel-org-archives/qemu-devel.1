Received: from eggs.gnu.org ([2001:4830:134:3::10]:44646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eineR-0006vA-An
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eineQ-0000ei-E8
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:46:07 -0500
Date: Mon, 5 Feb 2018 20:45:59 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180205204559.GP2787@redhat.com>
References: <20180205202232.19254-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180205202232.19254-1-mreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, Feb 05, 2018 at 09:22:30PM +0100, Max Reitz wrote:
> This series implements .bdrv_refresh_filename() for the ssh block
> driver, along with an appropriate .bdrv_dirname() so we don't chop off
> query strings for backing files with relative filenames.
>=20
> This series depends on my =E2=80=9Cblock: Fix some filename generation =
issues=E2=80=9D
> series and on Pino's =E2=80=9Cssh: switch from libssh2 to libssh=E2=80=9D=
 patch.
>=20
> Based-on: 20180205151835.20812-1-mreitz@redhat.com
> Based-on: 20180118164439.2120-1-ptoscano@redhat.com
>=20
>=20
> Max Reitz (2):
>   block/ssh: Implement .bdrv_refresh_filename()
>   block/ssh: Implement .bdrv_dirname()
>=20
>  block/ssh.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++------

I reviewed the patches and I can't see anything wrong with them.

I guess that on "weird" remote machines getting the directory from a
filename is an impossible mission, but for reasonable hosts it's going
to be fine.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
