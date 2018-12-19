Received: from eggs.gnu.org ([2001:4830:134:3::10]:58882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZk5D-0005At-RS
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZk5A-0003jZ-AV
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:12:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZk5A-0003gu-2w
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:12:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so20902138wrr.12
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 14:12:48 -0800 (PST)
References: <20181219091248.9641-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8b2c9fa-5524-7a43-c6ac-ee2d246a0b00@redhat.com>
Date: Wed, 19 Dec 2018 23:12:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181219091248.9641-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 12/19/18 10:12 AM, Markus Armbruster wrote:
> Avoids pointless recompilation.  Missed in commit 112ed241f5d.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> Untested; I don't have access to a Mac.

You kinda do, open a GitHub account and enable Travis-CI (free for
public projects), then pushing a branch to your GitHub will trigger a
Travis build:

https://travis-ci.org/philmd/qemu/jobs/470146270#L3047

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
> 
