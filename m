Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D588C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25A020878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25A020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIxV-0001dj-Ka
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpj-00078R-31; Tue, 13 Oct 2020 07:51:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIph-0004y9-5D; Tue, 13 Oct 2020 07:51:10 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUobv-1ksWwh3Wb3-00Qlh0; Tue, 13 Oct 2020 13:51:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/14] hw/acpi/piix4: Rename piix4_pm_add_propeties() to
 piix4_pm_add_properties()
Date: Tue, 13 Oct 2020 13:50:44 +0200
Message-Id: <20201013115052.133355-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U1JLs65+gAgexy6v+LBl9wE/g4Q0G1GxkcvGhlvQoGIIrOFstxm
 uBVsjCIP9WK9tAPHO3Vh4r04XJFvrtjmxtGa81l7rmmuE5dByDNg0gNCmmRpa0zWoBwfOtQ
 r3yFEjAfJeWKaOTxxI9/biFyyyq6PBdNqapD6kLhqFX5Wy8a0vAGwBJIQEO+BEOyjsWZX+9
 ZTjLCXD66Q3l4Y8RyjQBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FVU741uBOW4=:fZAXdr1SQRvGWqR9AVSsSD
 HiQvyQKJDf2UCDhKFSbddVSERW8w347b5k8OyojY85+vPJkKyfp2S9fTDks/1eLQesKtn0RUF
 BoJKkIHhs9cF1/EINnKnNlorBPi66RF9s9/tGBnHIBqj2+KEjLCVnFJBKSkC9SpXJJK8lGqTi
 f6SUMO5Mfo1ZYceG/K9bCrbBUXq5s7hCdB04IZp9bVtmFUq9Sd/ZtuH9JxIvQtA/L+vZkC1D5
 BJYXyhKIoyYgee9M8guZQYJf0t59GcLf+UtOeIWgqIQN9LHZi7hUvO+lZzSPP4J/5W5wNqR2f
 wCL8XIPc8N7mVYnSmVQKDUqytTrokgxfV5U7RKsaE5DCqPLa+QonYfck6xuXV1r7tqwlXoJPP
 DPbkQ8+TnKQSkqNevFAvYjPJ4RfMdLH6q7yNcziyBKDEfCtjmdJF2FQo4MkqJOkmV2IQ16brk
 Q9T3UaZXme0mSiEKXvgAAinzbLJsvVtvlKxsA3ctHmjRt3yq5AWhV7pWRSY/njF6TCnifeNyf
 zaC3nr+AWmx+vBBhV5TaLMcwA++wlrc1wOgg/WIdsg/k546So7ZfGQlnXAl0oq1Xl3julAFx6
 s6j2IkP6c8bN2a9VXcmjdIVW2ZZhf+Yru2xG5GEu7478LpoWizJpvrX6+RrIyrbGaK8MQTJob
 MWcVFQQy3PcdJSTEaocLrQXuqk3LHJPRsDlBA/0DeM2iuLN6htjkRy+UM7ZZ6F2gpgrFNrGzb
 jR5omvr+R3y6OH4EnZRUCMFP90E2cD4wFsXyP67fkObtmfqeWLSORcvlSK8pJrvWTZ48lqQ87
 ktalE/9OCfnmNHfPoIkyJbjU2fhYWyutNUWGCcaS4A/Im7dmdTGEqzgeDOl6zH1ShQeL7nj
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:32:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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


