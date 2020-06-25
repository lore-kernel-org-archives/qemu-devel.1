Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A48C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FA420709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FA420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joNxv-0006w9-DD
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1joNvn-0004kV-Nb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:12:27 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1joNvk-0007GF-8U
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:12:27 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mg6uW-1jCaP72d4Q-00hc7v; Thu, 25 Jun 2020 11:12:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/sparc: Translate flushw opcode
Date: Thu, 25 Jun 2020 11:12:03 +0200
Message-Id: <20200625091204.3186186-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625091204.3186186-1-laurent@vivier.eu>
References: <20200625091204.3186186-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:17KG+Vp7XE9zRzq69xA9HR6Wqle3aOe3kF8xH18Wq8OGEnpgOaH
 qkdoY1BfQcQxyj5gTvZzIOo+YRzXjqG0Z67My1QyUbMHSH8VLq1rpyxNnIjgb7zvwfns2CE
 0ck2rA1RrbnXIW6dgmtrjlYCExbHhqRwJzx9oWpQuukBbuXHh8Io8DzVEYxePT9AM2Nel2g
 pS72Q7sWIy/IahcrO+PXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x34blcC1KNg=:hUfQxqV4j0XUhk4i1670RZ
 0JNCxCUDiYtTPaTY8gIOWvnD6gxo9YkM7KCm4P2lUqew715hdNeBrpiojtgu3/0ucUh7UDNF2
 pvapEJfbUhIVIBYu0Exmm6ooZOlebbVuVy1c2Y6rNDR5+QgtR+wCTPCI031fF6/9CEX850unF
 b+bTtG5lZcWlc8Jp0EtNqNr0x/z61SlovMC4ZVS52qIKDsdILse+d4oDjYfYlQPlQnGlwhlrk
 4tywuKiCTwwJkdCYguG7Qn6R8eHdsb87Y8F4weoxx/4RW+fj3eP8xkqz664Rqf/ERR3GkYtUg
 pEVuyAsoJdvv8+WMRxFiHd0m6JvvDlL+j3P1T2ep7N0DwopAfbaS6W5hvI5E7Yu2K2jEhaPbf
 9TmwjCBg/UgaSWxCKv3Mh+Kr1u3ZFXdoG6q3JfP69EOm3ba7RkOQ1773ZHbq5RZn+o8WMZcAV
 cMTLpHDG2+ixIYzW+Le8emg8u6s687Op8P4O2yfhWqc0oIE85itHh7L8dv0a1e5LuALCKTSVG
 JmOwqvy74Xf6LmInaQqR+xXnqtf1v9UozR3Gk24FGIFC1j3GGxwQMjE/hFhg+L744BvUSk+32
 4m8OwnUzeyoLK1siXBoB4bb9yQfdJP31n1i9Su7kLUV7Z7mTuc2X82WoGWk5PSeALgZd9+hBY
 IHRMskM7eitZrnsejJ0EUTH629SPP9g/9bli9/t3oBUdA+QVHMzL6n8CdKEQsaXEpWY7dgW2r
 HeNh1GZhIoIkQzMay0PNmKip79lM5NSjZ5krzWsGEhBgJ6oITB927Nv48+qMegshhsqemK4T3
 3da76a/dh1h2PnOpdTWFfHfuA2stKpw3b0vH8imYJbqD1dA3zQ=
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 05:12:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LemonBoy <thatlemon@gmail.com>

The ifdef logic should unconditionally compile in the `xop == 0x2b` case
when targeting sparc64.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/sparc/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9416a551cf46..1a4efd4ed665 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 #endif
                 gen_store_gpr(dc, rd, cpu_tmp0);
                 break;
+#endif
+#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
             } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
 #ifdef TARGET_SPARC64
                 gen_helper_flushw(cpu_env);
-- 
2.26.2


