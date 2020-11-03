Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969DC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4418221D91
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv5Gj0GL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4418221D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0BA-0003XV-8R
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09t-0001X1-Vj; Tue, 03 Nov 2020 12:31:50 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09r-0007cJ-If; Tue, 03 Nov 2020 12:31:49 -0500
Received: by mail-wr1-x42f.google.com with SMTP id n18so19387260wrs.5;
 Tue, 03 Nov 2020 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uQkw/fFXtZYbLMzJPqkh+QCHUXnq5WFrEui1LRbfpqI=;
 b=sv5Gj0GLdzO4O8/BIPAF4HxFnkVs/u0Piw3qfNbC1bUj8DVBhx+3FO/pA63T7fi/Ts
 cynJaIMn76K28Asi4axqPYTr7cIQeQBs06bGKz15vUKMTFVmbfmVQcHDSG4fUBUKko31
 GDweZlwKuiqXMhe91x7LAv7q0iKz1QGvJ49biZ3WVfK4gi/XYFI1o9EA3b6mriXnye5Z
 Nlo49YrcETeBxgg8XuexHxLT8Gt0pRFz6xa8q+ZVLD2EOyt2w+ZeSSFke8E99EEhOUHQ
 /C6sKx1+IeUBRjm5gZ6SR7C/6D0IabvToj9s054s8FVH+ec2ZdBERbLNWXkxggK5Lyte
 aeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uQkw/fFXtZYbLMzJPqkh+QCHUXnq5WFrEui1LRbfpqI=;
 b=VZ4dsJlxgptd0ILCsYwo+pPiCa8SytLsBy5p5Cwg3B/JSYYpmt0v2cQlKOQ0n5rev6
 UeFU87stdi1rKqxaSuAWg7GNaLrdgGfxuQRV+4uqeuMMzwYOXG5n0ipAFXuWod9gh2jh
 a5rFKRufwrtvqV6oIEoP55L20aNgjy87FFDo83l7hEcR7kTG1DLQEdiLBsG6pzfhBwPq
 Oi+hVTcIHbMRTBRkuG+kZMOHFp/Ad3WLkjrylaZCn+70/3qAJyLCFORS8StxdDDcF3uC
 HZjL999O9v4j5k4tmQWc8ymY95y1hjQ/RW8UW1pVbpr2HXm5CXpW8YamnvWnyOppx7fa
 wbyA==
X-Gm-Message-State: AOAM533Ow57hffYLOKyCQcmYpBtzfE5eM2v203VYKwOvd9HDIdBoXrYg
 8RR++K3sEYWIqskYRvCmqqeQz0DxXAI=
X-Google-Smtp-Source: ABdhPJyb3uYkPL4Kq/qc0e4nfle7YTIQ90dWfB0G70y/L5ZtN2EqhL+EgH76dc2CXh1YtNB5QspA1g==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr26589912wro.88.1604424705483; 
 Tue, 03 Nov 2020 09:31:45 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h62sm28205976wrh.82.2020.11.03.09.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:31:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] hw/mips/boston: Fix Lesser GPL version number
Date: Tue,  3 Nov 2020 18:31:24 +0100
Message-Id: <20201103173127.2704256-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103173127.2704256-1-f4bug@amsat.org>
References: <20201103173127.2704256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
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
Message-Id: <20201023122633.19466-1-chetan4windows@gmail.com>
[PMD: Added hw/mips/ prefix in subject]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/pci-host/xilinx-pcie.h | 2 +-
 hw/core/loader-fit.c              | 2 +-
 hw/mips/boston.c                  | 2 +-
 hw/pci-host/xilinx-pcie.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci-host/xilinx-pcie.h b/include/hw/pci-host/xilinx-pcie.h
index f079e50db44..89be88d87fd 100644
--- a/include/hw/pci-host/xilinx-pcie.h
+++ b/include/hw/pci-host/xilinx-pcie.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index c465921b8f7..b7c7b3ba94d 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 74c18edbb34..3356d7a6814 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 3b321421b66..38d5901a454 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
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


