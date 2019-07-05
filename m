Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE57C4649E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEF8216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="in9QCrzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEF8216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQtQ-0007DB-Ny
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40384)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjQhg-00030E-7h
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjQhe-00028E-Ji
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjQhc-0000S2-MH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id r1so4119640wrl.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XnuvMB0J1monHDTSCE4AjSSICHHhGGwURpGxrTZnkKs=;
 b=in9QCrzOgJPCZLxoXL0YJFNU5Q9LDQGhLXn7xLZOmffqHnLi8S2dRRvfPPsDwaSCMS
 Fv48sKlgedip9fAGFX2DDl69IzOGkBE+0IpBTlWk/FnSgSA4yxELeng52SNj55yaCbtP
 DGmkIxGz0NOQbU51YOmanm4AtIyhNVvRA9Tc7xUc2BWJM2BQidJQOKmrqGMWZvcwtZB9
 jt88V2o5iQqOX6n5g5y3zQoE5RxTHxlrSvYk8NmMD8nECbTvYAwKezNqO8usQq6eO2HV
 n2Up3qNUVCjQig+RvJ89IeS4XwjSdinWYpD+fapCc2m5LVA+U8lZRvodO0jwJaSGCtTy
 vIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XnuvMB0J1monHDTSCE4AjSSICHHhGGwURpGxrTZnkKs=;
 b=R2g6uGaj3HgF11ACSXyIpVEWGl9ZZ7i9zQ0DUHC99aDbBUVSjrnbgmneMozZY+iA/w
 sTboxq75T67aiaqjKxcRRNY+YruqmKfY0FFJKmUT1V1XVqeQoUnUv7rlo7pksDmG5Vgd
 /NT3p9tGnRcdFe2oLIhehdGUxEecrjd8D7pypIjfyZN1CcpPC4xFJk96W7zBEgxFDe4g
 XCIKlcUezf6YSp038em0Fu/HKgfNiAwWjeYauvCVQ8pLk7+PaaX03b3VSMYXxuhpwRst
 JRZdKAoMOoPsyPZHfmm4BZRuy8LqhASIqA7FKMtFfoX6S9CLdLdoQpSMIYSXr1bGAxb8
 dn5w==
X-Gm-Message-State: APjAAAWW9vnVZEqx1/9dVpghGLB+I39YmWTYT72Y7kqz1CBQv5W7MyUQ
 V5MYm9HXiGFcnHuYSW2wF+nEnQ==
X-Google-Smtp-Source: APXvYqwp7KEVxlhwiM9ZGm1lc1F/MVDJ/gQVOydkraAU6tU6cBXgCYWQTt+uFAfLDqrmrKXcDOa2qg==
X-Received: by 2002:adf:a514:: with SMTP id i20mr4892081wrb.281.1562342664134; 
 Fri, 05 Jul 2019 09:04:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z25sm10457578wmf.38.2019.07.05.09.04.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 09:04:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA8AA1FF91;
 Fri,  5 Jul 2019 17:04:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:04:20 +0100
Message-Id: <20190705160421.19015-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705160421.19015-1-alex.bennee@linaro.org>
References: <20190705160421.19015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 4/5] gdbstub: add some notes to the header
 comment
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a link to the remote protocol spec and an SPDX tag.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 8618e34311..ea3349d1aa 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1,6 +1,10 @@
 /*
  * gdb server stub
  *
+ * This implements a subset of the remote protocol as described in:
+ *
+ *   https://sourceware.org/gdb/onlinedocs/gdb/Remote-Protocol.html
+ *
  * Copyright (c) 2003-2005 Fabrice Bellard
  *
  * This library is free software; you can redistribute it and/or
@@ -15,6 +19,8 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
-- 
2.20.1


