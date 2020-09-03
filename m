Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947BBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2419420775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Qxs7suyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2419420775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDs3w-0004gl-S9
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmc-0007yg-UL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:47263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmb-0007m4-5r
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149271;
 bh=jNYZ3H6m2XWVrcJ9B8h4Agdnq/9+ccN+LxZ5qPDMllg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Qxs7suyw09h6ss9YUGIuRqXiFmY99g+M+88s6nUJQxnKnjm86KYOm0wykhnbh2RU8
 NnJwbhQcrnKVZvaU/w8hT18LOi2KtO2LAvTBUA1tndMX1lNRPtu3XoZ7ydX9eB0gOr
 AghgBtKa1pl06u+qs+MxTGs+b1j7ujo5sNnSTvMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1kx89z2u7Y-00jF4M; Thu, 03
 Sep 2020 18:07:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 08/10] hw/display/artist: Verify artist screen resolution
Date: Thu,  3 Sep 2020 18:07:44 +0200
Message-Id: <20200903160746.27491-9-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3P5bc689WyTFuaPWEFdjLSuL3vrHMqrEfh9hNRNY1S9foehOA9e
 qusKmtgdVBPMRGj13ZeyV6ZTOabTzXLk208vvBJxktrKfJkX5yID/NuStl7FOvQ2kTh5U3o
 nwy0yyckE/PJ4XUuSn+hKr/ee1LgZf1D7xJcqn7s+UHtJyf5f0cy7a9d+LAK9kI55VhUEsA
 duXLIRmxISxK8LY6bMF2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uPdEJB2AaAo=:iO0TWr/sZ3I43/MlNH9hGm
 czhqcs1bTBM4X+XIigr3V2y+8iuQwXKKpemAvL74ZOrApGRlBP6SvZ5xNPH1ZftXo5zcXvv0b
 glyOCcDeACrXBTfq+pB/OY6h1LhYB3L6KRf/Ees9OYHeJQQ0lRUvkNs/cMPldJE3ATIJGKOUd
 xGm2O1EthrBbqaYKKrVLCBBaJF8eVaVJCWlmsHSBHxB8cC1wzauoc4Nt3JYZg/ptnonPOVj1r
 IrBgNFJqjr2rv7PfEg9SmDfcUxsBa5S/oK0rFRbZrOPtNayASDp7z4f5HprDSVweExJgLKTmB
 0KEFkBqfYhTGZOJHPN5tEgjgVFyAwPxgq4pUe6JOZlRTkCHmIuvktl3G56pf5CGIHXtwbF31R
 jsjXvfEjg66YlgmGNckY35vNUgxqvlBMcEyjNfr2a+8TFyuohpcV1Ao5U0HSfrbQVb7R17jtI
 MKc/638mIsKfZwIjjQrDtrsxF/8d/5m8U12ksl3SWLF5Cr0F/cCRzgs6n1kUH4NO42zM07v83
 vdtYCEMX+OMo4yLtChVwZhBIhyN5q/Q9HniLR0tgrxgQ/opCRz7yybWf4NIevnqrNRWNfQEFc
 tecLDcYQ/ufgmcniS/OR1gddXMfVuHYknQLsb36PhOoQORHZYztNzuysD5ZopJ/AcKkZg9ctD
 fJePOPhOMZRwIXf8Hu5A3mbedoihcyq8G2lbGGpVEU+0sOWXkAxTeV20O3MNsRO02DKJdtuy7
 sF6fO+kIIat12EcUMkd09XYVGX0+u15pl9iU5MqfbJWKQ5qtBHUDmXAXAeny0KWLiCEIcIE+Y
 vvfI9rKI+2A+kawVR5xWAHRnDLKbejnRdGAZn0GuMSi0p1DCFInmn/emRN9qihyxq/bzUmGc1
 CnIqHZ1RI3s880q/t2tLoh+ojiutyLtOBKVk8cbl/xz9XKnnix6KcexJ37wVf1RVwwOprGuqO
 5af9+ADv8fTJOu9tx0kGHoh/etf6AvlT/teupWYRTYHKPQgkhQhMS7s1TYjer2nTrPfGqMREB
 TZcxVqrEaTd0BQ10tB1ardM/+v+nyD7B8Lb9L73qU0GiOT6hFDstbbtn5EWbIr85V+rF1qLJt
 T6d2U4VA1OezJ0Iyfn9yRUyk1xtNWgNTZg44NgXKtZ9CCPrxJ6em9yRyrTIKDeo5eEPmtpaoc
 By4VSINInE0IywApzT+voaBeC70rsKOX5gVLXPZsYOJ5asYsVQNHGJMF/imobjQVUBPo7a+eG
 Zl3Qpocd3YrtfhNTJ
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Artist hardware is limited to 2048 x 2048 pixels.
STI ROMs allow at minimum 640 x 480 pixels.

Qemu users can adjust the screen size on the command line with:
 -global artist.width=3D800 -global artist.height=3D600
but we need to ensure that the screen size stays inside the given
boundaries, otherwise print an error message and adjust.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
=2D--
 hw/display/artist.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 71982559c6..ff1532fdc1 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1374,6 +1374,18 @@ static void artist_realizefn(DeviceState *dev, Erro=
r **errp)
     struct vram_buffer *buf;
     hwaddr offset =3D 0;

+    if (s->width > 2048 || s->height > 2048) {
+        error_report("artist: screen size can not exceed 2048 x 2048 pixe=
l.");
+        s->width =3D MIN(s->width, 2048);
+        s->height =3D MIN(s->height, 2048);
+    }
+
+    if (s->width < 640 || s->height < 480) {
+        error_report("artist: minimum screen size is 640 x 480 pixel.");
+        s->width =3D MAX(s->width, 640);
+        s->height =3D MAX(s->height, 480);
+    }
+
     memory_region_init(&s->mem_as_root, OBJECT(dev), "artist", ~0ull);
     address_space_init(&s->as, &s->mem_as_root, "artist");

=2D-
2.21.3


