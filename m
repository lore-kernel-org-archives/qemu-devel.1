Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425DCC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DF02075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL4t+5kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DF02075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaHq-0007Xu-2C
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaGd-0005lg-Lw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:49:43 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:37124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaGc-0008S8-4H
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:49:43 -0400
Received: by mail-pg1-x532.google.com with SMTP id g33so6982991pgb.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=htMtb1NzKhLangZNeh4fyVQE1LaLJL7zHAVE3XWM2KA=;
 b=mL4t+5kQR+qD0n7l12Y0V0Rjctr+8r5xeq8ZJfDtFa0jWrspoNZBSn9JaMTpU9JYh5
 09ocHvVPJubA7bBKZncRxpgNxyYyZu5Twz6ooRP2dvxp/XIDwRhjXHMthRjYtYLA/GUM
 BSK3y+Cq/8tsrKhf99DfPqZ/Dg34bxZ88hXdhH0QkIMhAj7af/mE5Ek4WfZKAjvMDduf
 RHcO8K5KzNQdV3SXgdMu27Qx0CPdi0TKU0AyOpSW4Zj5Zt/yQbyyZIE0QRZeaNVBisNL
 MqHSodc7W/QS8GXj6U4s6VwclqvzM+lhZ44NP8qZJlhHH7jDouo7pOQgvI2WsCgwzN0s
 laZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=htMtb1NzKhLangZNeh4fyVQE1LaLJL7zHAVE3XWM2KA=;
 b=Drf0mIfhZDfsx9OcDri/jJ+vbFyOopYOfR0kWMVtLe6/DuOPFgiu82rBM717y3GK7a
 nC7Hk9A0D/n8+OxD/oKX8Z/ziMvwBK0ixAwrZDvyPCIREX0hFTPUO6JINagiMeCY9itJ
 uKa44VUI9aHZpqBJTBXXORdqLMxfABJhokqxOQsIR92UB+btjIvcL4CcUdHkAnYZOIeL
 5U39E+hvjnc1vNdJiDtsGCnjJR7xad/uwASgUvN/8UlFUbkk+sNbmOKFVzfIeGRLtG2Y
 MZFpUJhfTUSSIji6efJqN9OswrAygpFloS+YAKPgli5KVVe9v7ewwKzcpEND4s/0djmX
 kMzQ==
X-Gm-Message-State: AOAM533YJdBk0qclNy9pGn69NeZWKp3GTn7gq+0ByhZdCJqizrsNsKEk
 6Jdp7wCSvaC5blb7dV0ySDqATEVKaekzKT8V
X-Google-Smtp-Source: ABdhPJyMxJtH29Hc2HKee3dVCCAhyxdbrsKfLcP8+MJ6TZsOmDbKIiMo2Viq93h3XEf44in6Ln8vGg==
X-Received: by 2002:a65:45ca:: with SMTP id m10mr803125pgr.187.1598366980371; 
 Tue, 25 Aug 2020 07:49:40 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id s198sm3093188pgc.4.2020.08.25.07.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 07:49:39 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] meson: Mingw64 gcc doesn't recognize system include_type
 for sdl2
Date: Tue, 25 Aug 2020 22:49:18 +0800
Message-Id: <20200825144919.1217-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825144919.1217-1-luoyonggang@gmail.com>
References: <20200825144919.1217-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index df5bf728b5..a3585881e1 100644
--- a/meson.build
+++ b/meson.build
@@ -224,8 +224,7 @@ if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
 
-sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static,
-                 include_type: 'system')
+sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static)
 sdl_image = not_found
 if sdl.found()
   # work around 2.0.8 bug
-- 
2.27.0.windows.1


