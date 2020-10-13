Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF13C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90587207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90587207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEIG-00064G-2c
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBe-00058I-26; Tue, 13 Oct 2020 02:53:30 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBc-0000GE-95; Tue, 13 Oct 2020 02:53:29 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MBUuV-1kcQFp23bz-00D23w; Tue, 13 Oct 2020 08:53:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] hw/acpi/piix4: Rename piix4_pm_add_propeties() to
 piix4_pm_add_properties()
Date: Tue, 13 Oct 2020 08:53:05 +0200
Message-Id: <20201013065313.7349-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:woYJNQODjUcHNZ+1c+iKhmMERfwUSmK8EGiTqB/C2ra9ic9nLlB
 ya2MGavCg5cqg/phui5OHpFna7k3cn1sCztcg1VvmWDIS10ljhF3VdsWCbgYI6Fd5E484fo
 O+QOZ1PQmcr6r3EUzin3w4zlhwCfeL08+gnrsNa55RzEOQtLGrUPzwU4pwLE9eWXP3CIR6z
 +3bcqaYeQ9EzfImHdunpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JU+OXbc3diA=:5K/30csLo4lwZAcsUxdoV1
 A4VfmYPbhbcwWATpNcgCuIFEcH6zIdNRyl8cyS2KSS/FtRBp3zHCwXxlf/T42LosMzeMoL6y8
 gfLE/8bXYShi0h1U5BOz3tIrQe01V2tGMQqTMTX4mUkiF604eFFv/YFJnCHetoah672WA3I19
 Vji6zIcoUZu1kUNMptmFHmWh+q/Stsg1gLzf9hMDv1TtYmi74iYE4091GhkBWr+u48RSoG13a
 MlwFV+JMVrHLiphhu6TYmXea5b5rg7Vd3/naoUmVaNJcHQ+TxwnzO3aMy4Za3ndniwxFjsAif
 sIkJMcBRsAg6Chweylr07805/LXIIX7IBRBoADZ1Y9u7q5D55H0Jtm63cN1elAcnSn/o9Rw4x
 csWIBXSvUBup94E3vMCzBPchjCQJmatVkfz9cP6N8wQHujPYrj1N/ZdjxI4U/w+Y1oRIR5Vfo
 mVUloAF638fSn6WfPVFJmVKxl2+94SKwQsscyHWzSdkfch2OiNIxICfGDgrlrbq5Zx3clHi0A
 XEW1IPFR/xJ4tQNXfK2G77u1PyTc7EIvpo+RV7SbcYFxKOVsSSbR/5cYZrB5Yh3QxPuLG1ooZ
 Jwdgb225CS9+aLr1m+7AFn1A1c7AwtDy13EvrwhIqgvX4Ib6fTEKYM1303Udrb2KYoxPsrZDR
 yEHUCithNLOcTgS4a9YMsJOP8knNWDpW/Y1FxtksrJy6k3TuRhfF49Tqgxc78wQOVuVanWWN4
 LCbldu71vYXrPOmNIr5UOvTJaudT0VeFmYEZL1kucVXHSTi90IcZSxDHGFjknCxb4rA7elD0u
 WXANwkaW3Gkr1cIAAokWx/ceNotAeEi0GNUoaIXaXFTPdcrQOhqyiS0Z8yTDbrbNcd9Ty37
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Li Qiang <liq3ea@gmail.com>, Greg Kurz <groug@kaod.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <160165476743.57452.2128307974125615413.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/acpi/piix4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 894d357f8c35..67a1ea41914f 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -437,7 +437,7 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 }
 
-static void piix4_pm_add_propeties(PIIX4PMState *s)
+static void piix4_pm_add_properties(PIIX4PMState *s)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
@@ -509,7 +509,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
                                    pci_get_bus(dev), s);
     qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
 
-    piix4_pm_add_propeties(s);
+    piix4_pm_add_properties(s);
 }
 
 I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
-- 
2.26.2


