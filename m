Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E0CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAC52070B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAC52070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAub-0002k4-QE
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoj-0008I1-0Y
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:21 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoh-0006jI-1x
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:20 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9W78-1jdrQI1BGG-005Wx1; Fri, 05 Jun 2020 13:47:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/19] tests/Makefile: Only display TCG-related tests when TCG
 is available
Date: Fri,  5 Jun 2020 13:46:50 +0200
Message-Id: <20200605114700.1052050-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zJtpyEOkuSYXyASOplonEvbFhibM7FywdmyfFiRGgQg3CReCWg9
 yr5MAftiNHWqi8H56oITEtZWyqukEaPyM1bf+T8mf2TsNLB+ltbZET5nuvfZXzOvg31c+VZ
 8Yac3XFJuPji1TvdDU0QfcHBelw2Fr3s79ekaenQEjQqeKPxN5utZReXWrlQOZgokrtLK6d
 LDnNe1KUX7FB+A9xQArrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YMmjw8aiFEU=:X/F5nAWK1Wu5e0FQZoiqov
 x6ex9SHfUbOpMXSTHiullSrtvz+Z/DlGuK79VQ9w3n2UOh1mlfl7xjsr3vHrw7XiIXsrYVqX/
 h4w5PN9XP3eP/USz96FwODqvzCi+rEYVlgo7V056qWGCVK8eQ5V5/PTcv0HuS7GZNFJu4egsn
 6akdl+zOmVNeNVrfdJszjVRoL73NPXodGZwIpB1X2bTf2TnAiEGmHzNsPoWQF6dzZbyzU0G2M
 flCB/FBjaLDXKLonfNEre8aQnfoeb4jza+6BOrHsST1WsAAH6VjLk58SfJMOPAnMA5/YvQtC3
 si/7ElA79y934IN9x9ghv8UEvJ8JsFvayazfpfLd/8UQdZ50iigXMoSCzYXx0pPjiUgY0PMwb
 AwesugkDLWgG9xGaUvYpWopS5P74+izKSIq0fHGO/ANNGEBDoht4Q2gqhf4CsXZEeu2WZa2Ae
 YFKHKdH0l1iUZd/4V+vhA8grfqcPyMcxpWvQxTFGSdvlPUbeA5zvM5oJ6YLK7ABKy6IGldcpm
 zrwJ3NIQWUyrs/Oz/cnTMvr7IEQoQtUx8zQc597Za9vfOCYeRmgEhG/NzSi6gT7IY0DTk7JeY
 HSisKNwtxXmm4uN+JfzeoGKMF9Ydcg48ifZE3TnvbdFAfjsrm/6jFOM2c+S8O0Ax3rjTo8JQd
 0sohamCK4xMzZYQBCOObvZgBjTmg48A8uiC+pm+zsWyX9lZpoHrEWMf0WWAbsLlej63v9ity9
 LCr7nqEuV3JmEnbU+YG+3myNF1bxJzi+4bYp1RUlme5E1IuOgsIhivPapQOKST9lWGkrfhdbr
 HSkQKP8WVwItXyfBR2r3SJj7JAGhD6eMhuykRluem1zMbWnxihYf+fTW+ga+hKEy8CkJgf6
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:27:03
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


