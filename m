Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DEFC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B1620663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B1620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErVk-0004tt-00
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRx-0005Os-3i
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRv-0004Dt-Qb
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:49 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46993)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRv-0004DI-HN
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:47 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2Plu-1jHbXC338g-003s6h; Thu, 19 Mar 2020 10:26:32 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 01/16] target/i386: Renumber EXCP_SYSCALL
Date: Thu, 19 Mar 2020 10:26:12 +0100
Message-Id: <20200319092627.51487-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9HGTExg1wp02cp06LD11V11vWuFuKKYKX4/OK/2gXe1DIZUeoGB
 20EERSaCpdqUGqmvoEI5Nh5SyjIg8L4mhrZdeCIPbKwI0Gjf19qkV3gN8tOT217QI8tqxR3
 MacyWqyWWr2GP5UJBX2xKsgRjrw38DMnopCE2YVUrzxFd00Bwslcqgs4z28yAgPgh5D6klV
 sXCa+/K/tg4hnwL+oOVug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FxU1ZPEB50I=:lLs9ykG/SKh10TtpeQvga9
 3xc1ZjDSd4JD+c3LflwyHlBinrIL5T6zhC5+ZGG7uLmZFmZr/YnUo5vbVFbQJk1CzTAQW5CTv
 2Rn/d8Y0A5hACnDVozwIopGFM5gufBtkiE27zhACx2v5URIjm4KjE/OnRb1pdyVAcvC4xoWNk
 btPGaIkXL9427j8aGW5Z+MVLRhihd5cgWMkPiZONIkFgsc3QdtXIzSL9omyjJduqIdeQXFGk2
 XIizD/E4HdLXyMiNUG46VJ3yz2Av80fFz+Cs959Enrj6ULIQHYk4kZ4Cp6p82qyEK68Y5mAFh
 lXcjLd29krXI0H37ThxBSgB0bKzrl2HplqhR8P0Cn05YQdhnlLqEJQpynKPbIp/LZvKT99DbX
 43k3b8nFui0DpGIO5NQlcbb8KrYzo43aJuFbutLTpiSK8LtWIGeKoVp4ejSqL0dS7DCGfWIsw
 i26GpZWy+uPcJhKqFydpDtgPJL0mHwYOAHWsel71O7vTmgCG41TtERbuW+371dmhZ1nLQO9px
 jXOeMxum8EUVdq5nXilxQSnRZp+9rOed0GNc3AMb7pEKRfa/wInerLKRr2YRDba0WM61/nRVV
 4jm2nluxpbw4bv3OpYVcCYa3dKQgaPiWRxxPDZY77y1P24L2F1KxoIEMmdWY4wp7W0EySqMvR
 lZKzuUegDFnFeRDTflaGc4m1Eid3t0YQbG4FJtu4Ti5bLYSGHnr/Wd420yHpOtqHbCZmyFcbS
 v5GF98txBhFvB9kQBelwEKOil+1WMfkHUFglKDmh3wcmlIX+fjulWOrwWxKAg+/7MCNUqqlO9
 e1ih0MTZinmNs9JfnMBBalqCB1vXcGQZXbPvUSvK3lP45qGLrTJ1tG0PyK0EEptEy+N7jEv
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
index 576f309bbfc8..08b4422f36bd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -999,9 +999,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
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


