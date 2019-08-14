Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748CBC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BB020665
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BB020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxw4d-0000hU-9l
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 12:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hxw3Q-0008S5-1W
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hxw3N-00006B-IK
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:23:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hxw3J-0008TS-P8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:23:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92E7F306E171
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 16:23:08 +0000 (UTC)
Received: from work-vm (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C86B6832AC;
 Wed, 14 Aug 2019 16:23:07 +0000 (UTC)
Date: Wed, 14 Aug 2019 17:23:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190814162305.GN2920@work-vm>
References: <20190814020218.1868-1-quintela@redhat.com>
 <20190814020218.1868-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814020218.1868-6-quintela@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 14 Aug 2019 16:23:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/6] migration: add some multifd traces
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued
> ---
>  migration/ram.c        | 3 +++
>  migration/trace-events | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f1aec95f83..25a211c3fb 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1173,6 +1173,7 @@ static void *multifd_send_thread(void *opaque)
>  
>  out:
>      if (local_err) {
> +        trace_multifd_send_error(p->id);
>          multifd_send_terminate_threads(local_err);
>      }
>  
> @@ -1203,6 +1204,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>      QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
>      Error *local_err = NULL;
>  
> +    trace_multifd_new_send_channel_async(p->id);
>      if (qio_task_propagate_error(task, &local_err)) {
>          migrate_set_error(migrate_get_current(), local_err);
>          multifd_save_cleanup();
> @@ -1496,6 +1498,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>                                  atomic_read(&multifd_recv_state->count));
>          return false;
>      }
> +    trace_multifd_recv_new_channel(id);
>  
>      p = &multifd_recv_state->params[id];
>      if (p->c != NULL) {
> diff --git a/migration/trace-events b/migration/trace-events
> index 9fbef614ab..5d85f8bf83 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -81,7 +81,9 @@ migration_bitmap_sync_start(void) ""
>  migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
>  migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
>  migration_throttle(void) ""
> +multifd_new_send_channel_async(uint8_t id) "channel %d"
>  multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
> +multifd_recv_new_channel(uint8_t id) "channel %d"
>  multifd_recv_sync_main(long packet_num) "packet num %ld"
>  multifd_recv_sync_main_signal(uint8_t id) "channel %d"
>  multifd_recv_sync_main_wait(uint8_t id) "channel %d"
> @@ -89,7 +91,9 @@ multifd_recv_terminate_threads(bool error) "error %d"
>  multifd_recv_thread_can_start(uint8_t id) "channel %d"
>  multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %" PRIu64
>  multifd_recv_thread_start(uint8_t id) "%d"
> +multifd_save_setup_wait(uint8_t id) "%d"
>  multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
> +multifd_send_error(uint8_t id) "channel %d"
>  multifd_send_sync_main(long packet_num) "packet num %ld"
>  multifd_send_sync_main_signal(uint8_t id) "channel %d"
>  multifd_send_sync_main_wait(uint8_t id) "channel %d"
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

