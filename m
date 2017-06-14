Received: from eggs.gnu.org ([2001:4830:134:3::10]:42049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL0Nv-0003JY-BI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL0Nt-0007pe-GQ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:58:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dL0Nt-0007o2-An
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:58:25 -0400
Date: Wed, 14 Jun 2017 12:58:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170614045821.GB25748@lemon>
References: <20170613183025.5145-1-f4bug@amsat.org>
	<20170613183025.5145-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613183025.5145-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: remove duplicate typedef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 06/13 15:30, Philippe Mathieu-Daud=C3=A9 wrote:
>     $ make docker-run-test-quick@centos6
>     In file included from hw/net/vmxnet3.c:30:
>     include/migration/register.h:18: error: redefinition of typedef =E2=
=80=98LoadStateHandler=E2=80=99
>     include/migration/vmstate.h:32: note: previous declaration of =E2=80=
=98LoadStateHandler=E2=80=99 was here
>     make: *** [hw/net/vmxnet3.o] Error 1
>     tests/docker/Makefile.include:118: recipe for target 'docker-run' f=
ailed
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/migration/vmstate.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f3f3c2af4d..342027def8 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -28,8 +28,8 @@
>  #define QEMU_VMSTATE_H
> =20
>  #include "migration/qjson.h"
> +#include "migration/register.h"
> =20
> -typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id=
);
>  typedef struct VMStateInfo VMStateInfo;
>  typedef struct VMStateDescription VMStateDescription;
>  typedef struct VMStateField VMStateField;
> --=20
> 2.11.0
>=20

Reviewed-by: Fam Zheng <famz@redhat.com>

Peter: since this affects patchew results, shall we apply this onto maste=
r
directly? I can take patch 1 in my tree.

Fam
