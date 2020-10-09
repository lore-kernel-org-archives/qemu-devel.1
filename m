Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA924C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 01:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8E722257
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 01:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHd+fxAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8E722257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQhQ8-0000Ir-Q5
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 21:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kQhOi-00089R-Ix
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 21:40:40 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:41441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kQhOg-00035i-N1
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 21:40:40 -0400
Received: by mail-qk1-x741.google.com with SMTP id b69so9094178qkg.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 18:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QlT9PQlD20lDDwPwpTfgzrYAeIuaceg3BeSZVBxq+nQ=;
 b=dHd+fxAHNVTy/T0n9jc4flI+Qdxih9jyOYqdvA4/XrjtTI+YzqhAngTVQpLVAGULxg
 9+ZqbwJNva/vpov+5T4osn21PADopFcXCDXvaHfomxdY0ObxJiWwcopbY1a5DJUpyRl3
 ooIwaIbC7A0DPKxV2x5M0GN/1h2vRCyOpa3dvOO/YKmCK5LWTvaijNq4kR+Q6ENez5y2
 hV5zMOaYyZo9GpqMUtzhg/NhZgAIe94AqleTJc33nQZ4No2oLTKMEpTAXHvX5re3lt4M
 sn5c+EtuauUU5Ha82kufhmNXPMzwNb+uBdXq3so38ulRcN3TyCRMXzn3BT/Y9sbMJknP
 e81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QlT9PQlD20lDDwPwpTfgzrYAeIuaceg3BeSZVBxq+nQ=;
 b=fzePQ9zJLRzRzOw/DPW9L1KKN8xeMk5Jb/tTDWicBx7AZ4n6i0y781yDit7thUtLy/
 a1zIPc1AgunB048zZIVtakSUS6hCyNon2nuVQZ07jOFfbAD8KLYBOJdPw4NSAP6Kua92
 qAdGHdAem+bbcNOEFb8hMgdLBfVkBt0moCsmeO/Bhn6W3a6yLKRbnwJ9zWyu6Ues2Y10
 YLbRs8u+FXdLkoTmKjzp8EodD+C1+6ChuEbQpHayqwmm3ficHqcmG7UyggjJcGDm81yu
 7LtLJcNmf5MXVwy6CD8iKKm/jIU2RUEN22dAgnQWvGPx4M8JTBVfrelyl6ctZkuGs3xg
 laVw==
X-Gm-Message-State: AOAM530dVuGq0CCrtltfiSTRDsG+Ov25w64n+IqfyJIG1beI2gXq0wF0
 XI9XHeGOlT7dvDwp+YXdEaY=
X-Google-Smtp-Source: ABdhPJzKkVuVfhY4iAqGfWkgs8tMLXqK336J4azAKSNDCg5fV/Zqzio5BApypXXXg1KMmYiQDIIg4w==
X-Received: by 2002:a37:9a55:: with SMTP id c82mr11614658qke.38.1602207637163; 
 Thu, 08 Oct 2020 18:40:37 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:d16e:135d:7295:3992])
 by smtp.gmail.com with ESMTPSA id z26sm2160260qtb.85.2020.10.08.18.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 18:40:36 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] vnc-stubs: Allow -vnc none
Date: Thu,  8 Oct 2020 21:40:32 -0400
Message-Id: <20201009014032.3507-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=jandryuk@gmail.com; helo=mail-qk1-x741.google.com
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
Cc: Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently `-vnc none` is fatal when built with `--disable-vnc`.  Make
vnc_parse accept "none", so QEMU still run without using vnc.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 ui/vnc-stubs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vnc-stubs.c b/ui/vnc-stubs.c
index 06c4ac6296..c6b737dcec 100644
--- a/ui/vnc-stubs.c
+++ b/ui/vnc-stubs.c
@@ -12,6 +12,9 @@ int vnc_display_pw_expire(const char *id, time_t expires)
 };
 QemuOpts *vnc_parse(const char *str, Error **errp)
 {
+    if (strcmp(str, "none") == 0) {
+        return NULL;
+    }
     error_setg(errp, "VNC support is disabled");
     return NULL;
 }
-- 
2.25.1


