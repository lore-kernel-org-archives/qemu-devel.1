Return-Path: <SRS0=Ux9P=SI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BBFC10F06
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2019 04:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A560C2173C
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2019 04:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cse.mrt.ac.lk header.i=@cse.mrt.ac.lk header.b="D20UMQWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A560C2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cse.mrt.ac.lk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50251 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCcaY-0001nZ-HV
	for qemu-devel@archiver.kernel.org; Sat, 06 Apr 2019 00:05:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hCcZg-0001Br-LL
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 00:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hCcZc-0000s3-Cc
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 00:05:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:37372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hCcZZ-0000o0-Pn
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 00:04:56 -0400
Received: by mail-pg1-x535.google.com with SMTP id e6so4088823pgc.4
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 21:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cse.mrt.ac.lk; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=KVBaOxuRux5oEzw4WwN5UyU3uc4DDu1j8pQtw55x870=;
	b=D20UMQWxH8WnozV2iNtCqc+frnkpX/KKrRmsfg/7TNTQFAxQQjoPHo1rvuTwa8NZFC
	wjD37YrUE15PwDS6qi4hThXlY4vvJU78vLME+G3wbtq9/hK7fNfWEprcxNjMNsJYAzNk
	sLT20OA9cvA89W9kPmA2wQ7aHrMgg4ADQlXeMCGtSSANKWXUAOJ4clOVrT2hY65e+E0/
	yXPMQB23VZvNczllHYP6Wj1eVjmi7ohA1qwwv1/PU1vMV0kPgaAIa+fF5EH71xyaStAQ
	bhHOoG6RqsyjGpEeuN1y2RwGJGQObsyQvGVWzPY9k5lge5aFTTb1ZO5meqspvwP9F9mO
	fTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=KVBaOxuRux5oEzw4WwN5UyU3uc4DDu1j8pQtw55x870=;
	b=aB98qwPPvynUoLKEyAcdYWRmIM6SAAXl7Gu8jm7HMhgLWJ3Yk2NhRnS0gZObMmv+n3
	jDbsupYQcqRwb49TPJpuiRwlyqXwlaYZdYe66vN/QQm9bn/Bd5l6PameZCBfaFaOPtWE
	DmQvtBtt4/iZ+lyfYt28obPMI5HVxAgt2ySR8MWnIGpdaPELu91iI348diiRc96w/a/p
	Vpu5JzCujQMf07L+3u6REdNt7dGe9v9u3z9bGzxipnosHUEm+Wa6dTVrkq+xdXX8vJAZ
	kmPBUr75RUkbn1EPAzLMTBTlOXaHY5WzuWtPk51qcYJY/BGnUfmoT+MUN8BqTuWARHfe
	8ZrQ==
X-Gm-Message-State: APjAAAXDtIR/t+3Oamv6xjStnM6LZV3ZMwCG9bWapPIw35ZXcqnguwhf
	bP4OiO8w+fVASUIMdnCMxMNokmLN/2M=
X-Google-Smtp-Source: APXvYqwrZt1l38nz3y6G1WcXVRojLz6v+CoBKSNPcENbuII+7G5uVzGuJUsmIdKNLZbG3db0LxLSSA==
X-Received: by 2002:a63:2f44:: with SMTP id v65mr15650727pgv.141.1554523489122;
	Fri, 05 Apr 2019 21:04:49 -0700 (PDT)
Received: from iLive.wlan.uom.lk ([192.248.9.138])
	by smtp.gmail.com with ESMTPSA id
	b14sm34659533pfi.92.2019.04.05.21.04.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 21:04:48 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
To: qemu-devel@nongnu.org
Date: Sat,  6 Apr 2019 09:34:22 +0530
Message-Id: <20190406040422.5276-1-aruna.15@cse.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::535
Subject: [Qemu-devel] [PATCH 4/4] Header cleanups: Removed unwanted includes
 from cpu-common.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190406040422.q6rwV19dFODOG6lpyik3TeLcG2QksXMJ4Dt0pRXxbd0@z>

Removed unwanted includes from cpu-common.h
This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks

Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
---
 include/exec/cpu-common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index cef8b88a2a..a3594f3f50 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,8 +7,6 @@
 #include "exec/hwaddr.h"
 #endif
 
-#include "qemu/bswap.h"
-#include "qemu/queue.h"
 #include "qemu/fprintf-fn.h"
 
 /**
-- 
2.17.1


