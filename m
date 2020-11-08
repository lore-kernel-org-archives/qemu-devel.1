Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1AAC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85025206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85025206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbuHW-0001R5-EK
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbu33-0000rU-5K
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:24:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbu31-0000GD-Co
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:24:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id f21so3684073plr.5
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x7c1G4sLPVoD9U12VrxMHshwvUYHPPrNVoUtKYDzjSE=;
 b=nUbNKCkVgZJbxJdvri9k2T0gCXA8GW04BMXJ2Ua8YI0WjXyooe1Ma+dC+1k+Rfds38
 eN3tQASLUloQklOt9PwxqtCTkprNXRpBOqPVYQlyqjMhvkaVDYHc3YGzbYDpm5Cd69I2
 f34bh4aS6FPReM0qfgIi4V8rnkbmcldWhEu7G+SZRG7e/44Gkxwju8mD4ppC1rnue74T
 xCBWK/5lpMurk24on9UbliI23UOieo6n18GT/UxO8H6WZbg35FI3GXL8vLNOJgquv/fe
 6jyxlCw/oycGr7W6SJBtIH7jEnCwOKPDZ1Tp6h+rrdz6Oshn3IPzHrVxr/gOpIdD75ib
 vN/A==
X-Gm-Message-State: AOAM531k/OvIIgFM4PUEXinO5P1q6vnWJSf/vul/cX51Ks3vQ4Qq5iBs
 7dp/2n4723pZrRTMKeTjaj+bX1iadAw=
X-Google-Smtp-Source: ABdhPJyIskYdBBOxFpjmwxcD5ngxyEa0oEMbDvTDA9qLC/nixqGUGrW++7KRqZyJW9Wqafw7j7unIg==
X-Received: by 2002:a17:902:b196:b029:d6:ffaf:c3c9 with SMTP id
 s22-20020a170902b196b02900d6ffafc3c9mr9731978plr.62.1604877873444; 
 Sun, 08 Nov 2020 15:24:33 -0800 (PST)
Received: from localhost.localdomain ([73.93.154.215])
 by smtp.gmail.com with ESMTPSA id z3sm8275171pgl.73.2020.11.08.15.24.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:24:33 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/7] slirp: update build flags for iOS resolv fix
Date: Sun,  8 Nov 2020 15:24:22 -0800
Message-Id: <20201108232425.1705-6-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108232425.1705-1-j@getutm.app>
References: <20201108232425.1705-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.196;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 18:24:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index b087721f63..40dd3b30fc 100644
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


