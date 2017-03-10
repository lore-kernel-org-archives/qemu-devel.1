Received: from eggs.gnu.org ([2001:4830:134:3::10]:58022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cmO2q-0006vm-Ds
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 12:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cmO2m-0001Bj-E8
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 12:09:36 -0500
References: <20170310163948.7567-1-shah.suramya@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b156f0e-4700-c268-d60d-6b23b24d69b0@redhat.com>
Date: Fri, 10 Mar 2017 18:09:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170310163948.7567-1-shah.suramya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] util: Removed unneeded header from
 path.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, QEMU Trivial <qemu-trivial@nongnu.org>

On 10.03.2017 17:39, Suramya Shah wrote:
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> --- 
> qemu-common.h is no longer necessary as of refactoring done in commit f348b6d.
>  util/path.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/util/path.c b/util/path.c
> index 5479f76..7f9fc27 100644
> --- a/util/path.c
> +++ b/util/path.c
> @@ -6,7 +6,6 @@
>  #include "qemu/osdep.h"
>  #include <sys/param.h>
>  #include <dirent.h>
> -#include "qemu-common.h"
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"

Reviewed-by: Thomas Huth <thuth@redhat.com>

(and putting qemu-trivial on CC: for this)
