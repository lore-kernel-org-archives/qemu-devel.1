Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12442C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB1220897
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zr3xqPAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB1220897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8mE-0003lL-6Y
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc8jc-0002H0-LE
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:05:32 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc8jW-0004kS-JM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:05:32 -0500
Received: by mail-wm1-x342.google.com with SMTP id h62so8220766wme.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CILW7Q+jMcCFlKzsmwexTUwuOZBWDrgnAlppGT8xQ9Y=;
 b=Zr3xqPAA+87LrmH0N9DXpinXlr1Wo9wFOOXHbdkLdT544CCv0tFDoavDlgEtvLdOAR
 oIOUKSRBo/mVLK3d1tLWftdiMY9mb/dW82WazsZggFpiLWSrPAHgnKRoolvH3QlEYtq4
 4vR8CFC+xdFTLxSh0haehnYfb0obOHeep+qhdVoPhkv7Imw2fZ2zofHy+mPpYQkZgg84
 Qdi9P3gtiG04NE4tTdZ9OSAuxey6LaOtd3P+nXVgVEO5KDtYwNOPHyOY1HjKrFNS16oN
 2P/R1udZmoRBYMZBHnChoaUkEz9yjrLhZIc2mIOH31FSOK/l8+eJNQD1gI16KDXyuFMv
 XJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CILW7Q+jMcCFlKzsmwexTUwuOZBWDrgnAlppGT8xQ9Y=;
 b=J3lL8PMj1hlvE+qqdqfRlv/8E2cvca6jmHLv6dlhx3Nq1t8mZVpb2CBtwjwrMv+8rt
 012SfmXLSJOnDkTef9Fxis0cbcb+6DbsPqRvsJdwDC7Vnmr/LBez7SNyaXZdDbYJv8Kp
 VNcNJ74G945TKDKLcahJkuFPNFohjBe7cWUxYY05BVbq8Uwbca3u5nyVf02H4A2/Ih42
 wrY/uLF/a3nuWiBn50Ycc3lqDmyoRNTnw7llioJ9/hlavnVa4x8bGEEOzzrlh6fSPV1f
 crAmoCsZXyEecS230RoRiRMuDaYDo14N2hOPYTpVZWeYLXYsu7YYFC1Dzu0Jy+DHp6gQ
 hhqQ==
X-Gm-Message-State: AOAM533NtpgEDuVOwf8Z9ISK/9DXb1QJB+6U/CNjWs+yKYFPtHY7xAZP
 /3BjuaR+jUIBmVz1u3EgXGI57z4SQB/4oQ==
X-Google-Smtp-Source: ABdhPJzxlaoWxK1hN0P14tQR+3Xeih6tfUbAgZvYJUjsM4hb9J+5kdSB4HbO+bYjCnYfgEnRDpy+IQ==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr15788906wmb.129.1604934324094; 
 Mon, 09 Nov 2020 07:05:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n10sm3360378wrv.77.2020.11.09.07.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 07:05:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2] block/export/vhost-user-blk-server.c: Avoid potential
 integer overflow
Date: Mon,  9 Nov 2020 15:05:22 +0000
Message-Id: <20201109150522.10350-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In vu_blk_discard_write_zeroes(), we read a 32-bit sector count from
the descriptor and convert it to a 64-bit byte count. Coverity warns
that the left shift is done with 32-bit arithmetic so it might
overflow before the conversion to 64-bit happens. Add a cast to
avoid this.

Fixes: Coverity CID 1435956
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tested with 'make check' and 'make check-acceptance' only.
---
 block/export/vhost-user-blk-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index 62672d1cb95..e5749451e65 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -70,7 +70,7 @@ vu_blk_discard_write_zeroes(BlockBackend *blk, struct iovec *iov,
     }
 
     uint64_t range[2] = { le64_to_cpu(desc.sector) << 9,
-                          le32_to_cpu(desc.num_sectors) << 9 };
+                          (uint64_t)le32_to_cpu(desc.num_sectors) << 9 };
     if (type == VIRTIO_BLK_T_DISCARD) {
         if (blk_co_pdiscard(blk, range[0], range[1]) == 0) {
             return 0;
-- 
2.20.1


