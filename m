Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B231C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 17:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D8B21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 17:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D8B21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS30D-0004TW-L6
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 12:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS2ya-0002LX-VY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 12:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS2yZ-0004X6-UG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 12:50:44 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:34039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iS2yZ-0004Wm-Li; Tue, 05 Nov 2019 12:50:43 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M42Ss-1iS2yG0Su0-0007FQ; Tue, 05 Nov 2019 18:50:24 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 2/3] hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
Date: Tue,  5 Nov 2019 18:50:09 +0100
Message-Id: <20191105175010.2591-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105175010.2591-1-laurent@vivier.eu>
References: <20191105175010.2591-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lZFxrSfyzft189ztgtj2zhDPSI/v8wne3TXsIYykJJGOhUsiUZI
 WUL5cdIywdu0OUa3r4YX6cB3Tht5LIMC0ClU0II1uDHDHXG37ReL8vF62QOrl1xOxWDZxAa
 yCqIAJHzVW28Cq2J7jJQs6dd+fOzaDuzfjzVCqTQsbJVnvlh+AledLIOc1Vel5LH8FUBnnh
 o47BZat4luIwytgGxrHcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:av6w0M/wZvM=:rDhXnAD9A6cpkNh2e0TgfK
 J5zOnZTmo/W2/DrEV1TxsmjMZKnl4JwjBQ2mVcpEMorM95RpraeHljKk6t3tDPN9htva00ZS+
 n0IKmM/g54Fxgbudpy2rNfAWupAwq8AOCr38O1wobl8Bp/lRRRUuj1DZn0hrORfW1BiiE1gRu
 GthE7ZJHo2MLLrMrhXBnGO7DPuPRa+1vEbtQk9FBU6jVR3g1Bmt3QddQzGLkiUOsMnAKkXybK
 iv9ZHOq6yKrXbOPUdJNLZqKmNu5QB8SvFBiRLk53kKWXg5DL8P3PSyFE44kUyIDBbCa2s3Ohc
 f94YctBbcL9YU5QBlW6Nwu4fdldc8HR0zwl23GHM8taAuVWhUUst0bAcbky1izqYVhnwHJn1R
 eQrdjr9KZX5ac4OXFu1KZrTwkQpp0tfr/HI2TkwfmnngyN4UksepaIhwp2Yjb0O7A88PqEUco
 4gDwDOA4U9bZNwEmwCgRAEhma1/YgZjpzKq8KwOH2+r85K5x7yNvLw9sSqzWLFA22rjhvchsv
 kDgAfgPtmB73k4lCOcLXEJpK0Wqgr/5KGZTohZmKSsuInPT/SYbnutSzOYKmnGtZQL5DBYf3a
 Ffz0lRXXmB1JvCyKrdlixwyOy5ZMKgh26Ca8J9olDZLuqEXYVP665ZS3UZpQ7giQkdwruVD1z
 VjZqrV5/+n8dISFBbupy5B/MNVImCkyCk1EuopkA7tj/QGjFM02nT+QEu1hmyrSQMJYIcyC1h
 v6AOWFzBqbucg6B8a7O4b488V2tPkikK+6Xj0FxRIchrNIh1TO3HeYrR72TWCmYvoiJsE3oVw
 MSVb44EyLNzkUgBzQ0nagEe+iBk+aTQLdvfM0Glo9oYSOyWcn6XykZEbWXbsOFtHKhG2fXxdO
 yV0/pVe89F9Tov60kVhYGU5ic5vtb/L80oLvPPMJo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 qemu-trivial@nongnu.org, Claudio Fontana <claudio.fontana@huawei.com>,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jiri Gaisler <jiri@gaisler.se>, David Gibson <david@gibson.dropbear.id.au>
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


