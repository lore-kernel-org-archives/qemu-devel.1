Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eIX-0007Jz-9L
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eIU-0005oE-3g
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:09:57 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eIT-0005nz-Vu
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:09:54 -0400
Received: by mail-qk0-x242.google.com with SMTP id u75so12271302qka.1
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 14:09:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170512160055.9081-1-quintela@redhat.com>
	<20170512160055.9081-12-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f52eede-8595-c336-0cd8-33495bccd2b6@amsat.org>
Date: Sat, 13 May 2017 18:09:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170512160055.9081-12-quintela@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/12] migration: Remove vmstate.h from
 migration.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 05/12/2017 01:00 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
> --
>
> Minor rearrangements due to rebase
> ---
>  include/migration/migration.h | 1 -
>  migration/block.c             | 1 +
>  migration/colo-comm.c         | 1 +
>  migration/migration.c         | 1 +
>  migration/ram.c               | 1 +
>  5 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 5ae21e6..a564ecd 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -18,7 +18,6 @@
>  #include "qemu-common.h"
>  #include "qemu/thread.h"
>  #include "qemu/notify.h"
> -#include "migration/vmstate.h"
>  #include "io/channel.h"
>  #include "qapi-types.h"
>  #include "exec/cpu-common.h"
> diff --git a/migration/block.c b/migration/block.c
> index d2923b3..c919787 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -27,6 +27,7 @@
>  #include "migration/migration.h"
>  #include "sysemu/blockdev.h"
>  #include "migration/qemu-file.h"
> +#include "migration/vmstate.h"
>  #include "sysemu/block-backend.h"
>
>  #define BLOCK_SIZE                       (1 << 20)
> diff --git a/migration/colo-comm.c b/migration/colo-comm.c
> index 9b35027..b4288b8 100644
> --- a/migration/colo-comm.c
> +++ b/migration/colo-comm.c
> @@ -13,6 +13,7 @@
>
>  #include "qemu/osdep.h"
>  #include "migration/migration.h"
> +#include "migration/vmstate.h"
>  #include "colo.h"
>  #include "trace.h"
>
> diff --git a/migration/migration.c b/migration/migration.c
> index a5a17fe..7ac09f0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -21,6 +21,7 @@
>  #include "migration/migration.h"
>  #include "qemu-file-channel.h"
>  #include "migration/qemu-file.h"
> +#include "migration/vmstate.h"
>  #include "sysemu/sysemu.h"
>  #include "block/block.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/migration/ram.c b/migration/ram.c
> index ce5019b..abd97d9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -38,6 +38,7 @@
>  #include "xbzrle.h"
>  #include "migration/migration.h"
>  #include "migration/qemu-file.h"
> +#include "migration/vmstate.h"
>  #include "postcopy-ram.h"
>  #include "exec/address-spaces.h"
>  #include "migration/page_cache.h"
>
