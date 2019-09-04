Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05707C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC01720870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E0v+WZae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC01720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dQ6-0007Uy-GF
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 18:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOy-0006Jd-9q
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOt-0007bT-5D
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:12 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOq-0007X8-53; Wed, 04 Sep 2019 17:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567630868; x=1599166868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A8Oo7chqCEMQBqZaiGtNcZHXd4mPVEMe1m5nZgs3PcQ=;
 b=E0v+WZaelCQKWj2GAXX2OqbMttbPr4POm2mJomisUNRLTRGMmgtYYJZY
 LflIyjbJbC4Sx+EkondFDPl33aSb4cfufpQJd33ls533I3aJJGmQX7LCF
 I6gR+24m/VbtD/QH+WMmVaiRcVCHi07kuwdxwu8wIRBGeZqcr4L1L3AZe
 qDS7qYLRZeMGE9ptpyIaJHXp+G2ApPIlzPOZsfUQIWPFSIlnSPgndvjKe
 8rwydo5Afh3/m5SZBWAX5k9sDcThRAQclwSXF5rAO9/SQPwqKIqnegwSf
 /GeCl5jp+r0IYML/68itaLCRhJCXdoDVhP9lHYDHlGIL66SS6FiLhz9ic Q==;
IronPort-SDR: 12WXz9Ag/oyNeBk/cbQdhTYglVtUo7jRjzi9GoBfcVGsrq2MXrQPah5nRj4K/cfibB3zslpBQo
 6rLCm9Moke9LoQwKgbEUQicXZhLP+mjhBvjX6CoUkUpJvHONNKU9P52ffw3VHsujjp1RcfUnGN
 6bDiWt77GWQ0hj9xEVlKdeLC3f1JhBRn3VZ8U7Syh7Tr87TGBQ8tLsZ/sxW1pD0ixTzwfYEw2l
 G2GtEDK0ps+6FeWE18cBn4iXncBUi5Kd35jdxmD4GBOx6S6b1/XAMplggqPDkcQuV/a1KZGOA3
 Cs8=
X-IronPort-AV: E=Sophos;i="5.64,468,1559491200"; d="scan'208";a="117451673"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2019 05:01:07 +0800
IronPort-SDR: 6URNMeOSQ3nPyA05qj5VQz7giRjmW0eOa2jLxnV0PtNFUo6jbeBhSH3RZDasqBDsqMThCMPR9E
 x0E8dZAjLx9xDbnP/VM0MheK1DQSulaRtjuEZ8i2UIoheoyKKf4z9Cx0hEgnqJY0IVF8ijt6Lm
 8K1ROz+kisu1gupMaYBstLGzZ0+vLZa3g0Ht4wV2nxED+DtqSoJjs+bkmdb0C3QPXww2m8YrDm
 RvLKOc9lXkF6PNb1SVgqyTIdpyrxtvcAf27a4sRg5dfIxcSJGYE2HiSFBlrS72vAiGsxL4A7Nt
 qtdqJTAlu8r409zmMVCvQWRu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 13:58:03 -0700
IronPort-SDR: YjXuHS28J1ClgwTz6GpdEqvd1NEGMjCblC4lTUE35ZOhOhGP60l52BV+dxautL2JGQeI0H3WVl
 9IEe320Yvr+hK0iGdUodDVPuKT06uAKKQKms6m8EB++ZiD22yR9uYLWzejYUoXKF7d+keNmEu1
 HvBw6afXzhPsvVsEyE3PRW8X29WB+rdjiARPIM1F9Yyh8PiSlUKKAefLgRaZIg7XptHFK+i1e/
 +TddVTHOtOa94NC7a/y8OhpEAwga6AtbKYpAY0uGMvHVM4RbP82V+aiL+8qd6we1bfNslIE0Dq
 MR0=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2019 14:01:05 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Wed,  4 Sep 2019 17:01:00 -0400
Message-Id: <20190904210100.10501-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v6 4/4] raw: Don't open ZBDs if backend can't
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
index c7e1aff6eb..f11d589f90 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2883,6 +2883,20 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
             goto fail;
         }
     }
+
+    /*
+     * If we are opening a zoned block device, check if the backend
+     * driver can properly handle host-managed devices, abort if not.
+     */
+    if (bdrv_is_hm_zoned(bs) &&
+        (shared & BLK_PERM_SUPPORT_HM_ZONED) &&
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


