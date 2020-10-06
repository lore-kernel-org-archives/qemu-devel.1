Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98102C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258FA206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg6kOe/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258FA206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpal-0006Ku-9S
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUX-0005jZ-6y
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUV-00040E-Fw
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id w5so14109302wrp.8
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cxrAuSrnDokaCtxW/I/fnzh9bA6WZipzM6DEEQQgmXg=;
 b=rg6kOe/IHkqKVk7LnDtaw1d1wjWBW3fp5vQIB5cvT0I9EURLDNlSeGgTbfLpKE57ZW
 H8BbjZY7q11dNbU9s1WNX7YhBHpNBfEQj3oB2Z2DKxG7BrY8z4uv4xayKcC9qA0CN1k/
 34HueN5cWqiLlcK8L2kltmlcolbVA7IwnAKnB2K85xFJNvkN64ajXPVhb/tC7YD4JvbL
 yMI+iVAHFW/j25lhUfNRHdZ/+Ld9hzKQpzFf3yjuRz7EIuyBLqmnyvGmWr+WDXJOtdqO
 LxZe+XoeMRfwLIPSO0JcwXJZNvfytMhFAI6hkUrQzN+SR5V4G33qgY4Mg7FYFoiNw7dP
 mR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cxrAuSrnDokaCtxW/I/fnzh9bA6WZipzM6DEEQQgmXg=;
 b=gelWmX6Lz+V72OGOpdAmO9KGWvnpfJLrErWSHfq7xYBe4Aryd3SpBOHjAG493T0dtW
 mK9iS3Xwl8cUivsh0jZ8c8fJD4viSps8fVOetCmGW5pGYBs+RBea8BJ4WYkUJiR08A0f
 zBCFMl5SrqC2i1S5qBLzGECsYsGVrHkGHM0g0sNNbqRY9EK60KzIMjEBHnmTaWM2pHci
 dI7OAs8HRnlEcX92bEVsqIqapzLvYU74ZynZc/DuTdBJlkGtf9IVJPRZPoloBwZOCZhe
 tWcVQslKkWAtaz8MgIA44kdrfF0r7vg/7SaY4USRJA72/8zeT853Z+0xEz6T3LZnGJz4
 8iuA==
X-Gm-Message-State: AOAM533DLNq5fOd38z9v9iOnmhJy/n5UxKIm0mu7e1qOeILILFbk4DZ5
 A0QaDOURRwyB+pTulXSZ8DKw69sROLw=
X-Google-Smtp-Source: ABdhPJzVxBm702jEscEEhVtKeWKIQSSfvwL/USfi0eESsGUkJFXtK35GUVjlgxrW7lVRECRcxA1liA==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr5722460wrp.112.1602000422083; 
 Tue, 06 Oct 2020 09:07:02 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:07:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 05/12] contrib/gitdm: Add Google to the domain map
Date: Tue,  6 Oct 2020 18:06:46 +0200
Message-Id: <20201006160653.2391972-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Erik Kline <ek@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Acked-by: Erik Kline <ek@google.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/domain-map | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index ae5d149434..72dc65f2b5 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -9,8 +9,9 @@ baidu.com       Baidu
 bytedance.com   ByteDance
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
-greensocs.com   GreenSocs
 fujitsu.com     Fujitsu
+google.com      Google
+greensocs.com   GreenSocs
 huawei.com      Huawei
 ibm.com         IBM
 igalia.com      Igalia
-- 
2.26.2


