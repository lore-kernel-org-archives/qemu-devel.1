Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4596821789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZDptCQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4596821789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbJu-0001wl-0S
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQbIu-0001F6-TA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQbIq-0004o0-EK
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602184211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDiB/MPXEqzS0pwXTJfWlf5v3fxsceKNYZTCFi7NMOA=;
 b=QZDptCQW1crKyTlETybDM6SzYGm1TCqH0/b5h9WNuSmFcc9J9k2Ch7/uw5lR2i0V6ywBiI
 R5R2zT74MgaYa/kuNsyMVIF9qhBzVcq8VPgTwPT8PMdwYQt6aPfX8DF4BJX6mlpwhRoLTC
 lua4KGczhhtic2dp5Sejsa/o5Xhia3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-cwpJaagvOaOTp6Am_2Sy0Q-1; Thu, 08 Oct 2020 15:10:06 -0400
X-MC-Unique: cwpJaagvOaOTp6Am_2Sy0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1069B1019625;
 Thu,  8 Oct 2020 19:10:05 +0000 (UTC)
Received: from work-vm (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 513C3702E7;
 Thu,  8 Oct 2020 19:09:57 +0000 (UTC)
Date: Thu, 8 Oct 2020 20:09:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/10] migration queue
Message-ID: <20201008190955.GG2962@work-vm>
References: <20201007155600.337316-1-dgilbert@redhat.com>
 <CAFEAcA9fjk5gpuV5Pq46DS8gux0gkY1fkhn=GU6W=B9jdAKBdg@mail.gmail.com>
 <20201008185114.GB376361@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20201008185114.GB376361@xz-x1>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 zhengchuan@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Oct 08, 2020 at 05:18:14PM +0100, Peter Maydell wrote:
> > Compile failure, windows crossbuilds:
> > 
> > ../../migration/migration.c: In function 'page_request_addr_cmp':
> > ../../migration/migration.c:148:23: error: cast from pointer to
> > integer of different size [-Werror=pointer-to-int-cast]
> >      unsigned long a = (unsigned long) ap, b = (unsigned long) bp;
> >                        ^
> > ../../migration/migration.c:148:47: error: cast from pointer to
> > integer of different size [-Werror=pointer-to-int-cast]
> >      unsigned long a = (unsigned long) ap, b = (unsigned long) bp;
> >                                                ^
> 
> Below squashed into "migration: Maintain postcopy faulted addresses" should fix
> the problem:
> 
> ------8<------
> diff --git a/migration/migration.c b/migration/migration.c
> index e7d179bffc..d8a5c0de44 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -145,7 +145,7 @@ static void migrate_fd_cancel(MigrationState *s);
>  
>  static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
>  {
> -    unsigned long a = (unsigned long) ap, b = (unsigned long) bp;
> +    uintptr_t a = (uintptr_t) ap, b = (uintptr_t) bp;
>  
>      return (a > b) - (a < b);
>  }
> ------8<------
> 
> A whole replacement patch attached too.
> 
> Thanks!
> 


> -- 
> Peter Xu

> From 6d5708092466abb2ed683f9ef24021e2edf25872 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 28 Aug 2020 18:02:14 -0400
> Subject: [PATCH] migration: Maintain postcopy faulted addresses
> 
> Maintain a list of faulted addresses on the destination host for which we're
> waiting on.  This is implemented using a GTree rather than a real list to make
> sure even there're plenty of vCPUs/threads that are faulting, the lookup will
> still be fast with O(log(N)) (because we'll do that after placing each page).
> It should bring a slight overhead, but ideally that shouldn't be a big problem
> simply because in most cases the requested page list will be short.
> 
> Actually we did similar things for postcopy blocktime measurements.  This patch
> didn't use that simply because:
> 
>   (1) blocktime measurement is towards vcpu threads only, but here we need to
>       record all faulted addresses, including main thread and external
>       thread (like, DPDK via vhost-user).
> 
>   (2) blocktime measurement will require UFFD_FEATURE_THREAD_ID, but here we
>       don't want to add that extra dependency on the kernel version since not
>       necessary.  E.g., we don't need to know which thread faulted on which
>       page, we also don't care about multiple threads faulting on the same
>       page.  But we only care about what addresses are faulted so waiting for a
>       page copying from src.
> 
>   (3) blocktime measurement is not enabled by default.  However we need this by
>       default especially for postcopy recover.
> 
> Another thing to mention is that this patch introduced a new mutex to serialize
> the receivedmap and the page_requested tree, however that serialization does
> not cover other procedures like UFFDIO_COPY.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Respin with that replacing the original coming up.

Dave

> ---
>  migration/migration.c    | 41 +++++++++++++++++++++++++++++++++++++++-
>  migration/migration.h    | 19 ++++++++++++++++++-
>  migration/postcopy-ram.c | 17 ++++++++++++++---
>  migration/trace-events   |  2 ++
>  4 files changed, 74 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b2dac6b39c..d8a5c0de44 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -143,6 +143,13 @@ static int migration_maybe_pause(MigrationState *s,
>                                   int new_state);
>  static void migrate_fd_cancel(MigrationState *s);
>  
> +static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
> +{
> +    uintptr_t a = (uintptr_t) ap, b = (uintptr_t) bp;
> +
> +    return (a > b) - (a < b);
> +}
> +
>  void migration_object_init(void)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> @@ -165,6 +172,8 @@ void migration_object_init(void)
>      qemu_event_init(&current_incoming->main_thread_load_event, false);
>      qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
>      qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
> +    qemu_mutex_init(&current_incoming->page_request_mutex);
> +    current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
>  
>      if (!migration_object_check(current_migration, &err)) {
>          error_report_err(err);
> @@ -240,6 +249,11 @@ void migration_incoming_state_destroy(void)
>  
>      qemu_event_reset(&mis->main_thread_load_event);
>  
> +    if (mis->page_requested) {
> +        g_tree_destroy(mis->page_requested);
> +        mis->page_requested = NULL;
> +    }
> +
>      if (mis->socket_address_list) {
>          qapi_free_SocketAddressList(mis->socket_address_list);
>          mis->socket_address_list = NULL;
> @@ -354,8 +368,33 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
>  }
>  
>  int migrate_send_rp_req_pages(MigrationIncomingState *mis,
> -                              RAMBlock *rb, ram_addr_t start)
> +                              RAMBlock *rb, ram_addr_t start, uint64_t haddr)
>  {
> +    void *aligned = (void *)(uintptr_t)(haddr & (-qemu_target_page_size()));
> +    bool received;
> +
> +    WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
> +        received = ramblock_recv_bitmap_test_byte_offset(rb, start);
> +        if (!received && !g_tree_lookup(mis->page_requested, aligned)) {
> +            /*
> +             * The page has not been received, and it's not yet in the page
> +             * request list.  Queue it.  Set the value of element to 1, so that
> +             * things like g_tree_lookup() will return TRUE (1) when found.
> +             */
> +            g_tree_insert(mis->page_requested, aligned, (gpointer)1);
> +            mis->page_requested_count++;
> +            trace_postcopy_page_req_add(aligned, mis->page_requested_count);
> +        }
> +    }
> +
> +    /*
> +     * If the page is there, skip sending the message.  We don't even need the
> +     * lock because as long as the page arrived, it'll be there forever.
> +     */
> +    if (received) {
> +        return 0;
> +    }
> +
>      return migrate_send_rp_message_req_pages(mis, rb, start);
>  }
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index e853ccf8b1..8d2d1ce839 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -104,6 +104,23 @@ struct MigrationIncomingState {
>  
>      /* List of listening socket addresses  */
>      SocketAddressList *socket_address_list;
> +
> +    /* A tree of pages that we requested to the source VM */
> +    GTree *page_requested;
> +    /* For debugging purpose only, but would be nice to keep */
> +    int page_requested_count;
> +    /*
> +     * The mutex helps to maintain the requested pages that we sent to the
> +     * source, IOW, to guarantee coherent between the page_requests tree and
> +     * the per-ramblock receivedmap.  Note! This does not guarantee consistency
> +     * of the real page copy procedures (using UFFDIO_[ZERO]COPY).  E.g., even
> +     * if one bit in receivedmap is cleared, UFFDIO_COPY could have happened
> +     * for that page already.  This is intended so that the mutex won't
> +     * serialize and blocked by slow operations like UFFDIO_* ioctls.  However
> +     * this should be enough to make sure the page_requested tree always
> +     * contains valid information.
> +     */
> +    QemuMutex page_request_mutex;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> @@ -332,7 +349,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
>  void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
>  int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
> -                              ram_addr_t start);
> +                              ram_addr_t start, uint64_t haddr);
>  int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
>                                        RAMBlock *rb, ram_addr_t start);
>  void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 722034dc01..ca1daf0024 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -684,7 +684,7 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
>                                          qemu_ram_get_idstr(rb), rb_offset);
>          return postcopy_wake_shared(pcfd, client_addr, rb);
>      }
> -    migrate_send_rp_req_pages(mis, rb, aligned_rbo);
> +    migrate_send_rp_req_pages(mis, rb, aligned_rbo, client_addr);
>      return 0;
>  }
>  
> @@ -979,7 +979,8 @@ retry:
>               * Send the request to the source - we want to request one
>               * of our host page sizes (which is >= TPS)
>               */
> -            ret = migrate_send_rp_req_pages(mis, rb, rb_offset);
> +            ret = migrate_send_rp_req_pages(mis, rb, rb_offset,
> +                                            msg.arg.pagefault.address);
>              if (ret) {
>                  /* May be network failure, try to wait for recovery */
>                  if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
> @@ -1149,10 +1150,20 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
>          ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
>      }
>      if (!ret) {
> +        qemu_mutex_lock(&mis->page_request_mutex);
>          ramblock_recv_bitmap_set_range(rb, host_addr,
>                                         pagesize / qemu_target_page_size());
> +        /*
> +         * If this page resolves a page fault for a previous recorded faulted
> +         * address, take a special note to maintain the requested page list.
> +         */
> +        if (g_tree_lookup(mis->page_requested, host_addr)) {
> +            g_tree_remove(mis->page_requested, host_addr);
> +            mis->page_requested_count--;
> +            trace_postcopy_page_req_del(host_addr, mis->page_requested_count);
> +        }
> +        qemu_mutex_unlock(&mis->page_request_mutex);
>          mark_postcopy_blocktime_end((uintptr_t)host_addr);
> -
>      }
>      return ret;
>  }
> diff --git a/migration/trace-events b/migration/trace-events
> index 338f38b3dd..e4d5eb94ca 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -162,6 +162,7 @@ postcopy_pause_return_path(void) ""
>  postcopy_pause_return_path_continued(void) ""
>  postcopy_pause_continued(void) ""
>  postcopy_start_set_run(void) ""
> +postcopy_page_req_add(void *addr, int count) "new page req %p total %d"
>  source_return_path_thread_bad_end(void) ""
>  source_return_path_thread_end(void) ""
>  source_return_path_thread_entry(void) ""
> @@ -272,6 +273,7 @@ postcopy_ram_incoming_cleanup_blocktime(uint64_t total) "total blocktime %" PRIu
>  postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset 0x%"PRIx64
>  postcopy_request_shared_page_present(const char *sharer, const char *rb, uint64_t rb_offset) "%s already %s offset 0x%"PRIx64
>  postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx64" in %s"
> +postcopy_page_req_del(void *addr, int count) "resolved page req %p total %d"
>  
>  get_mem_fault_cpu_index(int cpu, uint32_t pid) "cpu: %d, pid: %u"
>  
> -- 
> 2.26.2
> 

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


