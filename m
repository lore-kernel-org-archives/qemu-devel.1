Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF1EC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C3D20659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C3D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rbp-0000iP-Th
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j1rac-0007Zl-9N
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j1raJ-0003lN-70
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:58:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60493)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j1raI-0003kA-Ui
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:57:43 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MvsN5-1jJWgK0yr1-00supd; Wed, 12 Feb 2020 13:57:03 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] linux-user: add missing TARGET_SIGRTMIN for hppa
Date: Wed, 12 Feb 2020 13:56:55 +0100
Message-Id: <20200212125658.644558-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212125658.644558-1-laurent@vivier.eu>
References: <20200212125658.644558-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:onvve+0pxN44VCs5Gxk1+kdgKs5nzbt5h+mCqzGZz6Qzj1cOK+5
 XFIRjJU7e9qh2Mj+bceLkWxdwaTC7juLxDFErELA82jhP1MQ6Yc1OovTxOHyv4czCtEuvID
 /CRpfsbLDqIZTynxYvn8kiauDjtQblulwq9BjuGaRfxw3QkSlHaxwz+vmeqkKSmHH917g5o
 NFpyh3fdMkdE1EE5DO9/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u79cqCp7bNU=:OwtZbV0k6XWRWpQgReImt3
 iDb7PJBRo3Nzj8hzbPHLFFtsrJ/JTHkRD+ja68jReXAOBND3+5n3OhXH9Dog7cxWZhsLiupsa
 bfckF9sPmLc49rRXtOanOk7eijXTLTcdp8XkkMNPjiQKEqso7n42k+gT+pvBkM+/gLchu2iOf
 wYyLUubDzoLMqfJjvRlGGvjKOVgLHbU0s9fEM0t/NPyJ8pdtsSqt++skWTzBKClPn0qJkHRJ8
 dfY/EpM4MUl4dw6jLwPEzhS7EwoIwq4dRG/0DnRY/XqlZbk1W+gE4hnuZVQqqOpFJOk7qH4Go
 Wd/RlH5Kp27tvQatZkoLRvdPGkV5GEW7YvJylT5wJgjubZex7Yxn7qZ+u8T4xAK1ir7E0PR/r
 mHooZHWl5li2nq6V/Ywfd0gZijIfvyqVi+Yv3l8eS06RspPVwEngo9khKDBXelDfGzchsC7/j
 InkvadsjxdpzubNkoyLrHO6SpklKA+9cvqR8E5Qln0kbCqAlw30vWpvKK+YH8NvJWLUY+CFva
 EMZHFIDypt3td4jn1wEGegoWkspHKXRXa6YUMmRivC6gMk5ae7xvaXUTjviqVhzXmFXGfFG6z
 5A/kmJYyUzvrYu/heTcpKWn2WmKUStNguPLpnPvDaefvqL/LIqi3+dagCV9OzUiwmeAQkp64k
 eUG/2yE/H08Z4SxJRAAGWncGi2lHrQMBE+gSiuI8KfH8MqsPOWbAwbGAHUqD89S0wVGnPs8p9
 ZAQgjzKZEK5J7B08Yo1DNkz1QniY9cux3ARJUNMKHJJmMFtngFFXi40NIPRJU07ngui2d4nKT
 DAzG/ut56YeO+F5De/hgagNvbFNMUKze5USvFnonfpH9BgvqfcvrV6Ze1OmADNLci89Jv2F
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This signal is defined for all other targets and we will need it later

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
[pm: that this was actually an ABI change in the hppa kernel (at kernel
version 3.17, kernel commit 1f25df2eff5b25f52c139d). Before that
SIGRTMIN was 37...
All our other HPPA TARGET_SIG* values are for the updated
ABI following that commit, so using 32 for SIGRTMIN is
the right thing for us.]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

Notes:
    v3: Add Rb and comment from Peter

 linux-user/hppa/target_signal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index ba159ff8d006..c2a0102ed73d 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -34,6 +34,7 @@
 #define TARGET_SIGURG          29
 #define TARGET_SIGXFSZ         30
 #define TARGET_SIGSYS          31
+#define TARGET_SIGRTMIN        32
 
 #define TARGET_SIG_BLOCK       0
 #define TARGET_SIG_UNBLOCK     1
-- 
2.24.1


