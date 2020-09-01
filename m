Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D734EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72AE206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72AE206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Cz-0002tF-Mf
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zS-0005mA-8o; Tue, 01 Sep 2020 10:10:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zO-0003wY-Od; Tue, 01 Sep 2020 10:10:25 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MoNy4-1kxTNF3wSW-00okWT; Tue, 01 Sep 2020 16:10:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 25/44] hw/ide/core: Trivial typo fix
Date: Tue,  1 Sep 2020 16:09:35 +0200
Message-Id: <20200901140954.889743-26-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pyw0ZMEU7SgQFHutlITOWvz+cr+9whX18HAoSlliGteLCv9PN8T
 kbvHU2RKMwLZPzhmEOwgSOnOHU6yk11YBWl2nIo3al5XL5Y6FsBdZyc658kIsPxZDYGWJsS
 R2j8kZcjBul7QUZDUSEX171jbO2/M5+ccFx4CA1TGmBEhq9XgEl3FUebAO5LL78005OGONG
 qy2XHqpzgqC0DvzBKqngA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oMPzd5tmRqc=:lByhKLSp9ibkziAngfx7Cp
 CJ7cJsOaPyLZZyB+fhYAU9MoVcV0Tsr60IMyl8wgjrAK/mvuTfgt8znOfVKw19lf7c3L8Kl/Z
 HUwFQdxKnd7ZC3od4nQWoELw8WV4gAdXdT7aomkotP23LFhO0oTzXErQysLvC3uuTDJbYw4nI
 VPz9Oq2xI0p8dt0smOehiwD/iuzUYMTF47zBLu3enH9qJZxfLsUM7ly+vxu0OZs4ftX9iYhXw
 5Fog0/YQtt3TvATmdARBA3bBTfjNsRERDDertulSDQC6qKknB+1BdkMmzdojBLwYknMkTuESe
 NOJsTjhaDUi7B7g3CkWxv/OIQQj2rYbYRPxgPGjVOT3nhu3eA4VCF8fXkzMRl+SuBt/ntIKRp
 lbJ0eKcnqg1gN3xYpQBeZnJv1MCdF+OORbILg9hp47souZygH1D29kp/yd5D93rfcl289ZdAl
 TjFVWl3b2I4QCyG7v8xOYvZBfQI7cJZkpIwXz3a4QS21NdaYWOt6mRpnqwty2KJLlC7+Sifrs
 FffHTXGjH76881GSSm3uvZmga/gHsfRBkXgkfeOhNuFldNOwJcA+AuaLkgV7Hsi+bfGZgmcB7
 oVLIiF/iLGJ02eqPKXaprUJrsB79y9lDx3S+IQGz5yUmBhS99bMT02AG+0GuqmjxNNHjY/ioN
 WR8fB4B+PWxK9fpoGm1JogAkEe0SOOO3Wo1lp9ixv3BKWSCM5SpkgoKZo8EKwc6eewciBwZ3X
 UutV8ulSs3T51Ag8J57PNBw2Pc93z8VEmLEjudZXYS3WyLPZIXZ+yw+cHJhs3QQX2FbeDv3S5
 qElKGz6ZlYHS7Lm3Tf95ujoI0k/QxCB05BxJLRQ8WfRRu4YfnSm03AZgwpfE1fmb8DmdA+a
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:10
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-trivial@nongnu.org,
 Li Qiang <liq3ea@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200814082841.27000-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d997a78e47fe..f76f7e5234bc 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -709,7 +709,7 @@ void ide_cancel_dma_sync(IDEState *s)
     /*
      * We can't cancel Scatter Gather DMA in the middle of the
      * operation or a partial (not full) DMA transfer would reach
-     * the storage so we wait for completion instead (we beahve
+     * the storage so we wait for completion instead (we behave
      * like if the DMA was completed by the time the guest trying
      * to cancel dma with bmdma_cmd_writeb with BM_CMD_START not
      * set).
-- 
2.26.2


