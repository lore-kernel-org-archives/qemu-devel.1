Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE8C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 11:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E49208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 11:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E49208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbkVG-0001DL-8A
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 07:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hbkMF-00038S-4t
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hbkMA-0004Sr-OI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:26:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hbkM6-0004Pl-Tx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:26:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63458308FC4D
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 11:26:49 +0000 (UTC)
Received: from work-vm (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57AF55C257;
 Fri, 14 Jun 2019 11:26:39 +0000 (UTC)
Date: Fri, 14 Jun 2019 12:26:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190614112636.GC2785@work-vm>
References: <20190612105323.7051-1-quintela@redhat.com>
 <20190612105323.7051-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612105323.7051-6-quintela@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 14 Jun 2019 11:26:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 5/6] migration: Make no compression
 operations into its own structure
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
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> It will be used later.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> Move setup of ->ops helper to proper place (wei)
> Rename s/none/nocomp/ (dave)
> ---
>  migration/migration.c |   9 ++
>  migration/migration.h |   1 +
>  migration/ram.c       | 188 ++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 190 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 3f17d8f2f8..a3526d395b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2174,6 +2174,15 @@ int migrate_multifd_channels(void)
>      return s->parameters.multifd_channels;
>  }
>  
> +int migrate_multifd_method(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->parameters.multifd_compress;
> +}
> +
>  int migrate_use_xbzrle(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index 71c03353c3..437abf3405 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -270,6 +270,7 @@ bool migrate_auto_converge(void);
>  bool migrate_use_multifd(void);
>  bool migrate_pause_before_switchover(void);
>  int migrate_multifd_channels(void);
> +int migrate_multifd_method(void);
>  
>  int migrate_use_xbzrle(void);
>  int64_t migrate_xbzrle_cache_size(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index b0ca989160..3b0002ddba 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -45,6 +45,7 @@
>  #include "page_cache.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-types-migration.h"
>  #include "qapi/qapi-events-migration.h"
>  #include "qapi/qmp/qerror.h"
>  #include "trace.h"
> @@ -661,6 +662,8 @@ typedef struct {
>      uint64_t num_packets;
>      /* pages sent through this channel */
>      uint64_t num_pages;
> +    /* used for compression methods */
> +    void *data;
>  }  MultiFDSendParams;
>  
>  typedef struct {
> @@ -696,8 +699,152 @@ typedef struct {
>      uint64_t num_pages;
>      /* syncs main thread and channels */
>      QemuSemaphore sem_sync;
> +    /* used for de-compression methods */
> +    void *data;
>  } MultiFDRecvParams;
>  
> +typedef struct {
> +    /* Setup for sending side */
> +    int (*send_setup)(MultiFDSendParams *p, Error **errp);
> +    /* Cleanup for sending side */
> +    void (*send_cleanup)(MultiFDSendParams *p);
> +    /* Prepare the send packet */
> +    int (*send_prepare)(MultiFDSendParams *p, uint32_t used, Error **errp);
> +    /* Write the send packet */
> +    int (*send_write)(MultiFDSendParams *p, uint32_t used, Error **errp);
> +    /* Setup for receiving side */
> +    int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
> +    /* Cleanup for receiving side */
> +    void (*recv_cleanup)(MultiFDRecvParams *p);
> +    /* Read all pages */
> +    int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **errp);
> +} MultiFDMethods;
> +
> +/* Multifd without compression */
> +
> +/**
> + * nocomp_send_setup: setup send side
> + *
> + * For no compression this function does nothing.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    return 0;
> +}
> +
> +/**
> + * nocomp_send_cleanup: cleanup send side
> + *
> + * For no compression this function does nothing.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void nocomp_send_cleanup(MultiFDSendParams *p)
> +{
> +    return;
> +}
> +
> +/**
> + * nocomp_send_prepare: prepare date to be able to send
> + *
> + * For no compression we just have to calculate the size of the
> + * packet.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int nocomp_send_prepare(MultiFDSendParams *p, uint32_t used,
> +                               Error **errp)
> +{
> +    p->next_packet_size = used * qemu_target_page_size();
> +    return 0;
> +}
> +
> +/**
> + * nocomp_send_write: do the actual write of the data
> + *
> + * For no compression we just have to write the data.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int nocomp_send_write(MultiFDSendParams *p, uint32_t used, Error **errp)
> +{
> +    return qio_channel_writev_all(p->c, p->pages->iov, used, errp);
> +}
> +
> +/**
> + * nocomp_recv_setup: setup receive side
> + *
> + * For no compression this function does nothing.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    return 0;
> +}
> +
> +/**
> + * nocomp_recv_cleanup: setup receive side
> + *
> + * For no compression this function does nothing.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void nocomp_recv_cleanup(MultiFDRecvParams *p)
> +{
> +}
> +
> +/**
> + * nocomp_recv_pages: read the data from the channel into actual pages
> + *
> + * For no compression we just need to read things into the correct place.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int nocomp_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **errp)
> +{
> +    if (p->flags != 0) {
> +        error_setg(errp, "multifd %d: flags received %x flags expected %x",
> +                   p->id, MULTIFD_FLAG_ZLIB, p->flags);

Can you just explain that a bit - the 'received' seems to be constant
while the expected is p->flags - is that the right way around?
Why would you expect FLAG_ZLIB in nocomp?

> +        return -1;
> +    }
> +    return qio_channel_readv_all(p->c, p->pages->iov, used, errp);
> +}
> +
> +static MultiFDMethods multifd_nocomp_ops = {
> +    .send_setup = nocomp_send_setup,
> +    .send_cleanup = nocomp_send_cleanup,
> +    .send_prepare = nocomp_send_prepare,
> +    .send_write = nocomp_send_write,
> +    .recv_setup = nocomp_recv_setup,
> +    .recv_cleanup = nocomp_recv_cleanup,
> +    .recv_pages = nocomp_recv_pages
> +};
> +
> +static MultiFDMethods *multifd_ops[MULTIFD_COMPRESS__MAX] = {
> +    [MULTIFD_COMPRESS_NONE] = &multifd_nocomp_ops,
> +};
> +
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>  {
>      MultiFDInit_t msg;
> @@ -900,6 +1047,8 @@ struct {
>      uint64_t packet_num;
>      /* send channels ready */
>      QemuSemaphore channels_ready;
> +    /* multifd ops */
> +    MultiFDMethods *ops;
>  } *multifd_send_state;
>  
>  /*
> @@ -1030,6 +1179,7 @@ void multifd_save_cleanup(void)
>          p->packet_len = 0;
>          g_free(p->packet);
>          p->packet = NULL;
> +        multifd_send_state->ops->send_cleanup(p);
>      }
>      qemu_sem_destroy(&multifd_send_state->channels_ready);
>      qemu_sem_destroy(&multifd_send_state->sem_sync);
> @@ -1097,7 +1247,14 @@ static void *multifd_send_thread(void *opaque)
>              uint64_t packet_num = p->packet_num;
>              uint32_t flags = p->flags;
>  
> -            p->next_packet_size = used * qemu_target_page_size();
> +            if (used) {
> +                ret = multifd_send_state->ops->send_prepare(p, used,
> +                                                            &local_err);
> +                if (ret != 0) {
> +                    qemu_mutex_unlock(&p->mutex);
> +                    break;
> +                }
> +            }
>              multifd_send_fill_packet(p);
>              p->flags = 0;
>              p->num_packets++;
> @@ -1115,8 +1272,7 @@ static void *multifd_send_thread(void *opaque)
>              }
>  
>              if (used) {
> -                ret = qio_channel_writev_all(p->c, p->pages->iov,
> -                                             used, &local_err);
> +                ret = multifd_send_state->ops->send_write(p, used, &local_err);
>                  if (ret != 0) {
>                      break;
>                  }
> @@ -1176,6 +1332,7 @@ int multifd_save_setup(Error **errp)
>  {
>      int thread_count;
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    int ret = 0;
>      uint8_t i;
>  
>      if (!migrate_use_multifd()) {
> @@ -1187,9 +1344,11 @@ int multifd_save_setup(Error **errp)
>      multifd_send_state->pages = multifd_pages_init(page_count);
>      qemu_sem_init(&multifd_send_state->sem_sync, 0);
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
> +    multifd_send_state->ops = multifd_ops[migrate_multifd_method()];
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> +        int res;
>  
>          qemu_mutex_init(&p->mutex);
>          qemu_sem_init(&p->sem, 0);
> @@ -1202,8 +1361,12 @@ int multifd_save_setup(Error **errp)
>          p->packet = g_malloc0(p->packet_len);
>          p->name = g_strdup_printf("multifdsend_%d", i);
>          socket_send_channel_create(multifd_new_send_channel_async, p);
> +        res = multifd_send_state->ops->send_setup(p, errp);
> +        if (ret == 0) {
> +            ret = res;
> +        }
>      }
> -    return 0;
> +    return ret;
>  }
>  
>  struct {
> @@ -1214,6 +1377,8 @@ struct {
>      QemuSemaphore sem_sync;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
> +    /* multifd ops */
> +    MultiFDMethods *ops;
>  } *multifd_recv_state;
>  
>  static void multifd_recv_terminate_threads(Error *err)
> @@ -1246,7 +1411,6 @@ static void multifd_recv_terminate_threads(Error *err)
>  int multifd_load_cleanup(Error **errp)
>  {
>      int i;
> -    int ret = 0;
>  
>      if (!migrate_use_multifd()) {
>          return 0;
> @@ -1269,6 +1433,7 @@ int multifd_load_cleanup(Error **errp)
>          p->packet_len = 0;
>          g_free(p->packet);
>          p->packet = NULL;
> +        multifd_recv_state->ops->recv_cleanup(p);
>      }
>      qemu_sem_destroy(&multifd_recv_state->sem_sync);
>      g_free(multifd_recv_state->params);
> @@ -1276,7 +1441,7 @@ int multifd_load_cleanup(Error **errp)
>      g_free(multifd_recv_state);
>      multifd_recv_state = NULL;
>  
> -    return ret;
> +    return 0;
>  }
>  
>  static void multifd_recv_sync_main(void)
> @@ -1337,6 +1502,8 @@ static void *multifd_recv_thread(void *opaque)
>  
>          used = p->pages->used;
>          flags = p->flags;
> +        /* recv methods don't know how to handle the SYNC flag */
> +        p->flags &= ~MULTIFD_FLAG_SYNC;
>          trace_multifd_recv(p->id, p->packet_num, used, flags,
>                             p->next_packet_size);
>          p->num_packets++;
> @@ -1344,8 +1511,7 @@ static void *multifd_recv_thread(void *opaque)
>          qemu_mutex_unlock(&p->mutex);
>  
>          if (used) {
> -            ret = qio_channel_readv_all(p->c, p->pages->iov,
> -                                        used, &local_err);
> +            ret = multifd_recv_state->ops->recv_pages(p, used, &local_err);
>              if (ret != 0) {
>                  break;
>              }
> @@ -1384,9 +1550,11 @@ int multifd_load_setup(Error **errp)
>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
>      atomic_set(&multifd_recv_state->count, 0);
>      qemu_sem_init(&multifd_recv_state->sem_sync, 0);
> +    multifd_recv_state->ops = multifd_ops[migrate_multifd_method()];
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
> +        int ret;
>  
>          qemu_mutex_init(&p->mutex);
>          qemu_sem_init(&p->sem_sync, 0);
> @@ -1396,6 +1564,10 @@ int multifd_load_setup(Error **errp)
>                        + sizeof(ram_addr_t) * page_count;
>          p->packet = g_malloc0(p->packet_len);
>          p->name = g_strdup_printf("multifdrecv_%d", i);
> +        ret = multifd_recv_state->ops->recv_setup(p, errp);
> +        if (ret != 0) {
> +            return ret;
> +        }
>      }
>      return 0;
>  }
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

