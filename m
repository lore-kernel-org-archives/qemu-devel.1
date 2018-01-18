Received: from eggs.gnu.org ([2001:4830:134:3::10]:59143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAXN-0006n0-81
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAXI-0005w2-VL
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:47:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecAXI-0005tj-PG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:47:20 -0500
Date: Thu, 18 Jan 2018 13:47:16 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118134716.GQ19695@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
	<047d4fd6-aa7c-4b56-f8d9-3624d2d8d9ec@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <047d4fd6-aa7c-4b56-f8d9-3624d2d8d9ec@citrix.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] QIOChannelFile bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 18, 2018 at 01:40:30PM +0000, Ross Lagerwall wrote:
> On 11/01/2017 02:25 PM, Ross Lagerwall wrote:
> > Hi,
> >=20
> > Here is a bug fix with the use of QIOChannelFile and 2 bug fixes and =
an
> > improvement to implementation of QIOChannelFile.
> >=20
> > Regards,
> > Ross Lagerwall
> >=20
> > Ross Lagerwall (4):
> >    migration: Don't leak IO channels
> >    io: Fix QIOChannelFile when creating and opening read-write
> >    io: Don't call close multiple times in QIOChannelFile
> >    io: Add /dev/fdset/ support to QIOChannelFile
> >=20
> >   include/io/channel-file.h    |  2 +-
> >   io/channel-file.c            | 11 ++++-------
> >   migration/savevm.c           |  2 ++
> >   tests/test-io-channel-file.c | 29 +++++++++++++++++++++++++----
> >   4 files changed, 32 insertions(+), 12 deletions(-)
> >=20
>=20
> Ping for reviews...
>=20
> v1:
> Got feedback from Daniel P. Berrange and Marc-Andr=C3=A9 Lureau.
>=20
> v2:
> Patch 1: Unreviewed
> Patch 2: Unreviewed
> Patch 3: Reviewed by Marc-Andr=C3=A9 Lureau
> Patch 4: Reviewed by Marc-Andr=C3=A9 Lureau
>=20
> The patch series still applies cleanly on top of master.

Sorry my bad for forgetting this. I'll review it now.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
