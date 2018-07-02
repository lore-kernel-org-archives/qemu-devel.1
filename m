Received: from eggs.gnu.org ([2001:4830:134:3::10]:54965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZuKf-0000d4-B0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZuKc-0000qr-8r
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:37:13 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:43114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZuKc-0000pS-1Q
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:37:10 -0400
Received: by mail-wr0-f182.google.com with SMTP id f18-v6so888758wre.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 01:37:09 -0700 (PDT)
References: <CABgObfazhaOHnDT_Le6aPd0_SNDXOcfQrnj+zU5mf-akmyjNZA@mail.gmail.com>
	<20180630165057.21632-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f2690d0-14fa-0fcc-c068-70d573b9211d@redhat.com>
Date: Mon, 2 Jul 2018 10:37:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180630165057.21632-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] !fixup
 052f529eb3d07170b18b8d0920bc8c450e389a2f
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 30/06/2018 18:50, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> This was in e9dd993d-875f-4173-f68e-e6b4e75e3aa1@amsat.org but I can't
> find it on the list...
> 
>  tests/test-cutils.c    | 2 +-
>  tests/test-qemu-opts.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index a6e5fe4984..d85c3e0f6d 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -26,7 +26,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -
> +#include "qemu/units.h"
>  #include "qemu/cutils.h"
>  #include "qemu/units.h"
>  
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index fd4d848f66..43869cb754 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -8,7 +8,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/cutils.h"
> +#include "qemu/units.h"
>  #include "qemu/option.h"
>  #include "qemu/option_int.h"
>  #include "qapi/error.h"
> 

Squashed, thanks.

Paolo
