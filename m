Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC42C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DA322387
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DA322387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqF1S-0007ry-Hq
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46236)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqF1C-0007TU-Hg
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqF1A-00022O-Tj
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hqF1A-000220-KQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:01:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E802D30BD1CA;
 Wed, 24 Jul 2019 11:01:07 +0000 (UTC)
Received: from work-vm (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B997600C7;
 Wed, 24 Jul 2019 11:01:05 +0000 (UTC)
Date: Wed, 24 Jul 2019 12:01:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190724110103.GC2717@work-vm>
References: <20190724095523.1527-1-quintela@redhat.com>
 <20190724095523.1527-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724095523.1527-4-quintela@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 24 Jul 2019 11:01:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] migration: Make explicit that we are
 quitting multifd
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> We add a bool to indicate that.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

OK, similar to send.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 87bb7da8e2..eb6716710e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -677,6 +677,8 @@ typedef struct {
>      QemuMutex mutex;
>      /* is this channel thread running */
>      bool running;
> +    /* should this thread finish */
> +    bool quit;
>      /* array of pages to receive */
>      MultiFDPages_t *pages;
>      /* packet allocated len */
> @@ -1266,6 +1268,7 @@ static void multifd_recv_terminate_threads(Error *err)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          qemu_mutex_lock(&p->mutex);
> +        p->quit = true;
>          /* We could arrive here for two reasons:
>             - normal quit, i.e. everything went fine, just finished
>             - error quit: We close the channels so the channel threads
> @@ -1288,6 +1291,7 @@ int multifd_load_cleanup(Error **errp)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          if (p->running) {
> +            p->quit = true;
>              qemu_thread_join(&p->thread);
>          }
>          object_unref(OBJECT(p->c));
> @@ -1351,6 +1355,10 @@ static void *multifd_recv_thread(void *opaque)
>          uint32_t used;
>          uint32_t flags;
>  
> +        if (p->quit) {
> +            break;
> +        }
> +
>          ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>                                         p->packet_len, &local_err);
>          if (ret == 0) {   /* EOF */
> @@ -1422,6 +1430,7 @@ int multifd_load_setup(void)
>  
>          qemu_mutex_init(&p->mutex);
>          qemu_sem_init(&p->sem_sync, 0);
> +        p->quit = false;
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
>          p->packet_len = sizeof(MultiFDPacket_t)
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

