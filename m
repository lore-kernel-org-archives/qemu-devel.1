Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256BFC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB548214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB548214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGot0-0003Gh-L4
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonp-0002eP-7w; Fri, 11 Sep 2020 15:33:45 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonm-0000o6-VQ; Fri, 11 Sep 2020 15:33:44 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTfgb-1k6ccT0kJR-00TzJf; Fri, 11 Sep 2020 21:33:40 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] Makefile: Drop extra phony cscope
Date: Fri, 11 Sep 2020 21:33:18 +0200
Message-Id: <20200911193330.1148942-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P5pbF6IVxKRfx62q1+IVYkTf7lX5zxdS1J31WHZ31XgHpvkRr3t
 9DwdSrl2dydc/G7L5Z5cOanPIXJaNoUeJW4M5pKGGRHflj6IP0JQyApGCuh5QGQhEaBzDpI
 Ai/6dbMVDTeIIGVtXcLMoFZM/6TZ7w8SaFTsNYy/Bs9j52MeTZd+/mGEYF5rbAVZ6Xn3JfG
 uOIlSN0jaRLAgIfDBU+dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XFLQPU2ZFIA=:tiUAQFxOIGEtCOB5CD4FVY
 gPRzC9sU/5ZPA9jdXdwaUaTnxSyWAIy08dn0XxOW1lycDpmdIhfQRQfxcj43K/bW0IqInCNp6
 X/o08Ol7oKWNxoLlYbHHe6pqPhNcVpC0uqvwPBgYXbp0wQrZJlARBI9DoqIMdISpF4Jglds80
 sWItSllXpF+kZ1G9HJ/feLcqOxAPs1KRlcTLYcZQLof0mhlAaGXidQLDuISTMzk09IH1b+tRJ
 P03d7BsokXbvI/pToT3EfQZlmDAIeuTvp7NHKpG7Fu6yVnfXilIGVvuqtzFJydipC8hshwH83
 65O7XGBUsn53omTBJ952Upep8+CnhOa6mXIqE4CEJN93yHx1zFIkX07bqs3q3COooaTbaZXbE
 lTE6qzQuFLT1m/lEQiAXjMupsjizE3X3XTbzZhqp/F2LTf45IdQpIBy7hFy9eAuwLZOzLJp2Q
 12R/2q3TTStgb+yCzjDpvVVsj7CTprcsWMRY6nZx9NwRM7J6xqaObcmGBs28xY5ygUlGdRXCd
 9oE4/9fw8Ue8cT1eZ1bTb1mVWEtiaq5ZcVCU6v7Ltrmmf2Or8rLFBtJ2UyZNDBDr298msOdR5
 K4BcvO76i/bngvGEFiWTxj8sdK9qwei2QwAuGj2R48EWP1bZpDPETjZt8kacD//GCCEAmh6iC
 xz5iRFh1Z/AveWu9e1PsCW81BjUjStcO+ZrnyVdpeSWgKzOVl54pTCIItvgRZXjs1ET+u67Wz
 bNwSgv2e1wzyQBgHSc4HV7Hnh6kKgdJ4aZYPTCypCVT/1cdDxM3JWTsheSs0wDatOxEh1TlTh
 QGgupdjbrcigIpPiXw8kdQQPaPjVmb4asSUE8gFYlJtZsdpayfJemSGh7LYBxKOFTyp4lJ7
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Commit d79864058a64 added a dedicated phony line for cscope.

Fixes: d79864058a64 ("Makefile: Add back TAGS/ctags/cscope rules")
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <159916246865.691541.16619858522304817323.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d6c5c9fdef1a..83bc40b255db 100644
--- a/Makefile
+++ b/Makefile
@@ -128,7 +128,7 @@ build.ninja: config-host.mak
 Makefile: ;
 configure: ;
 
-.PHONY: all clean cscope distclean install \
+.PHONY: all clean distclean install \
 	recurse-all dist msi FORCE
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
-- 
2.26.2


