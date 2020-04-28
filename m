Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E2C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11CD206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArA3p1NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11CD206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSUb-0005gf-0Q
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 11:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTSTO-0004SR-L9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTSRl-0003dP-3M
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:48:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTSRk-0003dE-N2; Tue, 28 Apr 2020 11:46:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id r26so3440949wmh.0;
 Tue, 28 Apr 2020 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WekwITYydgUniyXF2jacUDLRb2z7FsHSDmau6DFbuNI=;
 b=ArA3p1NNIcKpe2Ppg66K5N3H6H8M6FQbh170ipLfbW+PFfLvxdIgr21zr3DoWVuYxC
 GyHhuhn1ECyvONSwIUDNs+U7CVVGbOYQdKpnnGHBR/WMRW8qCQhVIJj7weiLKP0mNjQK
 Upu7e7PdG+LSq+Q+MKHSITiPL9OwNHxLIzbt9u3DJcDhq0e2wR+k+HgB6e8lEaug3Mlb
 3n3mu/0xLdEoDOiFVBvhdiB+WJ44hQ4ld0e4+UIzbR72FOsuWAMsWuJUrLMSgmTNeCUv
 Cn1mMxJXTserHMzisV+PhKa3H+4QN6Yl7iLkGxMB/FPP2bF59iKKtzyB0GftYNsa5dtU
 6bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WekwITYydgUniyXF2jacUDLRb2z7FsHSDmau6DFbuNI=;
 b=EhfIviKSxtBFjepT42DhWIczCF/KVA2AE1XnC9wqh1i9HUu4ZaklGWQ8PKLq/AYlPn
 Y9jxMMMg+UNPttN+6b4h/dpagS0kLZI7MrnCqnuoL4wqcUNqhBHdEYUuOgk0Hg4Y6s3N
 DLFg9tem2FWQbTM6gLjk5cYohakTDSzYOkOEuEI8U9CwrmOldRFl1auWIffJcLZC69bt
 jcTopITrTV4xtQbRQKusnbJmEvG/FSBsdHDzRDL/9f9BI8fEY72wpTYPqcOSXl2fyWE+
 FwhDXjtPDz2zof2HjAB4c4RXH90yNYzYLXAvvzpKfSM9d6bE5hg2r0lT6Yg1wN9fseYm
 eHMA==
X-Gm-Message-State: AGi0PuYUCAqN0COooBEfZRB9I7mXnOpVqSFzFSo0YCHwqJ95GH2Kiwts
 rsVPIYPIuvxfAXjHta0L3lCTT08Y8WM=
X-Google-Smtp-Source: APiQypKLLJbSzMVCYslY+5PJNT0OaoLaHVxNsbPfzHyyQFW054lR26lIpyw7OweH3ZtoZFe72oHpFA==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr5448147wme.77.1588088812969; 
 Tue, 28 Apr 2020 08:46:52 -0700 (PDT)
Received: from x1w.redhat.com (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id p7sm27339428wrf.31.2020.04.28.08.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 08:46:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/mps2-tz: Use TYPE_IOTKIT instead of hardcoded string
Date: Tue, 28 Apr 2020 17:46:50 +0200
Message-Id: <20200428154650.21991-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using the TYPE_* definitions for devices, we can:
 - quickly find where devices are used with 'git-grep'
 - easily rename a device (one-line change).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2-tz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index a8dea7dde1..2c43041564 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -395,7 +395,7 @@ static void mps2tz_common_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    sysbus_init_child_obj(OBJECT(machine), "iotkit", &mms->iotkit,
+    sysbus_init_child_obj(OBJECT(machine), TYPE_IOTKIT, &mms->iotkit,
                           sizeof(mms->iotkit), mmc->armsse_type);
     iotkitdev = DEVICE(&mms->iotkit);
     object_property_set_link(OBJECT(&mms->iotkit), OBJECT(system_memory),
-- 
2.21.1


