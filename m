Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3578C38A2A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECC320746
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d79E/UnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECC320746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKjr-0003rj-MF
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomas.krcka@gmail.com>)
 id 1jWK0B-0005UG-0v; Wed, 06 May 2020 09:22:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomas.krcka@gmail.com>)
 id 1jWK0A-0002t9-37; Wed, 06 May 2020 09:22:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id x4so2588949wmj.1;
 Wed, 06 May 2020 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=MiTwX4MgDgiYSjlKlgkiylZjsvmQSPuFFt2g/0XQ1tU=;
 b=d79E/UnJR8m9jOQS0h8TkOuX/70Z6xwSUV5g87ALwPUti/SdsFhGVc25hyJ1dpt85i
 gXEWBj5az2yXckLPQt05k/2/QHcRVC+yADLYAV9TdhBrOMoEkAN7G3SmJAmPPkiSQ41I
 dWwyObjjmWxS3onz2080yyUM+efiqSVYY1RphsQmWcw6IeeMDFMDiKdDYv+M21il+Wu7
 1/kEw9UMpHofSauh1q12hjTDICJaKuHiwZ9xTdAoqCXaLLW+F7u5qHRDG6l3R3EGZXSw
 LZ0h5tfEZhRcoZ21OxLHcUnnjXCTQqVOlM9YqX3xuagkEbDZuObaEVuUcC4S1FGiEeNo
 ha+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MiTwX4MgDgiYSjlKlgkiylZjsvmQSPuFFt2g/0XQ1tU=;
 b=QiaScfcnYOUA+Xr1K9/tnKq5AtnXFUo02gWwCv4jW1KZiBcRnTWb4ROCJDhCRybFqo
 wWHmTFIQUD5x9pGxhAHDIUhpil7ImwqZVTktp5udmMgY+mW81JpZKRJf+gf+y+reGEAG
 i16St63kf+U7zQNzHmt183jqDO4/zgapVn4R4GzL527Q5AYjovR4K3kazAYFbC9MJs5B
 fmrUjsy9KnU28wUhW/ZvWMEsUFddpNvmExdUqqdOcOXMEmKCf0bVOokLgxx+9+EITwi+
 BcRGujKTA65R2jk1qgGAt2Kx/GUVnvETYzWw7pDnUu3K/1XBOngrGkwsOP4gWoOwqHwe
 T8PQ==
X-Gm-Message-State: AGi0PubklQvKF1+bs55x+08zBRyycufM13zYBO4JxymWneil3/wmwocY
 uG80TkBzQZMyC8WPs8qOYsPNSPh0MvuA3A76
X-Google-Smtp-Source: APiQypIUu09XDxvtdSjmV1gAWRN2o5sWbVuxt4Jq0jgiNgWyIYPR53nMMgVPgDGkmGKWLDzAAjpi4Q==
X-Received: by 2002:a1c:f306:: with SMTP id q6mr4323071wmq.169.1588771335591; 
 Wed, 06 May 2020 06:22:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:8070:e292:7300:cd4e:b210:1388:63d6])
 by smtp.gmail.com with ESMTPSA id h74sm2185392wrh.76.2020.05.06.06.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 06:22:14 -0700 (PDT)
From: Tomas Krcka <tomas.krcka@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux-user: add do_setsockopt SOL_CAN_RAW CAN_RAW_FILTER
 support
Date: Wed,  6 May 2020 15:21:13 +0200
Message-Id: <20200506132114.76406-1-tomas.krcka@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=tomas.krcka@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 May 2020 10:08:27 -0400
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Tomas Krcka <tomas.krcka@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Tomas Krcka <tomas.krcka@gmail.com>
---
 linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..88d4c85b70 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -56,6 +56,7 @@
 #include <linux/wireless.h>
 #include <linux/icmp.h>
 #include <linux/icmpv6.h>
+#include <linux/can/raw.h>
 #include <linux/errqueue.h>
 #include <linux/random.h>
 #ifdef CONFIG_TIMERFD
@@ -2111,6 +2112,39 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             goto unimplemented;
         }
         break;
+    case SOL_CAN_RAW:
+        switch (optname) {
+        case CAN_RAW_FILTER:
+        {
+            if (optlen % sizeof(struct can_filter) != 0) {
+                return -TARGET_EINVAL;
+            }
+
+            struct can_filter  *can_filters = NULL;
+            if (optlen != 0) {
+                can_filters = g_new0(struct can_filter, optlen);
+
+                if (!can_filters) {
+                    return -TARGET_ENOMEM;
+                }
+                if (copy_from_user(can_filters, optval_addr, optlen)) {
+                    g_free(can_filters);
+                    return -TARGET_EFAULT;
+                }
+                for (val = 0; val < optlen / sizeof(struct can_filter); val++) {
+                    can_filters[val].can_id = tswap32(can_filters[val].can_id);
+                    can_filters[val].can_mask = tswap32(can_filters[val].can_mask);
+                }
+            }
+            ret = get_errno(setsockopt(sockfd, level, optname,
+                                        can_filters, optlen));
+            g_free(can_filters);
+            break;
+        }
+        default:
+            goto unimplemented;
+        }
+        break;
     case SOL_RAW:
         switch (optname) {
         case ICMP_FILTER:
-- 
2.17.1


