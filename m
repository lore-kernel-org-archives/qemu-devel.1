Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE74CC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C724207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMSqz2e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C724207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkOR-0006xZ-A9
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHkNT-0006Hm-Su
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:02:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHkNO-00071I-DK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600074137;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=J4YUT3SFomD5TrMBeS/qPR4SpHQZF5gQlb4vsDfHxqc=;
 b=ZMSqz2e/GqPBKg6+CiI8jmygvl9UvfdJi2PEiPGOmW/9QbSMQMSn971Xncc9iWJDqrAZ5i
 JFRlTcNa7phA3WRSSD8V/MAsxTMHoiCMJ2bScQmnLgsqjeFYVelHOx6A6v90BipSvSsyn1
 pUckl2o05cUSWlDx6WSukXiY/lxnBAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-NNf9Bc3DNJOQ2wU928h1fA-1; Mon, 14 Sep 2020 05:02:16 -0400
X-MC-Unique: NNf9Bc3DNJOQ2wU928h1fA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E081091060;
 Mon, 14 Sep 2020 09:02:14 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E862875120;
 Mon, 14 Sep 2020 09:02:11 +0000 (UTC)
Date: Mon, 14 Sep 2020 10:02:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 3/6] migration/tls: add MigrationState and
 tls_hostname into MultiFDSendParams
Message-ID: <20200914090209.GD1252186@redhat.com>
References: <1599965256-72150-1-git-send-email-zhengchuan@huawei.com>
 <1599965256-72150-4-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599965256-72150-4-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, dgilbert@redhat.com,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 13, 2020 at 10:47:33AM +0800, Chuan Zheng wrote:
> MigrationState is need for tls session build and tls hostname is need
> for tls handshake, add both MigrationState and tls_hostname
> into MultiFDSendParams.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: Yan Jin <jinyan12@huawei.com>
> ---
>  migration/multifd.c | 5 +++++
>  migration/multifd.h | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index d044120..3e41d9e 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -543,11 +543,14 @@ void multifd_save_cleanup(void)
>  
>          socket_send_channel_destroy(p->c);
>          p->c = NULL;
> +        p->s = NULL;
>          qemu_mutex_destroy(&p->mutex);
>          qemu_sem_destroy(&p->sem);
>          qemu_sem_destroy(&p->sem_sync);
>          g_free(p->name);
>          p->name = NULL;
> +        g_free(p->tls_hostname);
> +        p->tls_hostname = NULL;
>          multifd_pages_clear(p->pages);
>          p->pages = NULL;
>          p->packet_len = 0;
> @@ -779,6 +782,8 @@ int multifd_save_setup(Error **errp)
>          p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>          p->packet->version = cpu_to_be32(MULTIFD_VERSION);
>          p->name = g_strdup_printf("multifdsend_%d", i);
> +        p->s = migrate_get_current();
> +        p->tls_hostname = g_strdup(p->s->hostname);
>          socket_send_channel_create(multifd_new_send_channel_async, p);
>      }
>  
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 448a03d..2b400e7 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -66,11 +66,15 @@ typedef struct {
>  } MultiFDPages_t;
>  
>  typedef struct {
> +    /* Migration State */
> +    MigrationState *s;
>      /* this fields are not changed once the thread is created */
>      /* channel number */
>      uint8_t id;
>      /* channel thread name */
>      char *name;
> +    /* tls hostname */
> +    char *tls_hostname;

Why do we need this, when it is already accessible from the
MigrationState field you're adding


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


