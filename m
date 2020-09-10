Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC716C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4844A20809
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNcxspHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4844A20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMlF-0005CU-E3
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGMkZ-00047y-N9
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:36:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGMkX-00016S-9A
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599744988;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wIE+RKsernw2Vsrh+H/fSmezlgPPABJn1fHfJxFZkw=;
 b=BNcxspHAcd1zZfFQ8sxxZb1XoBKjWN4JdvDb8C2+/zOxdjh/7OVFzck3MYWlI57LJLs3uL
 D71kHNCtWezkSYSuxZZplt1Ot97WrWcdElM+rjsi6dTL6DpHBBOJ8iB0USBSzsRLYWswtp
 5JnuhN89GM54v8Kf0AozAlI9Xpyy8qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-_vHV2uBbOyGVIR1et6PpPA-1; Thu, 10 Sep 2020 09:36:26 -0400
X-MC-Unique: _vHV2uBbOyGVIR1et6PpPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34F03801FD8;
 Thu, 10 Sep 2020 13:36:25 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 174A91002D6B;
 Thu, 10 Sep 2020 13:36:21 +0000 (UTC)
Date: Thu, 10 Sep 2020 14:36:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v1 5/7] migration/tls: add support for tls check
Message-ID: <20200910133619.GY1083348@redhat.com>
References: <1599663177-53993-1-git-send-email-zhengchuan@huawei.com>
 <1599663177-53993-6-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599663177-53993-6-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

On Wed, Sep 09, 2020 at 10:52:55PM +0800, Chuan Zheng wrote:
> add multifd_channel_connect to support for tls check.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: Yan Jin <jinyan12@huawei.com>
> ---
>  migration/multifd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b2e741c..b2076d7 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -20,6 +20,7 @@
>  #include "ram.h"
>  #include "migration.h"
>  #include "socket.h"
> +#include "tls.h"
>  #include "qemu-file.h"
>  #include "trace.h"
>  #include "multifd.h"
> @@ -718,6 +719,47 @@ out:
>      return NULL;
>  }
>  
> +static void multifd_tls_channel_connect(MultiFDSendParams *p,
> +                                    QIOChannel *ioc,
> +                                    Error **errp)
> +{
> +    /* TODO */
> +}
> +
> +static bool multifd_channel_connect(MultiFDSendParams *p,
> +                                    QIOChannel *ioc,
> +                                    Error *error)
> +{
> +    MigrationState *s = p->s;
> +
> +    if (!error) {
> +        if (s->parameters.tls_creds &&
> +            *s->parameters.tls_creds &&
> +            !object_dynamic_cast(OBJECT(ioc),
> +                                 TYPE_QIO_CHANNEL_TLS)) {
> +            multifd_tls_channel_connect(p, ioc, &error);
> +            if (!error) {
> +                /*
> +                 * tls_channel_connect will call back to this
> +                 * function after the TLS handshake,
> +                 * so we mustn't call multifd_send_thread until then
> +                 */
> +                return false;
> +            } else {
> +                return true;
> +            }
> +        } else {
> +            /* update for tls qio channel */
> +            p->c = ioc;
> +            qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
> +                                   QEMU_THREAD_JOINABLE);
> +       }
> +       return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>                                               QIOChannel *ioc, Error *err)
>  {
> @@ -749,8 +791,9 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>          p->c = QIO_CHANNEL(sioc);
>          qio_channel_set_delay(p->c, false);
>          p->running = true;
> -        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
> -                           QEMU_THREAD_JOINABLE);
> +        if (multifd_channel_connect(p, sioc, local_err)) {
> +            goto cleanup;
> +        }
>          return;
>      }

If this is squashed with the following patch then

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


