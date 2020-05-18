Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B6220657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTVCTCrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B6220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai1K-0006qk-E8
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jahzG-0005ZS-R2
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:47:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jahzE-0006qS-Qm
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:47:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id l18so12451598wrn.6
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sKzcEV9wkONoPB+ynBHsD63nfFrJQCqRKP35Nd+BbUw=;
 b=fTVCTCrx39WctUCz08VjkUeRTC3jDjw44YtMVBcFGoX4myyEpAtWISyAL8Us+55BTs
 yuY/vbTziibqdeZDoXCTaCr/UgccEnaiJsDMD2m6zzz4ik2/FiCuUiRonLyq1otYFpK3
 rER81wtnNoAoZEg9NzERh5ZRYiZZZLq7pgIl+6LwN5sFiB0n/BuYiElRSX+ggEdhIZH5
 5MW2gTSguHKwvvFzriVtP4JSxT8fM6Kt8W/HeSDKRUfWlyfpW3ZpQRi6HuVBDTOjOrSw
 rlxCqp6H3Hjo1t7QHxjgC8j5RUCLp5FgB7tArkOoqacNvgtfY+jaGId30GSZsmCaR2x6
 wT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sKzcEV9wkONoPB+ynBHsD63nfFrJQCqRKP35Nd+BbUw=;
 b=D/+xB2Ef3kTwIr9cLd8kXaNTRicow4hxC6B5UiOf4yRSOIUQtbKwjHJhbA8YVgyZdv
 hdBNki+qmO6fb9ePS+d4b33GoPAEBdkwupF+KqaEXpuyoVYCTm85m7JSwe2cW7oXiHJC
 2KriUxMCJQFLIRvhZ5S5gUmKU271kRozbQY5Gr17vIZ5irmZ6up+PHVDJbNaeHW/3Z8Y
 Y+PVn+LMUGK1Vq6zK8KvC7YFwbHoL94NbpxMo9rGrzL9EULGDjzUhoJj0PiJVlU4V//U
 08g4SQlWrhtC5xcMcn4fbC8aHE7+hZumjZtbbB8TgiAkOu+HvsbuVM1JBMfayaK6hC5p
 nsqg==
X-Gm-Message-State: AOAM532sG3Tr5bDRJ9grMIU1QfF6Cgig/BNBRxRxUPTn9WsFzQvD/kju
 X+6zwCo8wvV/BCMrcE9XQrbnQg==
X-Google-Smtp-Source: ABdhPJw5fF57H9a+SEwbr8rTbdcUt7VzLCxCieqBF0nAfyjDimQaqm/xIEXaisEdEDSZAl767Dq6EA==
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr20247390wrq.218.1589816847071; 
 Mon, 18 May 2020 08:47:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i6sm19242882wmb.41.2020.05.18.08.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:47:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH RISU] arm.risu, thumb.risu: Add v8.2 DP and FHM insns
Date: Mon, 18 May 2020 16:47:19 +0100
Message-Id: <20200518154719.18562-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add coverage for the v8.2 DP and v8.2 FHM insns in the Neon extension
space.  (We already had the v8.1 VQRDMLAH/VQRDLSH and the v8.3
VCADD/VCMLA, so this brings the risu coverage into line with what
QEMU has implemented so far.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I added these patterns as part of testing for the first part
of the Neon decodetree conversion and forgot I'd never sent out the
risu patch for review.

 arm.risu   | 18 ++++++++++++++++++
 thumb.risu | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arm.risu b/arm.risu
index c16d245..f8b6deb 100644
--- a/arm.risu
+++ b/arm.risu
@@ -861,6 +861,24 @@ VQRDMLAH_s  A1 1111001 q:1 1 d:1 size:2 vn:4 vd:4 1110 n:1 1 m:1 0 vm:4
 VQRDMLSH    A1 111100110 d:1 size:2 vn:4 vd:4 1100 n:1 q:1 m:1 1 vm:4
 VQRDMLSH_s  A1 1111001 q:1 1 d:1 size:2 vn:4 vd:4 1111 n:1 1 m:1 0 vm:4
 
+#
+# ARMv8.2 extensions
+#
+@v8_2_dp
+
+VUDOT       A1 1111110 00 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 1 vm:4
+VSDOT       A1 1111110 00 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 0 vm:4
+
+VUDOT_s     A1 11111110 0 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 1 vm:4
+VSDOT_s     A1 11111110 0 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 0 vm:4
+
+@v8_2_fhm
+
+VFMAL       A1 1111110 00 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMSL       A1 1111110 01 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMAL_s     A1 11111110 0 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMSL_s     A1 11111110 1 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+
 #
 # ARMv8.3 extensions
 #
diff --git a/thumb.risu b/thumb.risu
index b8afa59..357b791 100644
--- a/thumb.risu
+++ b/thumb.risu
@@ -449,6 +449,24 @@ VQRDMLAH_s  T1  111 q:1 11111 d:1 size:2 vn:4 vd:4 1110 n:1 1 m:1 0 vm:4
 VQRDMLSH    T1  111111110 d:1 size:2 vn:4 vd:4 1100 n:1 q:1 m:1 1 vm:4
 VQRDMLSH_s  T1  111 q:1 11111 d:1 size:2 vn:4 vd:4 1111 n:1 1 m:1 0 vm:4
 
+#
+# ARMv8.2 extensions
+#
+@v8_2_dp
+
+VUDOT       A1 1111110 00 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 1 vm:4
+VSDOT       A1 1111110 00 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 0 vm:4
+
+VUDOT_s     A1 11111110 0 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 1 vm:4
+VSDOT_s     A1 11111110 0 d:1 10 vn:4 vd:4 1101 n:1 q:1 m:1 0 vm:4
+
+@v8_2_fhm
+
+VFMAL       A1 1111110 00 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMSL       A1 1111110 01 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMAL_s     A1 11111110 0 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+VFMSL_s     A1 11111110 1 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
+
 #
 # ARMv8.3 extensions
 #
-- 
2.20.1


