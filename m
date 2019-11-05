Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DC6C5DF62
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA419214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA419214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3R1-000730-QD
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Iv-00063j-Ca
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Iu-0004kZ-80
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:45 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:46583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3It-0004jr-Ui
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MKbwg-1iDojs3Nng-00KwLt; Tue, 05 Nov 2019 19:11:29 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] tests/tcg/multiarch/linux-test: Fix error check for shmat
Date: Tue,  5 Nov 2019 19:11:09 +0100
Message-Id: <20191105181119.26779-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:guFf6kPoCev83970K61xUpTlYtpwIv48BL2vM28Yn6KhRBNECBn
 YR70Je6cEpMeOXp025Yoodu8WGSKnNgxNhWcqQ6u4lvUl2wmhQK1ujxhrWi5Gk1NGt/wHSK
 Su8wAy+e+HdOGB8FG8iEGnTnsmltEIJeWfAGf9LBdfLvoIA5pfDA+7N840HAVoCa6YRrKzO
 Nt4HZCIh1szLx6iCycfOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RbszguFOBm4=:4mHeeaEiSRAWMqaQWXEwMk
 KhHhTMd0v0mQ8cgw9SUQayU6jyt+ViAox4TDsTjZoV+bmztIS9oXYOccO/OPLzGtS635hQBjp
 NCipTPK7qbkXgSawtyiRSsdgn3Pb/ech+wQG4KkaTiUkBEfMADxads9jRYwULUMoePFO++OL+
 HvTedJ3iRCDGYJ28hg1zV4r/IGASWgG1F12RZTOCGRH29qtByNJxO78CpLpI+UDuXq5wXHzbY
 U5IGRM0dJzeSRaBfPW9u3cZge8pIGYu34enH/iB0dpDsRKFMoPi8XAB0e6RFw/u2kkHl/k6PM
 ukTNSFmC5IoDiA7MVLxB97USkUPrOOLEJY+bJiLxP8f8WDG+PR3xHQ+POl9v/7ez5vPoi8B1k
 0+x3IWPKxddHG1biN1HUdXmpRKC0EYwuEqRcCWibUyZ2fyMslDmsvX/uu/T7CSYojPW3yVWwh
 bf+nlMpZvRi1RvOeqbwkKfAo3hAfnmMqZ2JKCAFHUP+2rzFMNXGWW3yRPou3W2tap/rIcNaZJ
 4E5ljQoy0qptqNubL4hAIsHVZr39zuBNCLXAxM2gUSu7o9aUqqNrcHxUqsHRw8n3WaOxJ0ADC
 CJ4BSX1+xploak7/JzPAr7jF1GnZ7ZQ10YzKjp7TJt1qlf3B+AzBM0+R0BRSM55e4fJzeltEV
 RCdKfyyXzYVcMSeLn659Ag5Vsn6ilEHXvCXIIGu6RFjk/VBcsM3H7H3dWrggQzp3YfU7ht6V8
 +2i3h3sbm9Lk+/+QSlw3q9xVoP8OTy1h2jsV6w8doT2/b+sNn/ujjWZZJDcAU8Mw7nA4qqJmS
 EFx1i8X6sYmJHsEZqo0BI0s+hnjA99k4L/FhDx0rk+BfbfmaWbgHMDDdWI3l6/YJTx/RWujm0
 XZ/L5qDSmxz20yD0MA03KX7JTQ+FYj+Z3jaznOEfk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
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
Message-Id: <20191025113921.9412-3-richard.henderson@linaro.org>
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


