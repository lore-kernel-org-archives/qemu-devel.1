Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD294207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvVBlGh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD294207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxXb-0005bT-HM
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWL-00027p-DJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:49 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWK-000568-Ke
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:49 -0400
Received: by mail-pj1-x1042.google.com with SMTP id q9so4346379pjm.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W1694WY6F055oZOFF3E5eWwK1wEHGNgMdmDWrbbBY/M=;
 b=GvVBlGh6GZizFuyYHFIE3scoCKsIg/+Pinta/2iI0hpCwVAF9BlsEPmj5d8y+HwmXh
 p+43R11cG018wFQpJQ2nqBTpazUwJ6xdWAFSInINFG5e7iQkS5T7ZVDoqKEVK5RPXh0e
 X56Z5V2jXhd4Cz/WRhM1SVBY9leX/FvuX3r8GSf15MJ7QyDGmFtPCK4KpwW93MupSv5V
 5B/gxKYA2PvfJGcLVRbjvLiqdlup5ShM6FRS9yB2kSJr74G5VlCdRpxWmhAmJMyXwSwX
 lA2SH2VRv/V3RFD6LUxRlBOXCPSL3taoUWqEzTLcaoxQb0FUvywYhxLEmSXQKCsE0GWP
 F2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W1694WY6F055oZOFF3E5eWwK1wEHGNgMdmDWrbbBY/M=;
 b=p6Xxer9PH51JQfpQ49xw1BR6rVUK1kpS9h3bpp5d6eXNGwHE9nenGsiicGQN5hBfLP
 fWYFTcs7O0CjOAVNs5b1ii3m5E8yo7bhqpm19AyM1t7jCRUtVUFywJX0YlMNgjiRwAOo
 FfcGKKxU9GYQRni7WLKBIAugJ2kP4wEt7hU1XPqRDoa3e3Fts7pgO23PPkHmCsNQuS96
 F6EKnKv9yyEXw3KL8K9FCqStBuMx222b4UoeamKTvG0COjf2Y1m9yKsZs+z3BiZsnbw+
 tRYfEtCBKtRbmlhuLFST1Kl64SPZQhNXuwoF7faaSIUxS6RBirSZR4WBx78kLZmSNSaY
 k4fg==
X-Gm-Message-State: AOAM531dIXZnAJCmnlHGq446a6qMJgL7iToMBNPvhafmIcCFkRK5MJW8
 J8BD2sGWmttgleIhSf23HtrDt1HLjSU=
X-Google-Smtp-Source: ABdhPJwavG/+Ws7FPFuXFk92Xfc2YO87azuBXMj9tAv2+CRLckoKOZPksPC2CCwKe+/SFfwXFUjhjQ==
X-Received: by 2002:a17:902:6bcb:: with SMTP id
 m11mr12262424plt.264.1590114886994; 
 Thu, 21 May 2020 19:34:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/25] Adjust tracefile open for write
Date: Thu, 21 May 2020 19:34:19 -0700
Message-Id: <20200522023440.26261-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Truncate the new output file.  Rely on umask to remove
group+other file permissions, if desired.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risu.c b/risu.c
index 2f6a677..819b786 100644
--- a/risu.c
+++ b/risu.c
@@ -368,7 +368,7 @@ int main(int argc, char **argv)
             comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
         } else {
             if (ismaster) {
-                comm_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
+                comm_fd = open(trace_fn, O_WRONLY | O_CREAT | O_TRUNC, 0666);
             } else {
                 comm_fd = open(trace_fn, O_RDONLY);
             }
-- 
2.20.1


