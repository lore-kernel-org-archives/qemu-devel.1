Received: from eggs.gnu.org ([2001:4830:134:3::10]:43215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBFSR-0005EN-Rl
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBFSL-0005WL-TD
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:07:19 -0400
Date: Wed, 25 Apr 2018 09:06:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180425080659.GD30024@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180424220157.177385-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424220157.177385-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: Merge .bdrv_co_writev{,
 _flags} in drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:GLUSTER" <qemu-block@nongnu.org>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Xie Changlong <xiechanglong.d@gmail.com>

On Tue, Apr 24, 2018 at 05:01:57PM -0500, Eric Blake wrote:
> We have too many driver callback interfaces; simplify the mess
> somewhat by merging the flags parameter of .bdrv_co_writev_flags()
> into .bdrv_co_writev_flags().  Note that as long as a driver doesn't

Typo - this should be just  .bdrv_co_writev

> set .supported_write_flags, the flags argument will be 0 and behavior
> is identical.  Also note that the public function bdrv_co_writev()
> still lacks a flags argument; so the driver signature is thus
> intentionally slightly different.  But that's not the end of the
> world, nor the first time that the driver interface differs slightly
> from the public interface.
>=20
> Ideally, we should be rewriting all of these drivers to use modern
> byte-based interfaces.  But that's a more invasive patch to write
> and audit, compared to the simplification done here.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Based-on: <20180424192506.149089-1-eblake@redhat.com>
> ([PATCH v2 0/6] block: byte-based AIO read/write)
>=20
>  include/block/block_int.h |  2 --
>  block/io.c                | 13 ++++---------
>  block/gluster.c           |  4 +++-
>  block/iscsi.c             |  8 ++++----
>  block/parallels.c         |  4 +++-
>  block/qcow.c              |  6 ++++--
>  block/qed.c               |  3 ++-
>  block/replication.c       |  4 +++-
>  block/sheepdog.c          |  4 +++-
>  block/ssh.c               |  4 +++-
>  block/vhdx.c              |  4 +++-
>  11 files changed, 32 insertions(+), 24 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
