Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E651C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E7422454
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E7422454
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXbw9-0002tZ-Tx
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnt-0003ku-LD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:07:13 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:43641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnr-0006hb-Qr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:07:13 -0400
Received: by mail-pl1-f179.google.com with SMTP id o9so1780640plx.10
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zg+EmSwDq6QXcL2FDdEfglPIIUiq/1JDakKm/H1no/0=;
 b=HZLbh0CJFdtvB7kpwWnx8/8FyCiBh7StYnZnGihRccxPU7FU6S5AIqZoTTqL6wrCIz
 L+Hdh8QuQZaun2Tu1oHnIVzt86NyfRVlH3ncm3jCafUqlu7dbi1rhXc+9A6QNcPEyoNy
 8mELr7BgqlUJKnDOPDRQ0P57wdmjAlsc3vxLewC5GdofcRcDRztxP3y5DwmCZvze9NW3
 RCsawyCUFOZm66qFxc6JqjQCDN2d/FMKXTWMh7d6pt9/hdu5a85W9adaavJqKeyts2mv
 VDcRIXGRi9MAr4jwv2Fa9S+yq8eH4YXp9ZsAlb43+LLaA9swNadEiNpR+kaIP8Bi+VnR
 RDwA==
X-Gm-Message-State: AOAM532Yiiw6uvOpj0BrfwN/3sUHt7dwF9HNAFKn8AjDXR2NhdU65DIV
 iaPAZG0WSvX6l9Ndv4rrtxu8v2lsW44=
X-Google-Smtp-Source: ABdhPJwkourfUKUIIlFJlCp7pplY2ft3yQF8pzQ4ZVt8Bn5bM3DYazJOKRq3mWTJTdmx/J+/ai06Gw==
X-Received: by 2002:a17:90a:a008:: with SMTP id
 q8mr4750366pjp.211.1603854430352; 
 Tue, 27 Oct 2020 20:07:10 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.93])
 by smtp.gmail.com with ESMTPSA id n6sm3407219pjj.34.2020.10.27.20.07.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 20:07:10 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] slirp: update build flags for iOS resolv fix
Date: Tue, 27 Oct 2020 20:06:59 -0700
Message-Id: <20201028030701.14086-6-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028030701.14086-1-j@getutm.app>
References: <20201028030701.14086-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.179;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f179.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 23:07:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A future libslirp update will use libresolv on Darwin systems, so we add the
flags in QEMU build now.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 0beb199303..2b45b9434d 100644
--- a/meson.build
+++ b/meson.build
@@ -1140,6 +1140,8 @@ if have_system
     slirp_deps = []
     if targetos == 'windows'
       slirp_deps = cc.find_library('iphlpapi')
+    elif targetos == 'darwin'
+      slirp_deps = cc.find_library('resolv')
     endif
     slirp_conf = configuration_data()
     slirp_conf.set('SLIRP_MAJOR_VERSION', meson.project_version().split('.')[0])
-- 
2.28.0


