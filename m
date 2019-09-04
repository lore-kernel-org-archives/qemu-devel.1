Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A202C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB5622CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB5622CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5QPB-0006bY-5p
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 04:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5QOP-0006D2-PQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5QON-0004AR-AL
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5QON-00049u-1T
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:11:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80D3A3175288;
 Wed,  4 Sep 2019 08:11:49 +0000 (UTC)
Received: from work-vm (ovpn-117-227.ams2.redhat.com [10.36.117.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C65860606;
 Wed,  4 Sep 2019 08:11:31 +0000 (UTC)
Date: Wed, 4 Sep 2019 09:11:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Message-ID: <20190904081129.GA2828@work-vm>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <3bf3631115123d4a6a360b41ef0aaa47b40ff08d.1567534653.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf3631115123d4a6a360b41ef0aaa47b40ff08d.1567534653.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 04 Sep 2019 08:11:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 PATCH 01/45] multi-process: memory: alloc
 RAM from file at offset
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> Allow RAM MemoryRegion to be created from an offset in a file, instead
> of allocating at offset of 0 by default. This is needed to synchronize
> RAM between QEMU & remote process.
> This will be needed for the following patches.
> 
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  exec.c                    | 11 +++++++----
>  include/exec/ram_addr.h   |  2 +-
>  include/qemu/mmap-alloc.h |  3 ++-
>  memory.c                  |  2 +-
>  util/mmap-alloc.c         |  7 ++++---
>  util/oslib-posix.c        |  2 +-
>  6 files changed, 16 insertions(+), 11 deletions(-)

I'm surprised this doesn't change something in
vhost-user.c:vhost_user_set_mem_table so that the vhost-user client
knows what it's mapping?

Dave

> diff --git a/exec.c b/exec.c
> index 3e78de3..b3f1aa9 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1885,6 +1885,7 @@ static void *file_ram_alloc(RAMBlock *block,
>                              ram_addr_t memory,
>                              int fd,
>                              bool truncate,
> +                            off_t offset,
>                              Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> @@ -1936,7 +1937,8 @@ static void *file_ram_alloc(RAMBlock *block,
>      }
>  
>      area = qemu_ram_mmap(fd, memory, block->mr->align,
> -                         block->flags & RAM_SHARED, block->flags & RAM_PMEM);
> +                         block->flags & RAM_SHARED, block->flags & RAM_PMEM,
> +                         offset);
>      if (area == MAP_FAILED) {
>          error_setg_errno(errp, errno,
>                           "unable to map backing store for guest RAM");
> @@ -2325,7 +2327,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>  #ifdef CONFIG_POSIX
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd,
> -                                 Error **errp)
> +                                 off_t offset, Error **errp)
>  {
>      RAMBlock *new_block;
>      Error *local_err = NULL;
> @@ -2370,7 +2372,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      new_block->used_length = size;
>      new_block->max_length = size;
>      new_block->flags = ram_flags;
> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
> +    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
> +                                     errp);
>      if (!new_block->host) {
>          g_free(new_block);
>          return NULL;
> @@ -2400,7 +2403,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>  
> -    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
> +    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, errp);
>      if (!block) {
>          if (created) {
>              unlink(mem_path);
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index b7b2e60..15837a1 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -164,7 +164,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>                                     Error **errp);
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd,
> -                                 Error **errp);
> +                                 off_t offset, Error **errp);
>  
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>                                    MemoryRegion *mr, Error **errp);
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index e786266..4f57985 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -25,7 +25,8 @@ void *qemu_ram_mmap(int fd,
>                      size_t size,
>                      size_t align,
>                      bool shared,
> -                    bool is_pmem);
> +                    bool is_pmem,
> +                    off_t start);
>  
>  void qemu_ram_munmap(int fd, void *ptr, size_t size);
>  
> diff --git a/memory.c b/memory.c
> index 5d8c9a9..debed5e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1622,7 +1622,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
>                                             share ? RAM_SHARED : 0,
> -                                           fd, &err);
> +                                           fd, 0, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
>          mr->size = int128_zero();
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index f7f177d..4b727bd 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -86,7 +86,8 @@ void *qemu_ram_mmap(int fd,
>                      size_t size,
>                      size_t align,
>                      bool shared,
> -                    bool is_pmem)
> +                    bool is_pmem,
> +                    off_t start)
>  {
>      int flags;
>      int map_sync_flags = 0;
> @@ -147,7 +148,7 @@ void *qemu_ram_mmap(int fd,
>      offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
>  
>      ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -               flags | map_sync_flags, fd, 0);
> +               flags | map_sync_flags, fd, start);
>  
>      if (ptr == MAP_FAILED && map_sync_flags) {
>          if (errno == ENOTSUP) {
> @@ -172,7 +173,7 @@ void *qemu_ram_mmap(int fd,
>           * we will remove these flags to handle compatibility.
>           */
>          ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -                   flags, fd, 0);
> +                   flags, fd, start);
>      }
>  
>      if (ptr == MAP_FAILED) {
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index fe0309c..f6a243f 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -204,7 +204,7 @@ void *qemu_memalign(size_t alignment, size_t size)
>  void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
>  {
>      size_t align = QEMU_VMALLOC_ALIGN;
> -    void *ptr = qemu_ram_mmap(-1, size, align, shared, false);
> +    void *ptr = qemu_ram_mmap(-1, size, align, shared, false, 0);
>  
>      if (ptr == MAP_FAILED) {
>          return NULL;
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

