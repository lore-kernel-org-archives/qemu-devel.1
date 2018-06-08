Received: from eggs.gnu.org ([2001:4830:134:3::10]:44799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRLH7-00047l-1G
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRLH0-0003ny-PJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:34:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fRLH0-0003nL-Kk
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:34:02 -0400
References: <20180608131604.16826-1-berrange@redhat.com>
	<20180608131604.16826-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5e547f16-5756-984f-35f8-f7d06849c116@redhat.com>
Date: Fri, 8 Jun 2018 19:33:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180608131604.16826-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] glib: enforce the minimum required
 version and warn about old APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>

On 08.06.2018 15:16, Daniel P. Berrang=C3=A9 wrote:
> There are two useful macros that can be defined before including
> glib.h that are related to the min required glib version
>=20
>  - GLIB_VERSION_MIN_REQUIRED
>=20
>    When this is defined, if code uses an API that was deprecated
>    in this version, or older, a compiler warning will be emitted.
>    This alerts maintainers to update their code to whatever new
>    replacement API is now recommended best practice.
>=20
>  - GLIB_VERSION_MAX_ALLOWED
>=20
>    When this is defined, if code uses an API that was introduced
>    in a version that is newer than the declared version, a compiler
>    warning will be emitted. This alerts maintainers if new code
>    accidentally uses functionality that won't be available on some
>    supported platforms.
>=20
> The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
> in to using specific new APIs with a GLIB_CHECK_VERSION conditional.
> To workaround this Pragmas can be used to temporarily turn off the
> -Wdeprecated-declarations compiler warning, while a static inline
> compat function is implemented. This workaround is illustrated with the
> implementation of the g_strv_contains method to satisfy the test suite.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/glib-compat.h | 68 +++++++++++++++++++++++++++++++++++++++++++
>  tests/test-qga.c      |  2 --
>  2 files changed, 68 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
