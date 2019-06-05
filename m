Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF72C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6152A206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6152A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPFk-0007an-8g
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:18:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYPER-0006zY-Lh
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYPEQ-0006i7-8A
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1hYPEK-0006GU-1i
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:01 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1M4s8v-1hWTbU2tsd-0021jG; Wed, 05 Jun 2019 08:11:43 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 08:11:26 +0200
Message-Id: <20190605061126.10244-6-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190605061126.10244-1-david.brenken@efs-auto.org>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:s2njwR6oGYM7fGhSjh80tDAupNymw4DP6+GnNZpG0A7q5SNgqPj
	Q1gVWae9o/A7SJ31cnFcoecHcin5aihR4j3o078Ly7TixR/ICeO3EutQeZtbxonhOSq1Es4
	tGp06Zxxqi4KuqRru6NNxBEA8qbM5Rd8HyTHmZq9O0j+ACW4gaBZzVtzKXg/sNuzwhrKYWb
	IIEJgaWNB62J7mMOodknw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ld+D5SrsS4k=:p0eqtS5xeRNe+HXDjw7a1U
	m8P3t9rVoTs1EeLnjZxBUgRdTh6JhMFEkSLauZI07mpK9HgI3tYuzuJtCsbYy45DRzETXfKQg
	4undPE/jYcQuvjhgSV9dw8DlTjNoaNXMESsQRvko3p9R8DC6LMwQ6jJ7b0WkLH4J7XcJPPdB7
	x26clWd2pewigBZ9UcxSHdhDC0Flneq+voW7pWrx2E7BArfDkJn4D0TloKVueF4v+BDpk3hEJ
	zhOCmU+FWQZR7wfOY+y/SLfgI/9/U6YkiCc+qtBs03/Nk9GACUUnwmN+OANze8/sbuQ1vE8jT
	rijcFWSgCYQAmZOv8Xw9rxdvPA3ZCLEqSULFgbOU2oyDKq0TfJSb0TzU7TIK3urCdrjan4qRN
	K+ecYccU658L4d2ZWKXLT7iGKJmaiGNn4G+crvTnqOz/pytNmOM9+YoRzPvrrSmnZxyK6oyHS
	gGFSfrlwu5cFDCXcYx9zzAreitEH6jlBN10xH3l6YcRx4wXeEpZ9BmBypyv4wigyn13y81exv
	2ZXFWbyXpCsdXj1mNHuF6wgFqtB/bJty5K6kXm7LhKDkejS4bJfzwtUbaBSLapPQ/ARIfwwhg
	dE/JgvO5NaDuXxAszwIsE+cr3RF8JOhiVjvasDAjqNOOJRo5bGcyP3OaWopGfO7PqrkhUEm+B
	88I/FVcQSJ6NgJU67JGeuMPDtC3+D+h6XhXu8n54tmhf5E+TYh5ZPtE2/OfVHayo/fD9hySbQ
	vr3xQIuP6E3wYq24kv07gvTALUmhZvmjYkpb+Nn5aN8IFfGP1XpSF8+WSI4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PATCH 5/5] tricore: reset DisasContext before
 generating code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kbastian@mail.uni-paderborn.de,
	Lars Biermanski <lars.biermanski@efs-auto.de>,
	Georg Hofstetter <georg.hofstetter@efs-auto.de>,
	David Brenken <david.brenken@efs-auto.de>,
	Robert Rasche <robert.rasche@efs-auto.de>,
	Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Georg Hofstetter <georg.hofstetter@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>

---
 target/tricore/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index db09f82c31..cdbc00d654 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8811,6 +8811,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     target_ulong pc_start;
     int num_insns = 0;
 
+    memset(&ctx, 0x00, sizeof(DisasContext));
     pc_start = tb->pc;
     ctx.pc = pc_start;
     ctx.saved_pc = -1;
-- 
2.17.1


