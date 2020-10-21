Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1680C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B162242F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqOIURXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B162242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVI2k-0004ek-Rn
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI10-000347-8e; Wed, 21 Oct 2020 13:35:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI0y-000635-Jq; Wed, 21 Oct 2020 13:35:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id d3so3472794wma.4;
 Wed, 21 Oct 2020 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5sS64GiSnmfXDwPIZCoMSvNhCEcsO6wIvPcArhV3+yo=;
 b=qqOIURXFloBEn82NoV8gQANlT9mqefCoMan0WiMmhQHNdPP0hGC6hLI7iPr3eV1HJV
 vczs4pQOxNgUUJJzMcCiK7BqLhv+5nWfXV9mw92A8wHX4pbOkJGTsqAw/4feQl4jwOJv
 IiwLdB8oZJSy09i+Px6Qmmi8cMVxw4sYmFeLJGcUg1xMFkRWaatDVwoKOaHymeh4zk2R
 i6Wmnc/XnidT0HCk+0LJUetrf6TIuJFjZtMCDaBskkx4DT7ikhoRQTGC0arPiTb/oU+w
 1amfTjJ17V2L0SyyOah34UcZL/kSMCxl4WP1u0l7zzTE5P97jb3TZkN+YtksIlw9w6Gs
 rNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5sS64GiSnmfXDwPIZCoMSvNhCEcsO6wIvPcArhV3+yo=;
 b=b7nH730qSfocfvCNMTn1xndIZbC5+pmhUVIcCfv7YNJRETJY4roa21pKcL6XpFUDUE
 oQEbhw0sj7M3ZKJUDILXXnSiNQf3kNE/M5Pu86R8NS1Wak6gUtCaXQNHJQE10rm/iLqf
 UDFnGetaEzCyLyW7Do1oQsQUe6RdtEumMup5XAOPVtrKiMhj+drmmZFd43GcLWOdv6I1
 Pa9TfUzjuFi0XSipYb1ssJXPh7FI2Fk4LRopom9MJApD2dTo/FTQbYurt6kqlwjU5pSx
 +okr7IEezwd6I0VG5BrXuPOkVd/BXyGl+ZDSLFDvr+9vdPFEvVeSOlbXwJWyo8p+U+E0
 h06w==
X-Gm-Message-State: AOAM530dFORDzSDpK1ayYUPS/nWrqqS1Km/CvqCffd/eUtl30dtYROsx
 3YMRc/tWx4oLZECgKzHykn8KUNNYzxM=
X-Google-Smtp-Source: ABdhPJxELr3Os9sKHjCQIcYuZ2miiyJBdHWWbX0zykRyqwVxoDhrxTd+WhoTaGUjIMdkcz02f1Greg==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr4666672wmf.122.1603301706778; 
 Wed, 21 Oct 2020 10:35:06 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id k6sm4770610wmk.16.2020.10.21.10.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] hw/sd/sdhci: Fix DMA Transfer Block Size field
Date: Wed, 21 Oct 2020 19:34:40 +0200
Message-Id: <20201021173450.2616910-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'Transfer Block Size' field is 12-bit wide.

See section '2.2.2. Block Size Register (Offset 004h)' in datasheet.

Two different bug reproducer available:
- https://bugs.launchpad.net/qemu/+bug/1892960
- https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fsdhci_oob_write1

Cc: qemu-stable@nongnu.org
Buglink: https://bugs.launchpad.net/qemu/+bug/1892960
Fixes: d7dfca0807a ("hw/sdhci: introduce standard SD host controller")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200901140411.112150-3-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ed717ab549b..c849c3d99b8 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1107,7 +1107,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         break;
     case SDHC_BLKSIZE:
         if (!TRANSFERRING_DATA(s->prnsts)) {
-            MASKED_WRITE(s->blksize, mask, value);
+            MASKED_WRITE(s->blksize, mask, extract32(value, 0, 12));
             MASKED_WRITE(s->blkcnt, mask >> 16, value >> 16);
         }
 
-- 
2.26.2


