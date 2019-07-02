Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A83C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DE920989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DE920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNM4-0008VC-Lp
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50536)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLlX-0003On-BW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLlO-0000ae-0W
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59856 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hiLlL-0007qD-Qe
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:13 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id E71811A222E;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 8346E1A2161;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:35:23 +0200
Message-Id: <1562085328-5126-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 07/12] tcg/tests: target/mips: Amend MSA integer
 multiply tests
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Amend MSA fixed point multiply tests: correct output values for
MADDV.B, MADDV.H, MADDV.W, MADDV.D, MSUBV.B, MSUBV.H, MSUBV.W and
MSUBD.D.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1562068213-11307-3-git-send-email-aleksandar.markovic@rt-rk.com>
---
 .../user/ase/msa/int-multiply/test_msa_maddv_b.c   | 224 ++++++++++-----------
 .../user/ase/msa/int-multiply/test_msa_maddv_d.c   | 214 ++++++++++----------
 .../user/ase/msa/int-multiply/test_msa_maddv_h.c   | 224 ++++++++++-----------
 .../user/ase/msa/int-multiply/test_msa_maddv_w.c   | 224 ++++++++++-----------
 .../user/ase/msa/int-multiply/test_msa_msubv_b.c   | 224 ++++++++++-----------
 .../user/ase/msa/int-multiply/test_msa_msubv_d.c   | 224 ++++++++++-----------
 .../user/ase/msa/int-multiply/test_msa_msubv_h.c   | 224 ++++++++++-----------
 .../user/ase/msa/int-multiply/test_msa_msubv_w.c   | 224 ++++++++++-----------
 8 files changed, 891 insertions(+), 891 deletions(-)

diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c
index 5678677..d543e1a 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c
@@ -43,118 +43,118 @@ int32_t main(void)
 
     uint64_t b128_result[TEST_COUNT_TOTAL][2];
     uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
-        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
-        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
-        { 0x000000006666666cULL, 0x000000006666666cULL, },
-        { 0x0000000000000006ULL, 0x0000000000000006ULL, },
-        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
-        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
-        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
-        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
-        { 0x000000020000000cULL, 0x000000020000000cULL, },
-        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
-        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
-        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
-        { 0x000000020000000eULL, 0x000000020000000eULL, },
-        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
-        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
-        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
-        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
-        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
-        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
-        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
-        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
-        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
-        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
-        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
-        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
-        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
-        { 0x000000013333334aULL, 0x000000013333334aULL, },
-        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
-        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
-        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
-        { 0x000000006666667eULL, 0x000000006666667eULL, },
-        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
-        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
-        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
-        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
-        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
-        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
-        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
-        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
-        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
-        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
-        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
-        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
-        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
-        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
-        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
-        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
-        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
-        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
-        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
-        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
-        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
-        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
-        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
-        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
-        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
-        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
-        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
-        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
-        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
-        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
-        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
-        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
-        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
-        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
-        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
-        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
-        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
-        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
-        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
-        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
-        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
-        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
-        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
-        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
-        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
-        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
-        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
-        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
-        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
-        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
-        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
-        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
-        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
-        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
-        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
-        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
-        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
-        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
-        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
-        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
-        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
-        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   0  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x5757575757575757ULL, 0x5757575757575757ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x3636363636363636ULL, 0x3636363636363636ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x2075cb2075cb2075ULL, 0xcb2075cb2075cb20ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },    /*   8  */
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x5a5a5a5a5a5a5a5aULL, 0x5a5a5a5a5a5a5a5aULL, },    /*  16  */
+        { 0x5a5a5a5a5a5a5a5aULL, 0x5a5a5a5a5a5a5a5aULL, },
+        { 0x3e3e3e3e3e3e3e3eULL, 0x3e3e3e3e3e3e3e3eULL, },
+        { 0xb0b0b0b0b0b0b0b0ULL, 0xb0b0b0b0b0b0b0b0ULL, },
+        { 0x2828282828282828ULL, 0x2828282828282828ULL, },
+        { 0x0606060606060606ULL, 0x0606060606060606ULL, },
+        { 0xc45236c45236c452ULL, 0x36c45236c45236c4ULL, },
+        { 0x5c5c5c5c5c5c5c5cULL, 0x5c5c5c5c5c5c5c5cULL, },
+        { 0x0707070707070707ULL, 0x0707070707070707ULL, },    /*  24  */
+        { 0x0707070707070707ULL, 0x0707070707070707ULL, },
+        { 0x7979797979797979ULL, 0x7979797979797979ULL, },
+        { 0xb2b2b2b2b2b2b2b2ULL, 0xb2b2b2b2b2b2b2b2ULL, },
+        { 0x6e6e6e6e6e6e6e6eULL, 0x6e6e6e6e6e6e6e6eULL, },
+        { 0x5d5d5d5d5d5d5d5dULL, 0x5d5d5d5d5d5d5d5dULL, },
+        { 0xbc83f5bc83f5bc83ULL, 0xf5bc83f5bc83f5bcULL, },
+        { 0x0808080808080808ULL, 0x0808080808080808ULL, },
+        { 0x3c3c3c3c3c3c3c3cULL, 0x3c3c3c3c3c3c3c3cULL, },    /*  32  */
+        { 0x3c3c3c3c3c3c3c3cULL, 0x3c3c3c3c3c3c3c3cULL, },
+        { 0xb4b4b4b4b4b4b4b4ULL, 0xb4b4b4b4b4b4b4b4ULL, },
+        { 0x7070707070707070ULL, 0x7070707070707070ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xa4a4a4a4a4a4a4a4ULL, 0xa4a4a4a4a4a4a4a4ULL, },
+        { 0x88cc4488cc4488ccULL, 0x4488cc4488cc4488ULL, },
+        { 0xd8d8d8d8d8d8d8d8ULL, 0xd8d8d8d8d8d8d8d8ULL, },
+        { 0xa5a5a5a5a5a5a5a5ULL, 0xa5a5a5a5a5a5a5a5ULL, },    /*  40  */
+        { 0xa5a5a5a5a5a5a5a5ULL, 0xa5a5a5a5a5a5a5a5ULL, },
+        { 0x8383838383838383ULL, 0x8383838383838383ULL, },
+        { 0x7272727272727272ULL, 0x7272727272727272ULL, },
+        { 0x1616161616161616ULL, 0x1616161616161616ULL, },
+        { 0x3f3f3f3f3f3f3f3fULL, 0x3f3f3f3f3f3f3f3fULL, },
+        { 0x7889677889677889ULL, 0x6778896778896778ULL, },
+        { 0x0c0c0c0c0c0c0c0cULL, 0x0c0c0c0c0c0c0c0cULL, },
+        { 0x297ed4297ed4297eULL, 0xd4297ed4297ed429ULL, },    /*  48  */
+        { 0x297ed4297ed4297eULL, 0xd4297ed4297ed429ULL, },
+        { 0xe7ca04e7ca04e7caULL, 0x04e7ca04e7ca04e7ULL, },
+        { 0x46f09c46f09c46f0ULL, 0x9c46f09c46f09c46ULL, },
+        { 0x2a183c2a183c2a18ULL, 0x3c2a183c2a183c2aULL, },
+        { 0x6362646362646362ULL, 0x6463626463626463ULL, },
+        { 0xac26a4ac26a4ac26ULL, 0xa4ac26a4ac26a4acULL, },
+        { 0x80d42c80d42c80d4ULL, 0x2c80d42c80d42c80ULL, },
+        { 0x6463656463656463ULL, 0x6564636564636564ULL, },    /*  56  */
+        { 0x6463656463656463ULL, 0x6564636564636564ULL, },
+        { 0xfc6d8bfc6d8bfc6dULL, 0x8bfc6d8bfc6d8bfcULL, },
+        { 0x48f29e48f29e48f2ULL, 0x9e48f29e48f29e48ULL, },
+        { 0x98fe3298fe3298feULL, 0x3298fe3298fe3298ULL, },
+        { 0x2c81d72c81d72c81ULL, 0xd72c81d72c81d72cULL, },
+        { 0x002f5f002f5f002fULL, 0x5f002f5f002f5f00ULL, },
+        { 0x1010101010101010ULL, 0x1010101010101010ULL, },
+        { 0x50f4b4a050944910ULL, 0x09818994142910a0ULL, },    /*  64  */
+        { 0xa8a0b48458da5c10ULL, 0x4fe29220ea6e7070ULL, },
+        { 0x08e408fc40188310ULL, 0xbcca14c29417e060ULL, },
+        { 0x889acc58f0da8d90ULL, 0x0bc1ec1242cd40e0ULL, },
+        { 0xe046cc3cf820a090ULL, 0x5122f59e1812a0b0ULL, },
+        { 0xf94acc85218951d0ULL, 0x95738e42d193e4c0ULL, },
+        { 0x9d16cc43c6665ed0ULL, 0x53db3028d828be70ULL, },
+        { 0x6db8cc0a0c890c40ULL, 0x3d628818b56622f0ULL, },
+        { 0xcdfc2082f4c73340ULL, 0xaa4a0aba5f0f92e0ULL, },    /*  72  */
+        { 0x71c8204099a44040ULL, 0x68b2aca066a46c90ULL, },
+        { 0x016c64244a05b940ULL, 0x59f2d0a19fddc520ULL, },
+        { 0x4132584638a46f40ULL, 0xd44a00c982f36fa0ULL, },
+        { 0xc1e81ca2e86679c0ULL, 0x2341d81930a9cf20ULL, },
+        { 0x918a1c692e892730ULL, 0x0dc830090de733a0ULL, },
+        { 0xd150108b1c28dd30ULL, 0x88206031f0fddd20ULL, },
+        { 0xd1b1f4b4a08961f4ULL, 0x3101a07181016120ULL, },
+        { 0xd9fb2c24a0fb96f4ULL, 0x8c6880ef7f7c11a0ULL, },    /*  80  */
+        { 0x9c452c10c01c3094ULL, 0x64c00035ea008320ULL, },
+        { 0x6c8714b080c04094ULL, 0xa0c00000380072a0ULL, },
+        { 0xac30cca08080c0acULL, 0xc0800000300016a0ULL, },
+        { 0x0c101420808080acULL, 0x00000000d0003620ULL, },
+        { 0xd0f014800000000cULL, 0x00000000e00082a0ULL, },
+        { 0x9050ac800000000cULL, 0x0000000080004c20ULL, },
+        { 0x90007400000000b4ULL, 0x0000000000006420ULL, },
+        { 0x1000ac00000000b4ULL, 0x00000000000024a0ULL, },    /*  88  */
+        { 0xc000ac0000000054ULL, 0x000000000000ac20ULL, },
+        { 0xc000940000000054ULL, 0x00000000000088a0ULL, },
+        { 0xc0004c00000000ecULL, 0x00000000000098a0ULL, },
+        { 0xc0009400000000ecULL, 0x0000000000001820ULL, },
+        { 0x000094000000004cULL, 0x000000000000c8a0ULL, },
+        { 0x00002c000000004cULL, 0x000000000000b020ULL, },
+        { 0x0000f40000000074ULL, 0x0000000000001020ULL, },
+        { 0x00002c0000000074ULL, 0x00000000000010a0ULL, },    /*  96  */
+        { 0x0000b40000000074ULL, 0x0000000000001020ULL, },
+        { 0x00006c0000000074ULL, 0x00000000000010a0ULL, },
+        { 0x0000740000000074ULL, 0x0000000000001020ULL, },
+        { 0x0000740000000014ULL, 0x00000000000030a0ULL, },
+        { 0x00007400000000b4ULL, 0x0000000000009020ULL, },
+        { 0x0000740000000054ULL, 0x000000000000b0a0ULL, },
+        { 0x00007400000000f4ULL, 0x0000000000001020ULL, },
+        { 0x00004c00000000f4ULL, 0x00000000000060a0ULL, },    /* 104  */
+        { 0x0000f400000000f4ULL, 0x0000000000004020ULL, },
+        { 0x0000cc00000000f4ULL, 0x00000000000080a0ULL, },
+        { 0x00007400000000f4ULL, 0x0000000000000020ULL, },
+        { 0x00006c000000004cULL, 0x0000000000000020ULL, },
+        { 0x0000b40000000074ULL, 0x0000000000000020ULL, },
+        { 0x00002c00000000ccULL, 0x0000000000000020ULL, },
+        { 0x0000f400000000f4ULL, 0x0000000000000020ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
index 965703c..fda35f7 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
@@ -43,118 +43,118 @@ int32_t main(void)
 
     uint64_t b128_result[TEST_COUNT_TOTAL][2];
     uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   0  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x5555555555555557ULL, 0x5555555555555557ULL, },
         { 0x0000000000000002ULL, 0x0000000000000002ULL, },
-        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
+        { 0x3333333333333336ULL, 0x3333333333333336ULL, },
+        { 0x0000000000000003ULL, 0x0000000000000003ULL, },
+        { 0x1c71c71c71c71c75ULL, 0xc71c71c71c71c720ULL, },
         { 0x0000000000000004ULL, 0x0000000000000004ULL, },
-        { 0x000000006666666cULL, 0x000000006666666cULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },    /*   8  */
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x555555555555555aULL, 0x555555555555555aULL, },    /*  16  */
+        { 0x555555555555555aULL, 0x555555555555555aULL, },
+        { 0x8e38e38e38e38e3eULL, 0x8e38e38e38e38e3eULL, },
+        { 0xaaaaaaaaaaaaaab0ULL, 0xaaaaaaaaaaaaaab0ULL, },
+        { 0x2222222222222228ULL, 0x2222222222222228ULL, },
         { 0x0000000000000006ULL, 0x0000000000000006ULL, },
-        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x12f684bda12f6852ULL, 0x2f684bda12f684c4ULL, },
+        { 0x555555555555555cULL, 0x555555555555555cULL, },
+        { 0x0000000000000007ULL, 0x0000000000000007ULL, },    /*  24  */
+        { 0x0000000000000007ULL, 0x0000000000000007ULL, },
+        { 0x1c71c71c71c71c79ULL, 0x1c71c71c71c71c79ULL, },
+        { 0xaaaaaaaaaaaaaab2ULL, 0xaaaaaaaaaaaaaab2ULL, },
+        { 0x666666666666666eULL, 0x666666666666666eULL, },
+        { 0x555555555555555dULL, 0x555555555555555dULL, },
+        { 0x5ed097b425ed0983ULL, 0xed097b425ed097bcULL, },
         { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
-        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
-        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
-        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
-        { 0x000000020000000cULL, 0x000000020000000cULL, },
-        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
-        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
-        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
-        { 0x000000020000000eULL, 0x000000020000000eULL, },
-        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
-        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
-        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
-        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
-        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
+        { 0x333333333333333cULL, 0x333333333333333cULL, },    /*  32  */
+        { 0x333333333333333cULL, 0x333333333333333cULL, },
+        { 0xaaaaaaaaaaaaaab4ULL, 0xaaaaaaaaaaaaaab4ULL, },
+        { 0x6666666666666670ULL, 0x6666666666666670ULL, },
+        { 0x5c28f5c28f5c2900ULL, 0x5c28f5c28f5c2900ULL, },
+        { 0x99999999999999a4ULL, 0x99999999999999a4ULL, },
+        { 0x16c16c16c16c16ccULL, 0xd27d27d27d27d288ULL, },
+        { 0xccccccccccccccd8ULL, 0xccccccccccccccd8ULL, },
+        { 0x99999999999999a5ULL, 0x99999999999999a5ULL, },    /*  40  */
+        { 0x99999999999999a5ULL, 0x99999999999999a5ULL, },
+        { 0x7777777777777783ULL, 0x7777777777777783ULL, },
+        { 0x6666666666666672ULL, 0x6666666666666672ULL, },
+        { 0xa3d70a3d70a3d716ULL, 0xa3d70a3d70a3d716ULL, },
+        { 0x333333333333333fULL, 0x333333333333333fULL, },
+        { 0xd27d27d27d27d289ULL, 0xc16c16c16c16c178ULL, },
+        { 0x000000000000000cULL, 0x000000000000000cULL, },
+        { 0x1c71c71c71c71c7eULL, 0xc71c71c71c71c729ULL, },    /*  48  */
+        { 0x1c71c71c71c71c7eULL, 0xc71c71c71c71c729ULL, },
+        { 0x2f684bda12f684caULL, 0xf684bda12f684be7ULL, },
+        { 0x38e38e38e38e38f0ULL, 0x8e38e38e38e38e46ULL, },
+        { 0xb60b60b60b60b618ULL, 0xc71c71c71c71c72aULL, },
+        { 0x5555555555555562ULL, 0x5555555555555563ULL, },
+        { 0x06522c3f35ba7826ULL, 0xa781948b0fcd6eacULL, },
+        { 0x71c71c71c71c71d4ULL, 0x1c71c71c71c71c80ULL, },
+        { 0x5555555555555563ULL, 0x5555555555555564ULL, },    /*  56  */
+        { 0x5555555555555563ULL, 0x5555555555555564ULL, },
+        { 0x97b425ed097b426dULL, 0x7b425ed097b425fcULL, },
+        { 0x38e38e38e38e38f2ULL, 0x8e38e38e38e38e48ULL, },
+        { 0xeeeeeeeeeeeeeefeULL, 0x8888888888888898ULL, },
+        { 0x1c71c71c71c71c81ULL, 0xc71c71c71c71c72cULL, },
+        { 0x87e6b74f0329162fULL, 0x3c0ca4587e6b7500ULL, },
         { 0x0000000000000010ULL, 0x0000000000000010ULL, },
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
-        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
-        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
-        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
-        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
-        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
-        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
-        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
-        { 0x000000013333334aULL, 0x000000013333334aULL, },
-        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
-        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
-        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
-        { 0x000000006666667eULL, 0x000000006666667eULL, },
-        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
-        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
-        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
-        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
-        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
-        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
-        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
-        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
-        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
-        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
-        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
-        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
-        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
-        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
-        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
-        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
-        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
-        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
-        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
-        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
-        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
-        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
-        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
-        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
-        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
-        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
-        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
-        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
-        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
-        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
-        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
-        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
-        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
-        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
-        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
-        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
-        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
-        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
-        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
-        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
-        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
-        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
-        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
-        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
-        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
-        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
-        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
-        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
-        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
-        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
-        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
-        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
-        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
-        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
-        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
-        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
-        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
-        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
-        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
-        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
-        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
-        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+        { 0xad45be6961639010ULL, 0x3297fdea749880a0ULL, },    /*  64  */
+        { 0x9ced640a487afa10ULL, 0xeaa90809e3b1a470ULL, },
+        { 0xa5b377aa0caf5a10ULL, 0x95c9a7903bd12160ULL, },
+        { 0xa194ffe4fb27d390ULL, 0x17e6ccd3c9a1c0e0ULL, },
+        { 0x913ca585e23f3d90ULL, 0xcff7d6f338bae4b0ULL, },
+        { 0xc8ead0bee02cadd0ULL, 0x381c4d6a83a94cc0ULL, },
+        { 0x33b60e279e9989d0ULL, 0xe7f71f9b97ee3470ULL, },
+        { 0x217580abbfdd3e40ULL, 0x6779436687bc89f0ULL, },
+        { 0x2a3b944b84119e40ULL, 0x1299e2ecdfdc06e0ULL, },    /*  72  */
+        { 0x9506d1b4427e7a40ULL, 0xc274b51df420ee90ULL, },
+        { 0x1b2bb7962782ba40ULL, 0x9bf62dc42637b820ULL, },
+        { 0x91d16316b1663b40ULL, 0x3cf7c824fb128ca0ULL, },
+        { 0x8db2eb519fdeb4c0ULL, 0xbf14ed6888e32c20ULL, },
+        { 0x7b725dd5c1226930ULL, 0x3e97113378b181a0ULL, },
+        { 0xf21809564b05ea30ULL, 0xdf98ab944d8c5620ULL, },
+        { 0x3dcc402bfcefb9f4ULL, 0xf26a7a4530ab3a20ULL, },
+        { 0x81a8956a21043af4ULL, 0xe63ec4a9de07f3a0ULL, },    /*  80  */
+        { 0x14acc7eab115be94ULL, 0xa72fae300e450520ULL, },
+        { 0x4c5c3900181b6494ULL, 0xc26796e561c70ba0ULL, },
+        { 0x513451003792b1acULL, 0x5acad191d5b18fa0ULL, },
+        { 0x0daff27cb51538acULL, 0x31375ce2aea24b20ULL, },
+        { 0xbb9ebee52390b20cULL, 0xd8cfb350af547ea0ULL, },
+        { 0x4df25269204a3c0cULL, 0x07b9241bbd1b8320ULL, },
+        { 0x39b3c4d066371fb4ULL, 0x2a4dc00c264fb720ULL, },
+        { 0xf9aee458846dd0b4ULL, 0x79d838b37c524ca0ULL, },    /*  88  */
+        { 0x115f9e7f00744254ULL, 0x46ec87fe3540fa20ULL, },
+        { 0xb01458f6b0850854ULL, 0xde82246a25db24a0ULL, },
+        { 0xc18097bf5a7bb9ecULL, 0x4155f0da566748a0ULL, },
+        { 0x70c7391b1a7d90ecULL, 0x0400deec0a0cb020ULL, },
+        { 0xf7a41980bd958c4cULL, 0xedfeb14ff6d44fa0ULL, },
+        { 0x7906f19718fcf64cULL, 0x29e471752ecca820ULL, },
+        { 0xb6393967140b1974ULL, 0xbd0ed4c39361fc20ULL, },
+        { 0x74ecb57da4acfa74ULL, 0x36ea3f3dbcafcda0ULL, },    /*  96  */
+        { 0x5b14aa5e3f7c1b74ULL, 0xeb031f17fe2b7120ULL, },
+        { 0x0468573ef6087c74ULL, 0xe8ef35d2e05abea0ULL, },
+        { 0xd69cf5cf0de21d74ULL, 0x39f569701e89ae20ULL, },
+        { 0xf233f7a10f743514ULL, 0xf574fc00c1b755a0ULL, },
+        { 0x873c421a5ed469b4ULL, 0x96f393305dfcdf20ULL, },
+        { 0x17e80b0449fea354ULL, 0x2f05ddb06b40c2a0ULL, },
+        { 0x0741f67f982609f4ULL, 0x9c23f2dbc2b79820ULL, },
+        { 0x530275e3b2de7ff4ULL, 0xc6904e7f6f6c1aa0ULL, },    /* 104  */
+        { 0xf8214644bbe3f5f4ULL, 0xe44a0de01c974f20ULL, },
+        { 0xb59c90c0a8b66bf4ULL, 0x9abcf7a8e1391da0ULL, },
+        { 0xb67d543caed5e1f4ULL, 0x4ce8f72994d78e20ULL, },
+        { 0xcee67f5e9d2e224cULL, 0xba31bdf2ab48a220ULL, },
+        { 0x87acb43db40fad74ULL, 0x8a259794c40e3620ULL, },
+        { 0x45c27495332aeeccULL, 0xe81c4208ecf84a20ULL, },
+        { 0x50a99b794e1bc8f4ULL, 0x17cdf4c275d6de20ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c
index ad20f01..a9ee9b3 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c
@@ -43,118 +43,118 @@ int32_t main(void)
 
     uint64_t b128_result[TEST_COUNT_TOTAL][2];
     uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
-        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
-        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
-        { 0x000000006666666cULL, 0x000000006666666cULL, },
-        { 0x0000000000000006ULL, 0x0000000000000006ULL, },
-        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
-        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
-        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
-        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
-        { 0x000000020000000cULL, 0x000000020000000cULL, },
-        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
-        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
-        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
-        { 0x000000020000000eULL, 0x000000020000000eULL, },
-        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
-        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
-        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
-        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
-        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
-        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
-        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
-        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
-        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
-        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
-        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
-        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
-        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
-        { 0x000000013333334aULL, 0x000000013333334aULL, },
-        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
-        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
-        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
-        { 0x000000006666667eULL, 0x000000006666667eULL, },
-        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
-        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
-        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
-        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
-        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
-        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
-        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
-        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
-        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
-        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
-        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
-        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
-        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
-        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
-        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
-        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
-        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
-        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
-        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
-        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
-        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
-        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
-        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
-        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
-        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
-        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
-        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
-        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
-        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
-        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
-        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
-        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
-        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
-        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
-        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
-        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
-        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
-        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
-        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
-        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
-        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
-        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
-        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
-        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
-        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
-        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
-        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
-        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
-        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
-        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
-        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
-        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
-        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
-        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
-        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
-        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
-        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
-        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
-        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
-        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
-        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
-        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   0  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x5557555755575557ULL, 0x5557555755575557ULL, },
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },
+        { 0x3336333633363336ULL, 0x3336333633363336ULL, },
+        { 0x0003000300030003ULL, 0x0003000300030003ULL, },
+        { 0x1c75c72071cb1c75ULL, 0xc72071cb1c75c720ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },    /*   8  */
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x555a555a555a555aULL, 0x555a555a555a555aULL, },    /*  16  */
+        { 0x555a555a555a555aULL, 0x555a555a555a555aULL, },
+        { 0x8e3e8e3e8e3e8e3eULL, 0x8e3e8e3e8e3e8e3eULL, },
+        { 0xaab0aab0aab0aab0ULL, 0xaab0aab0aab0aab0ULL, },
+        { 0x2228222822282228ULL, 0x2228222822282228ULL, },
+        { 0x0006000600060006ULL, 0x0006000600060006ULL, },
+        { 0x685284c4a1366852ULL, 0x84c4a136685284c4ULL, },
+        { 0x555c555c555c555cULL, 0x555c555c555c555cULL, },
+        { 0x0007000700070007ULL, 0x0007000700070007ULL, },    /*  24  */
+        { 0x0007000700070007ULL, 0x0007000700070007ULL, },
+        { 0x1c791c791c791c79ULL, 0x1c791c791c791c79ULL, },
+        { 0xaab2aab2aab2aab2ULL, 0xaab2aab2aab2aab2ULL, },
+        { 0x666e666e666e666eULL, 0x666e666e666e666eULL, },
+        { 0x555d555d555d555dULL, 0x555d555d555d555dULL, },
+        { 0x098397bc25f50983ULL, 0x97bc25f5098397bcULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x333c333c333c333cULL, 0x333c333c333c333cULL, },    /*  32  */
+        { 0x333c333c333c333cULL, 0x333c333c333c333cULL, },
+        { 0xaab4aab4aab4aab4ULL, 0xaab4aab4aab4aab4ULL, },
+        { 0x6670667066706670ULL, 0x6670667066706670ULL, },
+        { 0x2900290029002900ULL, 0x2900290029002900ULL, },
+        { 0x99a499a499a499a4ULL, 0x99a499a499a499a4ULL, },
+        { 0x16ccd2888e4416ccULL, 0xd2888e4416ccd288ULL, },
+        { 0xccd8ccd8ccd8ccd8ULL, 0xccd8ccd8ccd8ccd8ULL, },
+        { 0x99a599a599a599a5ULL, 0x99a599a599a599a5ULL, },    /*  40  */
+        { 0x99a599a599a599a5ULL, 0x99a599a599a599a5ULL, },
+        { 0x7783778377837783ULL, 0x7783778377837783ULL, },
+        { 0x6672667266726672ULL, 0x6672667266726672ULL, },
+        { 0xd716d716d716d716ULL, 0xd716d716d716d716ULL, },
+        { 0x333f333f333f333fULL, 0x333f333f333f333fULL, },
+        { 0xd289c178b067d289ULL, 0xc178b067d289c178ULL, },
+        { 0x000c000c000c000cULL, 0x000c000c000c000cULL, },
+        { 0x1c7ec72971d41c7eULL, 0xc72971d41c7ec729ULL, },    /*  48  */
+        { 0x1c7ec72971d41c7eULL, 0xc72971d41c7ec729ULL, },
+        { 0x84ca4be7130484caULL, 0x4be7130484ca4be7ULL, },
+        { 0x38f08e46e39c38f0ULL, 0x8e46e39c38f08e46ULL, },
+        { 0xb618c72ad83cb618ULL, 0xc72ad83cb618c72aULL, },
+        { 0x5562556355645562ULL, 0x5563556455625563ULL, },
+        { 0x78266eac81a47826ULL, 0x6eac81a478266eacULL, },
+        { 0x71d41c80c72c71d4ULL, 0x1c80c72c71d41c80ULL, },
+        { 0x5563556455655563ULL, 0x5564556555635564ULL, },    /*  56  */
+        { 0x5563556455655563ULL, 0x5564556555635564ULL, },
+        { 0x426d25fc098b426dULL, 0x25fc098b426d25fcULL, },
+        { 0x38f28e48e39e38f2ULL, 0x8e48e39e38f28e48ULL, },
+        { 0xeefe88982232eefeULL, 0x88982232eefe8898ULL, },
+        { 0x1c81c72c71d71c81ULL, 0xc72c71d71c81c72cULL, },
+        { 0x162f7500b75f162fULL, 0x7500b75f162f7500ULL, },
+        { 0x0010001000100010ULL, 0x0010001000100010ULL, },
+        { 0xcbf432a0c5949010ULL, 0x838136944f2980a0ULL, },    /*  64  */
+        { 0xf8a073846fdafa10ULL, 0x81e20820066ea470ULL, },
+        { 0x25e45efce9185a10ULL, 0xd1ca0ec2ee172160ULL, },
+        { 0x9e9a52589fdad390ULL, 0x88c19612bccdc0e0ULL, },
+        { 0xcb46933c4a203d90ULL, 0x8722679e7412e4b0ULL, },
+        { 0xec4ab9850c89add0ULL, 0x31736642d9934cc0ULL, },
+        { 0x15164543016689d0ULL, 0xd2dbe12880283470ULL, },
+        { 0xe4b8e50ad4893e40ULL, 0xb8628f18916689f0ULL, },
+        { 0x11fcd0824dc79e40ULL, 0x084a95ba790f06e0ULL, },    /*  72  */
+        { 0x3ac85c4042a47a40ULL, 0xa9b210a01fa4ee90ULL, },
+        { 0x4a6ce5241805ba40ULL, 0x2ff282a198ddb820ULL, },
+        { 0xda320a46aaa43b40ULL, 0xaa4ae1c91cf38ca0ULL, },
+        { 0x52e8fda26166b4c0ULL, 0x61416919eba92c20ULL, },
+        { 0x228a9d6934896930ULL, 0x46c81709fce781a0ULL, },
+        { 0xb250c28bc728ea30ULL, 0xc120763180fd5620ULL, },
+        { 0xeab115b4cc89b9f4ULL, 0x1e01ac71b6013a20ULL, },
+        { 0x1ffb192480fb3af4ULL, 0x7b68d8ef267cf3a0ULL, },    /*  80  */
+        { 0xf545d210101cbe94ULL, 0xdcc07635cb000520ULL, },
+        { 0x8b8730b052c06494ULL, 0x5ec03300e4000ba0ULL, },
+        { 0xaa30f5a0a980b1acULL, 0x51803b00ac008fa0ULL, },
+        { 0xa21071208c8038acULL, 0x9c00e50050004b20ULL, },
+        { 0x99f03080ba00b20cULL, 0x2000270000007ea0ULL, },
+        { 0xf850658020003c0cULL, 0x2000000000008320ULL, },
+        { 0x9900ed0040001fb4ULL, 0x400000000000b720ULL, },
+        { 0xf300c900c000d0b4ULL, 0x0000000000004ca0ULL, },    /*  88  */
+        { 0x4d00840000004254ULL, 0x000000000000fa20ULL, },
+        { 0x5f002c0000000854ULL, 0x00000000000024a0ULL, },
+        { 0xb00068000000b9ecULL, 0x00000000000048a0ULL, },
+        { 0x90004800000090ecULL, 0x000000000000b020ULL, },
+        { 0x7000200000008c4cULL, 0x0000000000004fa0ULL, },
+        { 0xd00060000000f64cULL, 0x000000000000a820ULL, },
+        { 0x0000400000001974ULL, 0x000000000000fc20ULL, },
+        { 0x000040000000fa74ULL, 0x000000000000cda0ULL, },    /*  96  */
+        { 0x0000400000001b74ULL, 0x0000000000007120ULL, },
+        { 0x0000400000007c74ULL, 0x000000000000bea0ULL, },
+        { 0x0000400000001d74ULL, 0x000000000000ae20ULL, },
+        { 0x0000000000003514ULL, 0x00000000000055a0ULL, },
+        { 0x00000000000069b4ULL, 0x000000000000df20ULL, },
+        { 0x000000000000a354ULL, 0x000000000000c2a0ULL, },
+        { 0x00000000000009f4ULL, 0x0000000000009820ULL, },
+        { 0x0000000000007ff4ULL, 0x0000000000001aa0ULL, },    /* 104  */
+        { 0x000000000000f5f4ULL, 0x0000000000004f20ULL, },
+        { 0x0000000000006bf4ULL, 0x0000000000001da0ULL, },
+        { 0x000000000000e1f4ULL, 0x0000000000008e20ULL, },
+        { 0x000000000000224cULL, 0x000000000000a220ULL, },
+        { 0x000000000000ad74ULL, 0x0000000000003620ULL, },
+        { 0x000000000000eeccULL, 0x0000000000004a20ULL, },
+        { 0x000000000000c8f4ULL, 0x000000000000de20ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c
index 09f01d3..bc3f5d2 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c
@@ -43,118 +43,118 @@ int32_t main(void)
 
     uint64_t b128_result[TEST_COUNT_TOTAL][2];
     uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
-        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
-        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
-        { 0x000000006666666cULL, 0x000000006666666cULL, },
-        { 0x0000000000000006ULL, 0x0000000000000006ULL, },
-        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
-        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
-        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
-        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
-        { 0x000000020000000cULL, 0x000000020000000cULL, },
-        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
-        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
-        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
-        { 0x000000020000000eULL, 0x000000020000000eULL, },
-        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
-        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
-        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
-        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
-        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
-        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
-        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
-        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
-        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
-        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
-        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
-        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
-        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
-        { 0x000000013333334aULL, 0x000000013333334aULL, },
-        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
-        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
-        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
-        { 0x000000006666667eULL, 0x000000006666667eULL, },
-        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
-        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
-        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
-        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
-        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
-        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
-        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
-        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
-        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
-        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
-        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
-        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
-        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
-        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
-        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
-        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
-        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
-        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
-        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
-        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
-        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
-        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
-        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
-        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
-        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
-        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
-        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
-        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
-        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
-        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
-        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
-        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
-        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
-        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
-        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
-        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
-        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
-        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
-        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
-        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
-        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
-        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
-        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
-        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
-        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
-        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
-        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
-        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
-        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
-        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
-        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
-        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
-        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
-        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
-        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
-        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
-        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
-        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
-        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
-        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
-        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
-        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   0  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x5555555755555557ULL, 0x5555555755555557ULL, },
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },
+        { 0x3333333633333336ULL, 0x3333333633333336ULL, },
+        { 0x0000000300000003ULL, 0x0000000300000003ULL, },
+        { 0x1c71c72071c71c75ULL, 0xc71c71cb1c71c720ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },    /*   8  */
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x5555555a5555555aULL, 0x5555555a5555555aULL, },    /*  16  */
+        { 0x5555555a5555555aULL, 0x5555555a5555555aULL, },
+        { 0x38e38e3e38e38e3eULL, 0x38e38e3e38e38e3eULL, },
+        { 0xaaaaaab0aaaaaab0ULL, 0xaaaaaab0aaaaaab0ULL, },
+        { 0x2222222822222228ULL, 0x2222222822222228ULL, },
+        { 0x0000000600000006ULL, 0x0000000600000006ULL, },
+        { 0x12f684c4a12f6852ULL, 0x84bda13612f684c4ULL, },
+        { 0x5555555c5555555cULL, 0x5555555c5555555cULL, },
+        { 0x0000000700000007ULL, 0x0000000700000007ULL, },    /*  24  */
+        { 0x0000000700000007ULL, 0x0000000700000007ULL, },
+        { 0x71c71c7971c71c79ULL, 0x71c71c7971c71c79ULL, },
+        { 0xaaaaaab2aaaaaab2ULL, 0xaaaaaab2aaaaaab2ULL, },
+        { 0x6666666e6666666eULL, 0x6666666e6666666eULL, },
+        { 0x5555555d5555555dULL, 0x5555555d5555555dULL, },
+        { 0x5ed097bc25ed0983ULL, 0x97b425f55ed097bcULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x3333333c3333333cULL, 0x3333333c3333333cULL, },    /*  32  */
+        { 0x3333333c3333333cULL, 0x3333333c3333333cULL, },
+        { 0xaaaaaab4aaaaaab4ULL, 0xaaaaaab4aaaaaab4ULL, },
+        { 0x6666667066666670ULL, 0x6666667066666670ULL, },
+        { 0x8f5c29008f5c2900ULL, 0x8f5c29008f5c2900ULL, },
+        { 0x999999a4999999a4ULL, 0x999999a4999999a4ULL, },
+        { 0x7d27d288c16c16ccULL, 0x38e38e447d27d288ULL, },
+        { 0xccccccd8ccccccd8ULL, 0xccccccd8ccccccd8ULL, },
+        { 0x999999a5999999a5ULL, 0x999999a5999999a5ULL, },    /*  40  */
+        { 0x999999a5999999a5ULL, 0x999999a5999999a5ULL, },
+        { 0x7777778377777783ULL, 0x7777778377777783ULL, },
+        { 0x6666667266666672ULL, 0x6666667266666672ULL, },
+        { 0x70a3d71670a3d716ULL, 0x70a3d71670a3d716ULL, },
+        { 0x3333333f3333333fULL, 0x3333333f3333333fULL, },
+        { 0x6c16c1787d27d289ULL, 0x5b05b0676c16c178ULL, },
+        { 0x0000000c0000000cULL, 0x0000000c0000000cULL, },
+        { 0x1c71c72971c71c7eULL, 0xc71c71d41c71c729ULL, },    /*  48  */
+        { 0x1c71c72971c71c7eULL, 0xc71c71d41c71c729ULL, },
+        { 0x2f684be712f684caULL, 0x4bda13042f684be7ULL, },
+        { 0x38e38e46e38e38f0ULL, 0x8e38e39c38e38e46ULL, },
+        { 0x1c71c72a0b60b618ULL, 0x2d82d83c1c71c72aULL, },
+        { 0x5555556355555562ULL, 0x5555556455555563ULL, },
+        { 0x0fcd6eac35ba7826ULL, 0x5ba781a40fcd6eacULL, },
+        { 0x71c71c80c71c71d4ULL, 0x1c71c72c71c71c80ULL, },
+        { 0x5555556455555563ULL, 0x5555556555555564ULL, },    /*  56  */
+        { 0x5555556455555563ULL, 0x5555556555555564ULL, },
+        { 0x97b425fc097b426dULL, 0x25ed098b97b425fcULL, },
+        { 0x38e38e48e38e38f2ULL, 0x8e38e39e38e38e48ULL, },
+        { 0x88888898eeeeeefeULL, 0x2222223288888898ULL, },
+        { 0x1c71c72c71c71c81ULL, 0xc71c71d71c71c72cULL, },
+        { 0x7e6b75000329162fULL, 0x87e6b75f7e6b7500ULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0xb10332a061639010ULL, 0x3a253694749880a0ULL, },    /*  64  */
+        { 0xc1c27384487afa10ULL, 0xbb9c0820e3b1a470ULL, },
+        { 0x35565efc0caf5a10ULL, 0x735b0ec23bd12160ULL, },
+        { 0xe6475258fb27d390ULL, 0x49d49612c9a1c0e0ULL, },
+        { 0xf706933ce23f3d90ULL, 0xcb4b679e38bae4b0ULL, },
+        { 0xabfab985e02cadd0ULL, 0x0836664283a94cc0ULL, },
+        { 0xa33845439e9989d0ULL, 0x5b9fe12897ee3470ULL, },
+        { 0x1df3e50abfdd3e40ULL, 0x6d858f1887bc89f0ULL, },
+        { 0x9187d08284119e40ULL, 0x254495badfdc06e0ULL, },    /*  72  */
+        { 0x88c55c40427e7a40ULL, 0x78ae10a0f420ee90ULL, },
+        { 0x3f78e5242782ba40ULL, 0x93ad82a12637b820ULL, },
+        { 0x28380a46b1663b40ULL, 0x255be1c9fb128ca0ULL, },
+        { 0xd928fda29fdeb4c0ULL, 0xfbd5691988e32c20ULL, },
+        { 0x53e49d69c1226930ULL, 0x0dbb170978b181a0ULL, },
+        { 0x3ca3c28b4b05ea30ULL, 0x9f6976314d8c5620ULL, },
+        { 0x621b15b4fcefb9f4ULL, 0x7f3fac7130ab3a20ULL, },
+        { 0x81b8192421043af4ULL, 0x7180d8efde07f3a0ULL, },    /*  80  */
+        { 0xa0a1d210b115be94ULL, 0x33a676350e450520ULL, },
+        { 0xe27e30b0181b6494ULL, 0x359b330061c70ba0ULL, },
+        { 0xe0f1f5a03792b1acULL, 0xe6a63b00d5b18fa0ULL, },
+        { 0x38af7120b51538acULL, 0x7938e500aea24b20ULL, },
+        { 0x7a4830802390b20cULL, 0x4b472700af547ea0ULL, },
+        { 0xcc2f6580204a3c0cULL, 0x37510000bd1b8320ULL, },
+        { 0x9ba9ed0066371fb4ULL, 0xeba90000264fb720ULL, },
+        { 0x7400c900846dd0b4ULL, 0xb6b700007c524ca0ULL, },    /*  88  */
+        { 0x7e4e840000744254ULL, 0xf24d00003540fa20ULL, },
+        { 0x242a2c00b0850854ULL, 0xdb00000025db24a0ULL, },
+        { 0x38a168005a7bb9ecULL, 0xa3000000566748a0ULL, },
+        { 0x6cb048001a7d90ecULL, 0x7d0000000a0cb020ULL, },
+        { 0xe4dc2000bd958c4cULL, 0x2f000000f6d44fa0ULL, },
+        { 0xbcc9600018fcf64cULL, 0x000000002ecca820ULL, },
+        { 0x739b4000140b1974ULL, 0x000000009361fc20ULL, },
+        { 0x8ed24000a4acfa74ULL, 0x00000000bcafcda0ULL, },    /*  96  */
+        { 0xc3dd40003f7c1b74ULL, 0x00000000fe2b7120ULL, },
+        { 0x1fac4000f6087c74ULL, 0x00000000e05abea0ULL, },
+        { 0x9e6f40000de21d74ULL, 0x000000001e89ae20ULL, },
+        { 0x637500000f743514ULL, 0x00000000c1b755a0ULL, },
+        { 0xd9b400005ed469b4ULL, 0x000000005dfcdf20ULL, },
+        { 0x0a50000049fea354ULL, 0x000000006b40c2a0ULL, },
+        { 0x07400000982609f4ULL, 0x00000000c2b79820ULL, },
+        { 0x57c00000b2de7ff4ULL, 0x000000006f6c1aa0ULL, },    /* 104  */
+        { 0x1d400000bbe3f5f4ULL, 0x000000001c974f20ULL, },
+        { 0x09c00000a8b66bf4ULL, 0x00000000e1391da0ULL, },
+        { 0x03400000aed5e1f4ULL, 0x0000000094d78e20ULL, },
+        { 0x7d8000009d2e224cULL, 0x00000000ab48a220ULL, },
+        { 0x3d000000b40fad74ULL, 0x00000000c40e3620ULL, },
+        { 0x96000000332aeeccULL, 0x00000000ecf84a20ULL, },
+        { 0xb40000004e1bc8f4ULL, 0x0000000075d6de20ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c
index b68b57f..808c49d 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c
@@ -43,118 +43,118 @@ int32_t main(void)
 
     uint64_t b128_result[TEST_COUNT_TOTAL][2];
     uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
-        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
-        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
-        { 0x000000006666666cULL, 0x000000006666666cULL, },
-        { 0x0000000000000006ULL, 0x0000000000000006ULL, },
-        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
-        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
-        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
-        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
-        { 0x000000020000000cULL, 0x000000020000000cULL, },
-        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
-        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
-        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
-        { 0x000000020000000eULL, 0x000000020000000eULL, },
-        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
-        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
-        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
-        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
-        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
-        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
-        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
-        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
-        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
-        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
-        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
-        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
-        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
-        { 0x000000013333334aULL, 0x000000013333334aULL, },
-        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
-        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
-        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
-        { 0x000000006666667eULL, 0x000000006666667eULL, },
-        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
-        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
-        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
-        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
-        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
-        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
-        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
-        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
-        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
-        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
-        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
-        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
-        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
-        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
-        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
-        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
-        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
-        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
-        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
-        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
-        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
-        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
-        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
-        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
-        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
-        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
-        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
-        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
-        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
-        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
-        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
-        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
-        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
-        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
-        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
-        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
-        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
-        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
-        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
-        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
-        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
-        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
-        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
-        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
-        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
-        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
-        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
-        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
-        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
-        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
-        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
-        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
-        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
-        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
-        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
-        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
-        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
-        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
-        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
-        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
-        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
-        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xa9a9a9a9a9a9a9a9ULL, 0xa9a9a9a9a9a9a9a9ULL, },
+        { 0xfefefefefefefefeULL, 0xfefefefefefefefeULL, },
+        { 0xcacacacacacacacaULL, 0xcacacacacacacacaULL, },
+        { 0xfdfdfdfdfdfdfdfdULL, 0xfdfdfdfdfdfdfdfdULL, },
+        { 0xe08b35e08b35e08bULL, 0x35e08b35e08b35e0ULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },    /*   8  */
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xa6a6a6a6a6a6a6a6ULL, 0xa6a6a6a6a6a6a6a6ULL, },    /*  16  */
+        { 0xa6a6a6a6a6a6a6a6ULL, 0xa6a6a6a6a6a6a6a6ULL, },
+        { 0xc2c2c2c2c2c2c2c2ULL, 0xc2c2c2c2c2c2c2c2ULL, },
+        { 0x5050505050505050ULL, 0x5050505050505050ULL, },
+        { 0xd8d8d8d8d8d8d8d8ULL, 0xd8d8d8d8d8d8d8d8ULL, },
+        { 0xfafafafafafafafaULL, 0xfafafafafafafafaULL, },
+        { 0x3caeca3caeca3caeULL, 0xca3caeca3caeca3cULL, },
+        { 0xa4a4a4a4a4a4a4a4ULL, 0xa4a4a4a4a4a4a4a4ULL, },
+        { 0xf9f9f9f9f9f9f9f9ULL, 0xf9f9f9f9f9f9f9f9ULL, },    /*  24  */
+        { 0xf9f9f9f9f9f9f9f9ULL, 0xf9f9f9f9f9f9f9f9ULL, },
+        { 0x8787878787878787ULL, 0x8787878787878787ULL, },
+        { 0x4e4e4e4e4e4e4e4eULL, 0x4e4e4e4e4e4e4e4eULL, },
+        { 0x9292929292929292ULL, 0x9292929292929292ULL, },
+        { 0xa3a3a3a3a3a3a3a3ULL, 0xa3a3a3a3a3a3a3a3ULL, },
+        { 0x447d0b447d0b447dULL, 0x0b447d0b447d0b44ULL, },
+        { 0xf8f8f8f8f8f8f8f8ULL, 0xf8f8f8f8f8f8f8f8ULL, },
+        { 0xc4c4c4c4c4c4c4c4ULL, 0xc4c4c4c4c4c4c4c4ULL, },    /*  32  */
+        { 0xc4c4c4c4c4c4c4c4ULL, 0xc4c4c4c4c4c4c4c4ULL, },
+        { 0x4c4c4c4c4c4c4c4cULL, 0x4c4c4c4c4c4c4c4cULL, },
+        { 0x9090909090909090ULL, 0x9090909090909090ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5c5c5c5c5c5c5c5cULL, 0x5c5c5c5c5c5c5c5cULL, },
+        { 0x7834bc7834bc7834ULL, 0xbc7834bc7834bc78ULL, },
+        { 0x2828282828282828ULL, 0x2828282828282828ULL, },
+        { 0x5b5b5b5b5b5b5b5bULL, 0x5b5b5b5b5b5b5b5bULL, },    /*  40  */
+        { 0x5b5b5b5b5b5b5b5bULL, 0x5b5b5b5b5b5b5b5bULL, },
+        { 0x7d7d7d7d7d7d7d7dULL, 0x7d7d7d7d7d7d7d7dULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0xeaeaeaeaeaeaeaeaULL, 0xeaeaeaeaeaeaeaeaULL, },
+        { 0xc1c1c1c1c1c1c1c1ULL, 0xc1c1c1c1c1c1c1c1ULL, },
+        { 0x8877998877998877ULL, 0x9988779988779988ULL, },
+        { 0xf4f4f4f4f4f4f4f4ULL, 0xf4f4f4f4f4f4f4f4ULL, },
+        { 0xd7822cd7822cd782ULL, 0x2cd7822cd7822cd7ULL, },    /*  48  */
+        { 0xd7822cd7822cd782ULL, 0x2cd7822cd7822cd7ULL, },
+        { 0x1936fc1936fc1936ULL, 0xfc1936fc1936fc19ULL, },
+        { 0xba1064ba1064ba10ULL, 0x64ba1064ba1064baULL, },
+        { 0xd6e8c4d6e8c4d6e8ULL, 0xc4d6e8c4d6e8c4d6ULL, },
+        { 0x9d9e9c9d9e9c9d9eULL, 0x9c9d9e9c9d9e9c9dULL, },
+        { 0x54da5c54da5c54daULL, 0x5c54da5c54da5c54ULL, },
+        { 0x802cd4802cd4802cULL, 0xd4802cd4802cd480ULL, },
+        { 0x9c9d9b9c9d9b9c9dULL, 0x9b9c9d9b9c9d9b9cULL, },    /*  56  */
+        { 0x9c9d9b9c9d9b9c9dULL, 0x9b9c9d9b9c9d9b9cULL, },
+        { 0x0493750493750493ULL, 0x7504937504937504ULL, },
+        { 0xb80e62b80e62b80eULL, 0x62b80e62b80e62b8ULL, },
+        { 0x6802ce6802ce6802ULL, 0xce6802ce6802ce68ULL, },
+        { 0xd47f29d47f29d47fULL, 0x29d47f29d47f29d4ULL, },
+        { 0x00d1a100d1a100d1ULL, 0xa100d1a100d1a100ULL, },
+        { 0xf0f0f0f0f0f0f0f0ULL, 0xf0f0f0f0f0f0f0f0ULL, },
+        { 0xb00c4c60b06cb7f0ULL, 0xf77f776cecd7f060ULL, },    /*  64  */
+        { 0x58604c7ca826a4f0ULL, 0xb11e6ee016929090ULL, },
+        { 0xf81cf804c0e87df0ULL, 0x4436ec3e6ce920a0ULL, },
+        { 0x786634a810267370ULL, 0xf53f14eebe33c020ULL, },
+        { 0x20ba34c408e06070ULL, 0xafde0b62e8ee6050ULL, },
+        { 0x07b6347bdf77af30ULL, 0x6b8d72be2f6d1c40ULL, },
+        { 0x63ea34bd3a9aa230ULL, 0xad25d0d828d84290ULL, },
+        { 0x934834f6f477f4c0ULL, 0xc39e78e84b9ade10ULL, },
+        { 0x3304e07e0c39cdc0ULL, 0x56b6f646a1f16e20ULL, },    /*  72  */
+        { 0x8f38e0c0675cc0c0ULL, 0x984e54609a5c9470ULL, },
+        { 0xff949cdcb6fb47c0ULL, 0xa70e305f61233be0ULL, },
+        { 0xbfcea8bac85c91c0ULL, 0x2cb600377e0d9160ULL, },
+        { 0x3f18e45e189a8740ULL, 0xddbf28e7d05731e0ULL, },
+        { 0x6f76e497d277d9d0ULL, 0xf338d0f7f319cd60ULL, },
+        { 0x2fb0f075e4d823d0ULL, 0x78e0a0cf100323e0ULL, },
+        { 0x2f4f0c4c60779f0cULL, 0xcfff608f7fff9fe0ULL, },
+        { 0x379944bc60e9d40cULL, 0x2a66400d7d7a4f60ULL, },    /*  80  */
+        { 0x4a0b4408801e08acULL, 0x36fc80bb3c7401e0ULL, },
+        { 0x922d0cb800dcb0acULL, 0xfc5c807628f8dc60ULL, },
+        { 0xb24a046000c05044ULL, 0x30c080e6c008a460ULL, },
+        { 0x22a66ce00040c044ULL, 0x208000724030e4e0ULL, },
+        { 0xcc726c4000808024ULL, 0xe00000de0060dc60ULL, },
+        { 0xbc5e04c000000024ULL, 0xc00000bc004010e0ULL, },
+        { 0x7c5cac000000002cULL, 0x0000001c00c0f0e0ULL, },
+        { 0x9c4424000000002cULL, 0x000000d40080f060ULL, },    /*  88  */
+        { 0xa8cc2400000000ccULL, 0x0000004c000010e0ULL, },
+        { 0xc814ac00000000ccULL, 0x000000980000c060ULL, },
+        { 0x48e8e400000000a4ULL, 0x0000005800004060ULL, },
+        { 0x08d80c00000000a4ULL, 0x00000008000040e0ULL, },
+        { 0x30880c0000000084ULL, 0x000000380000c060ULL, },
+        { 0xf0b8e40000000084ULL, 0x00000070000000e0ULL, },
+        { 0xf0f04c000000004cULL, 0x000000f0000000e0ULL, },
+        { 0x709004000000004cULL, 0x000000d000000060ULL, },    /*  96  */
+        { 0xf0f06c000000004cULL, 0x00000070000000e0ULL, },
+        { 0x709064000000004cULL, 0x0000005000000060ULL, },
+        { 0xf0f08c000000004cULL, 0x000000f0000000e0ULL, },
+        { 0xa0d08c00000000ecULL, 0x0000009000000060ULL, },
+        { 0xc0708c000000008cULL, 0x000000f0000000e0ULL, },
+        { 0x80508c000000002cULL, 0x0000009000000060ULL, },
+        { 0x00f08c00000000ccULL, 0x000000f0000000e0ULL, },
+        { 0x00906400000000ccULL, 0x000000e000000060ULL, },    /* 104  */
+        { 0x00f06c00000000ccULL, 0x000000c0000000e0ULL, },
+        { 0x00900400000000ccULL, 0x0000008000000060ULL, },
+        { 0x00f04c00000000ccULL, 0x00000000000000e0ULL, },
+        { 0x00e0c400000000a4ULL, 0x00000000000000e0ULL, },
+        { 0x00c0ec00000000acULL, 0x00000000000000e0ULL, },
+        { 0x0080a40000000044ULL, 0x00000000000000e0ULL, },
+        { 0x00008c000000008cULL, 0x00000000000000e0ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c
index 5a0549a..9722dbd 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c
@@ -43,118 +43,118 @@ int32_t main(void)
 
     uint64_t b128_result[TEST_COUNT_TOTAL][2];
     uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
-        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
-        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
-        { 0x000000006666666cULL, 0x000000006666666cULL, },
-        { 0x0000000000000006ULL, 0x0000000000000006ULL, },
-        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
-        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
-        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
-        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
-        { 0x000000020000000cULL, 0x000000020000000cULL, },
-        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
-        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
-        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
-        { 0x000000020000000eULL, 0x000000020000000eULL, },
-        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
-        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
-        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
-        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
-        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
-        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
-        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
-        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
-        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
-        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
-        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
-        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
-        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
-        { 0x000000013333334aULL, 0x000000013333334aULL, },
-        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
-        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
-        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
-        { 0x000000006666667eULL, 0x000000006666667eULL, },
-        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
-        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
-        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
-        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
-        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
-        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
-        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
-        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
-        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
-        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
-        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
-        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
-        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
-        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
-        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
-        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
-        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
-        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
-        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
-        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
-        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
-        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
-        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
-        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
-        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
-        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
-        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
-        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
-        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
-        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
-        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
-        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
-        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
-        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
-        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
-        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
-        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
-        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
-        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
-        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
-        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
-        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
-        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
-        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
-        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
-        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
-        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
-        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
-        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
-        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
-        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
-        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
-        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
-        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
-        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
-        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
-        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
-        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
-        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
-        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
-        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
-        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaa9ULL, 0xaaaaaaaaaaaaaaa9ULL, },
+        { 0xfffffffffffffffeULL, 0xfffffffffffffffeULL, },
+        { 0xcccccccccccccccaULL, 0xcccccccccccccccaULL, },
+        { 0xfffffffffffffffdULL, 0xfffffffffffffffdULL, },
+        { 0xe38e38e38e38e38bULL, 0x38e38e38e38e38e0ULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },    /*   8  */
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xaaaaaaaaaaaaaaa6ULL, 0xaaaaaaaaaaaaaaa6ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaa6ULL, 0xaaaaaaaaaaaaaaa6ULL, },
+        { 0x71c71c71c71c71c2ULL, 0x71c71c71c71c71c2ULL, },
+        { 0x5555555555555550ULL, 0x5555555555555550ULL, },
+        { 0xddddddddddddddd8ULL, 0xddddddddddddddd8ULL, },
+        { 0xfffffffffffffffaULL, 0xfffffffffffffffaULL, },
+        { 0xed097b425ed097aeULL, 0xd097b425ed097b3cULL, },
+        { 0xaaaaaaaaaaaaaaa4ULL, 0xaaaaaaaaaaaaaaa4ULL, },
+        { 0xfffffffffffffff9ULL, 0xfffffffffffffff9ULL, },    /*  24  */
+        { 0xfffffffffffffff9ULL, 0xfffffffffffffff9ULL, },
+        { 0xe38e38e38e38e387ULL, 0xe38e38e38e38e387ULL, },
+        { 0x555555555555554eULL, 0x555555555555554eULL, },
+        { 0x9999999999999992ULL, 0x9999999999999992ULL, },
+        { 0xaaaaaaaaaaaaaaa3ULL, 0xaaaaaaaaaaaaaaa3ULL, },
+        { 0xa12f684bda12f67dULL, 0x12f684bda12f6844ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xccccccccccccccc4ULL, 0xccccccccccccccc4ULL, },    /*  32  */
+        { 0xccccccccccccccc4ULL, 0xccccccccccccccc4ULL, },
+        { 0x555555555555554cULL, 0x555555555555554cULL, },
+        { 0x9999999999999990ULL, 0x9999999999999990ULL, },
+        { 0xa3d70a3d70a3d700ULL, 0xa3d70a3d70a3d700ULL, },
+        { 0x666666666666665cULL, 0x666666666666665cULL, },
+        { 0xe93e93e93e93e934ULL, 0x2d82d82d82d82d78ULL, },
+        { 0x3333333333333328ULL, 0x3333333333333328ULL, },
+        { 0x666666666666665bULL, 0x666666666666665bULL, },    /*  40  */
+        { 0x666666666666665bULL, 0x666666666666665bULL, },
+        { 0x888888888888887dULL, 0x888888888888887dULL, },
+        { 0x999999999999998eULL, 0x999999999999998eULL, },
+        { 0x5c28f5c28f5c28eaULL, 0x5c28f5c28f5c28eaULL, },
+        { 0xccccccccccccccc1ULL, 0xccccccccccccccc1ULL, },
+        { 0x2d82d82d82d82d77ULL, 0x3e93e93e93e93e88ULL, },
+        { 0xfffffffffffffff4ULL, 0xfffffffffffffff4ULL, },
+        { 0xe38e38e38e38e382ULL, 0x38e38e38e38e38d7ULL, },    /*  48  */
+        { 0xe38e38e38e38e382ULL, 0x38e38e38e38e38d7ULL, },
+        { 0xd097b425ed097b36ULL, 0x097b425ed097b419ULL, },
+        { 0xc71c71c71c71c710ULL, 0x71c71c71c71c71baULL, },
+        { 0x49f49f49f49f49e8ULL, 0x38e38e38e38e38d6ULL, },
+        { 0xaaaaaaaaaaaaaa9eULL, 0xaaaaaaaaaaaaaa9dULL, },
+        { 0xf9add3c0ca4587daULL, 0x587e6b74f0329154ULL, },
+        { 0x8e38e38e38e38e2cULL, 0xe38e38e38e38e380ULL, },
+        { 0xaaaaaaaaaaaaaa9dULL, 0xaaaaaaaaaaaaaa9cULL, },    /*  56  */
+        { 0xaaaaaaaaaaaaaa9dULL, 0xaaaaaaaaaaaaaa9cULL, },
+        { 0x684bda12f684bd93ULL, 0x84bda12f684bda04ULL, },
+        { 0xc71c71c71c71c70eULL, 0x71c71c71c71c71b8ULL, },
+        { 0x1111111111111102ULL, 0x7777777777777768ULL, },
+        { 0xe38e38e38e38e37fULL, 0x38e38e38e38e38d4ULL, },
+        { 0x781948b0fcd6e9d1ULL, 0xc3f35ba781948b00ULL, },
+        { 0xfffffffffffffff0ULL, 0xfffffffffffffff0ULL, },
+        { 0x52ba41969e9c6ff0ULL, 0xcd6802158b677f60ULL, },    /*  64  */
+        { 0x63129bf5b78505f0ULL, 0x1556f7f61c4e5b90ULL, },
+        { 0x5a4c8855f350a5f0ULL, 0x6a36586fc42edea0ULL, },
+        { 0x5e6b001b04d82c70ULL, 0xe819332c365e3f20ULL, },
+        { 0x6ec35a7a1dc0c270ULL, 0x3008290cc7451b50ULL, },
+        { 0x37152f411fd35230ULL, 0xc7e3b2957c56b340ULL, },
+        { 0xcc49f1d861667630ULL, 0x1808e0646811cb90ULL, },
+        { 0xde8a7f544022c1c0ULL, 0x9886bc9978437610ULL, },
+        { 0xd5c46bb47bee61c0ULL, 0xed661d132023f920ULL, },    /*  72  */
+        { 0x6af92e4bbd8185c0ULL, 0x3d8b4ae20bdf1170ULL, },
+        { 0xe4d44869d87d45c0ULL, 0x6409d23bd9c847e0ULL, },
+        { 0x6e2e9ce94e99c4c0ULL, 0xc30837db04ed7360ULL, },
+        { 0x724d14ae60214b40ULL, 0x40eb1297771cd3e0ULL, },
+        { 0x848da22a3edd96d0ULL, 0xc168eecc874e7e60ULL, },
+        { 0x0de7f6a9b4fa15d0ULL, 0x2067546bb273a9e0ULL, },
+        { 0xc233bfd40310460cULL, 0x0d9585bacf54c5e0ULL, },
+        { 0x061015122724c70cULL, 0x0169d01f7cb17f60ULL, },    /*  80  */
+        { 0x23dacc726f603aacULL, 0xf3ea8c4eaa8b5ce0ULL, },
+        { 0xd82df953c25380acULL, 0xba87b7f0f99bbb60ULL, },
+        { 0x546cb94a0c5e7444ULL, 0x3818c320ce1bdf60ULL, },
+        { 0xa38f9428761ecf44ULL, 0x63113b9e681b66e0ULL, },
+        { 0x7dc23fbe59fe7924ULL, 0x156ddd68750e6260ULL, },
+        { 0x8a17717d36df5b24ULL, 0x36b1f5939596d2e0ULL, },
+        { 0x7e854cd9a677ce2cULL, 0xf2b6202eb36946e0ULL, },
+        { 0x246d8d067437a72cULL, 0x04c6347e9c1ff460ULL, },    /*  88  */
+        { 0xc48a013a554339ccULL, 0xcb81fd31acc4a5e0ULL, },
+        { 0xb971282c0b508fccULL, 0x20d62d6344ce5060ULL, },
+        { 0x835f812f0bc6a7a4ULL, 0x17bd6b5a08275460ULL, },
+        { 0xc0ee1b9557ab4aa4ULL, 0x170471a9d22d5fe0ULL, },
+        { 0xc6f66d89431f7984ULL, 0x5c6f5a646cad3f60ULL, },
+        { 0x5ae0b289f6ac0b84ULL, 0x6f9f6bc81fdb6be0ULL, },
+        { 0x2f584ee03fd2014cULL, 0xa7e34ccbd1bc3fe0ULL, },
+        { 0x5947927731cb724cULL, 0xf76af1f9a05f4160ULL, },    /*  96  */
+        { 0x68112ad490e3a34cULL, 0x7f944a22f5d630e0ULL, },
+        { 0x1cf6705c5faa944cULL, 0x801292d47291e660ULL, },
+        { 0x5519f2782cb0454cULL, 0x3d691c2dd53919e0ULL, },
+        { 0xe5c979861aac06ecULL, 0x585247d6e899e160ULL, },
+        { 0x2450b27896665b8cULL, 0x8276d8ad504f46e0ULL, },
+        { 0x2716d456a4a5ab2cULL, 0x46e1f3460c71c260ULL, },
+        { 0x5751460331251dccULL, 0xdc1dc7a4a693abe0ULL, },
+        { 0x3bf387b7f37473ccULL, 0x8efb4ff7cc92de60ULL, },    /* 104  */
+        { 0xc3103a3df066c9ccULL, 0x7d3b07351cd59ee0ULL, },
+        { 0x0d612554557c1fccULL, 0x5dbabfc2ac8ed560ULL, },
+        { 0x1cd018ef103475ccULL, 0xca277277956f49e0ULL, },
+        { 0x15d520225c2e79a4ULL, 0x08f2025804e95de0ULL, },
+        { 0x820f9c65be3ea1acULL, 0x37094edbda6ef1e0ULL, },
+        { 0x0f18515c62838744ULL, 0xcfbd4b5627d005e0ULL, },
+        { 0x11d549f26502488cULL, 0x8de999d53cdc99e0ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c
index 17bccc8..6c059c7 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c
@@ -43,118 +43,118 @@ int32_t main(void)
 
     uint64_t b128_result[TEST_COUNT_TOTAL][2];
     uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
-        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
-        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
-        { 0x000000006666666cULL, 0x000000006666666cULL, },
-        { 0x0000000000000006ULL, 0x0000000000000006ULL, },
-        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
-        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
-        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
-        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
-        { 0x000000020000000cULL, 0x000000020000000cULL, },
-        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
-        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
-        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
-        { 0x000000020000000eULL, 0x000000020000000eULL, },
-        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
-        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
-        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
-        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
-        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
-        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
-        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
-        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
-        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
-        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
-        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
-        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
-        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
-        { 0x000000013333334aULL, 0x000000013333334aULL, },
-        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
-        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
-        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
-        { 0x000000006666667eULL, 0x000000006666667eULL, },
-        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
-        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
-        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
-        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
-        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
-        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
-        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
-        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
-        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
-        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
-        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
-        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
-        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
-        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
-        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
-        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
-        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
-        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
-        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
-        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
-        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
-        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
-        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
-        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
-        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
-        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
-        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
-        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
-        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
-        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
-        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
-        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
-        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
-        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
-        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
-        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
-        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
-        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
-        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
-        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
-        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
-        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
-        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
-        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
-        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
-        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
-        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
-        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
-        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
-        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
-        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
-        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
-        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
-        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
-        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
-        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
-        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
-        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
-        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
-        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
-        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
-        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaa9aaa9aaa9aaa9ULL, 0xaaa9aaa9aaa9aaa9ULL, },
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },
+        { 0xcccacccacccacccaULL, 0xcccacccacccacccaULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xe38b38e08e35e38bULL, 0x38e08e35e38b38e0ULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },    /*   8  */
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xaaa6aaa6aaa6aaa6ULL, 0xaaa6aaa6aaa6aaa6ULL, },    /*  16  */
+        { 0xaaa6aaa6aaa6aaa6ULL, 0xaaa6aaa6aaa6aaa6ULL, },
+        { 0x71c271c271c271c2ULL, 0x71c271c271c271c2ULL, },
+        { 0x5550555055505550ULL, 0x5550555055505550ULL, },
+        { 0xddd8ddd8ddd8ddd8ULL, 0xddd8ddd8ddd8ddd8ULL, },
+        { 0xfffafffafffafffaULL, 0xfffafffafffafffaULL, },
+        { 0x97ae7b3c5eca97aeULL, 0x7b3c5eca97ae7b3cULL, },
+        { 0xaaa4aaa4aaa4aaa4ULL, 0xaaa4aaa4aaa4aaa4ULL, },
+        { 0xfff9fff9fff9fff9ULL, 0xfff9fff9fff9fff9ULL, },    /*  24  */
+        { 0xfff9fff9fff9fff9ULL, 0xfff9fff9fff9fff9ULL, },
+        { 0xe387e387e387e387ULL, 0xe387e387e387e387ULL, },
+        { 0x554e554e554e554eULL, 0x554e554e554e554eULL, },
+        { 0x9992999299929992ULL, 0x9992999299929992ULL, },
+        { 0xaaa3aaa3aaa3aaa3ULL, 0xaaa3aaa3aaa3aaa3ULL, },
+        { 0xf67d6844da0bf67dULL, 0x6844da0bf67d6844ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xccc4ccc4ccc4ccc4ULL, 0xccc4ccc4ccc4ccc4ULL, },    /*  32  */
+        { 0xccc4ccc4ccc4ccc4ULL, 0xccc4ccc4ccc4ccc4ULL, },
+        { 0x554c554c554c554cULL, 0x554c554c554c554cULL, },
+        { 0x9990999099909990ULL, 0x9990999099909990ULL, },
+        { 0xd700d700d700d700ULL, 0xd700d700d700d700ULL, },
+        { 0x665c665c665c665cULL, 0x665c665c665c665cULL, },
+        { 0xe9342d7871bce934ULL, 0x2d7871bce9342d78ULL, },
+        { 0x3328332833283328ULL, 0x3328332833283328ULL, },
+        { 0x665b665b665b665bULL, 0x665b665b665b665bULL, },    /*  40  */
+        { 0x665b665b665b665bULL, 0x665b665b665b665bULL, },
+        { 0x887d887d887d887dULL, 0x887d887d887d887dULL, },
+        { 0x998e998e998e998eULL, 0x998e998e998e998eULL, },
+        { 0x28ea28ea28ea28eaULL, 0x28ea28ea28ea28eaULL, },
+        { 0xccc1ccc1ccc1ccc1ULL, 0xccc1ccc1ccc1ccc1ULL, },
+        { 0x2d773e884f992d77ULL, 0x3e884f992d773e88ULL, },
+        { 0xfff4fff4fff4fff4ULL, 0xfff4fff4fff4fff4ULL, },
+        { 0xe38238d78e2ce382ULL, 0x38d78e2ce38238d7ULL, },    /*  48  */
+        { 0xe38238d78e2ce382ULL, 0x38d78e2ce38238d7ULL, },
+        { 0x7b36b419ecfc7b36ULL, 0xb419ecfc7b36b419ULL, },
+        { 0xc71071ba1c64c710ULL, 0x71ba1c64c71071baULL, },
+        { 0x49e838d627c449e8ULL, 0x38d627c449e838d6ULL, },
+        { 0xaa9eaa9daa9caa9eULL, 0xaa9daa9caa9eaa9dULL, },
+        { 0x87da91547e5c87daULL, 0x91547e5c87da9154ULL, },
+        { 0x8e2ce38038d48e2cULL, 0xe38038d48e2ce380ULL, },
+        { 0xaa9daa9caa9baa9dULL, 0xaa9caa9baa9daa9cULL, },    /*  56  */
+        { 0xaa9daa9caa9baa9dULL, 0xaa9caa9baa9daa9cULL, },
+        { 0xbd93da04f675bd93ULL, 0xda04f675bd93da04ULL, },
+        { 0xc70e71b81c62c70eULL, 0x71b81c62c70e71b8ULL, },
+        { 0x11027768ddce1102ULL, 0x7768ddce11027768ULL, },
+        { 0xe37f38d48e29e37fULL, 0x38d48e29e37f38d4ULL, },
+        { 0xe9d18b0048a1e9d1ULL, 0x8b0048a1e9d18b00ULL, },
+        { 0xfff0fff0fff0fff0ULL, 0xfff0fff0fff0fff0ULL, },
+        { 0x340ccd603a6c6ff0ULL, 0x7c7fc96cb0d77f60ULL, },    /*  64  */
+        { 0x07608c7c902605f0ULL, 0x7e1ef7e0f9925b90ULL, },
+        { 0xda1ca10416e8a5f0ULL, 0x2e36f13e11e9dea0ULL, },
+        { 0x6166ada860262c70ULL, 0x773f69ee43333f20ULL, },
+        { 0x34ba6cc4b5e0c270ULL, 0x78de98628bee1b50ULL, },
+        { 0x13b6467bf3775230ULL, 0xce8d99be266db340ULL, },
+        { 0xeaeababdfe9a7630ULL, 0x2d251ed87fd8cb90ULL, },
+        { 0x1b481af62b77c1c0ULL, 0x479e70e86e9a7610ULL, },
+        { 0xee042f7eb23961c0ULL, 0xf7b66a4686f1f920ULL, },    /*  72  */
+        { 0xc538a3c0bd5c85c0ULL, 0x564eef60e05c1170ULL, },
+        { 0xb5941adce7fb45c0ULL, 0xd00e7d5f672347e0ULL, },
+        { 0x25cef5ba555cc4c0ULL, 0x55b61e37e30d7360ULL, },
+        { 0xad18025e9e9a4b40ULL, 0x9ebf96e71457d3e0ULL, },
+        { 0xdd766297cb7796d0ULL, 0xb938e8f703197e60ULL, },
+        { 0x4db03d7538d815d0ULL, 0x3ee089cf7f03a9e0ULL, },
+        { 0x154fea4c3377460cULL, 0xe1ff538f49ffc5e0ULL, },
+        { 0x4a99edbce7e9c70cULL, 0x3f66800dba7a7f60ULL, },    /*  80  */
+        { 0xea0bfe08a81e3aacULL, 0xe7fcffbbd4745ce0ULL, },
+        { 0x3e2ddcb809dc80acULL, 0xc75ca276a8f8bb60ULL, },
+        { 0x5e4aa9605ec07444ULL, 0x6dc0dee66108df60ULL, },
+        { 0x03a670e01940cf44ULL, 0x05802472d23066e0ULL, },
+        { 0x8c72ca4059807924ULL, 0xb7002ade28606260ULL, },
+        { 0x945efbc07b005b24ULL, 0x4f00c3bc4040d2e0ULL, },
+        { 0xab5cc300f000ce2cULL, 0xf000bd1c6fc046e0ULL, },
+        { 0xd7445f001000a72cULL, 0x600018d43e80f460ULL, },    /*  88  */
+        { 0x66cca200e00039ccULL, 0xc000b74c5d00a5e0ULL, },
+        { 0x33140e00c0008fccULL, 0xc0005a98be005060ULL, },
+        { 0xafe8d8000000a7a4ULL, 0x00002a58c2005460ULL, },
+        { 0x99d8b80000004aa4ULL, 0x0000d6088c005fe0ULL, },
+        { 0xa388900000007984ULL, 0x0000413818003f60ULL, },
+        { 0xc5b8f00000000b84ULL, 0x0000fa7010006be0ULL, },
+        { 0x41f0c0000000014cULL, 0x00002bf0f0003fe0ULL, },
+        { 0x7490c0000000724cULL, 0x0000b9d0a0004160ULL, },    /*  96  */
+        { 0xb0f0c0000000a34cULL, 0x00008f70c00030e0ULL, },
+        { 0xed90c0000000944cULL, 0x000014508000e660ULL, },
+        { 0x0ff0c0000000454cULL, 0x00002ef0000019e0ULL, },
+        { 0xebd08000000006ecULL, 0x00001a900000e160ULL, },
+        { 0xf770000000005b8cULL, 0x000037f0000046e0ULL, },
+        { 0x825000000000ab2cULL, 0x000039900000c260ULL, },
+        { 0x5af0000000001dccULL, 0x000030f00000abe0ULL, },
+        { 0x22900000000073ccULL, 0x0000d1e00000de60ULL, },    /* 104  */
+        { 0x3bf000000000c9ccULL, 0x000083c000009ee0ULL, },
+        { 0xe990000000001fccULL, 0x0000c7800000d560ULL, },
+        { 0x0cf00000000075ccULL, 0x00000f00000049e0ULL, },
+        { 0x0ee00000000079a4ULL, 0x0000670000005de0ULL, },
+        { 0x77c000000000a1acULL, 0x00007f000000f1e0ULL, },
+        { 0x8380000000008744ULL, 0x00005700000005e0ULL, },
+        { 0xef0000000000488cULL, 0x0000ef00000099e0ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c
index 171b717..0a83db4 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c
@@ -43,118 +43,118 @@ int32_t main(void)
 
     uint64_t b128_result[TEST_COUNT_TOTAL][2];
     uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
-        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
-        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
-        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
-        { 0x000000006666666cULL, 0x000000006666666cULL, },
-        { 0x0000000000000006ULL, 0x0000000000000006ULL, },
-        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
-        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
-        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
-        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
-        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
-        { 0x000000020000000cULL, 0x000000020000000cULL, },
-        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
-        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
-        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
-        { 0x000000020000000eULL, 0x000000020000000eULL, },
-        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
-        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
-        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
-        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
-        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
-        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
-        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
-        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
-        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
-        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
-        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
-        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
-        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
-        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
-        { 0x000000013333334aULL, 0x000000013333334aULL, },
-        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
-        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
-        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
-        { 0x000000006666667eULL, 0x000000006666667eULL, },
-        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
-        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
-        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
-        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
-        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
-        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
-        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
-        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
-        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
-        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
-        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
-        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
-        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
-        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
-        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
-        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
-        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
-        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
-        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
-        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
-        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
-        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
-        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
-        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
-        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
-        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
-        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
-        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
-        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
-        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
-        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
-        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
-        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
-        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
-        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
-        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
-        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
-        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
-        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
-        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
-        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
-        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
-        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
-        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
-        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
-        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
-        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
-        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
-        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
-        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
-        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
-        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
-        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
-        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
-        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
-        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
-        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
-        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
-        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
-        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
-        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
-        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
-        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
-        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaa9aaaaaaa9ULL, 0xaaaaaaa9aaaaaaa9ULL, },
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },
+        { 0xcccccccacccccccaULL, 0xcccccccacccccccaULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xe38e38e08e38e38bULL, 0x38e38e35e38e38e0ULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },    /*   8  */
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xaaaaaaa6aaaaaaa6ULL, 0xaaaaaaa6aaaaaaa6ULL, },    /*  16  */
+        { 0xaaaaaaa6aaaaaaa6ULL, 0xaaaaaaa6aaaaaaa6ULL, },
+        { 0xc71c71c2c71c71c2ULL, 0xc71c71c2c71c71c2ULL, },
+        { 0x5555555055555550ULL, 0x5555555055555550ULL, },
+        { 0xddddddd8ddddddd8ULL, 0xddddddd8ddddddd8ULL, },
+        { 0xfffffffafffffffaULL, 0xfffffffafffffffaULL, },
+        { 0xed097b3c5ed097aeULL, 0x7b425ecaed097b3cULL, },
+        { 0xaaaaaaa4aaaaaaa4ULL, 0xaaaaaaa4aaaaaaa4ULL, },
+        { 0xfffffff9fffffff9ULL, 0xfffffff9fffffff9ULL, },    /*  24  */
+        { 0xfffffff9fffffff9ULL, 0xfffffff9fffffff9ULL, },
+        { 0x8e38e3878e38e387ULL, 0x8e38e3878e38e387ULL, },
+        { 0x5555554e5555554eULL, 0x5555554e5555554eULL, },
+        { 0x9999999299999992ULL, 0x9999999299999992ULL, },
+        { 0xaaaaaaa3aaaaaaa3ULL, 0xaaaaaaa3aaaaaaa3ULL, },
+        { 0xa12f6844da12f67dULL, 0x684bda0ba12f6844ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xccccccc4ccccccc4ULL, 0xccccccc4ccccccc4ULL, },    /*  32  */
+        { 0xccccccc4ccccccc4ULL, 0xccccccc4ccccccc4ULL, },
+        { 0x5555554c5555554cULL, 0x5555554c5555554cULL, },
+        { 0x9999999099999990ULL, 0x9999999099999990ULL, },
+        { 0x70a3d70070a3d700ULL, 0x70a3d70070a3d700ULL, },
+        { 0x6666665c6666665cULL, 0x6666665c6666665cULL, },
+        { 0x82d82d783e93e934ULL, 0xc71c71bc82d82d78ULL, },
+        { 0x3333332833333328ULL, 0x3333332833333328ULL, },
+        { 0x6666665b6666665bULL, 0x6666665b6666665bULL, },    /*  40  */
+        { 0x6666665b6666665bULL, 0x6666665b6666665bULL, },
+        { 0x8888887d8888887dULL, 0x8888887d8888887dULL, },
+        { 0x9999998e9999998eULL, 0x9999998e9999998eULL, },
+        { 0x8f5c28ea8f5c28eaULL, 0x8f5c28ea8f5c28eaULL, },
+        { 0xccccccc1ccccccc1ULL, 0xccccccc1ccccccc1ULL, },
+        { 0x93e93e8882d82d77ULL, 0xa4fa4f9993e93e88ULL, },
+        { 0xfffffff4fffffff4ULL, 0xfffffff4fffffff4ULL, },
+        { 0xe38e38d78e38e382ULL, 0x38e38e2ce38e38d7ULL, },    /*  48  */
+        { 0xe38e38d78e38e382ULL, 0x38e38e2ce38e38d7ULL, },
+        { 0xd097b419ed097b36ULL, 0xb425ecfcd097b419ULL, },
+        { 0xc71c71ba1c71c710ULL, 0x71c71c64c71c71baULL, },
+        { 0xe38e38d6f49f49e8ULL, 0xd27d27c4e38e38d6ULL, },
+        { 0xaaaaaa9daaaaaa9eULL, 0xaaaaaa9caaaaaa9dULL, },
+        { 0xf0329154ca4587daULL, 0xa4587e5cf0329154ULL, },
+        { 0x8e38e38038e38e2cULL, 0xe38e38d48e38e380ULL, },
+        { 0xaaaaaa9caaaaaa9dULL, 0xaaaaaa9baaaaaa9cULL, },    /*  56  */
+        { 0xaaaaaa9caaaaaa9dULL, 0xaaaaaa9baaaaaa9cULL, },
+        { 0x684bda04f684bd93ULL, 0xda12f675684bda04ULL, },
+        { 0xc71c71b81c71c70eULL, 0x71c71c62c71c71b8ULL, },
+        { 0x7777776811111102ULL, 0xddddddce77777768ULL, },
+        { 0xe38e38d48e38e37fULL, 0x38e38e29e38e38d4ULL, },
+        { 0x81948b00fcd6e9d1ULL, 0x781948a181948b00ULL, },
+        { 0xfffffff0fffffff0ULL, 0xfffffff0fffffff0ULL, },
+        { 0x4efccd609e9c6ff0ULL, 0xc5dac96c8b677f60ULL, },    /*  64  */
+        { 0x3e3d8c7cb78505f0ULL, 0x4463f7e01c4e5b90ULL, },
+        { 0xcaa9a104f350a5f0ULL, 0x8ca4f13ec42edea0ULL, },
+        { 0x19b8ada804d82c70ULL, 0xb62b69ee365e3f20ULL, },
+        { 0x08f96cc41dc0c270ULL, 0x34b49862c7451b50ULL, },
+        { 0x5405467b1fd35230ULL, 0xf7c999be7c56b340ULL, },
+        { 0x5cc7babd61667630ULL, 0xa4601ed86811cb90ULL, },
+        { 0xe20c1af64022c1c0ULL, 0x927a70e878437610ULL, },
+        { 0x6e782f7e7bee61c0ULL, 0xdabb6a462023f920ULL, },    /*  72  */
+        { 0x773aa3c0bd8185c0ULL, 0x8751ef600bdf1170ULL, },
+        { 0xc0871adcd87d45c0ULL, 0x6c527d5fd9c847e0ULL, },
+        { 0xd7c7f5ba4e99c4c0ULL, 0xdaa41e3704ed7360ULL, },
+        { 0x26d7025e60214b40ULL, 0x042a96e7771cd3e0ULL, },
+        { 0xac1b62973edd96d0ULL, 0xf244e8f7874e7e60ULL, },
+        { 0xc35c3d75b4fa15d0ULL, 0x609689cfb273a9e0ULL, },
+        { 0x9de4ea4c0310460cULL, 0x80c0538fcf54c5e0ULL, },
+        { 0xbd81edbc2724c70cULL, 0x7301800d7cb17f60ULL, },    /*  80  */
+        { 0xaebafe086f603aacULL, 0x35c5ffbbaa8b5ce0ULL, },
+        { 0xdf14dcb8c25380acULL, 0x3ef9a276f99bbb60ULL, },
+        { 0x5e0ea9600c5e7444ULL, 0x8ef3dee6ce1bdf60ULL, },
+        { 0x1c7370e0761ecf44ULL, 0x864a2472681b66e0ULL, },
+        { 0xb58eca4059fe7924ULL, 0x8c252ade750e6260ULL, },
+        { 0xfcc4fbc036df5b24ULL, 0x36a7c3bc9596d2e0ULL, },
+        { 0x57a2c300a677ce2cULL, 0x2922bd1cb36946e0ULL, },
+        { 0x88bd5f007437a72cULL, 0x45fd18d49c1ff460ULL, },    /*  88  */
+        { 0x2581a200554339ccULL, 0x6c99b74cacc4a5e0ULL, },
+        { 0x2d500e000b508fccULL, 0x1f975a9844ce5060ULL, },
+        { 0x5907d8000bc6a7a4ULL, 0x0eaa2a5808275460ULL, },
+        { 0xeab7b80057ab4aa4ULL, 0x8af4d608d22d5fe0ULL, },
+        { 0x95ab9000431f7984ULL, 0x840741386cad3f60ULL, },
+        { 0xf5ddf000f6ac0b84ULL, 0xd51bfa701fdb6be0ULL, },
+        { 0xdf7cc0003fd2014cULL, 0xb5052bf0d1bc3fe0ULL, },
+        { 0x3393c00031cb724cULL, 0x06abb9d0a05f4160ULL, },    /*  96  */
+        { 0xdb56c00090e3a34cULL, 0x7ff18f70f5d630e0ULL, },
+        { 0xa1b5c0005faa944cULL, 0x9e0514507291e660ULL, },
+        { 0xfa60c0002cb0454cULL, 0xc4182ef0d53919e0ULL, },
+        { 0xa6f680001aac06ecULL, 0x05ca1a90e899e160ULL, },
+        { 0x15a3000096665b8cULL, 0x0cec37f0504f46e0ULL, },
+        { 0xb79a0000a4a5ab2cULL, 0x578239900c71c260ULL, },
+        { 0xb70c000031251dccULL, 0xaa4c30f0a693abe0ULL, },
+        { 0x01140000f37473ccULL, 0x400dd1e0cc92de60ULL, },    /* 104  */
+        { 0xb1cc0000f066c9ccULL, 0x8cf683c01cd59ee0ULL, },
+        { 0xf8540000557c1fccULL, 0x0f82c780ac8ed560ULL, },
+        { 0xf88c0000103475ccULL, 0xa1f10f00956f49e0ULL, },
+        { 0x2e7000005c2e79a4ULL, 0xcf94670004e95de0ULL, },
+        { 0x96c00000be3ea1acULL, 0xdca57f00da6ef1e0ULL, },
+        { 0xbf00000062838744ULL, 0x368a570027d005e0ULL, },
+        { 0x4c0000006502488cULL, 0xcc98ef003cdc99e0ULL, },
     };
 
     reset_msa_registers();
-- 
2.7.4


