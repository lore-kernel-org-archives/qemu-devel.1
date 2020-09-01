Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B1EC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BFE207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E/wqhCfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BFE207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBBH-0003X3-Ai
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7a-0001X6-AI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:38415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7X-0008Bs-LW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598985296;
 bh=GfAPOzRoNtv6AQhGQrz6LyS411L8skaDZnE6D/yVaAY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E/wqhCfrEEk/gLs2UYVSDeHrECPOI5xnqWplQqVt1PnjdtCieohekFR/VY7NFky5X
 0gGBaIGdD4Tn12Z0QEs5IS7VbEYf75lTqP9OE83ecTOcItCddxKhSf+6q1E71jEQjc
 iomHWdRi4CKktOVz9s5Je767HVPvFTGnNBKnMBY0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.187.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1kmEt62JY8-00ZOLr; Tue, 01
 Sep 2020 20:34:56 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/hppa: Inform SeaBIOS about fw_cfg port address
Date: Tue,  1 Sep 2020 20:34:49 +0200
Message-Id: <20200901183452.24967-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200901183452.24967-1-deller@gmx.de>
References: <20200901183452.24967-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e37QjAvrtrusTSirTO1gaRJ89WS0dktBx/a9pYnXf/ZPSNp8CqL
 oOimbfOy2QGRd/n0nAx0J/oLcTEuc3vWWB302CLuL/d7HuhKbC8vX8GIriiZSmAT9hwPPph
 DaAlMhnjwcO7u2piTfilxbzn8eyO0jmdH1u1jKahsMR1hIM5i/Eaj4Vc6WDKOV7n4yJuQCw
 KDl2UzUkMwGmDOt+AC7Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I9rr1lg4Jzc=:bHU9q8Hle3lN751t74r+N1
 orO1qy0V4SVvvKt4whtjWKnhX+h8rpWjc87jlNDUZ2uTVlqHR9M16Azk3tf82usunYCAE9qy/
 0zJ51ra7EPLcV1YbRTN00bV5CMSlwA8kYW+Ty4SnUGhlEhJy3Cr335YVN3aAvTI147P4FolNm
 jnQxZbfa8BYHQy8OkvMjv8wlphV9PTGQiit0+fxzDgOUA//BSNSNjP1/M31TSxxBV40i52hr6
 rzSMoMG3/hKgMwqY2Tr6zIIks/m9m6uPtfmArZHtvtWDRmKO9ck4mPT8ZxQWo/7rFcbVV/mbA
 R+WOZGveUFj94chG3GX2sbcF4xDLD43qWo3ERa417nqgDOrdYsSD3GdXpIqlvtnfngqQckAHV
 1DF91FSPKBxhlDLVDkXK3h19SN6+Q+UsVzMG+depTVdb0s3I1gAfl8J2bzUZARFD74F67I6mP
 nHOLmE7sL03j8R02C6ccqoyUACeEaDm++pBNNFWolwx2NQ3dVfBaPo3bSprN24H90FoHMUftH
 MtxSwLDrdSoYOfTHHmC0Z9HI9DdZs6lN3nxzVYlwAChPRL0MPsmzv+EqSjdBmL77ZQQNXGlNG
 R4lusA5lJuLmWKYxcvrbOs3rUEaCJJxOp1UjYh/q3BKDQfkCvBkNyRMuaPM1DHb5A3trcUe10
 rHUkG2xucz/YpatFO9zZfYt7daNw7gByblKEBsi+ceW74rQUeSpIjnW8oS2VQOVUCQkrZ5K7q
 hYakf3srRckMLta7yOwEyVbWdzJT3qlly6slRfTe3DQL8tUBYUitk4L1ZTWHjze1V1ocM/nAc
 Cfip9c51p06jmcs64bvexDdYNn+rWxlH2ihNiwronSXriaJcV6wgO7NOT/oLMUSJu7j42IMP2
 XpybfeierTo+WLnmworzkk1K5779e4KgZHXdaXA9x30oBxdWjzGBzVsI1TgVzaYmzE7rRVg/Y
 N42EL/L7S2VU0qRDDbq6+TIOPRTwa9fij8wxMWdnr1tC+IAlOKQf6y7FZ8LEFiNuYIB+dma9z
 /9N0R/0Xm4aeDKnuBeoRU7cltAjdKBIl6PlLwUF/fhZeb8/1W/3elxiUW3qJMRVcq6TkvMpjU
 qTQnFs15N99nxsz+3QqNNTCuWbAaQwH3pGLg/evGJd+593oRPMTfrc5DFoW1drhRLqh/dYvLK
 KK3HSJDm+OLlhbppkWG4BV3uH/GPOgDvrrQyOs2Xsfs2ntoPtaGF/rU+TBZIfSjITT67s5HI7
 VHUiYoWdNvUcR+Q+M
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 14:35:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/hppa_hardware.h | 3 +--
 hw/hppa/machine.c       | 7 ++++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index cdb7fa6240..bc258895c9 100644
=2D-- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -38,8 +38,7 @@
 #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
 #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)

-/* QEMU fw_cfg interface port */
-#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
+#define FW_CFG_IO_BASE  0xfffa0000

 #define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
 #define PORT_SERIAL2    (LASI_UART_HPA + 0x800)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 4b35afc9d5..2bed49807b 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -69,7 +69,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     FWCfgState *fw_cfg;
     uint64_t val;

-    fw_cfg =3D fw_cfg_init_mem(QEMU_FW_CFG_IO_BASE, QEMU_FW_CFG_IO_BASE +=
 4);
+    fw_cfg =3D fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ram_size);
@@ -290,6 +290,9 @@ static void machine_hppa_init(MachineState *machine)

     /* tell firmware how many SMP CPUs to present in inventory table */
     cpu[0]->env.gr[21] =3D smp_cpus;
+
+    /* tell firmware fw_cfg port */
+    cpu[0]->env.gr[19] =3D FW_CFG_IO_BASE;
 }

 static void hppa_machine_reset(MachineState *ms)
@@ -317,6 +320,8 @@ static void hppa_machine_reset(MachineState *ms)
     cpu[0]->env.gr[24] =3D 'c';
     /* gr22/gr23 unused, no initrd while reboot. */
     cpu[0]->env.gr[21] =3D smp_cpus;
+    /* tell firmware fw_cfg port */
+    cpu[0]->env.gr[19] =3D FW_CFG_IO_BASE;
 }


=2D-
2.21.3


