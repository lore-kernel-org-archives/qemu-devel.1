Received: from eggs.gnu.org ([2001:4830:134:3::10]:54507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgyu-0004hm-Dq
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgyt-00075F-Jq
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:40:40 -0500
Date: Mon, 19 Nov 2018 10:40:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119104030.GK19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-7-berrange@redhat.com>
	<20181118022403.2211483-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181118022403.2211483-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/6] iotests: Also test I/O over NBD TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On Sat, Nov 17, 2018 at 08:24:03PM -0600, Eric Blake wrote:
> Enhance test 233 to also perform I/O beyond the initial handshake.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Depends on my tweak to 2/6 to suppress an EIO error message
> on a failed read after NBD_CMD_DISC.
>=20
>  tests/qemu-iotests/233     | 12 +++++++++++-
>  tests/qemu-iotests/233.out | 10 ++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)

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
