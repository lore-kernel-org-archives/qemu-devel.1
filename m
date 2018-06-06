Received: from eggs.gnu.org ([2001:4830:134:3::10]:59576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQdEG-00036a-Ac
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQdEF-0006qX-Gw
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:32:16 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:32947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQdEF-0006pw-Ad
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:32:15 -0400
Received: by mail-ot0-x241.google.com with SMTP id h6-v6so8448532otj.0
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 11:32:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606173233.28080-4-berrange@redhat.com>
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-4-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Jun 2018 19:31:53 +0100
Message-ID: <CAFEAcA-_e7mMB07fOCN6qmm-9YTPG2HSMJ3-z=0wRHaa+uTteA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util: remove redundant include of
 glib.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On 6 June 2018 at 18:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrot=
e:
> Code must only ever include glib.h indirectly via the glib-compat.h
> header file, because we will need some macros set before glib.h is
> pulled in. Adding extra includes of glib.h will (soon) cause compile
> failures such as:
>
> In file included from /home/berrange/src/virt/qemu/include/qemu/osdep.h:1=
07,
>                  from /home/berrange/src/virt/qemu/include/qemu/iova-tree=
.h:26,
>                  from util/iova-tree.c:13:
> /home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLIB_VERSI=
ON_MIN_REQUIRED" redefined [-Werror]
>  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
>
> In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
>                  from /usr/include/glib-2.0/glib/galloca.h:32,
>                  from /usr/include/glib-2.0/glib.h:30,
>                  from util/iova-tree.c:12:
> /usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the locati=
on of the previous definition
>  # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/iova-tree.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/util/iova-tree.c b/util/iova-tree.c
> index 2d9cebfc89..d39cd8bb29 100644
> --- a/util/iova-tree.c
> +++ b/util/iova-tree.c
> @@ -9,7 +9,6 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   */
>
> -#include <glib.h>
>  #include "qemu/iova-tree.h"

While we're fixing up the headers in this file:
it should start with an include of qemu/osdep.h,
and qemu/iova-tree.h should not include osdep.h...

thanks
-- PMM
