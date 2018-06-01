Received: from eggs.gnu.org ([2001:4830:134:3::10]:35230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOj58-0002Gx-0G
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOj54-0008OA-Km
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:22:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOj54-0008Np-FI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:22:54 -0400
Date: Fri, 1 Jun 2018 13:22:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601122251.GX3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-3-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527266793-301361-3-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/20] crypto: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, peter.maydell@linaro.org

On Fri, May 25, 2018 at 07:47:41PM +0300, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  crypto/block-luks.h    | 2 +-
>  crypto/block-qcow.h    | 2 +-
>  crypto/ivgen-essiv.h   | 2 +-
>  crypto/ivgen-plain.h   | 2 +-
>  crypto/ivgen-plain64.h | 2 +-
>  crypto/block-luks.c    | 2 +-
>  crypto/block-qcow.c    | 2 +-
>  crypto/block.c         | 6 +++---
>  crypto/cipher.c        | 6 +++---
>  crypto/ivgen-essiv.c   | 2 +-
>  crypto/ivgen-plain.c   | 2 +-
>  crypto/ivgen-plain64.c | 2 +-
>  crypto/ivgen.c         | 8 ++++----
>  crypto/tlscreds.c      | 2 +-
>  crypto/tlscredsanon.c  | 2 +-
>  crypto/tlscredsx509.c  | 2 +-
>  16 files changed, 23 insertions(+), 23 deletions(-)

Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
