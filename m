Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F4CC73C56
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BAE2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XOBA23sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BAE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkwvQ-0007RB-9I
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 16:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwsz-0005pO-TL
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwsw-0000vk-SV
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwsu-0000jE-80; Tue, 09 Jul 2019 16:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562704733; x=1594240733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WmkBOZQXw8TYDamyy1qpM/47me1gOgpWai3PcMTicTc=;
 b=XOBA23sVskaWOwy41Ag0uMf4PqJoaPO89neBSdrsNFPpCTrq/3rFZf6Z
 SgUg/xtf11Q2IDaCH9Yz+NKh8t0TBnzO55JlpSkWX6HX87U+FoW9zz12q
 AleeUKW7VAn1olLXWHy4eZNSi2ZJqQkdsWSLQBZHlPIU+ahgz/DCfcZjW
 gHKCRWdoFzEt18al2BHq7cxqHX/XT3u1+4nR9Fh5l69PMTVgVqjiBNgi1
 LaJz02d16VMEhulT6Jwk8p2JeO2tsG1bq1flJnAZBaVdZVWdAMVab8PQk
 6yMv751R+RcdYf8CJAnuf8/M99SsFWdMwiJ7AX+/Z+7Rqx+EijTvmPmGO g==;
IronPort-SDR: F+EwWzUJEar03fkdi64Fye2foTOUyIVux+5TBEzMcs5UfSRl+NB6tBdBJDWJutPtlDkbbl792s
 yBfyIEBTDebWNrUuBG4ERioRHApNR+dYLmg61qwQV2TZm4wqtrGip9ZUSMppVW0pj1oN4LcTGL
 4J2SjZ9Mt36WEQ/i84IjAsV178wEW/9ycLTAHvLLcoKHTTg1+PBNhtKuFguo+uihDas+Ok7JLO
 TqaOTFE0wMj/yHYffffMxf9Lfuh6MTZaLarJfkQsF2Zb8tKZNNyYa5J2EhsxUO+3OxHlMCyxAZ
 vUE=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; d="scan'208";a="212488454"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 04:38:53 +0800
IronPort-SDR: SH9a08Re68N42/kyJ7TF0h6Z5HT+aNwkR6a6B+OGrnqufwdVSYrfDBumMarc8jv3BZutXFySrI
 dgspAq7eXuMFD9Fwpxy7OrboMwlZjW8CzcVvdIc81jiDowSyrpd1dJWbxDT9bjTr4lvt6Uujiq
 uLUBagMuZlUjbMdPRwKhUJKHNVqB7TnZxQ4I65KNWpteQlrVxHOAFE+AN8uIpJWVV/nJotwGpw
 WZC8TR4j6n6RYuWk0LuFdbhOUv+wDgcwkRZ7nqI2k8v20yJZQHJv2P2tVbwlARyn3YsqpDtKTQ
 0NAeQqQYwI9wzscb4WC0V24I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 13:37:31 -0700
IronPort-SDR: VYaDgpXPS3hKGY7rbJDMZ8M1eYIoLDZBFOz7e08/v9DrfOqYZLv2+h498vft5lQBl4tENaTIER
 XLv1OTdeR6079GrVOVKzNBaU0X3Wwht2COpZwtYcZILs6w8FlIUBBjcGgOdzeIOE4zDgcclDgb
 tqC8UHVMvUqce4AGUOEvFX7UyNK2owouiZSv9UkxsJtXdL65xT0kEHbPbSRPezDuTDNv057iAJ
 8yHGHUmVD9YK0UWNSLgxEX1EA0PUgzbaQEVe13iDKp8tzU1+/fBPieElaiohCyqZz8/LS6qhOC
 1z8=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 13:38:44 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: kwolf@redhat.com, mreitz@redhat.com, mst@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 16:38:05 -0400
Message-Id: <20190709203806.17550-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH 3/4] virtio-blk: Don't realize zoned block
 devices
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prevent virtio-blk code from attaching a zoned block device because
it will otherwise appear as a reqular block device at the guest and
that will most certainly cause problems.

The functionality to support ZBDs via virtio-blk should be pretty
useful and there are some attempts underway to get it implemented,
but such work will inevitably lead to some modifications in virtio
protocol spec. Therefore, this activity is considered a more
long-term effort.

So for now, we just don't allow zoned block devices to work via
virtio-blk.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/virtio-blk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index cbb3729158..c11e028308 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1140,6 +1140,11 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (blk_is_zoned(conf->conf.blk)) {
+        error_setg(errp, "zoned block devices are not supported");
+        return;
+    }
+
     if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_DISCARD) &&
         (!conf->max_discard_sectors ||
          conf->max_discard_sectors > BDRV_REQUEST_MAX_SECTORS)) {
-- 
2.21.0


