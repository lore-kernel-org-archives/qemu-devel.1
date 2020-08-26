Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06C9C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741E020737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GvYLNww4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741E020737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2oj-0001tQ-CR
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k6-0008On-PF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:46489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k2-0002V8-Dp
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476431;
 bh=jLLmqaosE8xt+OARVvHb93VE1fgCMwuTT/uP+6We6T4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GvYLNww4LLRFIOGC3AUpb3D3a2lY3pUlcuG1gxJhaVmLQDRJTPrWzZUJVUR8Osri7
 GciXdfs4GrE3ksV+JXJV1G3KgEFaR2pbeYIfA7d+qaauPa4N29hvWshhULR2MShlFl
 7rG2zm3RwkReId2iE8BX8xQbWvn0VmTSsTVx1fSw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzuB-1kkwaG1wJL-00dVXI; Wed, 26
 Aug 2020 23:13:51 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 10/12] hw/display/artist: Unbreak size mismatch memory
 accesses
Date: Wed, 26 Aug 2020 23:13:43 +0200
Message-Id: <20200826211345.14295-11-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Psglrq9RXhoJHAzhdxSvovQRmJJqqnP2ZQqkOwmD7kneszFlhtu
 4Bv5++wev3Jk2SySPPtmIcdIqK3JrmMfwiAr1Le5OlDmaGxyqc3mpLBe+KUEg/CVNWvZeG9
 gxN/SDgFF4og8sF15ZOQXwieFpG5qoRWOoYHZ/zVtgOIqSXkdaTqm4dIxXM7/PypTom23vJ
 LupVbcQtMF/qTTN7ok8Bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5v7gXEH6Mtg=:9n0cLtKCCWTSNHvbgBt/jQ
 DKNawPn7FZ5/5mZMhWMO6tq9cpJsI0udsDLT9NSr7/SapEasK8pnCUjJJOtrY7BgOe94KuAOw
 UBDW0wIyBKU557iRAyiDG1xtYWNoshWVj2uqW+lqLd9jhuSgUaigMAep2FVwPHNXsTj1syrJx
 plsH5J+2p3aKy/VH0PAG0djZHgJbajH3b2E9wSj/Jft8RWhCEAUZxiD8uA5X3STL2yhRiiHXw
 lF6fkBQSqoeet07jg2qKA7Q1XEsT9hyNFkdEFtS4GNfhSv7KNR33U42UngCl7VGvZA/JqToKl
 LPRpnuDAa+A6MDnvcKXGuVRs8lC4gmqWDBHq++dmqHLICk2xO++P7Eong28NANQL/9XFB5j78
 d6WwC97BWfEWosUUey1jC58IIamyClqRIeGEJeWmWTPy5tHNh81BM9XmJ/hyg1y/1wa+fP0Wk
 G07FHevGXEMUYYBqzXVX04Wst3V3E/UoP6zCh1f5vlwNzWSBm7vjsYFI/xd9xv7oIrVAf2QGR
 7GPYY6IRtv3tiMmI5ReNRkS/oPKa2D71MjseWVHvePVzAeFdxGuU8w9mDO/7MaBKGqG7wgspX
 bi8Nfveeq4/5lEVmB1a4yNuC/ZoXrKmHCafKwNI7MsJNBRsriIZc/NivyNLUqM9NqF+d3Cf1F
 DfqwRulinJW5JGBk2lc4SFl1wjGW5zruSfGB5o5r86FdqRWiji3cB/qXAFKhRAI59o43ShKtk
 K7vQ6MLncUz/3NKRdJVnyLg/BBlU85l1S6ZQrqzv/Ll0LhEUfe+dqBwxVmwtjHJErZ4UfLvoU
 AG6LjjTufJUK6MEV18jhQhQr1WCVEx2h9DSB9WtpkVVMeTKJigZSTIdd3IymetTtQP5Gtm2qU
 Xuby1Vs+qpafb9am4LsEuSZZtIS9Lc3eprQr+FoYy+zD01mUg8klRdZjo0qwmWWfQCWy/72jT
 d5byk+leiTWFJ/cI1ZPDquPnFijG2DXbtVzLSloGKgK8C4Kr2g2n9VkiJstusPZk6eAaHYRLu
 R9E/xFjivPSpVtJVaR0wQY6AXh6jvhXmSetdUzsW5w3l6CHe2y7l+UBtboLkg18i9n87Hjfon
 0G2+9Nih+Ik5Bw7XK2pNdKY49kzOj1CZPgiUI3KATbTAVDpVpSpxwDl9Z+j+7Bt4rkOzkyIh6
 o+Zs6CoV/QcWpNz+iRakcAe6+xlTgOdZkXfWGjZDAyGRmF8OFrCiclq7G/6LOgnT8fJKdaHBq
 LwX5vOAdv0hWidZ23
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 17:13:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes
in memory_region_access_valid") broke the artist driver in a way that
the dtwm window manager on HP-UX rendered wrong.

Fixes: 5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes in =
memory_region_access_valid")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 46eaa10dae..44bb67bbc3 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1237,20 +1237,16 @@ static const MemoryRegionOps artist_reg_ops =3D {
     .read =3D artist_reg_read,
     .write =3D artist_reg_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
-    .valid =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 4,
-    },
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 4,
 };

 static const MemoryRegionOps artist_vram_ops =3D {
     .read =3D artist_vram_read,
     .write =3D artist_vram_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
-    .valid =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 4,
-    },
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 4,
 };

 static void artist_draw_cursor(ARTISTState *s)
=2D-
2.21.3


