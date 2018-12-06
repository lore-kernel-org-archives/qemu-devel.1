Received: from eggs.gnu.org ([2001:4830:134:3::10]:39057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUr53-0004NG-Gh
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUr4z-0005qd-0q
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:40:29 -0500
Date: Thu, 6 Dec 2018 10:39:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206103943.GM29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205144700.26563-5-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] crypto/block: introduce
 qcrypto_block_*crypt_helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Wed, Dec 05, 2018 at 05:46:59PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> Introduce QCryptoBlock-based functions and use them where possible.
> This is needed to implement thread-safe encrypt/decrypt operations.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  crypto/blockpriv.h  | 14 ++++++++++++++
>  crypto/block-luks.c | 14 ++++++--------
>  crypto/block-qcow.c | 14 ++++++--------
>  crypto/block.c      | 26 ++++++++++++++++++++++++++
>  4 files changed, 52 insertions(+), 16 deletions(-)

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
