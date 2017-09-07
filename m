Received: from eggs.gnu.org ([2001:4830:134:3::10]:36221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dppeP-0002X6-An
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dppeK-0007WE-GW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dppeK-0007Vx-A7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:46:48 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <934be1e8-469e-6d54-bcc1-21e12da2e408@redhat.com>
Date: Thu, 7 Sep 2017 07:46:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/19] exec, dump, i386, ppc,
 s390x: don't include exec/cpu-all.h explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 04.09.2017 17:42, David Hildenbrand wrote:
> All but a handfull of filles include exec/cpu-all.h via cpu.h only.
> As these files already include cpu.h, let's just drop the additional
> include.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  dump.c                            | 1 -
>  exec.c                            | 2 --
>  target/i386/arch_dump.c           | 1 -
>  target/i386/arch_memory_mapping.c | 1 -
>  target/i386/svm_helper.c          | 1 -
>  target/ppc/arch_dump.c            | 1 -
>  target/s390x/arch_dump.c          | 1 -
>  7 files changed, 8 deletions(-)
> 
> diff --git a/dump.c b/dump.c
> index a79773d0f7..2ef6a678e8 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -15,7 +15,6 @@
>  #include "qemu/cutils.h"
>  #include "elf.h"
>  #include "cpu.h"
> -#include "exec/cpu-all.h"
>  #include "exec/hwaddr.h"
>  #include "monitor/monitor.h"
>  #include "sysemu/kvm.h"
> diff --git a/exec.c b/exec.c
> index d20c34ca83..d109de2014 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -23,7 +23,6 @@
>  
>  #include "qemu/cutils.h"
>  #include "cpu.h"
> -#include "exec/exec-all.h"

You should maybe mention exec-all.h in the patch description, too.
(I think it can be dropped here because it is included by
translate-all.h already).

If you tweak the patch description:
Reviewed-by: Thomas Huth <thuth@redhat.com>
