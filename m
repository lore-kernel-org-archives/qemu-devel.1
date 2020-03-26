Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D63BC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7338D20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7338D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMti-0007aj-L1
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHMsf-0006Hu-J1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHMse-00084a-I7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50619)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jHMse-00084D-9g
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:44 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4alK-1jGpAZ2Cn8-001l68; Thu, 26 Mar 2020 08:23:57 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] target/i386: Renumber EXCP_SYSCALL
Date: Thu, 26 Mar 2020 08:23:48 +0100
Message-Id: <20200326072352.2056553-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326072352.2056553-1-laurent@vivier.eu>
References: <20200326072352.2056553-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Lbxy7qW3EMtPMQ3XrOVl2AkDuZWMyEnCNeYhJD9bBc7JOqd4xPV
 Q9Yet6h5P+8YRHrCS0i8W37Wfx2OGnGdpXTRfQW4qFwc0uExv49M/rxyA+C/zTivdXJGH19
 nS1zVnUlq/x8KkuvDKaVCZG74GeitDIUT+lGK3jm4my12GEx+w11rs9vTdrVbA/6ZncYim2
 /IMYC4OBLChSSO6akxxXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jAeKhWV8fO8=:iqq8Ppf8a3LBs3Xr9W9OLg
 +B7cN1G4bv2nKVIrl5Xc9BmkkQ/Hs11a7q73HM2GjfMdW0JTfP0PmSA3IDoanX+HPO/HL6c0q
 RyE/6YyNyYbG06LjTPIIo2N7wOEjMCGU/nb8wgNPqKsY9hjpplGjYXqXOo+fjQm3MkR3F/BCV
 wQkVk1/usmk5mRNJepBjefNEx6nE2FssecvOLBuq8/drKkruif9YQ5w3woz8n7duMnA79vdqC
 r3knjkMkSdc10pQSP67y9Tz4qUPzs6PMi38FBSfmwwk8/O9cSQXvpzTVqcKuAjMDouHBXdxm+
 QsLl5aAYaijJ3CHoUoD1WWIdwd9ljMkRrrh89Dv37r0597Sw32YjnNMum5eYiOWhxpoeO7s5Z
 GYt4sp+FjK56/eOSsn5qQEIGWFToCWsXAwapuhmI5GICdQrAu0URnHFEqJrPk7mJYsywj18SV
 priBfYrUYl+4mH+BZend5lblUY9+h4zARKYNyP4R4QlzRjK5BUtPGh8V4x4ux4cwYfpyFUmSG
 Wb+vp5rq7j8Ub/Pzd0TfXp0TAM1YYyQDceRpkkzfzptz0EmDMr8cZZrXZkZgxIJiKpTSUIq/o
 w6r6IHy1W8HAyll61hTv6ouYilydy1GZasxbzRXzEvUgI9RnBYnI1vQBqx0icAEFOuh1TWpTw
 oB1aT5PHbZ3YF5gRNhUIpG3sfrM3AG1M6YalvSiLepnCQ1zIJ2MSIDfY2mU95r4rdlLYronkI
 3NwJgFvzyOmOEFM94bJ3Pfy54Mq4MVsFJGATCef8hwSJqRa/9bH+kf2P9SWPhHB5GhXSuwRzN
 cqowc1IHZENjGZqBlwQnk8fD2HEwKKm8keHdwMzDnVabGq+QwaK2H+r5DYjKC96K4K6K7S6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We are not short of numbers for EXCP_*.  There is no need to confuse things
by having EXCP_VMEXIT and EXCP_SYSCALL overlap, even though the former is
only used for system mode and the latter is only used for user mode.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/cpu.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 60d797d5941f..49ecc23104c9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1001,9 +1001,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define EXCP11_ALGN	17
 #define EXCP12_MCHK	18
 
-#define EXCP_SYSCALL    0x100 /* only happens in user only emulation
-                                 for syscall instruction */
-#define EXCP_VMEXIT     0x100
+#define EXCP_VMEXIT     0x100 /* only for system emulation */
+#define EXCP_SYSCALL    0x101 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
-- 
2.25.1


