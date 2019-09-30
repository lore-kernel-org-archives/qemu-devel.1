Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02036C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8EB22501
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+E0bz8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8EB22501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Fl-0001a8-Fy
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2An-0004T6-4S
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Am-0005X8-5M
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:33 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:41262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2Am-0005Wm-0O
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:32 -0400
Received: by mail-pg1-x52d.google.com with SMTP id s1so7980907pgv.8
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sv1evknX8Peb+IcRUAjULJcxFSuTafe0C9v6FcPm5oM=;
 b=l+E0bz8FowiTNXOOsbv1VyBHhGhbkNflGZbFqRsQK9tfE7FFH1okd6BdE44JN/xZ7u
 AeyyVCoI+s6kE55+FlC055eUfRKdvXSCEVyAZNhvkDCOUwDK7MXi/Dcg2OmqFuawlswr
 wEWVvCz+JbRfYL1Go0Yik0P02oVZi2pTX3+oMzZJkqHNIBsSIezUJZiTfPcOFCd0MQOu
 PY5ML9L6bweuOpzl+Whyb5d7GdhIylzk0FWLm98A9Ljdy/dolRFnMDCID+rTHcedb4ZG
 ipKdoKrFWqFkgqG/WIR/tP2gdDM+JrW44lgNu2qkrsYxiTLo9WQcCMi25nRLPQG7Fj/s
 k4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sv1evknX8Peb+IcRUAjULJcxFSuTafe0C9v6FcPm5oM=;
 b=Bi/G611shqtTblcsn7nd9P2/0IJ0l4DuvsdLgURt4lOtW4F79kVeoC2BbxWPXWiYbV
 RGtDmMc0qyhpFJsBZbAR81b/iQ7677VJDFg8AUjEP1b+ypSPK5XcxKd5LzKnhhKDsDfn
 OdjmC0gwV7r0kBzx6/+qnFy87QQYkP3omOkoo/PbsHXszaJHn+DeMWHEb7X9lwHAWcQm
 dgDRHKtBCarA9yUjO8QWw/1ZOPJ4LoexYrTD2Anww6x0+E9oPi3qmtpwSgvFEkrQ+uVS
 aN7aOA4qHzkB6DQQtT3iktvtw25TNeqd203frmg32bXa0XingeI1bA7O81wjHmkRiwWT
 JvHQ==
X-Gm-Message-State: APjAAAXdnHzxu/YWImaLu4f/aL7igTjsYzOxrcHUQkgrIPvMRbKeKmq3
 hVlf32484F0z1iEg4zFnpjeLFU69zkQ=
X-Google-Smtp-Source: APXvYqyF2CYqOgt3P0OCEKt/r7onNZyg1BULgeZZv6eH6jLutRhlN+6rlsV5JpI8jFQ9ucKNGhNsiA==
X-Received: by 2002:a17:90a:fd86:: with SMTP id
 cx6mr1162845pjb.61.1569874890580; 
 Mon, 30 Sep 2019 13:21:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/22] tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()
Date: Mon, 30 Sep 2019 13:21:06 -0700
Message-Id: <20190930202125.21064-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce macros VRT(), VRA(), VRB(), VRC() used for encoding
elements of Altivec instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 8dc5455600..4aad5d2b36 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -473,6 +473,11 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define MB64(b) ((b)<<5)
 #define FXM(b) (1 << (19 - (b)))
 
+#define VRT(r)  (((r) & 31) << 21)
+#define VRA(r)  (((r) & 31) << 16)
+#define VRB(r)  (((r) & 31) << 11)
+#define VRC(r)  (((r) & 31) <<  6)
+
 #define LK    1
 
 #define TAB(t, a, b) (RT(t) | RA(a) | RB(b))
-- 
2.17.1


