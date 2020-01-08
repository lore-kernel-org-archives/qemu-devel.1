Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B9C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D282072A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D282072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDs8-000468-Qy
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ipDnY-0005zj-AW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ipDnX-00025A-2M
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:03:08 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:46689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ipDnK-0001tl-Lk; Wed, 08 Jan 2020 11:02:54 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5mWp-1jmd0O4C7v-017F6e; Wed, 08 Jan 2020 17:02:40 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] arm/translate-a64: fix uninitialized variable warning
Date: Wed,  8 Jan 2020 17:02:32 +0100
Message-Id: <20200108160233.991134-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108160233.991134-1-laurent@vivier.eu>
References: <20200108160233.991134-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EHnKO7J//24FrZUg1j5EIhq7KWvRVTiEIll+WUa35nyi5IL7Tzh
 ePKu/lTxyjEGo2CJgXrXlBESFDb4nLEwOexjcPUoLntfZ65SYP/HxOsb3KOu92ZrSUlkPiA
 h/G+s05PwjTZjcDlVxEffhkdpwxYipDYsQ9a0ECbdAEQyXAY/R78dTx/qog3VB3u7n+2ovH
 3FvNgcWftBwkIAsAFRcFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kp8Eg0YxKM4=:Ez7+Vo4nmSWoZpQ1sfoR1j
 TlLb05P6sWZj1pWDrDa8ZoMsiWLK2QlImCTTpgmhcZE4924VP1DfouXPx0YGMYoJhmZB/NZO8
 XqEhHNLHB9J+tcB+KO/SwRu9YaF2u94o61/HuhhZgSnSyH3NtVrz1zXGiH6Km/tJOdO6U9NjU
 OwMWx+RhF0L+itcsPbeRp/+HjnNwFXtOIOyH79VyaJJawDmC2ivHrDzQmYqFp1HcM6L4Y4pbQ
 +wQftz0gT0xXcmvjQO1BOwxcrOMmbkF6Vn4H//1vYJdPq1dliHFEyxSTSeyitZZvRMXp3eA1O
 EWm12TFCI8TloyA4jdTLlbSYS0LUn3DpzlmOkOWP9dtIiL2Z6SkxPXcDefvCCiNAsj5kMW6dG
 9SeAJWYyJqgNX5iNoC0V01mJjW4AmzDLLdVPrZwHJQCLf0dPWuzafzJMh7N9tTvNvMVdp8+2C
 cAkczGi8eTaGc+f2+hdlheaU8WKfYhPNMID1lBKyFQvnaKjwdrh2zilJbqk19CvJrhhpHRMeW
 rqWfuigEIv+5PFLIuPsB3Tfi+9++mkWgdfC4QeMNchlABu4x+ZKnsRZiBlhViNVWs5YXweH7G
 IqFX2NQO8nEQjRuF74zh+8TNey+YPGVw4O5BpxfGuiA9YPiZphfrwcd0r6uQBs4waJcZ1hDnI
 rSKHQpkSyQa/qZ5jFOgl3ijCxt4il2mspnhVXE4MwlHQ3S+7tLsVvkOv5e/e8Ohsi7wtV7sky
 iyK2gMG7K7Q9cmp5+NW+4A7I/a2hiO2TC3qhctSIHG4/Gngmcr4+Pf7rlSITF+lnuMt1/tF1K
 vY6dfgOR9C8YjQFCcZp/85JhrrAgFNH3gZv3CM/HtRA3EI/gqVeXpHtWS4Q1jtDehrSo7AycH
 5ykwqdja1wAGXaQtpn/5IskW0HuvHtgqBRFegV0Pw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Pan Nengyuan <pannengyuan@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Fixes:
target/arm/translate-a64.c: In function 'disas_crypto_three_reg_sha512':
target/arm/translate-a64.c:13625:9: error: 'genfn' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
qemu/target/arm/translate-a64.c:13609:8: error: 'feature' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    if (!feature) {

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200108023915.52288-1-pannengyuan@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/arm/translate-a64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d4bebbe62958..63a3d2668710 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13585,6 +13585,8 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
             feature = dc_isar_feature(aa64_sha3, s);
             genfn = NULL;
             break;
+        default:
+            g_assert_not_reached();
         }
     } else {
         switch (opcode) {
-- 
2.24.1


