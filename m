Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5EAC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600C82073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aSqsNywJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600C82073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkwzE-0001zX-CJ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 16:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60480)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwt8-0005tm-LL
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwt5-00014S-BH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwsw-0000jE-QN; Tue, 09 Jul 2019 16:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562704737; x=1594240737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4bRnmZTuElmpehaFuMCmU2Mkur6fL6pum6lfWyF8J5Q=;
 b=aSqsNywJvon9Hp/F0CImXxQWALrWFzI0kL52PR7BiORrxHWtFiCrRieY
 5D7kCAg5Lja7stMt3GQ0/q+KEs57pFNmTMrQtiAWMTTBd2LNihgn08ELh
 P9okANY8Lfj7EoJWx6aabyHdB2NujZbhDaJ9sWAoaHjB6OhqA2HtG3pTM
 UyUFDHehJoRpgF767x84B8SQqAtNdxISLWOWFKgh/LQvoYoB/1i5yllfa
 8By/6h0JCRAXb7YJGsNla7gh3Q7famTgiBCwo2x6ttgcdBeWvZop4TiN9
 +NyHABcKrQxHQ2Al5yEhrteQazeeP4sHzOlaFmIzHdK2EJngGWZ5F8zXF Q==;
IronPort-SDR: s4Gm3O/cjX0OFRNaozLwK1LqHNAg9VE4y7q8GutQjqMpilMsVJ7N8yzGWvr8vqqatosLOjxb07
 AWWt17jhbDRLU6mMlK7nGmxYsTZ6B9QEdSoP1hgs0vA3FMJ26JuV0+sccWEMtlAEJVqdKSW0s+
 Zcrq1FY+QWqM5q14jO1GN2oly2LMTyp2DrBOeoVKApZP2GKISBlshwM1g8ufJIXGH7CX8OWqcx
 3z5aO2Zp9W+9Zsq+0I8hwmP7f3Oe8Cjp1me1mkTgDHPvAzkP5oRoCNhpIWJF7SiOlya2pYJUUG
 bds=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; d="scan'208";a="212488455"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 04:38:57 +0800
IronPort-SDR: YnjMF3amshJBXEm7cdBbDV8BK40nA14C4ZWpIbby4ErTrB1spYm861siMDElG/3yf4An06xhBy
 eqv9+vKFB9xgey6836ILelnvQb6Xa4cmCo1FKWki5oXkmLo/yNdfKXRend/PrquwUrFVtYCUGf
 io0rkdziP5LYW73yBgGIUYihOOlMJPfDN3quau3+tlo0DCjNlEgS3rjuHytlImX5UZ0+e4RPGC
 +RAi23i0XCTrw7h+B/L0vH9q8Fs/pzB0Aqf9o+gqyR7v6geVjXuPh4uzx4kB+PbBRJs7fNxZH/
 pwM822F6aN+bPxLGlnZCD5vF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 13:37:33 -0700
IronPort-SDR: LMEA0a0Q09Wv3PN7GtMAPOAKDzRUwdngM/IgoSNM9Rxii8d4dNumYVkxdW72JNti7G/xP0/s0a
 ZI9z2/JO1ioMXRkLR3XlrTJqtlzDzs8LjkDuY1wgyZyRRjzJ0L27iMQgBUFIwNppaDpczBGqhA
 EaWp5RJGcrtYzVCY4YNJPTFLP0ZlqlQGhgIXmP98aIsrcwxQAWk/4mfDjzKlSkGc4TNrDAmdm5
 3J3uKOd7U4HFAr9kgXRCBZbwbMNLHaqUPoN4bfVcXy278rZHJIH1LKXaNpYXupE/AUOIen2cNe
 WH0=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 13:38:46 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: kwolf@redhat.com, mreitz@redhat.com, mst@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 16:38:06 -0400
Message-Id: <20190709203806.17550-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH 4/4] hw/scsi: Don't realize zoned block devices
 for virtio-scsi legacy drivers
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
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Prevent scsi-hd and scsi-disk drivers from attaching a zoned block device
because it will appear as a regular block device at the guest and will
most certainly cause problems.

The functionality to support ZBDs is not planned for scsi-hd and
scsi-disk legacy drivers. It is supported via scsi-generic driver already
and discussion is ongoing for scsi-block driver.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 hw/scsi/scsi-disk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ed7295bfd7..80682a61fb 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2401,6 +2401,11 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
      * backend will be issued in scsi_realize
      */
     if (s->qdev.conf.blk) {
+        if (blk_is_zoned(s->qdev.conf.blk)) {
+            error_setg(errp, "zoned block devices are not supported");
+            return;
+        }
+
         ctx = blk_get_aio_context(s->qdev.conf.blk);
         aio_context_acquire(ctx);
         blkconf_blocksizes(&s->qdev.conf);
-- 
2.21.0


