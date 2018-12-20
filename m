Received: from eggs.gnu.org ([2001:4830:134:3::10]:47526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZvOL-0007Ek-8q
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZvOH-00063o-A2
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:17:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZvOH-000633-30
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:17:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so1341602wmc.5
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 02:17:17 -0800 (PST)
References: <20181220084559.13880-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <863f502f-9e16-3367-5844-5906fa213846@redhat.com>
Date: Thu, 20 Dec 2018 11:17:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181220084559.13880-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, r.bolshakov@yadro.com

On 12/20/18 9:45 AM, Markus Armbruster wrote:
> Avoids pointless recompilation.  Missed in commit 112ed241f5d.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 
