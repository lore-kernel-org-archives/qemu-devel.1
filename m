Received: from eggs.gnu.org ([2001:4830:134:3::10]:54138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjKcb-00073u-Cu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjKcY-0002lp-Cq
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:53:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170301142320.8328-1-shah.suramya@gmail.com>
Date: Thu, 02 Mar 2017 07:53:47 +0100
In-Reply-To: <20170301142320.8328-1-shah.suramya@gmail.com> (Suramya Shah's
	message of "Wed, 1 Mar 2017 19:53:20 +0530")
Message-ID: <87r32gp3t0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH]  Removed header qemu-common.h from path.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Copying <qemu-trivial@nongnu.org>.

Suramya Shah <shah.suramya@gmail.com> writes:

> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  util/path.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/util/path.c b/util/path.c
> index 5479f76..46a6098 100644
> --- a/util/path.c
> +++ b/util/path.c
> @@ -6,8 +6,7 @@
>  #include "qemu/osdep.h"
>  #include <sys/param.h>
>  #include <dirent.h>
> -#include "qemu-common.h"
> -#include "qemu/cutils.h"
> +:#include "qemu/cutils.h"
>  #include "qemu/path.h"
>  
>  struct pathelem

I doubt this will compile.  Perhaps the trivial maintainers are willing
to repair it for you.
