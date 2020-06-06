Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70241C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D16206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D16206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYs6-0003Zd-Ib
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgd-0007Nd-Tp
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:35 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgb-0007fs-T3
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:35 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmUcL-1jGmVF3wzB-00iUPH; Sat, 06 Jun 2020 15:16:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/19] tests/Makefile: Only display TCG-related tests when
 TCG is available
Date: Sat,  6 Jun 2020 15:15:57 +0200
Message-Id: <20200606131607.1250819-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2CwXTbYR6vH8kFpUc7gS93fA+cfHFpzObB0sirNk3bTcC9GMQ6c
 qdGNZ8W4vdClWcq562PneQZb0b4LH5jO0QenObAluog5+pcTWYlABJpHFTVXKoBwUAio8qh
 39Y8dAiduaiSX5Ng3QaTkdwjcANw+ahIT908h1pcPkR9nBfV2FDZH6mamfeByvFuwTr1eW7
 9VSm1RwAA7syT8Xt6rbrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pM38J6YeDW4=:XVA/q7ucK/yu/WH+dM2GCq
 OKXTz/FC7c9LpKi34WMF7ywbSMHTxYyZtXfqiA5XCWrK+jE7yvQcyXRiw4/2hVi58WLTINVW6
 n0wurbwfuQBcKo29pBhdXUXMt30g28XoVyIidwxa9HjEvyqUXtQF0sksi14HEmXM/XGqDDfus
 VYxptAn3AXMayfKZ32qIkPk2UiOWIPgnfiIQFUsmYPnd93gwS9hqsWEWKYALUZO6O3FWYFcKE
 F4cJ/2sz6El+C1kCjLCcJJ86J+oKno3TR3xeEWfG1xwvYVGRftPjrMsn58MSCan+C3Bv8xaR+
 Xaf3ydR6pCLHbDGo3xH5bmmuIFJpupWBL/7yb5aUVnr1W981K5DxJND05EFVrEhIebp2RimaQ
 IVPYvy41+3yfXs/LJ+3ploXHUrUth7ZX+DGHshzwjZJ+tiHPLX47oLk88tLxK/rtr9yO1O+1o
 WNL9leBqcMxSZ4JOiTsdgFiEf8E44VWPSr7i0pR6zD1S9VcCNalyMzuD0taemf0FetDHBXpNK
 KnQhsAdm0N+n3p2V074AcwGZb4tO2Zyqk+MKlcboD5z2S6rbD2evUKUThHEaqWlu9AGCPT5Jj
 8mC1xMWYqKbaTunpginXnU7818dGnoqseoEoUhQvH6NRvXLOd32zrfQWIWq7CuMYURKDXMQm7
 5Jl7ujpRYcCMHzzYwF+VGfLVKhglDhvscSs/m9/mDqlyvfY9nBzJjoZyJQ3LQNcBiIUbSIz1a
 vmQ7psQi1mWHO24ltt/Vd7z89jU9qTPwgkJ/3eIn0uZ31ulAgv1WL8nSMvriM+0BIgBvlrjGL
 utEgWc9QKKruk7GicTSczVtS/ztXYfw0eN33aZTrnhtjg89unLQ3DNezlMH2EuDeS2aSGB8
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-4-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a74b60f6b2..6bc3d1096bc9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -12,8 +12,10 @@ check-help:
 	@echo " $(MAKE) check-speed          Run qobject speed tests"
 	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 	@echo " $(MAKE) check-block          Run block tests"
+ifeq ($(CONFIG_TCG),y)
 	@echo " $(MAKE) check-tcg            Run TCG tests"
 	@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
+endif
 	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) tests"
 	@echo
 	@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test report"
-- 
2.26.2


