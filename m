Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC6CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2B0207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjbbnBbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2B0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXPz-0005Yr-Qf
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX47-00022a-DI
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX45-000485-AK
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:23 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:33219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX45-00047m-4l; Mon, 06 Jan 2020 13:25:21 -0500
Received: by mail-qv1-xf41.google.com with SMTP id z3so19446137qvn.0;
 Mon, 06 Jan 2020 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tFptgxo5nLcHuBzNhDqkhDGvP/NtmbUAgg4er/i3OcI=;
 b=CjbbnBbZeH65SvqiUKCUdLGlmqNvamFF0SCoUPUUECYmNgvoxr20Hho/d2NoFjC/4n
 +ywLwA3JsotAuqchbZE06Kis3BhMSNOZ2xrNZZPa4+JNO6u2p6O8JN2NWJCVcoVh04o/
 E7aHRSIznAfeFO3aFLQXJ7eSw8pq4ZowRdjG3BdZPMsIacaX16L70D1xJa/dYgiJSEEe
 P7yNhPp1HXobhQzQkRIfAF/G0Wo8uOtIRFeEMktzBa9U7HJN21+BzEiO8TJehE+TPab9
 MeXbZbMbJIcDAsRnstHY17ZCJ6drHm/8qvpNVtyX7Z5E2u9zWPKyrNTYN2RDemiINZP7
 Gegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tFptgxo5nLcHuBzNhDqkhDGvP/NtmbUAgg4er/i3OcI=;
 b=FgGYmcLGbs6Tsj8NhenRRk2DEYK9bUM9VeoBDchWtS/28bFFI5je745nMBRe6FFiSI
 zZahaPUTgrbmVIUWms2h9N1BbgVUeKfeMq0bDcXvOP9DosH1Z+3f1UMsRG0zYdwb5XUU
 Z+FPqTOlH0yx4i073NgU/syPBdfFkbYZI2mR0yyfMa9J8nh2k4N+Rl6NFTn9eK5iFqMz
 2OCYIBNe5T0D8p/55YH0vta8V80SEqB0pL2mxceiK93gUNt11lQutsr/R3eaLYDilnyw
 soqrvbBUCXVciyMWXVK4BdCoANONl3AR3NchTykAQUJY2JDq5IzziM+/Cmse09mFZNnN
 NfKQ==
X-Gm-Message-State: APjAAAXh5CU7a7q9qRZ1g5W5uIUnFoKIR+u3DISHMG5SVVFbtanFUO+f
 5WZ3g7TZc2jgOwEhCjZWIlty3szL
X-Google-Smtp-Source: APXvYqymKbrnOHEYtNhyMzPUU1W18xtiLJrqeXj/Id6ujn5bb5mLTq9mC92G0kVdcTfeMFvWLV05rw==
X-Received: by 2002:a0c:e2d1:: with SMTP id t17mr82517992qvl.25.1578335120624; 
 Mon, 06 Jan 2020 10:25:20 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:20 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 16/59] block/gluster.c: remove unneeded 'exit' label
Date: Mon,  6 Jan 2020 15:23:42 -0300
Message-Id: <20200106182425.20312-17-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'exit' label in find_allocation() can be replaced by a
'return -ENOTSUP' call.

CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/gluster.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 4fa4a77a47..43bf76eed7 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1381,7 +1381,7 @@ static int find_allocation(BlockDriverState *bs, off_t start,
     BDRVGlusterState *s = bs->opaque;
 
     if (!s->supports_seek_data) {
-        goto exit;
+        return -ENOTSUP;
     }
 
 #if defined SEEK_HOLE && defined SEEK_DATA
@@ -1466,7 +1466,6 @@ static int find_allocation(BlockDriverState *bs, off_t start,
     return -EBUSY;
 #endif
 
-exit:
     return -ENOTSUP;
 }
 
-- 
2.24.1


