Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B9C43140
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E6021A49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c54lLrnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E6021A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6jNr-0005V1-OE
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 18:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM7-00040B-3P
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM6-0005dk-4Y
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36657)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM3-0005cW-CK; Sat, 07 Sep 2019 18:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567895931; x=1599431931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LI1nlGxApBLJrhe1y3qiBnJa248FPNVAYbXtDolUxMs=;
 b=c54lLrnUdiTPLI/22EndfndqK3ZpllloyGl1av9uGDBsUyF23E1/ZCCu
 w8TnCDNp3PosW51LOjJmnD2IMzeJsntx4qT3CGJwfSKLJF62hPPgm+rr7
 8v0P6wqS17nZlZQ0U2G4YBcsMVYFL1e6PPZ7JAHgHNJy3Sb9FAJ9aJ2H6
 CfCRn+3omZTytMSKmfX68+CNlG9dVNbrxPxwjp+f//mpN0TWqF5gY1pSo
 CDlt+ttFJm4hFYOf9OE0qgc30o9zjAONrkFdlZhjZ6EIeLyHw2acPYx66
 H9Wq+4CdDj30sP5mWu1vgd1JI05wRdZC5j+rDBnXvKlkVqX88Xpvl691/ A==;
IronPort-SDR: +WqYKLyu6jtKkhAVzIDA0mWdVOz4cmA0XdDvCxssyFmcZ+uAn2oDgIaRjJrcVGtc8tvZlIKLZr
 pyASl9ty3thvUR+q6e0FNXb/bHsx9jaGQVLLz6LMrmk8wp1Okos6RJ0pehJmpgcxbofGEoJz3t
 49u0cD4jJjqAuxvEbotHjWwTwjPIgugxQlaQxQfgRX3bAGaGsdXMJS+zgH3XCmOmqXwn/uXlJk
 i1ydsurevJAV8W/6WWh7XjcBWTLzzlpTRRZU/3/fhJLSMQQgRCTXPf4E1LguZDzBjnlhgmJtVz
 Ft8=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; d="scan'208";a="224505950"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 06:38:47 +0800
IronPort-SDR: P3KVC+NxNvbQpAaGrTGMO8GQdI2WT5iFm6QMN7g+4pKwAGE2Zss5syA2x5C5n40ccNh4ibC2M9
 CnZt8uFcFgbBaop0aE4NYICXezzRJq3paKdIhOQ5vix5xktMjSQKhcEB8ffHyZkdKxT7aMQZJp
 o4/PO63WSSRJ8HyaYT7mstkXlBquY/0Vy3zN75nY3VN4O2+0h243TWa6NgYe7W37X13O19fppe
 qzB66Dt2hM6IwLm6WJcs9jAzA627HwSIbyczGJil6XGVkaHyUayAbGy17XnnCLwd+PXi13ZqIF
 aZFy517FxI17iqS6QNVjqP6i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2019 15:35:37 -0700
IronPort-SDR: /70fQU78ZlVFr7dW7IgmwycdifH+b3HJBsM8+UriisMTG5hR3cguucvCMVUdnknIUw+MZXCBKf
 UkNx8Gh9OmUaiAdsYGvEGpXLmKXa7HuNd5noTQ46btKA/0uRzWtaegPrh2ZcMjh31/TE+p/08n
 nLZn+FCvHhXoC2huiMdTFWVMVjNnMX+Ue/aEQj5R02ejRdEdnWCUlSxqEFBTJC9h2ZHoL0TOYR
 QMM0s86b7gWTPtc2hGEkyUtQKoTIWpFE5IY3saOch999WHiqe5V0fcXU9RBIXVhvstz52xplG/
 hI4=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Sep 2019 15:38:47 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Sat,  7 Sep 2019 18:38:41 -0400
Message-Id: <20190907223841.20210-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
References: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v7 4/4] raw: Don't open ZBDs if backend can't
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index caacb21f07..3de371a97d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2934,6 +2934,20 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
             goto fail;
         }
     }
+
+    /*
+     * If we are opening a zoned block device, check if the backend
+     * driver can properly handle host-managed devices, abort if not.
+     */
+    if (bdrv_is_hm_zoned(bs) &&
+        !(shared & BLK_PERM_SUPPORT_HM_ZONED) &&
+        !(perm & BLK_PERM_SUPPORT_HM_ZONED)) {
+        error_setg(errp,
+                   "block backend driver doesn't support host-managed zoned devices");
+        ret = -ENOTSUP;
+        goto fail;
+    }
+
     return 0;
 
 fail:
-- 
2.21.0


