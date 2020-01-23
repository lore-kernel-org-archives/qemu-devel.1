Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A732071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLLV5iSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A732071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufBQ-0006UB-C9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrX-0005Ct-So
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrW-0003kr-QR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrW-0003jb-KG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:34 -0500
Received: by mail-wm1-x32b.google.com with SMTP id p17so2612951wma.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v/VgNXOBwqlXi77Cypci6UQXOG1m8+dEPsEh2RkKozI=;
 b=DLLV5iSesL9OJoKrYqawkYuFpirNytSCncrUG4k7Hn3OHOqwgE398wLZusCZnbXGaH
 3bqQWsN9rI1UfdnAJ0b/yS0Iud6Q1UoaaowL5ZdPTGM7Yo9bxE+7D58R/KIa3rKJ0nMA
 nz0U3+zah4b0uSffMW4nX13NcG7vk+7vq83VVWoqa2++N/AICBG7yJu6zQSbc8r7JsjH
 ZCbcdA27wO580v5kGdsXfA6Iyzw7LNUXU1uytk0Bx6L17e2iCaMy443+UmiOEhSx8x0W
 HRX4WdWIwl9PA++jDy/SltV/hIdbDlJokICPH63dIgL4nQgSYr6PQra9I2zs2wGYQnLC
 PIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=v/VgNXOBwqlXi77Cypci6UQXOG1m8+dEPsEh2RkKozI=;
 b=OPJJWIbXiSR4r+HeCGCtqR6xF99uZFVufd1s3nUNiWEaL8EP0iRWZSTWsBrHVFvYP0
 E21TGnsVbPgdzpFTTXodbvmVUONL6dGxz+PQXgDOTIYqoDyvFW4+g/szvc/+3oWhVLwf
 A7+fTGxAhOu9rlXM42AZ4mIYvV3cnXTbTDfyreK+i3oRZ6pPsK2HowHco6YttqpJTxLt
 izWCPBM4B2M1VuZhpe3MkZXbcAYQWFzdYvSXUMaDtrFwX4OBx/kw0ljv3jJZuGVYqStH
 tC5WPlxSOGfw8XFcF8VOmi9OusLFj+ebOTLQQiv7J6TVUA3Q6u5dnVIMRwHBnklfBnOu
 1qSQ==
X-Gm-Message-State: APjAAAXB8NPIbuhw8Wf+JrW5UHUNn6LyzP3FwEcMUzEXRMcd1xSXjRZI
 XkpMm2UnqvTNdRle9aITMs927r1x
X-Google-Smtp-Source: APXvYqxQ0Edf/75PjdyMiqSqCPJVTmes/9ooXVwvK/QkMWGN5wLW8BiV/9yAwpIHq8rSX4T5j5Q2jg==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr4424211wmi.89.1579787373537;
 Thu, 23 Jan 2020 05:49:33 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/59] accel/tcg: Sanitize include path
Date: Thu, 23 Jan 2020 14:48:33 +0100
Message-Id: <1579787342-27146-31-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit af0440ae852 moved the qemu_tcg_configure() function,
but introduced extraneous 'include/' in the includes path.
As it is not necessary, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200121110349.25842-11-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 1802ce0..acfdcfd 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -31,9 +31,9 @@
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
 #include "tcg/tcg.h"
-#include "include/qapi/error.h"
-#include "include/qemu/error-report.h"
-#include "include/hw/boards.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/boards.h"
 #include "qapi/qapi-builtin-visit.h"
 
 typedef struct TCGState {
-- 
1.8.3.1



