Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB330C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8833120767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bzZthR50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8833120767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYuV-0001Du-FP
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXd-00065W-9Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:44839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXU-0002v3-2F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075301;
 bh=COQc6HaTkxyk6PCDL8szWSyaqNKoLmkbh/JrrAXBxtI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bzZthR50l6yZP5V11in29lrvOmF6hhZ0RqWSPhHXbZx26xRauf671SnwoDjOTXFQk
 s+r8/w9xsAcQ6I0W7myvXGu//LgT9W+jI6edJ8FUDyseUofp4j3PEk0c/e8Q7+3sA7
 xH3Dj41MDUDd9jjRsV1UrPpAQbW2liKSlCsPpxP8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1jvKtT0OSQ-00IBsm; Wed, 02
 Sep 2020 21:35:01 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] hw/hppa: Tell SeaBIOS port address of fw_cfg
Date: Wed,  2 Sep 2020 21:34:53 +0200
Message-Id: <20200902193456.29844-6-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200902193456.29844-1-deller@gmx.de>
References: <20200902193456.29844-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4JpRpTc1kqank28efAEjVyLQUDwY6O5PfqbyekNTYm/6l3Xm+TS
 v6s8qB6hn192xMXyMRZNCWZnMvukIYes9FutUrdb+RuALRlGxuDR/1oEVI8fnPT4RAUTMKL
 0QivzwnOAyXYIntqWuLwjDjpXHnlmDBDTLkgfOdRCvIPy83XSAhs2YebdLsAjE5R5YWUvG2
 Mb8DFLAvfCSLJNkUcTYRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0FAWXjcoVoo=:jJ6YZv3Kzkd9fty6ttjTmW
 i0eg0z8W0TaN7D3/82ay/JNny9Yc6I1cZ+flqBL3FQkVBi2xlBJCKEN6JKQyrHTzLWraIe43S
 9cOB9rbBsgz6ykZn8bhpKRZEc9dk7er6HU7DmHjoSiqzudOEgRdXLHvRAeyjNX9nV59V9snhY
 MG9rcGcD6tF5Rxu2FHmWgnHcYQ/f9w/OdGL5KjHdhFNIFV+eJEVfip1PcotYYDlNSlWhTABux
 pq9I4dp+x7Aof8B5hLulJ9r/37ArPo1c6vsKmyedtidv5/ngJGkNuRGk0ZEREztjkuQXnrRsH
 TWqO4+AaisyuiDQYnktSKdeauwd2l4r8b7PDEU61e03czFkmhJ25j+R38aSvc4DluU6qrzBik
 JKxQPISXxyQ5IXs8bskjv00qbtExpo1NKUw90gQNFrQSvKs33MJcMjgOiDFp5C0JVLeGbJce8
 GL1KzsxeNwnxEa4mum4YYLu5J+6b+hoajv/L2tnUGFlzbmGWlWot9i5P3a3G1U4pDNwxxIYe3
 b6UTA7XuyLZxZL9jphcQtPa1sn15YfB94z9k9zst08PngyXwpeXWYCY7NT5A2kC2gaCgCZAKk
 BOXW4hFbaZVfkLTu/I/49pDhX5RRraA/C1fyjtBsDje402Zvt/kLF2lS6+ZX50RkNEvziTpo6
 aXM1OYY0p6qwrGCLXj8BId4PgnV9HAVrtGixx/x8xYbIs5Z5Aj9JuvADphtAPPuafNmk4g0IF
 dovUODhsomSQYIYY+psvXlO8uSmd9WE8QrS0NBi4n60P4gOByPmRJ7jz6s1m0tckGaAE1up/I
 NGt2fMDBgmQM2SrSI3SYUnzrspkJIsfWVIXR+DFGVE2zwaEy3+3EMet8yEDNVcjheQajhY9m+
 l4TplUySlAGqOKqLnIVVlvvxMwp5q0vmEnyBUbGtv33SWy2qU95vgAHG/VkB/bu4gTd5jn3yK
 l+RPp1ahzQYtCl+jqHIP6eQ8B8DqK2JPpsoRpUQ+qH3DVVYMUcJpsbGvgDMHRWEu5FbEaLXgC
 +dMzEyOlpiU5KFVWYIu4rNj0jQeskxwthZeUhD+8KUGDH9kAzqluUyQ4JdwTz+yC9mD9J/Hzk
 cFJCScUhGRYzHWsoREDn+v27E2GgUI2bE7vmF/3N6PxHSls+cqARZb5SLc1557ljMjxHc5VXd
 7Wqsf/outMSsSUX9ssYDa5/ki/WlqWL2yMCl/rfLH/JK6QwY7J+PyDnXUDrCwfRuDN0/N98f0
 f2sD7mYRae0slVsnM
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:12
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

Change QEMU_FW_CFG_IO_BASE to shorter variant FW_CFG_IO_BASE and hand
over the actual port address in %r19 to SeaBIOS.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/hppa_hardware.h | 2 +-
 hw/hppa/machine.c       | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index b2fbbc2eec..bc258895c9 100644
=2D-- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -38,7 +38,7 @@
 #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
 #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)

-#define QEMU_FW_CFG_IO_BASE     0xfffa0000
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


