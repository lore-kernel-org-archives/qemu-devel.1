Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ADAC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8980020678
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8ja9Qu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8980020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW4J-0001CT-Lz
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrZ-0002kM-UK
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrO-0003Mc-Rg
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrO-0003M2-Ls
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id 65so542897wrl.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+bsGyQcFnOKVG+Bd26nlz77NXbYaghgLj/LaGKCq2kg=;
 b=F8ja9Qu2fuEWoUyu5PPqgzA621ECwiPvYGvFj9QanTVML124/cbNkFFYz1x4dn1Tyj
 xGLiLK2IHuaR8NZv0BBEtw6WVS1Ob5UT3egtR5czRsDs+l/bg39Nw/AxSYXuk7JIyaAs
 +C/9A3uFcAHDqZ7sFSHpj21AdzOx0hSNzT+kWcfkTkUT4xyQ8q9QDM1OzgvPuSsYdSLS
 tI9Y8F2sVffYWuplQbzJ687UsbbU9fhQxSCoZowdzW06jseisLZq4MNXL8oMFT1cSl7I
 RAFIu7d80RlPP95avzXNhSjkk2qLPHICYPyu3kqeTdhdh9dupbpkawZooRLAFaWsIITp
 WRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+bsGyQcFnOKVG+Bd26nlz77NXbYaghgLj/LaGKCq2kg=;
 b=qvkbLJDqGIHEoA9AMZeClgOSarOKe7bz4/JPqcLYIK2ycXsqh6gBefSWQqBPGy+fx8
 GQpEsmVkuZE4BfEQKByjyzWlfeLhKY6rkC2bIDwPRYnTPtsg8ivSOzxYv6w2ebhYrZzL
 Fy3mNjfRRgiAug9gjTNC0hVPwsaPgPAy+ObS/iosuRBKaYVFpuFGfdL90vbzeY3ukLrR
 XDL8NRPcysaSuo3Ts3or1yOz+Z4VRfP2/IHId4Vft05CqG7dzwM8n7IxzlMj3KgHRKtG
 v7D8G+FRifcsCT3cyG/G7DL2OLcIOSnRt5EJq5T4lXPw2RsvVJBUeHmC9JZqMClIB4LC
 wiZA==
X-Gm-Message-State: AGi0PuYA63XFCfz9dh6EeR1orAjpSBALe87uCoclrRyspsMCBBPuq2/w
 +yIocd6wg4LUKA9sE+c+06Wky/fWGT8=
X-Google-Smtp-Source: APiQypJ+MA+ozQQxEbfMdnMsywDvTlsML4uX/3y31XTgjbuC3dW6JpMXY9TPDpDSwL0c5LusmCaKhQ==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr349359wrt.408.1586195313605;
 Mon, 06 Apr 2020 10:48:33 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 35/54] hw/pci-host/pnv_phb3: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:24 +0200
Message-Id: <20200406174743.16956-36-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/pnv_phb3.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 57d717ed23..a9029f5a02 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1008,7 +1008,11 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
 
     /* LSI sources */
     object_property_set_link(OBJECT(&phb->lsis), OBJECT(pnv), "xics",
-                                   &error_abort);
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     object_property_set_bool(OBJECT(&phb->lsis), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1023,9 +1027,17 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
 
     /* MSI sources */
     object_property_set_link(OBJECT(&phb->msis), OBJECT(phb), "phb",
-                                   &error_abort);
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     object_property_set_link(OBJECT(&phb->msis), OBJECT(pnv), "xics",
-                                   &error_abort);
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     object_property_set_bool(OBJECT(&phb->msis), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1034,7 +1046,11 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
 
     /* Power Bus Common Queue */
     object_property_set_link(OBJECT(&phb->pbcq), OBJECT(phb), "phb",
-                                   &error_abort);
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     object_property_set_bool(OBJECT(&phb->pbcq), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.21.1


