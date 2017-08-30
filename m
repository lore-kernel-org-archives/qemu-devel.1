Received: from eggs.gnu.org ([2001:4830:134:3::10]:35705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn893-0007JQ-9L
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn890-00014W-PK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:55:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dn890-00014H-Ia
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:55:18 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d05eb222-8b39-4ec6-2a2b-34a255becd43@redhat.com>
Date: Wed, 30 Aug 2017 20:55:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170830170601.15855-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 01/11] exec,
 dump: don't include exec/exec-all.h explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 30.08.2017 19:05, David Hildenbrand wrote:
> All but two, namely exec.c and dump.c, include exec/exec-all.h via
> cpu.h only. as these files already include cpu.h, let's just drop the
> additional include.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  dump.c | 1 -
>  exec.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/dump.c b/dump.c
> index d9090a24cc..c00094475c 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -15,7 +15,6 @@
>  #include "qemu/cutils.h"
>  #include "elf.h"
>  #include "cpu.h"
> -#include "exec/cpu-all.h"

That's cpu-all.h, not exec-all.h ...

>  #include "exec/hwaddr.h"
>  #include "monitor/monitor.h"
>  #include "sysemu/kvm.h"
> diff --git a/exec.c b/exec.c
> index d20c34ca83..8d8b6a0769 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -23,7 +23,6 @@
>  
>  #include "qemu/cutils.h"
>  #include "cpu.h"
> -#include "exec/exec-all.h"
>  #include "exec/target_page.h"
>  #include "tcg.h"
>  #include "hw/qdev-core.h"

... and if I do a grep for exec-all.h in the cpu.h files, I hardly get
any matches. => Your patch description sounds wrong ... I guess you only
wanted to handle cpu-all.h here?

 Thomas
