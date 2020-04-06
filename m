Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2843DC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9F0206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/CmFvSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9F0206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWB1-0005AB-0U
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrV-0002eA-TW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrU-0003Qt-O7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrU-0003Pv-HP; Mon, 06 Apr 2020 13:48:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id s8so488453wrt.7;
 Mon, 06 Apr 2020 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FDBdESrURRPicePACLX6D+U/FCdcNfiH/tBCs4PTlwk=;
 b=P/CmFvSVQzsQft3uyJjkRaW/eLuDkTyzXBCgHKyPqAPYe3Bn8uj2wmbUpHOB6bgYXg
 3Y2cBzAFgYPfvySz+M2OfZyA4NAuG2qcXBe9fpXLGLq5Cg+LaT8IY0v7in78HBwBEzvd
 fuSko43evhKUnILP9E8YfupkQ71/I7kVRQJAGC0VhZmHI5XXCHXtO/9yFV+FfWJojVvI
 u6y/wiv53eUCT/iuKhA6vKDtb5F0DooiQ7bPEU/T36LZK4RKQBtXOQyLNsUQ7AkPJocc
 eIaK1Uwr74m3GCjFdQiiwtP4D8Mg4o4/eE+7sE6ALvkdOBg8B+LRRw56Tcn9q6D7Jgc0
 7RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FDBdESrURRPicePACLX6D+U/FCdcNfiH/tBCs4PTlwk=;
 b=nwctdz+GlZRNP7nw6uXKgAyz35r0QZAI45M8kar/96jsYoVtPAi8uJkpkCxrC5rPE0
 8BDm4Fll6GT6oJMOetl/5jkt8GpPoQMeW+v1h/EpYHCEirJnEmJ0MusVn+eGHHcW7l9E
 iCWNrJi8B55fPFh0sL5+oNWfD6P5DoueYc6ZCMkyiDTrqEvOG7hFvOKnrheEcAaJCqrk
 34yZb49roeZrSf1YCffTROnzGiQ8pDGqfTj3VLIyCUHnRFNW6Y4X3Q56JhsO72WTzoi4
 LIqjHGCdW8hn8EcgBmI1WsRUW1BQz//R3/ts07nK+3cL5NXAvYgYigpriTtqsmFpG4T6
 uz5A==
X-Gm-Message-State: AGi0Pubw4Oe+H8rN81To3xDWuYt1lO2LEzu9FTovdHzMOyuwWhb6nr+a
 GkxT82YAoDtyS3n0FWSCGcSYQ+7LwtQ=
X-Google-Smtp-Source: APiQypKeuEhl5xNMVushH86yDeOsELEGkR4FFfTT08X1aA5vzhpdcZKtsgLIu5ANPvBIvBuDVlIZBw==
X-Received: by 2002:adf:a347:: with SMTP id d7mr352144wrb.21.1586195319419;
 Mon, 06 Apr 2020 10:48:39 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 39/54] hw/arm/fsl-imx: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:28 +0200
Message-Id: <20200406174743.16956-40-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:i.MX25 PDK" <qemu-arm@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/fsl-imx25.c | 8 ++++++++
 hw/arm/fsl-imx6.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 3d87fe867e..69d8645dcd 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -271,8 +271,16 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         object_property_set_uint(OBJECT(&s->esdhc[i]), 2, "sd-spec-version",
                                  &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
                                  "capareg", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index b3cef5bb57..c254294a70 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -343,8 +343,16 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
         object_property_set_uint(OBJECT(&s->esdhc[i]), 3, "sd-spec-version",
                                  &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
                                  "capareg", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.21.1


