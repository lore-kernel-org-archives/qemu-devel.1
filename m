Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C6C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0C020897
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0C020897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbdOX-0001Dg-P5
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 00:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDU-0001TJ-VR
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 00:26:16 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:42739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDT-0004wB-Fc
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 00:26:16 -0500
Received: by mail-pf1-f171.google.com with SMTP id x13so5082139pfa.9
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 21:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IfWDGFIhMp3jXxBnSlVW2+A/U5la+FYoeeC16IgzEnQ=;
 b=siZ4njzTQOuS9IEbx03AIwKd7RVN1BPeet/zHUAoQTLmSwXhs6BgohonKpA92RFGWO
 BRwqoYHdBEufmEN960uQpBOnGkuxP1maYLbo+jvoW3FVCNRdMul7JaBUWjDHLFKfusDF
 wd0OSnXX7sbIHLGGGICWt0H/Q5E/DMvN/DS/y5PljW1KUudLqxIzkKa0eKo+3vcgyc3R
 6igl/DAwwswHy5QGt7M7vSKZJiZDDxQbyIURWLF8Z6HUGCwF3nxGmoOlpGXrf6HJGcTe
 z+L+/zoRZRyk6QbgXHmRRTGPfNHVJDxiKS7eKKssB8oifb0NbmNbBHDDf8w2WRl9VWVI
 OHMQ==
X-Gm-Message-State: AOAM531uTYxi2X+hDfd2tNN15cvVEuYnNOEaBaccIV4kROoJsN0HygEh
 yvFWo03Ip6y1jJTtPfhH613TaGYZ9AE=
X-Google-Smtp-Source: ABdhPJygqrvwSD74rWwAv/A8zJaetN9th5EWDG6QDScJiS0/O4MfPCfSzzQoUzAhTty7t/3/4liGUg==
X-Received: by 2002:a63:4c19:: with SMTP id z25mr8190096pga.58.1604813174043; 
 Sat, 07 Nov 2020 21:26:14 -0800 (PST)
Received: from localhost.localdomain ([73.93.155.42])
 by smtp.gmail.com with ESMTPSA id hz18sm6994406pjb.13.2020.11.07.21.26.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2020 21:26:13 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/7] slirp: update build flags for iOS resolv fix
Date: Sat,  7 Nov 2020 21:26:03 -0800
Message-Id: <20201108052605.45840-6-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108052605.45840-1-j@getutm.app>
References: <20201108052605.45840-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.171;
 envelope-from=osy86github@gmail.com; helo=mail-pf1-f171.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 00:26:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Joelle van Dyne <j@getutm.app>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A future libslirp update will use libresolv on Darwin systems, so we add the
flags in QEMU build now.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index e62324d5ac..664d9f93a5 100644
--- a/meson.build
+++ b/meson.build
@@ -1156,6 +1156,8 @@ if have_system
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


