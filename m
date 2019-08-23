Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3108E21874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U1M3SJlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3108E21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FG6-0005bJ-Gu
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F97-0007dp-7Q
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F95-0004LY-VV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:22:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F93-0004HC-Lc; Fri, 23 Aug 2019 15:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566588166; x=1598124166;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oXXVZjLLMipUXBqkSzzjZDHjxHTciBQy9f0jCrV5G90=;
 b=U1M3SJlUyYrhrYdzFXxMYuTcmsqXaTx9p2DyUqn7DwHr+YCW+HrvLSYq
 jpROToJN15t2p4Rn5xNtXBuF43y6iRA25rQnGFZwR24zbmerfBC407LwE
 cKpbCz51+1LtlAn9UlyPya330Iu4jM2B/i3fPFKAgGnhDXqPxJRAnZNsZ
 oRdj6r6UWvobCLjXfuU6B9+SNTgclBs1qjwC7cC74uOmwIF/eTHEMELVV
 bf3RqTpNFl82K4uAP3U7otaJg3U9z4fC5x2rR6HLwXd9cZdhsDHiusZVX
 tS30oHFoKPZdQ74SniTB/m+/Bvg49ufaGD+3zsGMAw0vwzECNbWDa5nP9 w==;
IronPort-SDR: 6wZMekoa+ic/mwSicIT0FnxnuyQvWJK5M7ukNHLzllJZEC+AF+76l/BW17cC25maTNsRojPeHG
 YAnoHJs25M0YMjhcXBdg5KZFNsGMdSuK0qcPfYE1jIkIxK9mJMX+quBmLNSVqbNG7z3ejUyoLk
 sMckaGAwppxeO8Qy+gmIGtKAO4GxUH/QH2jnk2OHX5U9q7F4f8D13FlfQTOLhCDzw5dzATm2ws
 MK7kJ9fYjBwuV3troaMqEExZsWuvQNCRf1EKGQgb6QOrbNCNC0xJx2eT8VLn8+Fdu2ubxhhNVQ
 UnQ=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117476291"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:22:34 +0800
IronPort-SDR: AhTRtiV61dGhnDBV/gjhpcGdHmKQv+oGv/XT/DEqF0LwRQXbO87LOZnItHK9Mpv6syUVQE2JDE
 RW/oS4QiD/n7e63wnYbdPdIGNGIRcMo9s6yFbc+LbQHsZuGRbxTsDtKzo1g3a4jSSi+ApznuB9
 fP17cl70iuava+J+Eg+Q5Fo3SgorGVRi2tF+lbwu4NZwHkmQXdaRydEUm8KzJ9NTI0lhoWyZTk
 UBfWHpGycqJCQyVPsDFSblstHtc4YrwBzWO/PFA70NrP0rnHu/7+/2Djt3Uc4bFLfoKpSst0zp
 ZYj7S7C0wAgj780pgeqAVpHB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:19:50 -0700
IronPort-SDR: wTV4CZHMBxhakaiQ/ILgrVIVZpocjPjP8l7/EF7rlzt7RbLQQnbSrfyyMsioosFTW9ziAhJRyD
 VwI0XEphzUxXZAggOMPe0LfrOgMaZjl/r3RCgTgSaYx6a1Cx+U32xk9TIFAqZLFBDEuAbdqjXt
 kaINKOp8kQMHv3oODjEX/ue3ia4FNfxBePA1CY1DnLuTexXVLtBsntvNQ4NWFntUzfa9esuTGP
 BUESTx1IwUPSIoBKxprxOcwYoDvRse0xr0DLShe8d5mokmoKH4p+nMKlTglrZx9sPHnY7ICM+D
 SNQ=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 12:22:32 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:22:26 -0400
Message-Id: <20190823192226.21154-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823192226.21154-1-dmitry.fomichev@wdc.com>
References: <20190823192226.21154-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v4 4/4] raw: Don't open ZBDs if backend can't
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
 1 file changed, 14 insertions(+)

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
-- 
2.21.0


