Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91270C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E21207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnZtQ9a9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E21207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTYr-0003Mr-4v
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLp-0007hB-W5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:38 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLk-0006qa-V3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:37 -0400
Received: by mail-pj1-x1044.google.com with SMTP id u3so73282pjr.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dUzCYJf1zGH8bjxVLC2B7lv4j1gP+ZwtRM63BTbI6Lk=;
 b=FnZtQ9a9Myb2E90Q7TH3JxeaxHXN3p82Q3oUwAUs/A3ZmKleFmOFDJODkE5c75xfwc
 8ZxqlzTIiAaipHlEDuUfkmLwMTnTDtFqhqwlAXxl2UsoLqkQziqC7G3dkCQEpWkNw3hU
 bhnt+0drZ5QACMKGRXIsYZcUtZKTwDGYJQRNWyB9/obEE2doVSoWAvjjRS0SrCbr0hEt
 1Z8d8dAeN54jUQUHGaMG+0fQYF+GehWISBGZoZwseMjvFM+jQwTSrEG0RdSBqL1gIM6q
 pe4z/4xgwRxLJu/MGon+Oc1bHqy4Y3kVBOqpZYiLXh+3VvsrTwzO8OImsLzGX2JENH5G
 DvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dUzCYJf1zGH8bjxVLC2B7lv4j1gP+ZwtRM63BTbI6Lk=;
 b=hqnTQ4KPfSuIu+0U0UmXSEcNmyeFkmN7PzTDxHbMHBMubMzWGnuchGaZJdkzYBmtJ+
 4CD+/dt5WFENZEyvwzFzp4ZZb2F248wfxyHaBvQY+RMT+KQFFWgU1OUaYx+zoop7vZ0O
 DtX3Ny2jXCFbvysFMzqyZKS+lXU+7jk0ArNWTJ0GBlrgy0MpLSLMOXnx8JnhaBMrhG6S
 MCamb46HRqVhJwlezo5c8GkUiAfnjcFseE3LrzPpoE/dOOEjEFQGS+vVZ+YwvSluPlOt
 XCv/RTd5WfZBeXcz4w8fx9nsa5qRn5L3lc4VQZs6CndmRoNYfhudaWijsVgbMlFuxqq9
 /9Xw==
X-Gm-Message-State: AOAM533aAoNUb7vp5WlZ/zxNs4NpPFxwU/imfNfJZUDGFrKshLRYqfB8
 ogH/ZZZah4nMw00P+WxMuGSs9GYD6VSCYA==
X-Google-Smtp-Source: ABdhPJzN+NutJ+KKTeFt5V95w6cnLLpTVHjiHJRhxeK3MaNpHTPoZnwAbTMro+Y0Kj1HlEfKEWuzuw==
X-Received: by 2002:a17:90b:4acf:: with SMTP id
 mh15mr192869pjb.204.1601915311239; 
 Mon, 05 Oct 2020 09:28:31 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x13sm374725pfj.199.2020.10.05.09.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 09:28:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] plugin: Fixes typo in qemu-plugin.h
Date: Tue,  6 Oct 2020 00:28:04 +0800
Message-Id: <20201005162806.1350-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201005162806.1350-1-luoyonggang@gmail.com>
References: <20201005162806.1350-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
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


