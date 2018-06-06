Received: from eggs.gnu.org ([2001:4830:134:3::10]:49786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQcVH-0003nc-QC
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQcVD-0001Gf-SB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:45:47 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:40430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQcVD-0001GO-Jb
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:45:43 -0400
Received: by mail-qk0-x242.google.com with SMTP id r66-v6so4506021qkr.7
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 10:45:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ccef0f39-020e-04fb-373e-02299ccde64d@amsat.org>
Date: Wed, 6 Jun 2018 14:45:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180606173233.28080-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 06/06/2018 02:32 PM, Daniel P. Berrangé wrote:
> Code must only ever include glib.h indirectly via the glib-compat.h
> header file, because we will need some macros set before glib.h is
> pulled in. Adding extra includes of glib.h will (soon) cause compile
> failures such as:
> 
> In file included from /home/berrange/src/virt/qemu/include/qemu/osdep.h:107,
>                  from /home/berrange/src/virt/qemu/include/qemu/iova-tree.h:26,
>                  from util/iova-tree.c:13:
> /home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLIB_VERSION_MIN_REQUIRED" redefined [-Werror]
>  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
> 
> In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
>                  from /usr/include/glib-2.0/glib/galloca.h:32,
>                  from /usr/include/glib-2.0/glib.h:30,
>                  from util/iova-tree.c:12:
> /usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the location of the previous definition
>  # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/iova-tree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/util/iova-tree.c b/util/iova-tree.c
> index 2d9cebfc89..d39cd8bb29 100644
> --- a/util/iova-tree.c
> +++ b/util/iova-tree.c
> @@ -9,7 +9,6 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   */
>  
> -#include <glib.h>
>  #include "qemu/iova-tree.h"
>  
>  struct IOVATree {
> 
