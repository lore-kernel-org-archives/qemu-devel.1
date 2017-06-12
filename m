Received: from eggs.gnu.org ([2001:4830:134:3::10]:57039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKMpj-0003cV-1l
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKMpf-0008Pc-Mw
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:44:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dKMpf-0008PM-Ee
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:44:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70C195D689
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 10:44:26 +0000 (UTC)
References: <20170601212921.30241-1-quintela@redhat.com>
	<20170601212921.30241-6-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <685b43c5-0b43-fcd6-8780-211999a72d6b@redhat.com>
Date: Mon, 12 Jun 2017 12:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170601212921.30241-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/11] migration: Move constants to savevm.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 01/06/2017 23:29, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  include/migration/migration.h | 15 ---------------
>  migration/savevm.h            | 15 +++++++++++++++
>  migration/vmstate.c           |  1 +
>  tests/test-vmstate.c          |  1 +
>  4 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 79b5484..dd52d3c 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -22,21 +22,6 @@
>  #include "exec/cpu-common.h"
>  #include "qemu/coroutine_int.h"
>  
> -#define QEMU_VM_FILE_MAGIC           0x5145564d
> -#define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
> -#define QEMU_VM_FILE_VERSION         0x00000003
> -
> -#define QEMU_VM_EOF                  0x00
> -#define QEMU_VM_SECTION_START        0x01
> -#define QEMU_VM_SECTION_PART         0x02
> -#define QEMU_VM_SECTION_END          0x03
> -#define QEMU_VM_SECTION_FULL         0x04
> -#define QEMU_VM_SUBSECTION           0x05
> -#define QEMU_VM_VMDESCRIPTION        0x06
> -#define QEMU_VM_CONFIGURATION        0x07
> -#define QEMU_VM_COMMAND              0x08
> -#define QEMU_VM_SECTION_FOOTER       0x7e
> -
>  /* Messages sent on the return path from destination to source */
>  enum mig_rp_message_type {
>      MIG_RP_MSG_INVALID = 0,  /* Must be 0 */
> diff --git a/migration/savevm.h b/migration/savevm.h
> index eb44877..45b59c1 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -14,6 +14,21 @@
>  #ifndef MIGRATION_SAVEVM_H
>  #define MIGRATION_SAVEVM_H
>  
> +#define QEMU_VM_FILE_MAGIC           0x5145564d
> +#define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
> +#define QEMU_VM_FILE_VERSION         0x00000003
> +
> +#define QEMU_VM_EOF                  0x00
> +#define QEMU_VM_SECTION_START        0x01
> +#define QEMU_VM_SECTION_PART         0x02
> +#define QEMU_VM_SECTION_END          0x03
> +#define QEMU_VM_SECTION_FULL         0x04
> +#define QEMU_VM_SUBSECTION           0x05
> +#define QEMU_VM_VMDESCRIPTION        0x06
> +#define QEMU_VM_CONFIGURATION        0x07
> +#define QEMU_VM_COMMAND              0x08
> +#define QEMU_VM_SECTION_FOOTER       0x7e
> +
>  bool qemu_savevm_state_blocked(Error **errp);
>  void qemu_savevm_state_begin(QEMUFile *f);
>  void qemu_savevm_state_header(QEMUFile *f);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 51a19b6..377d951 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -14,6 +14,7 @@
>  #include "qemu-common.h"
>  #include "migration/migration.h"
>  #include "migration/vmstate.h"
> +#include "migration/savevm.h"
>  #include "qemu-file.h"
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index c52aff9..f30433a 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -30,6 +30,7 @@
>  #include "migration/qemu-file-types.h"
>  #include "../migration/qemu-file.h"
>  #include "../migration/qemu-file-channel.h"
> +#include "../migration/savevm.h"
>  #include "qemu/coroutine.h"
>  #include "io/channel-file.h"
>  
> 
