Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B496C17498
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7F2217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7F2217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS0A2-0006cx-Ar
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 09:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS03O-0008UY-04
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS03M-0002kR-Ie
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:43:29 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:57135)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iS03D-0002f7-Vy; Tue, 05 Nov 2019 09:43:20 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqZE0-1i5upG2BIu-00mbPo; Tue, 05 Nov 2019 15:42:58 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
Date: Tue,  5 Nov 2019 15:42:45 +0100
Message-Id: <20191105144247.10301-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105144247.10301-1-laurent@vivier.eu>
References: <20191105144247.10301-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L0D96drAblJ0e5CYodG0S9iuT59onHnJ0Slrv+hqH6rKd5o+myY
 mmZ4AB9u/hybpbbZ2Ui1BvYZaGmkHHRYBjFF//4qqaI/qpxjt4w1bMwDK3anqiXodn8epC6
 j+saVzYmrd4wPfoElBBOiTRuP4dIA/vJMIvF0Mv0Go4JTNym5GyH8fnWYgtYzA1H7fd69+J
 cVRaRWixqbsaw5ieGlf5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K08tChYLLIg=:38M25GKpRoC1OrLY/QzTVf
 UueeHNpRByJqajENf/AkFYd1n5DA6UZgyq0efhC0T2q0rlbcjrvJYCFp/IWpImifpMVamJqQO
 oL0heUITSvF3XbfNrx6W8AHVcV6mdls5eFR6fnfGyuRInk5Q+vL4AkEH9eW27qgs1w6kb2qO8
 MyuHTFWPQmFGMfmM1SF29ep8RMakYptJFnybUwcp2JH9PwEJoFuOfxFRbcBo607K3fRqsNltJ
 +f3SgwUN94AqAoBmoF5ZfJlOvZONGdRcc2sUjW16Dg5ewtKXqNYYEhxy4CUVvlygnv/jmVCwu
 l5ynhoADTlMtQiLyD6Yt3t5RXnvC5ZLHdZXLQrbSJFklUmwoloe2K+oauhYWwnEn051Fed/l4
 g1ezK1/d6FGpiPvcTaoPKSvO268khCULfcMQ11maybdp7kfn2cxy2WezOAE6XzlIgtWqacSwR
 736/bwyNvNiJMOB4+L+T3PXT8BksGAWQHAT1X9+x1hWwDphfCuddY7Y/U1TyzHw6GjVsBAVL+
 hTQqCX4BuHidsJU5sfjs304RpJACYm5LWTQuUNEZTH72L4wcgLSe733/o9N5tG0aSY6hny6xW
 tTyk2Nxz3ubxIX0l6vrd9JUhAqnpW63QaotnJmb0D/FlDOPGa24akh3GsKUzzrsJqzObHFsoM
 2uMBbsrAErbO1vaQniD2xUv9QzqhuvU2UOYhjvnefSS3GvwVazVLeZ+R2eMHxiWYK+cpE5zAe
 87tuOBo1ejLYN3PRS9ZS9PTfF6v6Gmz0a9V9thYO4wWFvhW7BSUSwGWKC2eZiWvEj9vL5X4Sx
 zgON+iu1SdKsNHF/IBgjW3DSHLwL6qK65CsZBdIq0//NLe89vvlDH3D69k9SmTZB4f3bvpvB1
 oyrCOw7D2x1G4Km4z4PTVzH56hxX5qVzEsv2S8qBY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jiri Gaisler <jiri@gaisler.se>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Plug & Play region of the AHB/APB bridge can be accessed
by various word size, however the implementation is clearly
restricted to 32-bit:

  static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsigned size)
  {
      APBPnp *apb_pnp = GRLIB_APB_PNP(opaque);

      return apb_pnp->regs[offset >> 2];
  }

Set the MemoryRegionOps::impl min/max fields to 32-bit, so
memory.c::access_with_adjusted_size() can adjust when the
access is not 32-bit.

This is required to run RTEMS on leon3, the grlib scanning
functions do byte accesses.

Reported-by: Jiri Gaisler <jiri@gaisler.se>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20191025110114.27091-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/grlib_ahb_apb_pnp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index f3c015d2c35f..e230e2536361 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -242,6 +242,10 @@ static const MemoryRegionOps grlib_apb_pnp_ops = {
     .read       = grlib_apb_pnp_read,
     .write      = grlib_apb_pnp_write,
     .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 static void grlib_apb_pnp_realize(DeviceState *dev, Error **errp)
-- 
2.21.0


