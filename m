Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51823C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164BE207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9Tak1XI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164BE207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tRg-0007RP-TV
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP4-0003QC-JV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOy-0002BB-V9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:17 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tOy-0002Ac-MC
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:12 -0500
Received: by mail-wr1-x441.google.com with SMTP id r7so7822185wro.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kriMcQzkMm95EhhcHWuzwV+BnRHVXDuG3tsQM4aq6Cw=;
 b=k9Tak1XIl5hpRS2IycmEMeNJAl2hJxRw/4geQF27jaiogi8lSH4HeUzU2x5VxYT7K3
 s24QmCAMNNOMYZARxiYBgZ7fGPJWiDYqlz4PI9/YVP8wN34yBoQAMFStI/hnEx/tp79b
 OCOfBJfw1Ob8++fdmnY07yuxKC4EoNc5n3sz36t12kYtzShPDc2Q0dslb7zbFQl1hGts
 2zIfbjaRqRLv/WCXeWjdYV4rXC4Kxhouead59KgvIU4N0avNYb1pYNmIWtmF/IrSXO8t
 +UzGlbbcBsJAbxPYiRb0qbcclHZb4TrqLcZY1A8xLx+QriUV0lDDbsQ+puyPd0h8VCvi
 f78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kriMcQzkMm95EhhcHWuzwV+BnRHVXDuG3tsQM4aq6Cw=;
 b=ZquwsIxlXErs/sck2bPQhU6sdpFfgfFdIFBuoleAIqxFhRtF8e+jU9xw32uArwfeD/
 8z3VhWyua7GO5cVBSE8K8doLvKdtL3G4cG+S17fMJhB3tTZ3tr5iZzK2EzpVOzYRvzxB
 qtdrXgwVIJVOeyj5tsOWiIhYge+5syA9CfRI4lcfJDtEFSADF6JnvGRgG1ULFfO50Kpv
 pUZmTpBAxtOc27RBxhihXIigjudTqiQruTaoMzqlxQVrQMJJ5AhRPQYRYxFHI7RrrzMt
 I01mpkIB0riMwbBPuj7TpqAtxJYrz7Q3IkM0y7LFKBajqZDkTv7cL4yTqBkRWE2ieqML
 xUDA==
X-Gm-Message-State: ANhLgQ3kxxCZe9mmRyZySEkkRkqwx0xCPSeSU1IsebiF9sjPe4dSlOOR
 hekZPpb1/3n4TFbFGetN+pB/k3oiWJ34sQ==
X-Google-Smtp-Source: ADFU+vv2nOB6gcwQFVx9X7UpbJB7rGuW1k7W+LyfeFmnyZwTO2+Z0uF92A/4C3sLElXfK5ryBk2v4Q==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr11311848wrn.9.1583425871400; 
 Thu, 05 Mar 2020 08:31:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/37] hw/arm/omap_sx1: Simplify since the machines are
 little-endian only
Date: Thu,  5 Mar 2020 16:30:31 +0000
Message-Id: <20200305163100.22912-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We only build the little-endian softmmu configurations. Checking
for big endian is pointless, remove the unused code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap_sx1.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 2bebab4171b..de5ff447dcf 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -114,7 +114,6 @@ static void sx1_init(MachineState *machine, const int version)
     DriveInfo *dinfo;
     int fl_idx;
     uint32_t flash_size = flash0_size;
-    int be;
 
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -154,17 +153,11 @@ static void sx1_init(MachineState *machine, const int version)
                                 OMAP_CS2_BASE, &cs[3]);
 
     fl_idx = 0;
-#ifdef TARGET_WORDS_BIGENDIAN
-    be = 1;
-#else
-    be = 0;
-#endif
-
     if ((dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
         if (!pflash_cfi01_register(OMAP_CS0_BASE,
                                    "omap_sx1.flash0-1", flash_size,
                                    blk_by_legacy_dinfo(dinfo),
-                                   sector_size, 4, 0, 0, 0, 0, be)) {
+                                   sector_size, 4, 0, 0, 0, 0, 0)) {
             fprintf(stderr, "qemu: Error registering flash memory %d.\n",
                            fl_idx);
         }
@@ -187,7 +180,7 @@ static void sx1_init(MachineState *machine, const int version)
         if (!pflash_cfi01_register(OMAP_CS1_BASE,
                                    "omap_sx1.flash1-1", flash1_size,
                                    blk_by_legacy_dinfo(dinfo),
-                                   sector_size, 4, 0, 0, 0, 0, be)) {
+                                   sector_size, 4, 0, 0, 0, 0, 0)) {
             fprintf(stderr, "qemu: Error registering flash memory %d.\n",
                            fl_idx);
         }
-- 
2.20.1


