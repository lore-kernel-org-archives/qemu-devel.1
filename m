Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38E7C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB65A2070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB65A2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqUP-0005Pf-Rl
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:23:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFf-0000fj-JG
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFe-00044t-Ks
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFX-0003s4-Al; Thu, 06 Jun 2019 07:08:03 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1Mjjvp-1gpIoP3RQB-00lIOV; Thu, 06 Jun 2019 13:06:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:19 +0200
Message-Id: <20190606110625.32127-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aAa1raASz8JOmSHlj+lCdaiafK8ieKWUPyy/UkUZ38PqO9+KY5j
	rycJ0oIdjZws5HBSsWNdb41aH1emLIY8VwJIOPyX0fx8uGumkPozjf5X2RcmUEJoIQIjzRP
	G/E4kNIwblA3p5Aki9SPJDiU/YiMBcHPigbIK8kcbAft51Zc2UqzB+SeoS8FV2pM1UFTR40
	8O73Da6kZRsn9RxZAYLKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TaGw/BMz8Ds=:+RxgS5R5CEPEwcHSeBiEa9
	6BPo33XP9pjQQDFUbXt5rUEFQ9qDhLHbSEj1s9e8h+ELqtsOuMgawgprMxGMFasq5bHCDhsrA
	rEGFmcOc4AcilUwmi9Il4f6Fhi0GkbwUkJxhTrO0AHiCkTC2k1LQv6YR3XsxFUBEUvernwNDM
	7Kp5EGnUfUL1jJdLkur8cs1450ZBX6IMw3tlhgN7MB8waCcczeca8QrK2wHmnNvVINAW4C9VF
	076o/oaWLs8OmHM2Ba3re/hyW1FNPnrQCmPkptAEkUc85M9rWNsZ30lBe4rbckpy3iqh6rNpS
	RQfbvd6ipvUbm3+68smisfzvAr2dbmsUanIvCHL+jnbfLNeKYdlT4OXVMucj3bOMGapK8qfLt
	8SAbmK8h54US12l96MBh1ODXxnbS6KpIXdAb9IkO1P3rXJeV6tCKuZofYh/Qpe6Ak47bjt8Jf
	BG9qOPwhIyZKqbiZHYOh1axIK32ket6NzhSth8K15UDjjwTQhw+CKeIqEAv714AfbcdJAaQl6
	9w54CcvGxgtkxjNhAUGDC6bmaiScLH+4MgKqIN13gIVfMUGdec86e8NhAyU/JDDd8IweA+MTW
	fj7nktBu9b91KA9Fo5MSZhL9lmtgcE+SBx4P73trB72Y308XOw3GczzjSDkWstiLcOI2v7u2y
	9FWCw2gbZ1nUOcM9cdK4jh4ps/mRe18ZFymKmWvTVC9gO5Fs8lm9O9NY3hQfXNPZelfFU/1U6
	Gedg7yXzCJiLGP2gjEfwPNBJnrI2qLuxUgxd0855y252S8K3lP5hzZCM2t4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 10/16] hw/isa: Use the QOM DEVICE() macro to
 access DeviceState.qdev
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Rather than looking inside the definition of a DeviceState with
"s->qdev", use the QOM prefered style: "DEVICE(s)".

This patch was generated using the following Coccinelle script:

    // Use DEVICE() macros to access DeviceState.qdev
    @use_device_macro_to_access_qdev@
    expression obj;
    identifier dev;
    @@
    -&obj->dev.qdev
    +DEVICE(obj)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190528164020.32250-8-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/isa/lpc_ich9.c | 2 +-
 hw/isa/vt82c686.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 031ee9cd933d..35d17246e940 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -412,7 +412,7 @@ void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled)
                                  true);
     }
 
-    ich9_lpc_reset(&lpc->d.qdev);
+    ich9_lpc_reset(DEVICE(lpc));
 }
 
 /* APM */
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 85d0532dd5b5..d46754f61cfb 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -369,7 +369,7 @@ static void vt82c686b_pm_realize(PCIDevice *dev, Error **errp)
     pci_conf[0x90] = s->smb_io_base | 1;
     pci_conf[0x91] = s->smb_io_base >> 8;
     pci_conf[0xd2] = 0x90;
-    pm_smbus_init(&s->dev.qdev, &s->smb, false);
+    pm_smbus_init(DEVICE(s), &s->smb, false);
     memory_region_add_subregion(get_system_io(), s->smb_io_base, &s->smb.io);
 
     apm_init(dev, &s->apm, NULL, s);
-- 
2.21.0


