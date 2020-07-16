Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82164C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3622076D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4ELa6bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3622076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw61k-00028s-JJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw60g-00019c-CF
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:41:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw60e-0007d1-3s
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:41:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id f139so12046923wmf.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TFEeAigEIjpMhWK7DoHcFuCUqfcQKRxgqCRDpAIxz64=;
 b=W4ELa6bwjHcVX3CesooMK/yVwoBCd4shwKHFCmu4wGfLzoUIsZXDRR1Yx95nfvgIZw
 U4BvBX894c6gdLfZcBnJvpzXdlUf9w2ot03j7TfFHpSYcZw2SSQx9arc3ED4CZ+FRuwU
 77xDC8265rpV2KmIR0fpIMJjL7216ugylwpN7j7zhTUziRJdTjn3U4r1GJ3TPJspGX4I
 5v5TJxDpBePh1/D70ijoluJVa/YU0lc6MXh+Z86GmGSdrrSrM1FhMqXlmb4DWjhU1lyJ
 AoDxLT40WRM3JsNgLzSXU5OxMeEaBuq0rM3Bt4xPcH/FrdM0KZYd6aOoRO1Km7ipvAGg
 frtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TFEeAigEIjpMhWK7DoHcFuCUqfcQKRxgqCRDpAIxz64=;
 b=KbUNClKSQshALZ9vxeHUCLdFj+nNU8AlQAmVu90PWsc3Vhkuc4A/w6vi3KLQQikrVb
 dZYK70EBkvSWexc/ZBaePDJmNZAaLG45WvcYhZmLzlepLd/WLBefGHSt/mLxqxLVe6lw
 UoNbWCW/a96BqxEFZdlY/WYIeG4lH0gLsUjEzQxflgwZ9vzIASsWKX6byUmtIeib7zlY
 1GAsx7jtKhVepPtyvwU1x9OrKm/l/7L8FLtkW1TEpYvvy9F8bJk6NKi+fshGtNubVKp7
 ZDwOC88gsQPy+VM2YKUaz5fUQup+sG9WlXcAf/4TYFkKThPoXWAfsAtvwAmmZUEiuu6c
 RQTg==
X-Gm-Message-State: AOAM532S3tGu7vCCaz4vGdfQqyuvvUcqVM1kbrSrCrnApFJU2K+rZ42e
 t0tLZ8lzCC1dxF5bKFjYvtmueRocTM6sCg==
X-Google-Smtp-Source: ABdhPJwUs/Re27mBoKaIarf4T99MABoHs/uKrZYIOZ6y7XA4AJfSaNnVZnELXcF/WVfradYvyPug8g==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr4935929wmj.67.1594914077203; 
 Thu, 16 Jul 2020 08:41:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm9505012wrx.69.2020.07.16.08.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 08:41:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
Date: Thu, 16 Jul 2020 16:41:14 +0100
Message-Id: <20200716154114.10838-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a documentation comment for qemu_get_thread_id(): since this
is rather host-OS-specific it's useful if people writing the
implementation and people thinking of using the function know
what the purpose and limitations are.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Based on conversation with Dan on IRC, and prompted by the recent
patch to add OpenBSD support.

Q: should we document exactly what the thread-id value is for
each host platform in the QMP documentation ? Somebody writing
a management layer app should ideally not have to grovel through
the application to figure out what they should do with the
integer value they get back from query-cpus...

 include/qemu/osdep.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4841b5c6b5f..8279f72e5ed 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -515,6 +515,20 @@ bool qemu_has_ofd_lock(void);
 
 bool qemu_write_pidfile(const char *pidfile, Error **errp);
 
+/**
+ * qemu_get_thread_id: Return OS-specific ID of current thread
+ *
+ * This function returns an OS-specific identifier of the
+ * current thread. This will be used for the "thread-id" field in
+ * the response to the QMP query-cpus and query-iothreads commands.
+ * The intention is that a VM management layer application can then
+ * use it to tie specific QEMU vCPU and IO threads to specific host
+ * CPUs using whatever the host OS's CPU affinity setting API is.
+ * New implementations of this function for new host OSes should
+ * return the most sensible integer ID that works for that purpose.
+ *
+ * This function should not be used for anything else inside QEMU.
+ */
 int qemu_get_thread_id(void);
 
 #ifndef CONFIG_IOVEC
-- 
2.20.1


