Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96DEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DD721D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhvh5k3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DD721D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwws-00074F-Bc
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuR-0005Np-OO; Thu, 15 Oct 2020 02:38:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuQ-0006vc-61; Thu, 15 Oct 2020 02:38:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id 13so1922279wmf.0;
 Wed, 14 Oct 2020 23:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q1pTPTH3LX9VUD1iKOS/b8uIDJxiGdXQ9x55yZUv5B0=;
 b=Xhvh5k3ibwtO3exbd6PuxeS1fog9Ju7CTOlpQWvjlKQG4N5yt5IQpyzRVoncRKIRr5
 +eL96dsi0WaeKR5logMhgDylXtObk0jCleWXpnBwj9AzNZWADLw81gFUk0o0SgbCgcAU
 X+IHNmgxTIInaNzskyji5HrzXvQfYyXtPVxdAmH+jeINRlVIB6qD2WtOvlRzLJrFkaC8
 pZcRSzfM0R3zUyEbLdgr7icTMoGOJ/7ZlZVlYlakzSttkE3v2sm4C5GS+06xcLMzB6zB
 KZuaft2c2XuQG2QZ08nqua6+1SrCPX23aV9sSzQrAu1T/sYsETnYJZcILrWtrkIquJ72
 jt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=q1pTPTH3LX9VUD1iKOS/b8uIDJxiGdXQ9x55yZUv5B0=;
 b=bjT5kP6jKt0oGM7Qb6NxF0iCaB80g03J9cNuF4o30rR4ijMfEy0UjdM2djdILv/CSI
 QzbFkOkAc7TT+BPnDq4HJYMTgn6Jtytn3nEIxumb2mRZU3SMQKCjVhPkbxaHOnsTHsIS
 8c+UgE/2jIZST+YDglTe3BRmMVfun2Esd715HGe+XPpVEIzJcmHg1KSjHc3IETvOQO8P
 4TXzEuFwfvTXYC/SYID6Bu44jj7fnGhu/+8cqMKEN5+u0ezIiqV92Z35jGPS8ngfxFsF
 rXm7jYAYtbb3VHy/pI1AMi3P500BLiVr8QGSfKEnzgdjC0Hy7WuMV7PvvTuE6WRNha2k
 MVRA==
X-Gm-Message-State: AOAM530Yf+zdP6s6ZB1wLQylG+qHfVRf5ZMOCsSA2OCY66z5ZZZjYVSe
 ge5i6QNBZIraS01cbxx2J9AYC6grAuc=
X-Google-Smtp-Source: ABdhPJyjn/J4hPjlZNCH2FzNsfHMZYjXIyB9o4G8Cn0gfUKHPxkXcY1+C2m3W/LgA7Vg5bXhloW+8w==
X-Received: by 2002:a1c:4056:: with SMTP id n83mr2309019wma.186.1602743920375; 
 Wed, 14 Oct 2020 23:38:40 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l5sm2797914wrq.14.2020.10.14.23.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 23:38:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
Date: Thu, 15 Oct 2020 08:38:21 +0200
Message-Id: <20201015063824.212980-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015063824.212980-1-f4bug@amsat.org>
References: <20201015063824.212980-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Kevin O'Connor <kevin@koconnor.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is legal to WRITE/ERASE the address/block 0,
change the value of this definition to an illegal
address: UINT32_MAX.

Unfortunately this break the migration stream, so
bump the VMState version number. This affects some
ARM boards and the SDHCI_PCI device (which is only
used for testing).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Kevin O'Connor <kevin@koconnor.net>
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


