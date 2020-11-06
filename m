Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB153C4741F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25C82067C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="Rq4MyxPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25C82067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb4AA-0005nu-4F
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 11:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kb49B-00050v-6g
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:59:29 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kb499-00044h-Hq
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:59:28 -0500
Received: by mail-wm1-x343.google.com with SMTP id c9so1913553wml.5
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=PIeaDE/BGv+dgMY9US0iMz8LoWgwMn4Qgq9X2ZMMf5w=;
 b=Rq4MyxPst9lJCEDngt1HRRigUpBdM5SCWLctDpaRMcumajKWhEZquUnF7WDgGfGh09
 K0FxsPnpwweZF3YdHzqUDjdWLovhalmkXO2zu0OuA+JdxoQ0DwqJEXdYQuilZ8BMzhy9
 fMCIuRbGIZ6+AUsCG7loKOc/OKn4Mv4bb2UgyMTqKKn93kTDEuAxNs3QKzgOs9Rf1fKp
 m+eF3G/QVBkMVXJMRhbOhwgm4pJmsPKh8qJ3vUlsYItnRiYDRPJVpdhWN+1wclsnfPOC
 p7E0ooVATHsGcI84EjN31NnVPGumhFtB84gE0LHjA6L/CxfVuNThcDBaC25iW1GIC+Yl
 N8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=PIeaDE/BGv+dgMY9US0iMz8LoWgwMn4Qgq9X2ZMMf5w=;
 b=RGYmPPr/LbwXduCsuuAo25vG755xYYyw84aD0iPDVGH8nQR5waGprybdzoxiieQIb7
 92Q7s9FjEo/AWDW7w8G1fovXffEyZc7UBv6LImqO59fiuQ6jPlJ+uMaUsd3q8VlVOr7i
 9EjTAXs9bj8WhR5Mt2Gp55f8csR3LKmDarSD0UmzMdKx8Axm7/I0ySiCEw3j2Vha8YNC
 mLG/zpTmzOWabUwZp9i/LD3JLrsZovzuVHzWdT0GBOsHaYewgH73GtNBTm3FVvex7XyW
 A25ul+EewnqBgQuDtA5LGdOxr1M/Us/L9PMnuHubTZkqXI4a8S18TafwAFwaezuQ+3J1
 P8qg==
X-Gm-Message-State: AOAM531gYpaOlx0ZsumwSyGGONe+ZcFP+xfrTr/225vLT+QI+I74GzQ5
 tk36u6Vv2pkug2gpyd7m4J06NA==
X-Google-Smtp-Source: ABdhPJwmJdDhxgYNtHgPKEJECK1O7C8L7rXihDpoq61UBrw6Det7u/ZM2e54gKNsFB5Z70we0SYwFg==
X-Received: by 2002:a1c:2384:: with SMTP id j126mr277839wmj.116.1604678365369; 
 Fri, 06 Nov 2020 07:59:25 -0800 (PST)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id x18sm3060900wrg.4.2020.11.06.07.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:59:24 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 22885b74;
 Fri, 6 Nov 2020 15:59:23 +0000 (UTC)
To: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com,
 cjia@nvidia.com
Subject: Re: [PATCH 1/1] Change the order of g_free(info) and tracepoint
In-Reply-To: <1604669964-27222-1-git-send-email-kwankhede@nvidia.com>
References: <1604669964-27222-1-git-send-email-kwankhede@nvidia.com>
X-HGTTG: zarquon
From: David Edmondson <dme@dme.org>
Date: Fri, 06 Nov 2020 15:59:22 +0000
Message-ID: <cunr1p6tr1h.fsf@zarquon.hh.sledj.net>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::343;
 envelope-from=dme@dme.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: mcrossley@nvidia.com, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Friday, 2020-11-06 at 19:09:24 +0530, Kirti Wankhede wrote:

> Fixes Coverity issue:
> CID 1436126:  Memory - illegal accesses  (USE_AFTER_FREE)
>
> Fixes: a9e271ec9b36 ("vfio: Add migration region initialization and finalize
> function")
>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>

Maybe "fix use after free in vfio_migration_probe" as a summary?

Reviewed-by: David Edmondson <dme@dme.org>

> ---
>  hw/vfio/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 3ce285ea395d..55261562d4f3 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -897,8 +897,8 @@ int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>          goto add_blocker;
>      }
>  
> -    g_free(info);
>      trace_vfio_migration_probe(vbasedev->name, info->index);
> +    g_free(info);
>      return 0;
>  
>  add_blocker:
> -- 
> 2.7.0

dme.
-- 
I think I waited too long, I'm moving into the dollhouse.

