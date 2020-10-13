Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329B6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DADD21655
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee+Q6fhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DADD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8DH-0001EB-05
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8B4-0007vZ-Jh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:30 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8B3-0004ml-2c
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id b26so15387288pff.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dUzCYJf1zGH8bjxVLC2B7lv4j1gP+ZwtRM63BTbI6Lk=;
 b=ee+Q6fhybk6tc1EGZlQIY8Bba+F0V5ID852XnSQiPIPJ5ZwfSdseTsb8WeZlLbppY0
 JbM7YHPlG5p38WDE/1czhEuF/+dHfWdvPe+9FcOpGusZSFOTcbgvzMMghD1f5CCe66zr
 nQxtXcuFrqts/pALcePlAh/PUCsSgMZM9VMGAC+0TJRXqy52JoBgQh+5D8LpWoRzAeyC
 cTfY8ppnGEz74mu363Uku1G0Z5lCz9KDRYkfimpO8qAG2hcgRxSvROkgksLmpCdNeMou
 +2GTZ9mNTY3TdoDXgH9nKE6dZPIm7kOrYgHDWvCQW1R9VPlrxhctgXDiZ7bGDbiW+60Y
 d94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dUzCYJf1zGH8bjxVLC2B7lv4j1gP+ZwtRM63BTbI6Lk=;
 b=je3Ek7vjfZ3+V3OfOKXIGSnVVGE6ECUOxlaqmZaLp7nPyuL3q2SC4Agx9WzkYb+v+V
 i0ZT4rqOgkbViSFVPYjnZPJ+oysCvF9H9SM/3qBKg3CtTgakM3LHj0YppnXQ0f+1SO6h
 +Xd/rF5yJb1GA470scAueH2S/X5BGTkqkgvXkLL5jufK6hWLzLCn26lfbOwenj/FBL1s
 XCZ/0PbTgmOTsaK56DlFVNZXn3EMZB9hKQOmeXgfSoevIbyzeLaFAu+qUkohmYu2fdLk
 R7r+KnNOVgHSgEKLuLFumm5FuYpYhuegVEzlwbWlp1cK9Nxuk1VaWvqn5ZooczHvb23c
 toxA==
X-Gm-Message-State: AOAM533Jd1NnkUs5/v9K6yO1ZO7aTmFcSnDymUmr/vcajdpxo13Gbd1o
 gsLM41NYcDK3E+Bkzjrs9Cghp+lE05kuOQ==
X-Google-Smtp-Source: ABdhPJxaVQShyoVOU7Q8W/L5ls40C9zSuJ4Uow8ohe0ob7cl8W1KCSpAT4zchF6UnyRSpIIj8Lf7dg==
X-Received: by 2002:a63:4f1b:: with SMTP id d27mr14728227pgb.53.1602548907156; 
 Mon, 12 Oct 2020 17:28:27 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id y5sm22565925pge.62.2020.10.12.17.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 17:28:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/5] plugins: Fixes typo in qemu-plugin.h
Date: Tue, 13 Oct 2020 08:28:03 +0800
Message-Id: <20201013002806.1447-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201013002806.1447-1-luoyonggang@gmail.com>
References: <20201013002806.1447-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Getting the comment consistence with the function name

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/qemu-plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index bab8b0d4b3..daac8291b8 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -218,7 +218,7 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb);
 
 /**
- * qemu_plugin_register_vcpu_tb_trans_exec_cb() - register execution callback
+ * qemu_plugin_register_vcpu_tb_exec_cb() - register execution callback
  * @tb: the opaque qemu_plugin_tb handle for the translation
  * @cb: callback function
  * @flags: does the plugin read or write the CPU's registers?
@@ -236,7 +236,7 @@ enum qemu_plugin_op {
 };
 
 /**
- * qemu_plugin_register_vcpu_tb_trans_exec_inline() - execution inline op
+ * qemu_plugin_register_vcpu_tb_exec_inline() - execution inline op
  * @tb: the opaque qemu_plugin_tb handle for the translation
  * @op: the type of qemu_plugin_op (e.g. ADD_U64)
  * @ptr: the target memory location for the op
-- 
2.28.0.windows.1


