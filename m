Received: from eggs.gnu.org ([2001:4830:134:3::10]:38097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG1ad-0000Nf-4Y
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG1ac-00040h-AJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:19:31 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1525376963-79623-17-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 3 May 2018 22:50:51 +0300")
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-17-git-send-email-mst@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 14:21:27 +0200
Message-ID: <87wowe8hiw.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 16/67] migration: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.

No, it is not by accident.
qemu-version.h and config-host.h are on the root directory.  I could
agree with moving them.

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  migration/block-dirty-bitmap.c | 2 +-
>  migration/page_cache.c         | 2 +-
>  migration/ram.c                | 4 ++--
>  migration/vmstate.c            | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index dd04f10..09c086d 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -66,7 +66,7 @@
>  #include "qemu/error-report.h"
>  #include "migration/misc.h"
>  #include "migration/migration.h"
> -#include "migration/qemu-file.h"
> +#include "qemu-file.h"

Substitite for "./qemu-file.h"?

My wonder here is what happens if we end with a file with the same name in
two places.

Later, Juan.
