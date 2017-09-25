Received: from eggs.gnu.org ([2001:4830:134:3::10]:43482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwOVS-00016G-My
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwOVR-0000sL-T3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:12:46 -0400
Date: Mon, 25 Sep 2017 10:12:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170925101232.4d5dd45c.cohuck@redhat.com>
In-Reply-To: <20170922154014.29350-6-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/34] misc: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org

On Fri, 22 Sep 2017 12:39:45 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> exec: housekeeping (funny since 02d0e095031)
>=20
> applied using ./scripts/clean-includes
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  accel/tcg/translate-all.c          | 1 -
>  exec.c                             | 3 ---
>  hw/arm/spitz.c                     | 1 -
>  hw/char/xen_console.c              | 1 -
>  hw/core/machine.c                  | 1 -
>  hw/s390x/css.c                     | 1 -
>  target/openrisc/exception_helper.c | 1 -
>  tests/vhost-user-test.c            | 1 -
>  util/qemu-sockets.c                | 1 -
>  vl.c                               | 1 -
>  10 files changed, 12 deletions(-)

> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 75d4f301fb..3938fa5909 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -13,7 +13,6 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "hw/qdev.h"
> -#include "qemu/error-report.h"
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
>  #include "exec/address-spaces.h"

Acked-by: Cornelia Huck <cohuck@redhat.com>
