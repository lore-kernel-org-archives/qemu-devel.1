Received: from eggs.gnu.org ([2001:4830:134:3::10]:40547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPOs3-00025m-Iy
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPOs2-0000Q3-Ke
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:32:31 -0500
Date: Wed, 21 Nov 2018 09:32:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181121093218.GH26577@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181120225241.2371769-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120225241.2371769-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iotests: Skip 233 if certtool not installed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Nov 20, 2018 at 04:52:41PM -0600, Eric Blake wrote:
> The use of TLS while building qemu is optional. While the
> 'certtool' binary should be available on every platform that
> supports building against TLS, that does not imply that the
> developer has installed it.  Make the test gracefully skip
> in that case.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> On Fedora, libvirt requires libtls-utils to be present, but not qemu.
>=20
> I'm fine if Kevin wants to pick this up in a pull request related
> to iotests in general; if not, I'll do a pull request through my
> NBD tree in time for -rc3.
>=20
>  tests/qemu-iotests/common.tls | 3 +++
>  1 file changed, 3 insertions(+)

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
