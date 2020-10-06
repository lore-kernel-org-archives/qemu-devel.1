Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E777EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AA820663
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbzT3j4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AA820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlpd-00073C-EL
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPlnC-0003OQ-7x
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:10:06 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPlnA-0004EN-Fv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:10:05 -0400
Received: by mail-pl1-x642.google.com with SMTP id h2so1117125pll.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dUzCYJf1zGH8bjxVLC2B7lv4j1gP+ZwtRM63BTbI6Lk=;
 b=vbzT3j4Y1pCF30z/9/Ro3kcDdY9cjeq1lyJQdrx7sGwqicbjs1mRTGXJEStrS1xYJ9
 BiEWpc7m0VWM/iSy2nx1J9b3HYQRJCUk6zAfyHBp66zHokUhlOC5kZIJmC2dY8kl5PC2
 JUI4BrU1adsjDiwUMZd33dNiRtsicBnzXmFmicrDMXYtM8iGoiXydogR4AtIhvCvqXfb
 arzaV94kYMB+76BOpseREmquhNVEi0Ts9oJc00rcqmCmNBXMfTVlYl6yr0aCQS1BKXLI
 u+9WbBpJWhXVHEEHNO7lvH9AZElxmQxhI9vtdDNg8Zvw4GqyJbCaCLVmbk5OreSff+3y
 d1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dUzCYJf1zGH8bjxVLC2B7lv4j1gP+ZwtRM63BTbI6Lk=;
 b=PMi7cb46XeyrT0uSOmbJ14KEiNxNg4nCqL8YgDTbsjeML0l/+OSPWxhvpyhmirFw0J
 19ur1ZMUpIRZrv+voPrMLU79vD9PH7I1D/WJzP8lVzTswXcCd4Z45iY0Zkfd47q/C9LM
 +Z7IUN+cgxcKXbrT/4HUNm40kNBwTztcJOgjwJiiC/hmeGvXObUAphvaqBg/jH0bWFu/
 d5ng3q3AGow/OrD0fOo0e1ehQpDAs91GSvmJxxM+58ZBdD+u2U84KcFvDjpsOP2DmqrX
 kEbkvciHO4dyx00SkAjaNwcFInusSzG+vODJvOdS1u4KCjsAPRg8nJ2p5rwXtHQx4heB
 Bd/g==
X-Gm-Message-State: AOAM5303lsSb98TT+SaftyAXWs55dp06BvyxCqOpI0o0+RUzuHFpkC7H
 uLMQXxnrR1zSRebPKnLk5Aqq3o03iim5DQ==
X-Google-Smtp-Source: ABdhPJwvEqs1rpiA5GDP41oPh7zHTbuvm6dRzzWOn6YR48IL6+VfM25vVQqQnSdB/xmAcxD2woX1Vw==
X-Received: by 2002:a17:90a:ae12:: with SMTP id
 t18mr4148025pjq.147.1601986202638; 
 Tue, 06 Oct 2020 05:10:02 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id f4sm2965681pgk.19.2020.10.06.05.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:10:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/7] plugin: Fixes typo in qemu-plugin.h
Date: Tue,  6 Oct 2020 20:08:57 +0800
Message-Id: <20201006120900.1579-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201006120900.1579-1-luoyonggang@gmail.com>
References: <20201006120900.1579-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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


