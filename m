Received: from eggs.gnu.org ([209.51.188.92]:44668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggslG-0000ED-JG
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggslD-0001fK-4V
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:53:45 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggslB-0001Q0-VO
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:53:42 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so3717382otk.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 06:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20181220084559.13880-1-armbru@redhat.com>
In-Reply-To: <20181220084559.13880-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 14:53:25 +0000
Message-ID: <CAFEAcA-DeefmbqJP2sJs5VPTGMA5RztdkYeYf41UEOQ2WDzc8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa: Include less of the generated
 modular QAPI headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Roman Bolshakov <r.bolshakov@yadro.com>

On Thu, 20 Dec 2018 at 08:46, Markus Armbruster <armbru@redhat.com> wrote:
>
> Avoids pointless recompilation.  Missed in commit 112ed241f5d.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  ui/cocoa.m | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index ecf12bfc2e..ddc058e76e 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -32,7 +32,8 @@
>  #include "ui/input.h"
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands.h"
> +#include "qapi/qapi-commands-block.h"
> +#include "qapi/qapi-commands-misc.h"
>  #include "sysemu/blockdev.h"
>  #include "qemu-version.h"
>  #include <Carbon/Carbon.h>
> --

Applied, thanks.

-- PMM
