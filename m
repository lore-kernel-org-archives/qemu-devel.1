Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66739C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F99F20838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq42EvTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F99F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95Ds-0002UL-Bh
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joerichey94@gmail.com>) id 1j95Ci-0000fg-DB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joerichey94@gmail.com>) id 1j95Ch-0006Yn-FQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:55:12 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joerichey94@gmail.com>)
 id 1j95Cf-0006VU-9K; Tue, 03 Mar 2020 05:55:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id g12so1162366plo.3;
 Tue, 03 Mar 2020 02:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5yWmyIrqHTAqM09UqJ2f2/xjm9zFSZ0B5uaocMHnVpw=;
 b=Gq42EvTgtIEtNt0eaJDo0PCDhrpQBVT4gmZvA7L/ggp/SSIBp3ovBTfkpHMfHhHVgB
 q15WBbplMxylOM0MZpJ0CJ2+XiTx72c93lzVyJ/MpHBMXg+lEWYjonX2cbGkCBAEHZ3h
 hLKOaNFud0tDA2uUsK/LjbRDUxtDdoCeYQtoUc/BQyGrcG/stb7GZcQVo4MpmCFB6mN7
 mqrRnyKseeYe7cCTRel7fZBLicpYke0izv29V5tkdlVQR2J9FMnf5q2PMP1xnq9DoNk/
 K5MOYTx7huzzZbzItxM1AyHw3/UNrwAeNd1i2Z9+mBUSQATVQOsyT6AARARx2lZs47uE
 uiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5yWmyIrqHTAqM09UqJ2f2/xjm9zFSZ0B5uaocMHnVpw=;
 b=qdcfmiJxi92c5cFj4YdESWTzUUaQYbLcguW55VmsyMo6sA3rwnt0DK+rZb9Lgegk3j
 ITm0HzlJcolQRiKnYx9uiOkYbml6KKumvFvxvLSbEcsbxRYIk++QG3Tll042AwencK27
 6aWkYIeR+WhBPNd8Lzk+ISqR5vJ4mrV7gKfORNlNkokJo+5HJdgyO0LP71iCu6PX8j1i
 wcIw4N0lGuQ/yI6PBGrHHfOmQOpmE96tCpCuun5TJM5WpSTthKNXX8k1YVED1X1DV/kW
 pVhoI3U7QANlwTH38qtB/jdnA1BsUf4WUIy5cd8EJhw/MUVBIq8c0tvCeihIUvp8Udiw
 HwcQ==
X-Gm-Message-State: ANhLgQ2FdzDmcQyjZlK6pw5VhVpy1q6mLglSSUJXnx1cOJabfn4XVEeT
 4L3a6iCU6qcOmCfSDClbP59HNvBxKFU=
X-Google-Smtp-Source: ADFU+vsTqqScwRmKycjZH2eGrLtzFs0kNHZVULujOT4a7GI+8bDPLkVLgBG5ZFkj4kBbpFG1+Btoug==
X-Received: by 2002:a17:902:c383:: with SMTP id g3mr3806653plg.9.1583232906322; 
 Tue, 03 Mar 2020 02:55:06 -0800 (PST)
Received: from pride.lan ([24.35.77.40])
 by smtp.gmail.com with ESMTPSA id e28sm24473793pgn.21.2020.03.03.02.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 02:55:05 -0800 (PST)
From: Joe Richey <joerichey94@gmail.com>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] optionrom/pvh: scan entire RSDP Area
Date: Tue,  3 Mar 2020 02:52:47 -0800
Message-Id: <20200303105246.66390-1-joerichey94@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Joe Richey <joerichey@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joe Richey <joerichey@google.com>

Right now the PVH option rom scans for the RSDP from 0xE0000 to
0xE1FFF. This is probobly a typo, it should scan from 0xE0000 to
0xFFFFF.

This is actually an issue on some QEMU versions/machines. For example,
when I run QEMU the RSDP is placed at 0xf5ad0 which will not be picked
up by the current implementation.

This bug still allows a Linux guest to boot (in most configurations) as
the kernel will just scan for the RSDP if one isn't provided.

Signed-off-by: Joe Richey <joerichey@google.com>
---
 pc-bios/optionrom/pvh_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
index a015e1bf22..28e79d7fc4 100644
--- a/pc-bios/optionrom/pvh_main.c
+++ b/pc-bios/optionrom/pvh_main.c
@@ -29,7 +29,7 @@ asm (".code32"); /* this code will be executed in protected mode */
 
 #define RSDP_SIGNATURE          0x2052545020445352LL /* "RSD PTR " */
 #define RSDP_AREA_ADDR          0x000E0000
-#define RSDP_AREA_SIZE          2048
+#define RSDP_AREA_SIZE          0x00020000
 #define EBDA_BASE_ADDR          0x0000040E
 #define EBDA_SIZE               1024
 
-- 
2.25.1


