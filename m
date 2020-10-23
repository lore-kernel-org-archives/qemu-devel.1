Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72610C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6DF2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FhO+lppl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6DF2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzZo-0004oU-DE
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyv-0004KG-K8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyr-0001YB-Gz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466869; x=1635002869;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gRLFW5UCKjh4yvdZBvLQXqEJVfV48oDYZ79tpYj1D7Q=;
 b=FhO+lpplcE/M+Jwl4Q+KrkHHZD9KhuzErCkLUgnevwJvOeBBlRc3Kmqi
 K3XQenCVYXblj9XT5vIOqFMddLecl1/RRT2ihkLgCr33KEFuv5XkSu6w7
 fmzno+yqojdgcXbZmQ5rqwycLIxk7tPdLAaLwuymHk1kvY8l+Tupay/o+
 OK7r7NUILG3eMaH1+/YukaxukJPdl/knr/VufDp9t/Y4q3eDa7n/KZyrN
 vePf7wb8p0wTThKRuI1CjE4mmbg6bAVr5/jsK9rzAc2I2DG1X1Ac1lCse
 GpxkkZnvVLrwHqkZaz9Dxi4j3SXE6Khx9FyGZyvaabQxbFm5rkY5UHXYT g==;
IronPort-SDR: KIv2oBvMkcOjDj2kH+PrWgul7DRxgH2y0LJcVUM79E5JV/MhaZ7bzk9mRwb9GRTw63S8Lq/s3c
 5bEptVR3UiqwutKqtnm30fRDxH7IuuCQgWwIvsmcRi5s5ByIdKoo3XUpt/6UPNrvQNbs8/IpYr
 n2g0Tj7so9i3WrAiGzBdQT+oLC51w6eCVXxdMuJq99TyylTpbp9yOlBe4C8Z6AZsl0FaH/VaEK
 +H2sfT93ntOAd6arh9vIa+Zr+VFDXlIppOLLDojoAzsbZkyZfIDj+rEavfhgkJR8iXqmzoBJ2i
 FY4=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652321"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:43 +0800
IronPort-SDR: W0bfe6gLH7Rsyl0H6TZRxS5JRuyZZpVrtCQ2hXkWd+7toBw3WCiCAZ7x38nn2QI1T+HL/LPMeS
 hB1gKvYY3SjuAU9k576TTE0+QQUH7T1UtiUxtZ44JR3NsXvP9PfNJrlsZhjIHOC7y0BlDB+CFy
 n7jGDy1z0m1BPeqPX9a+I4iVABkNmpH6vQrOxh60nSZzLL4h2Wbgj/5Df+7bXxaIUV9xLOZeSq
 eSyDc3AFCBVT+T1UOs8coLoHE03hD/MT+bL8LyNzT0jV2Pv1lzmSW5q+LQzJAqMaiaCfCFzc+a
 mWkbyjIB+WbcmQ2ncmuzuDHL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:59 -0700
IronPort-SDR: Uym5J0JqYHMp8vu3fkrO9a5wU3qkxZl21fCIgJydQoF6PXJjpDt5pi81nSjnA6xV+wHudDYFmZ
 1MeemGmgolWaCgcm0h0+Uzpqs3f9mJOiPVDQ+VurPe3hv3knSodKFw6jNv9glla0H+h7S8o2Zr
 okxqadq3ZF+f3Yg1fcYsutOzfd29nPawcHzgfzI0qJnZT6xvcdTrlEmVyLGolZpY0J6i+ffXvS
 3aooc7hklsgMCxo+Ob+ZO96FnontMUpXR9Hs1ygp/5GeLM8ek8ZYo7Q/VPFtnnsX3mplm0lQQ6
 CSk=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 05/12] target/riscv: Fix implementation of HLVX.WU instruction
Date: Fri, 23 Oct 2020 08:16:12 -0700
Message-Id: <20201023151619.3175155-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Georg Kotheimer <georg.kotheimer@kernkonzept.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Georg Kotheimer <georg.kotheimer@kernkonzept.com>

The HLVX.WU instruction is supposed to read a machine word,
but prior to this change it read a byte instead.

Fixes: 8c5362acb57 ("target/riscv: Allow generating hlv/hlvx/hsv instructions")
Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201013172223.443645-1-georg.kotheimer@kernkonzept.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index e987bd262f..4ce73575a7 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -333,12 +333,12 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
         riscv_cpu_set_two_stage_lookup(env, true);
 
         switch (memop) {
-        case MO_TEUL:
-            pte = cpu_ldub_data_ra(env, address, GETPC());
-            break;
         case MO_TEUW:
             pte = cpu_lduw_data_ra(env, address, GETPC());
             break;
+        case MO_TEUL:
+            pte = cpu_ldl_data_ra(env, address, GETPC());
+            break;
         default:
             g_assert_not_reached();
         }
-- 
2.28.0


