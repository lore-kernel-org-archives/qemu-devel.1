Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA2DC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC3720661
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2nHp+7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC3720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isCOY-0007Pp-QJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 16:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isCKg-0002TK-4O
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isCKf-0007Rr-0h
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:38 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isCKe-0007RA-Q3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:36 -0500
Received: by mail-pf1-x441.google.com with SMTP id 62so4183767pfu.11
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 13:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H4QnzckU0LL28w0wQX6tx5bhPXYdOpaHqvueD20Pzw4=;
 b=q2nHp+7rN05vWxg+MFugnxb6VHeo3d71Kz7sEa9Y80rwOml6ZLzDzLyE6VZFWXtMSH
 fFVXEyQzpKKC3QurcA2YzQIBlEWvKpI2ZtaY1qrbWflxHLX0vdCeFdDmSKhkLjCIauOV
 sRhlFs79N7tJyUl1DJE4ztmZ6IsAHzOuRKqDiQW1ryVr5LQqk56LDSDElByoaInxn/c3
 qgG5+RFWmi5THue7fMh9PmSrnDG1sfZFvKKXpI8mvHg8jT9LRS+jIcdpRez8ywxCkSaU
 xk0GEuAUetl/om/3eK/h1ek9M7r6u4+JIH7zjMuDeV7Z47ozuIkDyfJf3Q2Z87pObWW+
 B4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H4QnzckU0LL28w0wQX6tx5bhPXYdOpaHqvueD20Pzw4=;
 b=sT3ZjdBul0xIm4TDyUHjVCWpF7C+4HDSrtZjhDmt9mMf57v94IEXZmYR077/s8NDpn
 hKSh8nQB8vBh7zz7wYT5BGL7zpZJTfSttJPFojLPG73S2b2fcx0AxtTSZaeYkh8S2+8J
 JpfP29sJkkrYKnlhzJy9LsJj+IS4FLyTTC+CgnD+VKaLjljBA819WDStUVjxb87S5iXm
 8bXwTwc0Wg4dr2S6yVAgaQETz1IpN++wYJLqm+V3NQ9a/5JSm15KibXg7zD6w8MnltUL
 e9dIGoRC1mfDXZKDmxjwhSuqjp65QpMZ06T4//HSRpCvEOWRTxAc2a52cEiBMf0vNhcr
 Shuw==
X-Gm-Message-State: APjAAAXuH8oxGbG4fmKvX+WkOqiqBV+2Mb5YSM021CIJh6QAzvMK4C1U
 Qc3eonSbBZzx+LRRe7u7m4MCMvRJcR0=
X-Google-Smtp-Source: APXvYqwqFuXXCilBqSrTe89hSNEV01TW/+DppEBq0VyayJcOCDDM2C1uSB9rMjPNFktRllxj3yhwVA==
X-Received: by 2002:a63:1e47:: with SMTP id p7mr40886916pgm.339.1579208735554; 
 Thu, 16 Jan 2020 13:05:35 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id k21sm25494907pgt.22.2020.01.16.13.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 13:05:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] vl: Reduce scope of variables in configure_accelerators
Date: Thu, 16 Jan 2020 11:05:26 -1000
Message-Id: <20200116210528.31953-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116210528.31953-1-richard.henderson@linaro.org>
References: <20200116210528.31953-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, aleksandar.m.mail@gmail.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The accel_list and tmp variables are only used when manufacturing
-machine accel, options based on -accel.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: The freeing of accel_list was fixed in adb464ff671d.
---
 vl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 6a5abf2f54..3e2b77a4e8 100644
--- a/vl.c
+++ b/vl.c
@@ -2753,7 +2753,6 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 static void configure_accelerators(const char *progname)
 {
     const char *accel;
-    char **accel_list, **tmp;
     bool init_failed = false;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
@@ -2761,6 +2760,8 @@ static void configure_accelerators(const char *progname)
 
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
+        char **accel_list, **tmp;
+
         if (accel == NULL) {
             /* Select the default accelerator */
             if (!accel_find("tcg") && !accel_find("kvm")) {
-- 
2.20.1


