Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4EBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DF8206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3ryhhun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DF8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0EY-000056-6Z
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09o-0001Ul-LR; Tue, 03 Nov 2020 12:31:44 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09m-0007bo-T7; Tue, 03 Nov 2020 12:31:44 -0500
Received: by mail-wr1-x434.google.com with SMTP id e6so2144860wro.1;
 Tue, 03 Nov 2020 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=flfR7C3ZpMvn4beKvApVO0gmRbPM0MVpe29hyYCIhJU=;
 b=h3ryhhunZS3camgASrkSqLiX82noUhgPpWVbaaZGIykh5WlC0RfkDvnAc+zJCoVr2H
 4yImEP+dKbT3MhHxxlHzbPT5WbDkrSboo57H61BuAYKMP9uPuyjXFgsX/1YASzDrIH2s
 WXZ9pY9cC3JReV/L8m6qDVO4Mg5dLWLbl/+FU36ERhB8GMt4dGR4S7iiF6PDm6nzhH03
 1a+xkqfaBmL/oYGUI/Y+6Wp1mkGPVY4mS6grCzml3pqcTSO6SHHtN5i7kfhHarFRQbWZ
 vW3fT7kk27UyAdekCSXGo8GZmWP80wPSmuGhwuPO7/+KZb21VLO99wS1gdEgq1E1Enk1
 afvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=flfR7C3ZpMvn4beKvApVO0gmRbPM0MVpe29hyYCIhJU=;
 b=mA17BVDDzJ5R9quOCgOuomAtwamJB2Eip0raGhS8egkSsHgkCAiOaVo1KOwdPXeNAF
 OdzZ8D3kYkyjzqBLKXdR4a6VKEHy1oT4Z08dz6Ca33QPFOHUhPslOPtKwVpe0TvImOK2
 4Uv/5NZgAjF8m+XdPfxFIpephhGuGGf22DfLGUCECm3rtLsCREUWOPFGqamTBd0KaKwR
 78dKpPOS+CkVkOUIpCC1WetOqtMzIVPM76zQDaLLMxzqT+nM/tqx3LLoajRxHGjiURrt
 kOsKpR6smOIwXYGye0+NMKZetjD/NaQweRs8l3FyUysbMXAI9omt4uirrXZTUTYxOt9f
 PDYQ==
X-Gm-Message-State: AOAM530Zlw0vmv2EHkS6+zQmxTepZzDLMUSvmtfGkCZf/7N7XaHm2Q5q
 DlLimb3M/QRCEJn+1J/cbYLzZKZjbrI=
X-Google-Smtp-Source: ABdhPJyZ+iAE2mxZugn6hufNKrr9JKzoMLQqYjgvZwFdgQaQojHRbVMdQ2r4lYeGTnEMSSyJUcRoJA==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr27496606wrw.151.1604424700260; 
 Tue, 03 Nov 2020 09:31:40 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n6sm26713461wrj.60.2020.11.03.09.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:31:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] hw/mips: Fix Lesser GPL version number
Date: Tue,  3 Nov 2020 18:31:23 +0100
Message-Id: <20201103173127.2704256-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103173127.2704256-1-f4bug@amsat.org>
References: <20201103173127.2704256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Paul Burton <paulburton@kernel.org>,
 libvir-list@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Chetan Pant <chetan4windows@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chetan Pant <chetan4windows@gmail.com>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201016143509.26692-1-chetan4windows@gmail.com>
[PMD: Split hw/ vs target/]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/mips/cps.h      | 2 +-
 include/hw/misc/mips_cpc.h | 2 +-
 include/hw/misc/mips_itu.h | 2 +-
 hw/mips/cps.c              | 2 +-
 hw/misc/mips_cpc.c         | 2 +-
 hw/misc/mips_itu.c         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 859a8d4a674..04d636246ab 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index e5dccea151f..fcafbd5e002 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 96347dbf65d..50d961106da 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index c624821315a..962b1b0b87c 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 7c11fb3d447..4a94c870546 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 35409852588..133399598fc 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.26.2


