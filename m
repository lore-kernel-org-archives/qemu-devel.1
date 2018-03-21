Received: from eggs.gnu.org ([2001:4830:134:3::10]:42551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eya5u-0006L6-Ds
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eya5t-0003UV-Cb
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:31:42 -0400
Date: Wed, 21 Mar 2018 09:31:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180321093125.GG8551@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180320173632.25480-6-kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 05/12] luks: Turn another invalid
 assertion into check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Tue, Mar 20, 2018 at 06:36:25PM +0100, Kevin Wolf wrote:
> Commit e39e959e fixed an invalid assertion in the .bdrv_length
> implementation, but left a similar assertion in place for
> .bdrv_truncate. Instead of crashing when the user requests a too large
> image size, fail gracefully.
>=20
> A file size of exactly INT64_MAX caused failure before, but is actually
> legal.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/crypto.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

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
