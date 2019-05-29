Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0187C28CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1FE23F25
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1FE23F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW2D1-0006Ec-5O
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 13:17:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hW2BW-0005cg-Ev
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hW2BQ-0000rF-Ix
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hW2BK-0000oN-VW
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:16:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5655DB0AA6
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 17:15:58 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D237A5C706;
	Wed, 29 May 2019 17:15:55 +0000 (UTC)
Date: Wed, 29 May 2019 18:15:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190529171552.GM2882@work-vm>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121544.4597-9-quintela@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 29 May 2019 17:16:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 8/8] multifd: rest of zlib compression
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> This is still a work in progress, but get everything sent as expected
> and it is faster than the code that is already there.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 104 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index fdb5bf07a5..efbb253c1a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -747,6 +747,100 @@ MultifdMethods multifd_none_ops = {
>      .recv_pages = none_recv_pages
>  };
>  
> +/* Multifd zlib compression */
> +

Comment the return value?

> +static int zlib_send_prepare(MultiFDSendParams *p, uint32_t used)
> +{
> +    struct iovec *iov = p->pages->iov;
> +    z_stream *zs = &p->zs;
> +    uint32_t out_size = 0;
> +    int ret;
> +    int i;

uint32_t to match 'used' ?

> +    for (i = 0; i < used; i++) {
> +        uint32_t available = p->zbuff_len - out_size;
> +        int flush = Z_NO_FLUSH;
> +
> +        if (i == used  - 1) {
> +            flush = Z_SYNC_FLUSH;
> +        }
> +
> +        zs->avail_in = iov[i].iov_len;
> +        zs->next_in = iov[i].iov_base;
> +
> +        zs->avail_out = available;
> +        zs->next_out = p->zbuff + out_size;
> +
> +        ret = deflate(zs, flush);
> +        if (ret != Z_OK) {
> +            printf("problem with deflate? %d\n", ret);

If it's an error it should probably be at least an fprintf(stderr or
err_ something.

Should this also check that the avail_in/next_in has consumed the whole
of the input?

> +            qemu_mutex_unlock(&p->mutex);

Can you explain and/or comment whyit's unlocked here in the error path?

> +            return -1;
> +        }
> +        out_size += available - zs->avail_out;
> +    }
> +    p->next_packet_size = out_size;

Some traces_ wouldn't hurt.

> +    return 0;
> +}
> +
> +static int zlib_send_write(MultiFDSendParams *p, uint32_t used, Error **perr)
> +{
> +    return qio_channel_write_all(p->c, (void *)p->zbuff, p->next_packet_size,
> +                                 perr);
> +}
> +
> +static int zlib_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **perr)
> +{
> +    uint32_t in_size = p->next_packet_size;
> +    uint32_t out_size = 0;
> +    uint32_t expected_size = used * qemu_target_page_size();
> +    z_stream *zs = &p->zs;
> +    int ret;
> +    int i;
> +
> +    ret = qio_channel_read_all(p->c, (void *)p->zbuff, in_size, perr);
> +
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    zs->avail_in = in_size;
> +    zs->next_in = p->zbuff;
> +
> +    for (i = 0; i < used; i++) {
> +        struct iovec *iov = &p->pages->iov[i];
> +        int flush = Z_NO_FLUSH;
> +
> +        if (i == used  - 1) {
> +            flush = Z_SYNC_FLUSH;
> +        }
> +
> +        zs->avail_out = iov->iov_len;
> +        zs->next_out = iov->iov_base;
> +
> +        ret = inflate(zs, flush);
> +        if (ret != Z_OK) {
> +            printf("%d: problem with inflate? %d\n", p->id, ret);
> +            qemu_mutex_unlock(&p->mutex);
> +            return ret;
> +        }
> +        out_size += iov->iov_len;
> +    }
> +    if (out_size != expected_size) {
> +        printf("out size %d expected size %d\n",
> +               out_size, expected_size);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +MultifdMethods multifd_zlib_ops = {
> +    .send_prepare = zlib_send_prepare,
> +    .send_write = zlib_send_write,
> +    .recv_pages = zlib_recv_pages
> +};
> +
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>  {
>      MultiFDInit_t msg;
> @@ -1145,7 +1239,11 @@ static void *multifd_send_thread(void *opaque)
>      /* initial packet */
>      p->num_packets = 1;
>  
> -    multifd_send_state->ops = &multifd_none_ops;
> +    if (migrate_use_multifd_zlib()) {
> +        multifd_send_state->ops = &multifd_zlib_ops;
> +    } else {
> +        multifd_send_state->ops = &multifd_none_ops;
> +    }
>  
>      while (true) {
>          qemu_sem_wait(&p->sem);
> @@ -1399,7 +1497,11 @@ static void *multifd_recv_thread(void *opaque)
>      trace_multifd_recv_thread_start(p->id);
>      rcu_register_thread();
>  
> -    multifd_recv_state->ops = &multifd_none_ops;
> +    if (migrate_use_multifd_zlib()) {
> +        multifd_recv_state->ops = &multifd_zlib_ops;
> +    } else {
> +        multifd_recv_state->ops = &multifd_none_ops;
> +    }
>      while (true) {
>          uint32_t used;
>          uint32_t flags;
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

