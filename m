Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E709C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B912072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B912072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0hp-0001Yo-8X
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ux-0007ya-Cr; Wed, 10 Jun 2020 09:10:31 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40119)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uw-0003iG-5v; Wed, 10 Jun 2020 09:10:30 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Macaw-1jCPVK24pm-00c8PY; Wed, 10 Jun 2020 15:10:24 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/16] semihosting: remove the pthread include which seems
 unused
Date: Wed, 10 Jun 2020 15:10:11 +0200
Message-Id: <20200610131011.1941209-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ldzgHkhI8KmsyOCiFaLmnS0K5iFXGYvIBP/UBPuWhTqg8wcqsIP
 wsnEKytnVV2F1Xl988TfyG7hNDxvvV8fex9KGMgtE3jS2B3NbI6ghu3admhgoWYmRFzJAkw
 XzfCqsNp24L7150ogMU20TZs8szOCUpvhqQw/N2SamZIFX4xZ9OpBSLcTnebS2TwD9xOVqT
 DPDZ3oUFlPcDVg7XX0QkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GYFIDvf0oXM=:Krk5biTk1H33Y5ee50ButZ
 KesGI7jR5CilUGKYf/qlesmRjJvaAWuS1X+djGX16sOcdpgFZ5wt4qbqJ7Cx4jiXL5NtFoZTH
 59FLYlbBxTo1dsbz1IG6Q/tnB/lnNOObu/HFH3QdE1iI1/tfXhY4WjbZvxT17HiLLibiVjpHg
 lQkQXC78L6vvsUG34cGD6VtWtRkw1fMEGNasxf7ATMFU/iumlLuGMYmOiU6puTwOyaKLnSIFD
 nEiVTEBerofBPHyZyAGOP96sapnmXAHTSSak4fwLTQ0t19HmNTu8pV+k5lFSDkayz5CCOenFl
 8pR6/mxIEywRCn0QwmtBlbbGN9/SYEMSMoMZylX7QBidYxH3KP07uVsBSRjTNvFOLr/pCkDeK
 y2J8K4i4ejAKS9DJKA5IN5KF5idXNgkDfB4YuAvnoQFl4BFtf0Xn1DyDTfhXXXvqMP+gpWZS6
 sl38acmww4EsxKFKlrALfBk6PODbF7sSWZfAAN5bmxOouGDLy1vRExNjjSMRtngkMcL07YKgn
 O/RLm6WlvKP0Xb6Vx/7zbwSqAB1Oe0rvwESCMdp9rUFiFntgbs24V0XIwndaiIF8WsHyiCZBB
 3Wgaeo5JcnEuINI/mrlYqIBDl4FlOBumiaG7xwh5hwD2PsZX/Oh14S6E73ull74ELXLyg6zLI
 jJMCIr89CcsD39paGP5bz16hSJcha1ku4Cep3rIT7SBwVSuxhwt7s+yjJkzEoOtJH75iDgLM7
 uh4XLoS7dtw5UW2OTW6so2jeguMXwb0lakuBsduF5pOY9NtHjNltIRX4gmgURh0kTjL8faOFO
 qTT6nvUxmVfDgsrFcdbCgeNSlo4ZlAbDxZnbmofS78CrrZ0QSy1zlDsVTNVl1Nj5qIYECRi
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:24
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

This have been introduced by:
  8de702cb677c8381fb702cae252d6b69aa4c653b

It doesn't seem to be used so remove it.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <1589806958-23511-1-git-send-email-frederic.konrad@adacore.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/semihosting/console.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 6346bd7f506e..22e7827824af 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -23,7 +23,6 @@
 #include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
-#include <pthread.h>
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
-- 
2.26.2


