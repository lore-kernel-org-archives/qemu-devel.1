Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A8CC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5916214DA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5916214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvrW-0007zM-O7
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34610)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hgvR8-00089q-6c
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hgvR6-0000wK-KY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:17:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hgvR6-0008KF-6z
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:17:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so7212954wre.7
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 11:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0qTyUXfjgsv4FS3LlpdkisQ54fw5sFRwJhSEO6vox+M=;
 b=r6mU2k+qcIHxy+OHCbbjtq5mGKKmWXuTUA6VzGIs/bJoOQhvFZ9vI8LW/nhgg998kM
 S9Yh87ExEqSWOJwks/Q/RWuwQ9n2BafozaL06M3KLEsM/O4ye/jd4HkGrVa1VBGZtr3d
 NsyG/xYGoN7s1HHCj7nIqaP1hK7OdP48JwVTbrg6isvvNZLTkTFRELJI5s922AG2YRI/
 c02fbJ8ruIbEVOF+2zo3W4Semd9C2lOh2P7sPhXMyMK4iN/gGWjq5qbncAuLz379zaB7
 W0rmd2qn4xHYBT3s/9eimH0svXqxo6Xgs8Z78zl+OxZZFI0aMNenJz5Fggt9pppRT1/7
 75FQ==
X-Gm-Message-State: APjAAAVjmwzMBplwXAfqHQAm/IlZAouA90Lp3mIZg8in4zpzykinWas/
 qFi0NwykFClLbZJnenMaSXC9jEoU
X-Google-Smtp-Source: APXvYqz5m9fmJWwWhP183vfd6UN64GWe7mZAm7LEAo3kWJ9e9SmZPMBLbQRda9ChBgjrD/uhqMmAFw==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr8263268wrv.224.1561745748031; 
 Fri, 28 Jun 2019 11:15:48 -0700 (PDT)
Received: from thl530.multi.box (p5791D57D.dip0.t-ipconnect.de.
 [87.145.213.125])
 by smtp.gmail.com with ESMTPSA id s10sm3331447wmf.8.2019.06.28.11.15.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 11:15:47 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 20:15:36 +0200
Message-Id: <20190628181536.13729-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628181536.13729-1-huth@tuxfamily.org>
References: <20190628181536.13729-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: [Qemu-devel] [PATCH v2 4/4] m68k: Add an entry for the NeXTcube
 machine to the MAINTAINERS file
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't have much clue about the NeXT hardware, but at least I know now
the source files a little bit, so I volunteer to pick up patches and send
PULL requests for them until someone else with more knowledge steps up
to do this job instead.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b9487..6b4fa7221f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -900,6 +900,13 @@ F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
 
+NeXTcube
+M: Thomas Huth <huth@tuxfamily.org>
+S: Odd Fixes
+F: hw/m68k/next-*.c
+F: hw/display/next-fb.c
+F: include/hw/m68k/next-cube.h
+
 MicroBlaze Machines
 -------------------
 petalogix_s3adsp1800
-- 
2.21.0


