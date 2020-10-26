Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF6C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD3520874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD3520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAhe-0006BV-7R
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAal-0005gO-Ls
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:51 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAaj-0005GF-Ud
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:51 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3suW-1kOTNT0bom-00zk6H; Mon, 26 Oct 2020 23:03:47 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] target/xtensa: enable all coprocessors for linux-user
Date: Mon, 26 Oct 2020 23:03:39 +0100
Message-Id: <20201026220339.195790-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026220339.195790-1-laurent@vivier.eu>
References: <20201026220339.195790-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OAzESyHoUVSYsGs9sf3S2LXlWzkpaRhJnhG9hVEGdi9FPX3khEQ
 3lAOAHIlwxOpOwq5cDgec5QWk34hQyu/eGGlfxWGHMgVBAKFNcXGk67ZzIWQ1y+gUnkT2rS
 hDLxnpun7VfY2ce/Rmuq3MVSbkdxAxatPQj3OrLft4wh0ZHtoed4DKiys3ZanAUOB8V1l8r
 2LgUQApeHee0sYO9YrpXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+VTo9Y2U3jA=:zU8dMITeVOZuYVN9WQJuRV
 m/M+oOEYWkwNySJekQdS8CCZiXTkFMc6UysGJrscHy1QRlHsPgB0E4UhzyVosXo7yLFjYPjOj
 PPmm2wnGxKPtTMDi9SJ7a8XkeaYM1oJTABsZQ6Vv6XnGfMXk0mfZ6MgDmQTkvf6ltG4byPKNU
 ffWpHgRH2Csb64wIVHhyQMs1Zeww0Hc3t3KQKwaS+EBu5fuConotTYYZJZwqw+dGVrUn97UGA
 TaGFDiTYsIyxjdgiSHtw6GZzW4C6GrC0XvRebJkmEqLmgzYaHXSfq7AGmbNOM5/eTDPdvMIol
 JtsIkgbP+BypPcqwISj276sVLm0CQ6v72LceRksP7rIuUuCv9ai1RRsgNVzhBilxr0LSSw99S
 9SM1GewT16t7rds+oq0LnGixHe4NpTBN5diAM+Q0DTvNLf+CO3G+a5wm6BG5gg20YvaZnOrmD
 CJek24AFPw==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 18:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Filippov <jcmvbkbc@gmail.com>

Linux userspace always sees coprocessors as enabled. CPENABLE register
and coprocessor exceptions are used internally by the kernel to manage
lazy coprocessor context switch. None of it is needed for linux-user.
Always enable all coprocessors for user emulation.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200829104758.22337-1-jcmvbkbc@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/xtensa/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6a033e778c95..88a32268a18b 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -93,6 +93,7 @@ static void xtensa_cpu_reset(DeviceState *dev)
         !xtensa_abi_call0()) {
         env->sregs[PS] |= PS_WOE;
     }
+    env->sregs[CPENABLE] = 0xff;
 #endif
     env->sregs[VECBASE] = env->config->vecbase;
     env->sregs[IBREAKENABLE] = 0;
-- 
2.26.2


