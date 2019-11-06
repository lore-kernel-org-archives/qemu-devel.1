Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702F2C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CA921882
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CA921882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL1p-0005LW-0X
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzt-0003S2-HD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzs-0002wU-Dv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:17 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:43641)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzs-0002vZ-4L
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:16 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N63NQ-1hqnLo2u8u-016Pwb; Wed, 06 Nov 2019 14:05:08 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/13] tests/tcg/multiarch/linux-test: Fix error check for
 shmat
Date: Wed,  6 Nov 2019 14:04:46 +0100
Message-Id: <20191106130456.6176-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vu1BYmduwVjJTm9simsfiMGEKoqN9w6waqLssuklMSO6JIBEGVU
 9EeL0wEnC5U4DUjrnHPoocjRh3N4mKrdkynjbqqV7i3Orom2/BvPyfmOQ5vqCV3P/vG0jAx
 UDJJzkliQ2XEw7La3Ac0XAaAf5SeFxxLxG0PoageV1T/TwWa+zRAU1XBqtDcGcpekxcVVHZ
 IyTtU4J+13UVQsSKoRrvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xROpSsYcRq8=:7mHkMJ+n9Ny8JVJpwk4VwW
 fsVRVxbvzqdQyPXu1WDM/B2zkWyGNbyjM53mr/x5lC2OImt0+tGEjqaNtagvXo4uoHn7xfyLB
 vNHOZU2jn7f45inIZdR4cHrRofVU+ZGioCjTbjcAEmeN5FD5O8/D4DKu54bNaYhgO6lD/I20k
 880f7Sfs3zx/1tZWbBoy/yMuZlKpEFzFMDw5hqopomWFj7+TDPeWons4yva1Zf7Kf96BACA0P
 CXpxdUvmW5tTKHKhPKLkZKstEHTNjSF4eXX53SSsMO0MM59ylzCMdFdN8h5zNAxW1H2glTPL6
 NJaJ8hdT6phqTnnCzw2NdTGzBUEgq4YI5aepBnU0Q9+W6XfZm8xkR6MJ5nAQ3OkVtIB4vnwj3
 dqpz8fnV2SlCbevGx5xEdNkkixBWpgUQI+GaIDIk/JqwRyZA95GmtmAKwsGJ6WKMfAsioV4h+
 wYM1gq2OBkOeROQIzuW0LV+ho+DIlQEb2D+EVJ9cvL7JczLrw3Kx0aAcgiDISDczFrl4zUI8b
 Q0V4XHBDiR1wPXlqXxmMDehl4iDi425yIC+FTDwOuoEHXtxAvDM2xDFH68gZuko+ZMusP27YH
 ATWt7ewG7sYwEVnmL1ncDrBl/Y2dsf7cuAX1PbeastECVVu6TXl79u+7fy+0c5QbHOM/UWcMX
 Gw1qWgUeNF7TVXzn/o3t622LaK4+B6ee5Z/09U8NxxaYHDD6PetDciDIhnUcDD1FBrF2+QJjS
 7ekJ4oEQIlqRSAxRgoXgMKsDGPB8p6OzPr24zOsRlWIbkJJTAJol0k1hc0uo2k9fd9Y3orYTF
 rREHohLKSpyeI9ML7CJq2jM4iyb4mcDEue07EMewFoWFpQ7f4hjHQSEbt9ME2452PgQ+AYwRM
 ocMhAFrjy61HvbxUAIkA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The error indicator for this syscall is -1, not 0.

Fixes: e374bfa35bfb ("shm tests - disabled clone test")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191106113318.10226-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/tcg/multiarch/linux-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index fa4243fc0426..673d7c8a1c25 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -503,8 +503,9 @@ static void test_shm(void)
 
     shmid = chk_error(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | 0777));
     ptr = shmat(shmid, NULL, 0);
-    if (!ptr)
+    if (ptr == (void *)-1) {
         error("shmat");
+    }
 
     memset(ptr, 0, SHM_SIZE);
 
-- 
2.21.0


