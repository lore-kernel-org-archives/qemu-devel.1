Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB03DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EA020809
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6oFYUXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EA020809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMmU-0006Nb-Ut
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGMlk-0005ra-CM
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:37:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGMli-0001CB-4h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599745061;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vowvG0en0uvs+BamXJ5FnElMcjdKmIOgYFz31rpaAAQ=;
 b=E6oFYUXkqh5xR0AYvDoVGTwxMCI8g7d1elFldNOvq0REK5b6kpDDCoGJ/qeoCPHR8VXSTB
 F2rSFT2XbMhEWfp6GjBvIOm9uudfjTTnbtDU5zSQcCIofl2j587MZqz3XlctzIlxa7nfAD
 JzaB/wJ4Ctm4zfUu8LgMltCFAquu67c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182--FpAXyN6Nf-Ukz9s2j-jkg-1; Thu, 10 Sep 2020 09:37:39 -0400
X-MC-Unique: -FpAXyN6Nf-Ukz9s2j-jkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B17801AEA;
 Thu, 10 Sep 2020 13:37:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D4527E8EF;
 Thu, 10 Sep 2020 13:37:35 +0000 (UTC)
Date: Thu, 10 Sep 2020 14:37:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v1 7/7] migration/tls: add trace points for multifd-tls
Message-ID: <20200910133732.GZ1083348@redhat.com>
References: <1599663177-53993-1-git-send-email-zhengchuan@huawei.com>
 <1599663177-53993-8-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599663177-53993-8-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, yuxiating@huawei.com,
 dgilbert@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 10:52:57PM +0800, Chuan Zheng wrote:
> add trace points for multifd-tls for debug.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: Yan Jin <jinyan12@huawei.com>
> ---
>  migration/multifd.c    | 10 +++++++++-
>  migration/trace-events |  5 +++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 2509187..26935b6 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -730,7 +730,11 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>      QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>      Error *err = NULL;
>  
> -    qio_task_propagate_error(task, &err);
> +    if (qio_task_propagate_error(task, &err)) {
> +        trace_multifd_tls_outgoing_handshake_error(error_get_pretty(err));
> +    } else {
> +        trace_multifd_tls_outgoing_handshake_complete();
> +    }
>      multifd_channel_connect(p, ioc, err);
>  }
>  
> @@ -747,6 +751,7 @@ static void multifd_tls_channel_connect(MultiFDSendParams *p,
>          return;
>      }
>  
> +    trace_multifd_tls_outgoing_handshake_start(hostname);
>      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
>      qio_channel_tls_handshake(tioc,
>                                multifd_tls_outgoing_handshake,
> @@ -762,6 +767,9 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>  {
>      MigrationState *s = p->s;
>  
> +    trace_multifd_set_outgoing_channel(
> +        ioc, object_get_typename(OBJECT(ioc)), s->hostname, error);
> +
>      if (!error) {
>          if (s->parameters.tls_creds &&
>              *s->parameters.tls_creds &&
> diff --git a/migration/trace-events b/migration/trace-events
> index 4ab0a50..860d2c4 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -109,6 +109,11 @@ multifd_send_sync_main_wait(uint8_t id) "channel %d"
>  multifd_send_terminate_threads(bool error) "error %d"
>  multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %"  PRIu64
>  multifd_send_thread_start(uint8_t id) "%d"
> +multifd_tls_outgoing_handshake_start(const char *hostname) "hostname=%s"
> +multifd_tls_outgoing_handshake_error(const char *err) "err=%s"
> +multifd_tls_outgoing_handshake_complete(void) ""

I'd suggest adding 'void *ioc' for all of these to make it clearer to
correlate the traces.

> +multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
> +
>  ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
>  ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
>  ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
> -- 
> 1.8.3.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


