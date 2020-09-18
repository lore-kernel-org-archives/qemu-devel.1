Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC22C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2403A21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or9i/vPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2403A21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKUo-0007iZ-UD
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNy-0002ne-2e; Fri, 18 Sep 2020 13:41:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNw-0000GF-Ln; Fri, 18 Sep 2020 13:41:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so6437635wrm.9;
 Fri, 18 Sep 2020 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+lnXOruvwPuxAjkIojj7o4yQ5aFq/OmvzZbaJBwTWHI=;
 b=Or9i/vPQpsO73usv3qG+KDnRuo2OOMhVmIb/ORV5OOIw4CEUU2qA6gQrsFnGACFAUs
 MCoXGhi9qC2bCU/1prPvbxdIir2pbkXDJi8rUqNsA/0Xw+YKOyddmToYHLF4PLQ9qWCo
 YiX2wpTJ48K2Ls54ztB67sy8lP7kGrU6SDqykStK2/KA+Ffa8/4J3rIcRlHHcmbFCkOB
 lACBJNRv92pOB5i0N1lg6uf4Vt2hKOzh3vHMHUIAp13jD0gkGPt3EB0B1qXoRsbLQMyF
 B4hIe4IghQMBoxDh3hXNueItLdw6Fb+yxFsZ2H3TUGWx7dysxHf25OaNc9xazzyQ0W/9
 ehow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+lnXOruvwPuxAjkIojj7o4yQ5aFq/OmvzZbaJBwTWHI=;
 b=ld3g2hOEx4ntyCTWyDMUYGCkMWT+WKt1kA1L3pYowCIb+Q2RsFAK2FmiG3cPl/r/VP
 mKLwW8uZeKDZnhrbt5ZpK0WKi+/ElZsZ9okPWuxua20NQ6uZl2Jf3NuF8nLbSnaxd5Uj
 1IBOSyqewNUYpgZQ/0TPD4CpVUae8zENh/ftnOiOKOZ25yfckeHqboHYyiKWN/bXz3tA
 diJH8r0T4qczRQNbgtfLBcT7mXSM6ivmEPiwZ2zNd/WTkMYJaBdGn2WDOcPuawWFzg+Z
 hljlWTLtHSjxZVBHctx/FHrJcBoxyGNpxJ7NKjrKCoDhSl215QyFdcYeAqO+Gk1qDt2u
 38+Q==
X-Gm-Message-State: AOAM5306FQadtFaJWYrt0J7JJ/yfufDojeuGj5X189h94imTfSX1/S2D
 G31MS/zVM7udgdBelQlZc7ECuQyBgdY=
X-Google-Smtp-Source: ABdhPJyNuXppnabVqj7d9ZQ2+QlTwjxtPPlqmLeVjmVCa2hTDlWfTJW5plEXiufffA9L+CxmYIHu7A==
X-Received: by 2002:adf:f701:: with SMTP id r1mr39481606wrp.341.1600450882691; 
 Fri, 18 Sep 2020 10:41:22 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a81sm6356179wmf.32.2020.09.18.10.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 10:41:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/6] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
Date: Fri, 18 Sep 2020 19:41:14 +0200
Message-Id: <20200918174117.180057-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918174117.180057-1-f4bug@amsat.org>
References: <20200918174117.180057-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is legal to WRITE/ERASE the address/block 0,
change the value of this definition to an illegal
address: UINT32_MAX.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

Same problem I had with the pflash device last year...
This break migration :(
What is the best way to do this?
---
 hw/sd/sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 30ae435d669..4c05152f189 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -53,7 +53,7 @@
 
 #define SDSC_MAX_CAPACITY   (2 * GiB)
 
-#define INVALID_ADDRESS     0
+#define INVALID_ADDRESS     UINT32_MAX
 
 typedef enum {
     sd_r0 = 0,    /* no response */
@@ -666,8 +666,8 @@ static int sd_vmstate_pre_load(void *opaque)
 
 static const VMStateDescription sd_vmstate = {
     .name = "sd-card",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(mode, SDState),
-- 
2.26.2


