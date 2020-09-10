Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EB6207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgpZdMWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EB6207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMWQ-0006hi-UO
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGMRO-0006HW-Rg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGMRM-0006UI-56
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599743798;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvXaQwNSqkMHqkl6zk86zFQeEr8qOrHdqkIqiRyogm4=;
 b=OgpZdMWxw5BQGssg2HT5h2u2vmwc5DLTSqbulpB/dcdIP0z51ktYss+rfTrqQ88hFvRwPp
 8/STSwY7PRQUaR8A2eDJTJ15Eon7Z1S1LrKHPMo5Ck+nlz+3nahgLUynotrxwFiCNGW+MS
 /GKLrs6PfZOJyxEdpEGcINL7c6vv4RQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-qs62fx9cOnWm78v9nRGz_Q-1; Thu, 10 Sep 2020 09:16:32 -0400
X-MC-Unique: qs62fx9cOnWm78v9nRGz_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADA0A1019629;
 Thu, 10 Sep 2020 13:16:30 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B2EF27CC7;
 Thu, 10 Sep 2020 13:16:25 +0000 (UTC)
Date: Thu, 10 Sep 2020 14:16:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v1 2/7] migration/tls: extract
 migration_tls_client_create for common-use
Message-ID: <20200910131622.GT1083348@redhat.com>
References: <1599663177-53993-1-git-send-email-zhengchuan@huawei.com>
 <1599663177-53993-3-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599663177-53993-3-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 09, 2020 at 10:52:52PM +0800, Chuan Zheng wrote:
> migration_tls_client_create will be used in multifd-tls, let's
> extract it.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: Yan Jin <jinyan12@huawei.com>
> ---
>  migration/tls.c | 26 ++++++++++++++++++--------
>  migration/tls.h |  6 ++++++
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/tls.c b/migration/tls.c
> index 7a02ec8..e888698 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -22,7 +22,6 @@
>  #include "channel.h"
>  #include "migration.h"
>  #include "tls.h"
> -#include "io/channel-tls.h"
>  #include "crypto/tlscreds.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -125,11 +124,10 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>      object_unref(OBJECT(ioc));
>  }
>  
> -
> -void migration_tls_channel_connect(MigrationState *s,
> -                                   QIOChannel *ioc,
> -                                   const char *hostname,
> -                                   Error **errp)
> +QIOChannelTLS *migration_tls_client_create(MigrationState *s,
> +                                 QIOChannel *ioc,
> +                                 const char *hostname,
> +                                 Error **errp)

Alignment of parameters is messed up.

>  {
>      QCryptoTLSCreds *creds;
>      QIOChannelTLS *tioc;
> @@ -137,7 +135,7 @@ void migration_tls_channel_connect(MigrationState *s,
>      creds = migration_tls_get_creds(
>          s, QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, errp);
>      if (!creds) {
> -        return;
> +        return NULL;
>      }
>  
>      if (s->parameters.tls_hostname && *s->parameters.tls_hostname) {
> @@ -145,11 +143,23 @@ void migration_tls_channel_connect(MigrationState *s,
>      }
>      if (!hostname) {
>          error_setg(errp, "No hostname available for TLS");
> -        return;
> +        return NULL;
>      }
>  
>      tioc = qio_channel_tls_new_client(
>          ioc, creds, hostname, errp);
> +
> +    return tioc;
> +}
> +
> +void migration_tls_channel_connect(MigrationState *s,
> +                                   QIOChannel *ioc,
> +                                   const char *hostname,
> +                                   Error **errp)
> +{
> +    QIOChannelTLS *tioc;
> +
> +    tioc = migration_tls_client_create(s, ioc, hostname, errp);
>      if (!tioc) {
>          return;
>      }
> diff --git a/migration/tls.h b/migration/tls.h
> index cdd7000..d4a0861 100644
> --- a/migration/tls.h
> +++ b/migration/tls.h
> @@ -22,11 +22,17 @@
>  #define QEMU_MIGRATION_TLS_H
>  
>  #include "io/channel.h"
> +#include "io/channel-tls.h"
>  
>  void migration_tls_channel_process_incoming(MigrationState *s,
>                                              QIOChannel *ioc,
>                                              Error **errp);
>  
> +QIOChannelTLS *migration_tls_client_create(MigrationState *s,
> +                                   QIOChannel *ioc,
> +                                   const char *hostname,
> +                                   Error **errp);

Again alignment is messed up.

Assuming that's fixed

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


