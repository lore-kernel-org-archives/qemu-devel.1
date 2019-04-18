Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5946C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 22:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928F620693
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 22:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928F620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHFBM-0006sf-AS
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 18:07:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHFA0-00068a-Sg
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHF9y-00038w-Fv
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHF9t-00030s-68
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:05:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1320B307DAC8;
	Thu, 18 Apr 2019 22:05:23 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15A3C5C21F;
	Thu, 18 Apr 2019 22:05:17 +0000 (UTC)
Date: Thu, 18 Apr 2019 19:05:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Message-ID: <20190418220516.GP25134@habkost.net>
References: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
	<5d07bf7e9a3e576f5a87e81d786e8886fb2bb551.1549555521.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <5d07bf7e9a3e576f5a87e81d786e8886fb2bb551.1549555521.git.yi.z.zhang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 18 Apr 2019 22:05:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V13 4/5] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
	yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com,
	stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418220516.sXBFkSxMIcYvtweDkyzNLwUPTshaGVhf2gge4_TVnK4@z>

Hi,

I found out that this series missed QEMU 4.0 and I was going to
queue for 4.1, but unfortunately this patch conflicts with:

commit 2044c3e7116eeac0449dcb4a4130cc8f8b9310da
Author: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Date:   Wed Jan 30 21:36:04 2019 -0200

    mmap-alloc: unfold qemu_ram_mmap()
    
    Unfold parts of qemu_ram_mmap() for the sake of understanding, moving
    declarations to the top, and keeping architecture-specifics in the
    ifdef-else blocks.  No changes in the function behaviour.
    
    Give ptr and ptr1 meaningful names:
      ptr  -> guardptr : pointer to the PROT_NONE guard region
      ptr1 -> ptr      : pointer to the mapped memory returned to caller
    
    Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
    Reviewed-by: Greg Kurz <groug@kaod.org>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

I'm queueing patches 1-3 into machine-next[1], so only patches 4
and 5 need to be refreshed and resubmitted.

[1] https://github.com/ehabkost/qemu.git machine-next


On Fri, Feb 08, 2019 at 06:11:11PM +0800, Zhang, Yi wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
> 
> When a file supporting DAX is used as vNVDIMM backend, mmap it with
> MAP_SYNC flag in addition which can ensure file system metadata
> synced in each guest writes to the backend file, without other QEMU
> actions (e.g., periodic fsync() by QEMU).
> 
> Current, We have below different possible use cases:
> 
> 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
>    a: backend is a dax supporting file.
>     - MAP_SYNC will active.
>    b: backend is not a dax supporting file.
>     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
> 
> 2. The rest of cases:
>    - we will never pass the MAP_SYNC to mmap2
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  util/mmap-alloc.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 97bbeed..2f21efd 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -10,6 +10,13 @@
>   * later.  See the COPYING file in the top-level directory.
>   */
>  
> +#ifdef CONFIG_LINUX
> +#include <linux/mman.h>
> +#else  /* !CONFIG_LINUX */
> +#define MAP_SYNC              0x0
> +#define MAP_SHARED_VALIDATE   0x0
> +#endif /* CONFIG_LINUX */
> +
>  #include "qemu/osdep.h"
>  #include "qemu/mmap-alloc.h"
>  #include "qemu/host-utils.h"
> @@ -101,6 +108,8 @@ void *qemu_ram_mmap(int fd,
>  #else
>      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  #endif
> +    int mmap_flags;
> +    int map_sync_flags = 0;
>      size_t offset;
>      void *ptr1;
>  
> @@ -111,13 +120,47 @@ void *qemu_ram_mmap(int fd,
>      assert(is_power_of_2(align));
>      /* Always align to host page size */
>      assert(align >= getpagesize());
> +    mmap_flags = shared ? MAP_SHARED : MAP_PRIVATE;
> +    if (shared && is_pmem) {
> +        map_sync_flags = MAP_SYNC | MAP_SHARED_VALIDATE;
> +        mmap_flags |= map_sync_flags;
> +    }
>  
>      offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
>      ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
>                  MAP_FIXED |
>                  (fd == -1 ? MAP_ANONYMOUS : 0) |
> -                (shared ? MAP_SHARED : MAP_PRIVATE),
> +                mmap_flags,
>                  fd, 0);
> +
> +
> +    if (ptr1 == MAP_FAILED && map_sync_flags) {
> +        if (errno == ENOTSUP) {
> +            char *proc_link, *file_name;
> +            int len;
> +            proc_link = g_strdup_printf("/proc/self/fd/%d", fd);
> +            file_name = g_malloc0(PATH_MAX);
> +            len = readlink(proc_link, file_name, PATH_MAX - 1);
> +            if (len < 0) {
> +                len = 0;
> +            }
> +            file_name[len] = '\0';
> +            fprintf(stderr, "Warning: requesting persistence across crashes "
> +                    "for backend file %s failed. Proceeding without "
> +                    "persistence, data might become corrupted in case of host "
> +                    "crash.\n", file_name);
> +            g_free(proc_link);
> +            g_free(file_name);
> +        }
> +        /* if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
> +         * we will remove these flags to handle compatibility.
> +         */
> +        ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
> +                    MAP_FIXED |
> +                    (fd == -1 ? MAP_ANONYMOUS : 0) |
> +                    MAP_SHARED,
> +                    fd, 0);
> +    }
>      if (ptr1 == MAP_FAILED) {
>          munmap(ptr, total);
>          return MAP_FAILED;
> -- 
> 2.7.4
> 
> 

-- 
Eduardo

