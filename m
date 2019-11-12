Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6020F20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6020F20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYtR-0007Jm-JR
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUYr7-0004tp-Q7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUYr6-0007t6-UM
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:25 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUYr6-0007rl-LQ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:24 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MILnm-1iisiE3z9g-00ELwK; Tue, 12 Nov 2019 17:16:59 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] linux-user: fix missing break
Date: Tue, 12 Nov 2019 17:16:53 +0100
Message-Id: <20191112161654.2253-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112161654.2253-1-laurent@vivier.eu>
References: <20191112161654.2253-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4q1ZiXUm1NNxEphIptLzxsFCP5oKPyBKAyhrjBdSzsQbJQQJjqa
 yYgGBkzRkI4rffCarwnM/rbXeZ/DWcXHqqfzc2gPsdtiPS/SZLn2OSPI4XtN8xFRN8jTaVY
 GqJHJLiujCs/JTP2HFm5SiR757aVoE0/1HriLCScr8Bx8oRjK6zkqyJqO0zgTyJST+pIdbk
 K1vuBZTGT3V4ONpWGoePg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X/8ttX9xq2A=:I/aF08mj3XklnJGxcbX/OZ
 vvR+Ni5NUnWhbksGh92qblu0yzUs8jy6izEiUywm5p+7F8oe6l0b78nEd+a46ikcciPOCQDHY
 iPitZEqOIXtTMadSZPCsNdlYQYMLBrFasf6yvEM1jofR0iRGHOALd0reGkA0FkZuVm5CMKNgn
 nwaw2g5Mbw0r9AUAPLen7kgyXhBjggc8G5FondcOZpiOaqdH0YUOHZRcB/pTe0UMAu/6HN6H/
 qLnMf2n36yr39DhU19OxcE5zPojzTJij4MD19M6cPP7HeGBbw4LuGH52oaAmemrPPwMPzrECw
 nhC/qllNI8qWbGxMbByghqbP9DjOml+pvkIviLdr9i32xe+ScrIoJCEcM7ap1KQw9v34Xgu3P
 wDWW3PfoTstCRgbFR/g10Yqv/KCsfIkh22u9iXnYlXEJRQUEgiv4Uflm+D9ErT1k+AaC1/RVD
 F0v2r9a7PRu53WBDWOIMnWNaY+sLxPQa5AiPIPTtLD+OQD7DBmI5UhJugw6zFEzWWcZ8DaZgu
 lRqHAmsiyJgaJ692sxNwlbOPMSTbeH+y/VQsCDd5Kvm5ImZ7PazZfgNRW28LWFbOoFFjQ3+4a
 6Nc/BsCEBBgZKn8va0N0kOnwwqLHha+lmvDv6FiHDsAEAkEZ2S8QZJJ4+Vv08tlkEBJwNJ9hu
 KGHUIYT/8jOw5QjBH0PEs2HUSfu5iLCLzlBlvxsEsv2gWBoeKF/y4QKSyJCY1DZuAUNrxJR/H
 YC2BG/JpqHnnnCib325MsLN4i1GVDwRM0TFF1lndXfd/+fQ3YFnwULFWZkEWk++H+Z7fZyCzq
 6mBrat8W5fdMV4+HDmzopFc96KT54KWkPsszaB33edrwjVdaFty9dQ4CbG4wNiYelZhHo8HPm
 0+lb95MeTVKbJBpjI39gGnSyZ/i1wXACHS8a/Jz6Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: Josh Kunz <jkz@google.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported by Coverity (CID 1407221)
Fixes: a2d866827bd8 ("linux-user: Support for NETLINK socket options")
cc: Josh Kunz <jkz@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191112105055.32269-1-laurent@vivier.eu>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ab9d933e53af..4e97bcf1e5a9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2632,6 +2632,7 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         default:
             goto unimplemented;
         }
+        break;
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-- 
2.21.0


