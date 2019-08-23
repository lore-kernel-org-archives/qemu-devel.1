Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18833C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEFB21874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CSz5ivSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEFB21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Fal-0002Ls-GK
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ4-0000Mc-NZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ3-0000ZM-G5
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:49:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47029)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ0-0000Vz-KZ; Fri, 23 Aug 2019 15:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566589774; x=1598125774;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w9QPhGBbG9LdiAC/MDYwSdaIk/5gNeFcYnd1Y7poLK0=;
 b=CSz5ivSR6AuhtD/8B840aPrYcQCcVI03mhGJXDRnLkBNtVoL+s+Ig0AA
 tbiD6Vidb1WMVvo1Z4zgvLqzqQQp9/UO/mj7HkEDoiNMKlFlIrJnPeAf9
 DhPEjJ20AdCQIoRzhgOFwNJpISEXtbdJhFekakyr02ztBjxiwXOTX0WpP
 t7cA264g9A+Wc0J7Z4nr3JHrq6tsVEo7Av6c3L4+1mIejTGZ768/ElDvT
 PhETFXSaOuditX7Ljs41qjXtW7aLEcjGRHjwZRxYe8g5JlJaYNDIWsn0X
 +ADmOUJjzYbPrHpKWRLfDQVU71ZXTUjBjN7rMKNDdbqGlNVi2c2eua5hu w==;
IronPort-SDR: n5v0yZbQ0Jxn95Qyl0ZcM2TOgg4/XGTK3HQ1D1b3zak5lA1Fasr1XfINJN4YlPwM8EsBQ94KT+
 6ogl0utomC0v7Nxa65IUtx3FIqGymbM8NRkKfneNTjW1h7MsXOIIkI8m6tTW4UpetrBtpuXS2I
 ZkIg4wBjzLoytlnz2AsReGHv2SF+R/pgId15b71dkqfSTNOcbzCOMqDgky67U6Zzdy8GfEwyFU
 G+hFnKrVJQ0eJ1i1uWOrotsUMNOtifh9Yi1Jym3Eevbz4nljb/NH33wdzc3I3KinQIqb6jjyoZ
 Qlk=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="223162547"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:49:33 +0800
IronPort-SDR: PkDtSQT+eNoKKhmf3q5A2oU31FevVEKvDY/o9pSyMxSBa9gLVBA1Ilw9u3bvvnylK7l3cXJw7d
 7dP9AH322kpgsq0DBmLMlBBUGW7ytrf8udU8gcJARAspKld6fAPx4oKVb47dFiLD3bhtt6OSCK
 fPidKjYYACNq8Pz8oGikZvorXB2W+lf5J1fqPpYsUxb8OtzjcaRyQ6RZVXVyhF8LUo1Po8lUy2
 5jCbh8TS1jV0/Pf3W/7hiaJGPRTPeoOm72tipDPVjWG0zURn5IJ8945HknSMGiC5cNqmMawBUO
 DGc4jXpJ7K2RieBU+H55KEbN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:46:50 -0700
IronPort-SDR: 10z4T2LRZCTpDuSsedWqMM6SZmhpNfD3GXOevYbSAH2RosAi3TMmlSoInq7HqNm+3/Aw1pHtrP
 myr2n0Pk34TX0ZXuu1h8w+3b4mhmm9+inmz6vjvh5JA05464x1oUnejxmAX9fLN55fYNCCjeXE
 Z/EPU9mVDKguD6e/qnIaAty+DGUHmNzljt31AuxXuF8kryZRwKxhujaq8y1pDCeDOevherIHaE
 EJXuBdMt9sqyOFpBllkW8y5fhAfnfNl8JnXohzceUL0XLnQk1gwYpu6q3yH9ziz/Xe4VBwf/2m
 724=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 12:49:32 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:49:27 -0400
Message-Id: <20190823194927.23278-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v5 4/4] raw: Don't open ZBDs if backend can't
 handle them
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Abort opening a zoned device as a raw file in case the chosen
block backend driver lacks proper support for this type of
storage.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/file-posix.c | 14 ++++++++++++++
 hw/block/fdc.c     |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d9f2fc5e46..090e7c4d2f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2884,6 +2884,20 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
             goto fail;
         }
     }
+
+    /*
+     * If we are opening a zoned block device, check if the backend
+     * driver can properly handle such devices, abort if not.
+     */
+    if (bdrv_is_zoned(bs) &&
+        (shared & BLK_PERM_SUPPORT_ZONED) &&
+        !(perm & BLK_PERM_SUPPORT_ZONED)) {
+        error_setg(errp,
+                   "block backend driver doesn't support HM zoned devices");
+        ret = -ENOTSUP;
+        goto fail;
+    }
+
     return 0;
 
 fail:
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index c5f41b3eb6..673a8b39bc 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -570,7 +570,7 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     dev->conf.werror = BLOCKDEV_ON_ERROR_AUTO;
 
     if (!blkconf_apply_backend_options(&dev->conf, read_only, false, false,
-    				       errp)) {
+                                       errp)) {
         return;
     }
 
-- 
2.21.0


