Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D470C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5F7217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kjen5fso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5F7217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqBq-0005p9-3z
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkC-0000NH-PP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkB-0002ut-Gc
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:39086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkB-0002ti-64
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id x4so3315244wrt.6
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oj/0oPpqLDS/GX/KzCrsGX7DQFLG22FAaJqDHl23Ay4=;
 b=Kjen5fsoYTGAeB1k2EAmzlv51KrS5lr09BpoulPDbZXumh3IT85rtXJcMmXSPXjUHC
 cLqFUov2x2tdBdQ+xNYzyB+Qj2EQ9Rm5qR9FAQiZiC38X0LMqEROpWGh4pfVTEM0JzSF
 v85N/vLObTEcTo6J07vdvOTp6Ul90yBHSPvfIkwNJE5bHryoTbpIgxSevGd+bfI/1pZV
 GuNUry6nJdEL7AHc48r9g0HHKM1rzsPh8KnOqithZ2RcSaj/ZopYW5CUW65E/1v+R5oF
 izQ7BJKbtnvL2Nsp9zEkX1P9WJwbo/JA92AP6ZDY//BwPK9ePVeB9jLhX3YPKhfx6/Dj
 jJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Oj/0oPpqLDS/GX/KzCrsGX7DQFLG22FAaJqDHl23Ay4=;
 b=N5DjqSBAtrI2cfOjJEUyXKLCGZEUSlVYJ3qas+geM23QFMaRh+DGJhLENqqr9MJrn7
 i+b/7outAw+lenhc2R8rCOpUkGnoNJZh2O0/ORXAJIdotHeYl4LS481Mbl8jjqOfnk1/
 g5d/hzFvZyPXxk/JuNoF9l+Zq1m1/PikOBQYIU2tQmy4P2e9dMtMlRFMN2yT0PYsl0QA
 8DRAx/2cZ2L89k9YihoSO3b2vE5rL5gIwmH0hJO18P++jnHACnD4zuoxIqevwE2CAE8N
 mkqfqwyijuvl+9Kdcng9Y7ZZ97jtI4sSWHzY4EQQElUMA/5w6IZoUVNLoAnBu5DhJf7T
 JNiw==
X-Gm-Message-State: APjAAAVE1LY76cYmSVadTN87n1rCA12zRh+1S5tL6vrFwgg/8TtvzuAe
 772q0W+nKL4fuHqV3s4zFlyQ6GcoV4c=
X-Google-Smtp-Source: APXvYqyXYaUP5/nsn+/uIdwF80NhYG/ZQOeUsR5r60NGPeGsixupb6MBeBGtKw7kTlCdkACIMYAAEA==
X-Received: by 2002:adf:de90:: with SMTP id w16mr33056671wrl.217.1560532321714; 
 Fri, 14 Jun 2019 10:12:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o8sm4715854wrj.71.2019.06.14.10.12.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:00 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 854831FF8C;
 Fri, 14 Jun 2019 18:12:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:11 +0100
Message-Id: <20190614171200.21078-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PATCH v3 01/50] trace: expand mem_info:size_shift to
 3 bits
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This will allow us to trace 16B-long memory accesses.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace-events b/trace-events
index 844ee58dd9..037169aab3 100644
--- a/trace-events
+++ b/trace-events
@@ -159,7 +159,7 @@ vcpu guest_cpu_reset(void)
 # Access information can be parsed as:
 #
 # struct mem_info {
-#     uint8_t size_shift : 2; /* interpreted as "1 << size_shift" bytes */
+#     uint8_t size_shift : 3; /* interpreted as "1 << size_shift" bytes */
 #     bool    sign_extend: 1; /* sign-extended */
 #     uint8_t endianness : 1; /* 0: little, 1: big */
 #     bool    store      : 1; /* wheter it's a store operation */
-- 
2.20.1


