Received: from eggs.gnu.org ([2001:4830:134:3::10]:38078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gZfEV-0004Zz-0q
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gZfEO-0001fG-Sa
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:02:06 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:47414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gZfEM-0001ZE-MT
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:02:00 -0500
Date: Wed, 19 Dec 2018 20:01:50 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20181219170150.m2tmhhg3tuyfrnvx@SPB-NB-133.local>
References: <20181219091248.9641-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181219091248.9641-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa: Include less of the generated
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Dec 19, 2018 at 10:12:48AM +0100, Markus Armbruster wrote:
> Avoids pointless recompilation.  Missed in commit 112ed241f5d.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> Untested; I don't have access to a Mac.
> 
>  ui/cocoa.m | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index ecf12bfc2e..43e751693c 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -32,7 +32,8 @@
>  #include "ui/input.h"
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands.h"
> +#include "qapi/qapi-commands-block-core.h"
> +#include "qapi/qapi-commands-misc.h"
>  #include "sysemu/blockdev.h"
>  #include "qemu-version.h"
>  #include <Carbon/Carbon.h>
> -- 
> 2.17.2
> 
> 

Hi Markus,

You should change change qapi/qapi-commands-block-core.h to
qapi/qapi-commands-block.h to avoid:

ui/cocoa.m:1225:5: warning: implicit declaration of function 'qmp_eject' is invalid in C99 [-Wimplicit-function-declaration]
    qmp_eject(true, [drive cStringUsingEncoding: NSASCIIStringEncoding],
    ^
ui/cocoa.m:1225:5: warning: this function declaration is not a prototype [-Wstrict-prototypes]

Thanks,
Roman
