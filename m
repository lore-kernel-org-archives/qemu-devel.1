Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3947FC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956E4207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ged8XCqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956E4207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkNQ-00065Z-MP
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHkM5-0004ha-Br
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:00:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57792
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHkM2-0006rZ-6c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600074053;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rpjzEeE5wDw0AhGcrcrQPwmY9Dq+JsRrS9dkQacGeZo=;
 b=Ged8XCqAT/hlbOU37l8tpMjUHN5DWidSeAOATtCxDwKqAg8u0sBS/je7WAvSmLBWsxNX4v
 veFeylkeum2Lro7rIHTgVX5dOb0ieH5pKYbh8AyXVunceZHaL3N934AB49293oLpwecc8U
 xyGYTp2WONzeZIk9uc36Cf344609H2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-2PeU-XJKPr2tlwi29Quqkg-1; Mon, 14 Sep 2020 05:00:51 -0400
X-MC-Unique: 2PeU-XJKPr2tlwi29Quqkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B805FAF20C;
 Mon, 14 Sep 2020 09:00:49 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA30660FC2;
 Mon, 14 Sep 2020 09:00:46 +0000 (UTC)
Date: Mon, 14 Sep 2020 10:00:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 1/6] migration/tls: save hostname into MigrationState
Message-ID: <20200914090043.GC1252186@redhat.com>
References: <1599965256-72150-1-git-send-email-zhengchuan@huawei.com>
 <1599965256-72150-2-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599965256-72150-2-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:36:47
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
 dgilbert@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 13, 2020 at 10:47:31AM +0800, Chuan Zheng wrote:
> hostname is need in multifd-tls, save hostname into MigrationState.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: Yan Jin <jinyan12@huawei.com>
> ---
>  migration/channel.c   | 6 ++++++
>  migration/migration.c | 1 +
>  migration/migration.h | 5 +++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 20e4c8e..0e4104a 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -66,6 +66,11 @@ void migration_channel_connect(MigrationState *s,
>      trace_migration_set_outgoing_channel(
>          ioc, object_get_typename(OBJECT(ioc)), hostname, error);
>  
> +    /* Save hostname into MigrationState for handshake */
> +    if (hostname) {
> +        s->hostname = g_strdup(hostname);
> +    }
> +
>      if (!error) {
>          if (s->parameters.tls_creds &&
>              *s->parameters.tls_creds &&
> @@ -90,5 +95,6 @@ void migration_channel_connect(MigrationState *s,
>          }
>      }
>      migrate_fd_connect(s, error);
> +    g_free(s->hostname);
>      error_free(error);
>  }

IIUC, this means hostname is free'd once the initial connection is
established. Don't we have to wait until all the multifd connections
exist too ?

IOW, should we be doing this somewhere in a cleanup path. Perhaps
migrate_fd_cancel() is the rigt place ?

> diff --git a/migration/migration.c b/migration/migration.c
> index 58a5452..e20b778 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1883,6 +1883,7 @@ void migrate_init(MigrationState *s)
>      s->migration_thread_running = false;
>      error_free(s->error);
>      s->error = NULL;
> +    s->hostname = NULL;
>  
>      migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index bdc7450..bc96322 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -259,6 +259,11 @@ struct MigrationState
>       * (which is in 4M chunk).
>       */
>      uint8_t clear_bitmap_shift;
> +
> +    /*
> +     * This save hostname when out-going migration starts
> +     */
> +    char *hostname;
>  };
>  
>  void migrate_set_state(int *state, int old_state, int new_state);
> -- 
> 1.8.3.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


