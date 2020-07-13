Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED35C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FAC2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVYohas5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FAC2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzIs-0003QD-Pg
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAy-0005Lz-6J
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:24 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAw-0006dl-1b
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f2so16675636wrp.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UrTMYXsKYBCCeeRev7zn6zcrL7aDFdGahwfyK1NLkvM=;
 b=qVYohas5ocgS+RPL4ScujKXWa7XMktaIgmOG5itxCIqEX572fGuYFPZRiYAlD15Owx
 YvyFhZysgv+8kDLIrjPXj5VeiJWzNGPEbR+GlG1j/ip2kzAo38PVgcqth/3GTZL0tDmb
 XIyeKdFeSs9WG7xAcdK/RAw3fdflNbH+SjJ6Uu7OtnSTGY8iW/oQqCaCNEaNB/mEEoNO
 OTUpyLe+8//pjl1T3QiUT32KgW+af+SfS8b6Wu7MsqumMunrv4ZWTLfzNKyQeTiCC5nh
 IiW1liofaDZvZhZ/PWwOUCC7ojuPPg1SGHMprtajVYTycyseZOvxHIhs7lRYvKetMEDJ
 8WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UrTMYXsKYBCCeeRev7zn6zcrL7aDFdGahwfyK1NLkvM=;
 b=MFt46zilwXHz6p/C74/5gMCTkJUPPFS2ESXLImocdsYrA6W3w/HQHx5OW2yqoaVQEq
 1OhWo09AyMIaQGhHAIA57zPgsYG3VvxRz1JW+5ezCWR2K7rYYEEGxoGXEHjoWQ4YR6+N
 GB9r+hAX1/GBo0DgIkhObxIGnohA0WQINoxoxJ98F2fZ3SMeTr9XgA0glvC4Unkt3V6q
 emfMbYdIhjtI6e+qrSRjELPOdHm1mrIvGW3nCqxzQH4izjkJOC/DOvMG0/eajyeFwLi6
 97FYnSNdQ4Jdra+Qi86uQxnIN59RTf1V080YS95corMkiNI89+Wl0zKG74Vhjf7GALmJ
 N2ig==
X-Gm-Message-State: AOAM533/nUy9NuygEx/jfVcFzwa2iCYjYwF003SCETshGJIZXfdhIds4
 iAi+47QsoD7WJ3GpuRxDKO7S9CBxZEDGtA==
X-Google-Smtp-Source: ABdhPJwziGWE9XzWIU/f90OxiQRLIoF00f7buY96Vn9KONEvkYNIZlUQJB1FqQVvtIl3m4VH/5ilkw==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr78795904wrm.169.1594649480342; 
 Mon, 13 Jul 2020 07:11:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/25] osdep.h: For Haiku, define SIGIO as equivalent to SIGPOLL
Date: Mon, 13 Jul 2020 15:10:51 +0100
Message-Id: <20200713141104.5139-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Haiku doesn't provide SIGIO; fix this up in osdep.h by defining it as
equal to SIGPOLL.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-6-peter.maydell@linaro.org
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/osdep.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 14059bce5a7..979a4039841 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -432,6 +432,10 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #define HAVE_CHARDEV_PARPORT 1
 #endif
 
+#if defined(__HAIKU__)
+#define SIGIO SIGPOLL
+#endif
+
 #if defined(CONFIG_LINUX)
 #ifndef BUS_MCEERR_AR
 #define BUS_MCEERR_AR 4
-- 
2.20.1


