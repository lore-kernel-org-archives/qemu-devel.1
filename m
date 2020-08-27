Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63BAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665EB20825
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jUzT+LAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665EB20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOgN-0001Fd-FN
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOca-0007r5-2s
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:50063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcU-0001Wy-LC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598560521;
 bh=GfAPOzRoNtv6AQhGQrz6LyS411L8skaDZnE6D/yVaAY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jUzT+LAmIwW95FLhGoGNus66afloudSMl2A4tb06DA0p6/jjoN3DE/avXAQSSsa7n
 OLdhSKtYgdbxNTNT7z6Cx6wEJMmmP+R4EGZt3Z3+pC7GOFpimWTddj2mFbbZ8bcK0l
 ibQbHQyPW2Tb1LWI3zBNjT6J9O+jhQeIWe9KLzhg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.181.35]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1kkjQv0qRc-00ZO9w; Thu, 27
 Aug 2020 22:35:21 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/hppa: Inform SeaBIOS about fw_cfg port address
Date: Thu, 27 Aug 2020 22:35:16 +0200
Message-Id: <20200827203517.29404-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200827203517.29404-1-deller@gmx.de>
References: <20200827203517.29404-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sv4H8Z5VfW29P/71RunDSvZ0S3eb9+SxNIw1KsLfvBpS8nH5XJ3
 doLxzBukwebbKRpawbZF+c6Oux7k/SVGvYRu4SdIBGIcdfZVKYjdAPkrWkremEy+kNG1pUS
 5ad+SbMwUwV3b1XlY18UhJDu/pRYmkIa54AhuAlZu8Sfab9RmiLzTrTHleMw9XtO4OE8Ai6
 3yI66GfPyxZF8h7MKwf3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xtIir5blvKA=:m5JAW6vEETSj3t5mvNr5VT
 ffUYIlVJ35W5XuxblfIQHHzFjnC/TMRvjpkyWeXLf47quswbkUVn/JATNcac53w+4frxV+hot
 RqLg3g/Z7tY7yVa2VbyhS3kEIeicFiJk943tjouEHYPGDYRM7GsdEv1nciW3HtFjZdO30GNSh
 GyVElkUsG+1Gt9mk5Q1kJSKzpVlhRN+im7xVwTQcts1we7YuOxPPVEr7dtdj1pbXRWJ8H+O31
 bUovow6W2kA3lqHM/krInLYXehjxeFctEJC/UMQeb0pW4q5Mn857EKEhCnP+KbHbcyerROXs8
 H0LtRMJ0PiScGdU6idemzaVSKolhWxUkQbu5doUiLgM3Pp7WmE841rw8wqOXQCYtA/lVZ2Gs5
 aazgnngM+ylIwW7BS5kmXuzhLVJkcWehZ5alzap7yocLmx8A/syWW7Tjxl2xi7cI/ogPTK7+7
 3hF5R1Fvy1HIrkE6z6SeFm8xLIrQJISuD2UmQBlRnclAIYIh7Ex8pzzSnyQ1LJXz/pITATynA
 6H+3E1CYU/BCwwsWDMV5mBOZOerKPFRerV4Vat9o7KaCROh+incsE39bguwnHdfV8hsIwPhri
 39jaN8GgsNtgPGbNbXAm/2PMn9dYVBjvrrLgBL9w811GDV02oqllVrGVDlO/62QdBohZ2NFEx
 u0lNnqwbeL98a1Eh2HmpjckjlprnBbew/LcKagbWkUsuZGGLMHpXBTFqreoSFWGwv3CMt4dwd
 IZOlu6LZzQHtUcRVIF/UiC1sODcMtEehexxanIucoMTYFT240kiTMgklMQxQbECAqdvUKBr4k
 /c9cWvCaixL6n7IJzUr8SdsS//UTFZSooBbJt1+Oq0DgSZrF3JkOLAJ3qWBr5DcrnoL6wN4PB
 hFStkjBhLKxJo7mcik4o+zRipjqjfzSR3ooBDFG7lGf37K9R7p3DSGtb4vt+Uhi9uc7lYIYR/
 zWn1lc1X3ZMs3venYtrtPOI6C2UhbrO4XZAAEHHlD/NGhygFhkM3AnB9Km/+tsi4XNwtlpeoK
 O+0ECRzmB8MCdhIMy7lVABDugATEPtteNNQfYOqkwq4Hphht10laLgoxUHSFqEXISaGLukYqz
 +Tc5Yxvef10+KLk0yC8VilLutxLSozoCuLEraVu955fW6YCh4K6RqjjT+61pI7Vn0PPxmbwp2
 Jg2olQqGsFoxMfi8QGfiMWX242/mM+msfeYO7i3NlPvuUpVIGnYc2mKwnLSCham4BgD4QyMWQ
 yg3q0jwf7rt9BoZOp
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 16:35:28
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
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
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


