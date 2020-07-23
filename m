Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652B0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 22:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7D420714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 22:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LS55Qy3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7D420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyjbq-0008PZ-EU
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 18:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyjbG-00080i-CV
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 18:22:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyjbE-00009A-0K
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 18:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595542918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9MfUOvyfNRglIQk6QNLmYU833yKx1vHxH+xn80/BVs=;
 b=LS55Qy3KcgxHxRjKWjUI4IYtNWKiLK170wlUySkoRO2/UC0R/VMeGnr6hIrnXQzhHSjoFF
 4/oGNdcIwr7/VP6iA54MhL+2VqA7z3ToSmwPj4BlwGDsRfX2LyL+o+/b+jVK+clp8Yvx1Z
 Lwhby/KkWI50mY5Ci+dDqQnPEil/Z9U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-WtB5_AnJOTabFSQTMS9sQA-1; Thu, 23 Jul 2020 18:21:56 -0400
X-MC-Unique: WtB5_AnJOTabFSQTMS9sQA-1
Received: by mail-qt1-f198.google.com with SMTP id c26so4698791qtq.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 15:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u9MfUOvyfNRglIQk6QNLmYU833yKx1vHxH+xn80/BVs=;
 b=TJhuvFVoutDO6t1rZ/y9QUJWLamPq+kWPMUwnvT7udUWnisMqlBkUgVnH8tcuMRGyj
 HhxBFt+P8Wbhh2k4JOK9wUq6/wCLwV5tqx4pp0b4102sPActbqzfI2sOeBO9Ya7OWbKn
 nX2RPaRWN041IHCHCqAxVfA1q5RBkmkuSOtc+sON04jRsqBLanasZzdKPUbWPWKSsSPW
 7sFwXybJ0do14AS2Ijz7dcmlrs1amKZoM3cLLFS+lHT79V/cFRw3Hzi7o5lO4KWdI7DM
 ssfmxPKpYrPrt6O3IdrVp02+/IArvtMghWN5zqGPxo5OK8s4V+2NDrWT8fFm9VP7ocxr
 NGjw==
X-Gm-Message-State: AOAM530UJV8EBtFDm9KFiZ1Mwo2IivvuLkA3eu7KMoXJh0bn8jARPrHB
 CnNL5jRs7bEEWO+hy+cX35JfV2Iu484iECxVCYhbAWJdjIwdIB9TGXcjrWCXAxfv27XKdaHyb86
 FoXQMz4BifbhMJfY=
X-Received: by 2002:a05:620a:805:: with SMTP id
 s5mr7547771qks.214.1595542916544; 
 Thu, 23 Jul 2020 15:21:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS86oasBPOaM2z/GQ12wVzZLKveUmSFnC50+cAISOg0o4C3DwD3yTPeOdUzLyagEqn4h/jTg==
X-Received: by 2002:a05:620a:805:: with SMTP id
 s5mr7547753qks.214.1595542916320; 
 Thu, 23 Jul 2020 15:21:56 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id g8sm3517244qtu.65.2020.07.23.15.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 15:21:55 -0700 (PDT)
Date: Thu, 23 Jul 2020 18:21:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 2/4] migration: add background snapshot capability
Message-ID: <20200723222153.GD831087@xz-x1>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-3-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200722081133.29926-3-dplotnikov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 11:11:31AM +0300, Denis Plotnikov wrote:
> diff --git a/migration/migration.c b/migration/migration.c
> index 2ed9923227..2ec0451abe 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1086,6 +1086,32 @@ static bool migrate_caps_check(bool *cap_list,
>              error_setg(errp, "Postcopy is not compatible with ignore-shared");
>              return false;
>          }
> +
> +        if (cap_list[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> +            error_setg(errp, "Postcopy is not compatible "
> +                        "with background snapshot");
> +            return false;
> +        }
> +    }
> +
> +    if (cap_list[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> +        if (cap_list[MIGRATION_CAPABILITY_RELEASE_RAM]) {
> +            error_setg(errp, "Background snapshot is not compatible "
> +                        "with release ram capability");
> +            return false;
> +        }
> +
> +        if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
> +            error_setg(errp, "Background snapshot is not "
> +                        "currently compatible with compression");
> +            return false;
> +        }
> +
> +        if (cap_list[MIGRATION_CAPABILITY_XBZRLE]) {
> +            error_setg(errp, "Background snapshot is not "
> +                        "currently compatible with XBZLRE");
> +            return false;
> +        }

Are these four the only ones that is not compatible with background snapshot?
I'm looking at:

typedef enum MigrationCapability {
    MIGRATION_CAPABILITY_XBZRLE,
    MIGRATION_CAPABILITY_RDMA_PIN_ALL,
    MIGRATION_CAPABILITY_AUTO_CONVERGE,
    MIGRATION_CAPABILITY_ZERO_BLOCKS,
    MIGRATION_CAPABILITY_COMPRESS,
    MIGRATION_CAPABILITY_EVENTS,
    MIGRATION_CAPABILITY_POSTCOPY_RAM,
    MIGRATION_CAPABILITY_X_COLO,
    MIGRATION_CAPABILITY_RELEASE_RAM,
    MIGRATION_CAPABILITY_BLOCK,
    MIGRATION_CAPABILITY_RETURN_PATH,
    MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
    MIGRATION_CAPABILITY_MULTIFD,
    MIGRATION_CAPABILITY_DIRTY_BITMAPS,
    MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME,
    MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
    MIGRATION_CAPABILITY_X_IGNORE_SHARED,
    MIGRATION_CAPABILITY_VALIDATE_UUID,
    MIGRATION_CAPABILITY__MAX,
} MigrationCapability;

My gut feeling is that most of them is not compatible with it... If background
snapshot is majorly used on its own, not sure whether it's worth it to create a
new qmp command, rather than reusing the "migrate" command.  The thing is it
could be confusing when people noticed when all the parameters won't work again
with snapshots.

Btw, it does not mean we need to duplicate the code.  We should still be able
to leverage most of the codes in qmp_migrate(), maybe even call qmp_migrate()
inside a new qmp_snapshot().

Thoughts?..

-- 
Peter Xu


