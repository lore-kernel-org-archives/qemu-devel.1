Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA42C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 20:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A95D2076C
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 20:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="HsR7cd+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A95D2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcxB9-0002Gb-Ka
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 16:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcxAd-0001pf-4s
 for qemu-devel@nongnu.org; Sun, 24 May 2020 16:24:31 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcxAc-0000P3-AI
 for qemu-devel@nongnu.org; Sun, 24 May 2020 16:24:30 -0400
Received: by mail-qk1-x741.google.com with SMTP id b27so5932680qka.4
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7u6xV8y57rSEgwmSwQhBGOWV2pFQ90H+qLntmV/ayQo=;
 b=HsR7cd+Wu1zkbt17trhOJhtKnBRYxRNdLz5Y3uV/ylLnyi6vpi/wSpwZufGmp6LWt8
 FYZF/bFjjrL26ZMeMYzpJKtjv4Wkf0zt4ENJaixr8Ptqg8iTusAP4uqtSOmn3KCa2fz2
 XPHimYYgW+6sRlxz6XLVan4ZrqQCBPp7uazUS1w6U12piT3M3RISLS+eP8OS+LJxo0ki
 8rypiEkFm6/rJoF9Zou2xH2q/A3p8oqPX+sEL1HkOpr/6ptA/2D3f5Vc836Y6Ejp6fYU
 zDSlcbrvFUMKyuIORIvNlKks3QgY492N92PW2V/WvcHPu3vutywD/d7aFJcTy5ZtBw6o
 ltFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7u6xV8y57rSEgwmSwQhBGOWV2pFQ90H+qLntmV/ayQo=;
 b=F5qYAQlloqrTwM9HWXVAQNyw+fVp7f0kgrpfvPUOXC9zp1IQ2dYmObrzH/r6x2iVh1
 yGI89hmm+whewjWqXe4n6cyicqCzbYSeLXNAlWfekdw3xfMywU0/V1tiiJF9koJaW/3F
 QOVK25efvtX5I7cW1J63I+7NRMwRnYUDfPDdPc/I0zIRTzlOhgnObUAt3yYWtkr8uqQh
 vKA/3y6GomjLqQN8l+nc6qTii1VBclRTSzs/jdUUDiIlRT9MI7BmN5SSZWuLbfrA1fTI
 gU0e1zdRdxk+3e/ihhMbOV7tduhb314K/OQ1MYQM7uUs+d4Ua7z08ZoUhb6P+YHqGdC1
 4ITw==
X-Gm-Message-State: AOAM531d2E6GeHkK2P858DAyuueuYuBAGWKOtCQzP1MYcf9gxWXPyf9I
 2oGSydEm9JgjbbzDVLTdPZCuGK5eDts=
X-Google-Smtp-Source: ABdhPJz13r3QWKpcw5DBOgyOqdD8+ZAN+fYk9lt1baTzydQwv9L3UfeXwpZLlt3K0VcqQkUtsQxDtA==
X-Received: by 2002:ae9:eb08:: with SMTP id b8mr11900469qkg.381.1590351868373; 
 Sun, 24 May 2020 13:24:28 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id m7sm13060152qti.6.2020.05.24.13.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 13:24:27 -0700 (PDT)
From: "Emilio G. Cota" <cota@braap.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-plugin.h: add missing include <stddef.h> to define size_t
Date: Sun, 24 May 2020 16:24:27 -0400
Message-Id: <20200524202427.951784-1-cota@braap.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=2607:f8b0:4864:20::741;
 envelope-from=cota@braap.org; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qemu-plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 89ed579f55..bab8b0d4b3 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -12,6 +12,7 @@
 
 #include <inttypes.h>
 #include <stdbool.h>
+#include <stddef.h>
 
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
-- 
2.25.1


