Received: from eggs.gnu.org ([2001:4830:134:3::10]:50058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYWgc-0003Oy-CU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYWgY-0007RA-6Q
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:10:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYWgY-0007Qh-08
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:10:06 -0400
Date: Thu, 28 Jun 2018 14:09:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628130959.GA13043@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180608131604.16826-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608131604.16826-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] glib: update the min required
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>

Ping, Paolo:

Peter confirmed he'd updated his mingw cross env now, so should be
safe to include this in a PULL before soft-freeze on tuesday.

On Fri, Jun 08, 2018 at 02:16:01PM +0100, Daniel P. Berrang=C3=A9 wrote:
> The previous patch to bump glib to 2.42 hit problems with Peter's build
> environment for testing merge:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02557.html
>=20
> This posting drops back to 2.40, which allows Ubuntu 14.04 from GLibC
> compile farm to be supported.
>=20
> It does NOT try to go back to 2.34, because it is hoped that the mxe.cc
> Debian packages will be suitable for Peter to test Windows
> cross-compile. Alternatively the docker environments provided in tree
> can be used for mingw build testing on any host able to run docker.
>=20
> I also dropped some more GLIB_CHECK_VERSION checks that are redundant
> given the new min version.
>=20
> Changed in v3:
>=20
>  - Use #pragma instead of _Pragma
>  - Move dockerfile deletion to earlier patch
>  - Add missing osdep.h include
>  - Reorder patches to preserve bisectability
>=20
> Daniel P. Berrang=C3=A9 (3):
>   util: remove redundant include of glib.h and add osdep.h
>   glib: bump min required glib library version to 2.40
>   glib: enforce the minimum required version and warn about old APIs
>=20
>  configure                                |   6 +-
>  crypto/hash-glib.c                       |   4 -
>  crypto/hmac-glib.c                       |  36 ---
>  include/glib-compat.h                    | 373 ++++-------------------
>  include/qemu/iova-tree.h                 |   1 -
>  qga/commands.c                           |  11 +-
>  tests/docker/dockerfiles/centos6.docker  |  30 --
>  tests/docker/dockerfiles/min-glib.docker |   8 -
>  tests/ivshmem-test.c                     |   6 -
>  tests/test-qga.c                         |   2 -
>  tests/test-qmp-event.c                   |   8 +-
>  tests/tpm-emu.h                          |   4 +-
>  tests/vhost-user-test.c                  |  26 +-
>  trace/simple.c                           |   6 +-
>  util/iova-tree.c                         |   2 +-
>  util/osdep.c                             |  14 -
>  16 files changed, 73 insertions(+), 464 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/centos6.docker
>  delete mode 100644 tests/docker/dockerfiles/min-glib.docker
>=20
> --=20
> 2.17.0
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
