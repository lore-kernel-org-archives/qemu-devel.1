Received: from eggs.gnu.org ([2001:4830:134:3::10]:55655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLw0-0000oS-T5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLvz-00083B-TZ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:48:08 -0400
Date: Mon, 12 Mar 2018 11:48:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312114801.GN3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172713.26318-3-kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] luks: Create
 block_crypto_co_create_generic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Fri, Mar 09, 2018 at 06:27:09PM +0100, Kevin Wolf wrote:
> Everything that refers to the protocol layer or QemuOpts is moved out o=
f
> block_crypto_create_generic(), so that the remaining function is
> suitable to be called by a .bdrv_co_create implementation.
>=20
> LUKS is the only driver that actually implements the old interface, and
> we don't intend to use it in any new drivers, so put the moved out code
> directly into a LUKS function rather than creating a generic
> intermediate one.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/crypto.c | 95 +++++++++++++++++++++++++++++++++++++-------------=
--------
>  1 file changed, 61 insertions(+), 34 deletions(-)

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
