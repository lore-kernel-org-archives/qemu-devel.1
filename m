Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_MSGID_YAHOO,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89907C282E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E66F2085A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t7S8wtJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E66F2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUo4x-0000Pq-84
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 04:00:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hUo3k-0008LP-9n
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hUnxp-0000MJ-Vv
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:53:06 -0400
Received: from sonic306-46.consmr.mail.sg3.yahoo.com ([106.10.241.166]:42840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1hUnxp-0000Jr-HG
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1558857182; bh=UpAF+Bp0rIUtVnXVOisU6bkLam7XumHi/1u+zXHbgc8=;
	h=From:To:Cc:Subject:Date:From:Subject;
	b=t7S8wtJxYsx9Mnixx5mnr5zFR50ObV6YfCZt3GM+J5NSteproudFe6IZq+i8ZQb4Ti3aiSkcN7QqWvYgM5bKwMg+Cudxnmg2QOc5AXMVfzJensLo8fIMl7NdFoT+YqY9i8U5FwCkYAUQt6606doO7qEi/PvZlR9AxhUdnAQFod3VzNw1dRUCocujY/g7w3BAaLxRnVPt51ds+n2aeJeTxp+g8zluNr9QAXcMkDMmbNIkKXSFt/a347Pj2pLYSsYg3eHj75kSBfEDKrmBwMM5kS1PKNFcpv68x6maVdf9WWlBw+07Nd5ZgjY9VIgMMblpDx+y4Uokbk0oLjC41AdZaA==
X-YMail-OSG: 3HBsUhYVM1nIbH4P_qDpmfF8N62Ur6rbcGnwPRr6180ynbbH0KHiTdamVQiUKr4
	AVOJY6281u4Gj03hByxF9c13VjuJEQY4pZROk3FyGyAmBk_yvX0XzecvbimRYQhzj3n0bXhcFbNv
	oWEMS8xiZWiawlyjppxgDQaJ9fH6Ci.oNeP2enO5pexMN.45xrMVHZcu3GERB7sL1_FGLT49_ryn
	taCdaIC8dgtBZtDUjFQMxsOaLC.WfV2kf.7xI6QbgjEhFwJcs294lTep7Eb6zIzYhthoLzNmX4lm
	xolFZpggmfhhSOQb5A8mA9keR1LMAeeTzVVfyChHCDfyjGdodnLXIgVmBfmYsaOA5IOogaPHxt1W
	_6_tUoUO1j.0WvpAMB1JkBPFiEzECnvmX2Pxi7yUvgHXn8vlErVLd9OFWSKz3akJ50.sqmt8PTa.
	HFdS79F5W5CTAOU_Peu48cnnK5t3XosmnPvoodc5vJaohZMQNTvXA1nrH5er22emBz8C1x3fTxlo
	jCD1ST1NMRa8FwE_kAv27SW7vNM7JhRQxWLzCgOC0DYC_akFj7ws2GakFnp0D7D2gPhEWGUc83Or
	wTZqy8Pdn8eya.lvN7SO_l3AgobTqj5vClYtoCoVF_T2mIM7Sy2mU1ObIAx93owUJAo9e3od4i1a
	sZJs8PRNE1dIiuX9h7p.0KvNR6Mx7LmcOA4EJVP1poha9jD_CLRVshI9pMIe0rOIya9ceU1xbes7
	DQf7MZ3hZwsjgSqWwg3ICvTAO7UJmfPuUz8Q9.1NCPTdZnUZ76UEbnjd0ZE1yU8vT86xmF.m412m
	HekECmP.T0qSFQuqGdBd_QAcJX.VxzM42Sl6rj7EBWODPC7S37wGBdA.VK5T742zaVAWwnjiM2vG
	mkUCIyDQ3qq9G.9zPY.Rgw1wk2iZ6YL29Qrs3SthavxJHgil_aVxWpDKcwik_sHa8w_2E4dT7z9k
	UHD159PmPA7F9koRNu44B2.pW_YuNFkj1Sbl8fT6.wKCY14DgDh3m.ByWzgY4ws95DVkB9RmptnG
	UZsrUDR6jAg.2v8.L_Yuvwkj2TyVM_hGnlQEbpvOEL7mfzJjHPo87qeESjgnh9EIFdsTahZv47I9
	M9loILmPYQB.ZZsELXp3cjwvG5yzpEnB4.1HlGPYf7qajO_N36ojDxVdEf4337vafiQpO7P7Oi8u
	RauH8pzlVTf_JZRW25FG8CP4S.2ZIgXOWRZtS0DO0_tJ5m5lHB3KvnIHhM7KstuwkfxDvER71jGI
	d3LL.taKm.yw3nw2mcKEwbhPhMNEVIX5w_tgXlg.K1nHBdjUH9KMMtQVxqHjnfG90psyJ_GfvH5I
	-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic306.consmr.mail.sg3.yahoo.com with HTTP;
	Sun, 26 May 2019 07:53:02 +0000
Received: from pl35138.ag1212.nttpc.ne.jp (EHLO localhost.localdomain)
	([133.232.247.66])
	by smtp403.mail.sg3.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
	c6670c1054cd47402857e31956aff826; 
	Sun, 26 May 2019 07:51:01 +0000 (UTC)
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 16:50:56 +0900
Message-Id: <20190526075056.33865-1-lucienmp_antispam@yahoo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 106.10.241.166
Subject: [Qemu-devel] [PATCH] Regression for m68k causing Single-Step via
 GDB/RSP to not single step
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
From: Lucien Murray-Pitts via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	"Emilio G . Cota" <cota@braap.org>, lucienmp_antispam@yahoo.com,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A regression that was introduced, with the refactor to TranslatorOps,
drops two lines that update the PC when single-stepping is being performed.
( short commit 11ab74b )

This patch resolves that issue.

Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
---
 target/m68k/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f0534a4ba0..2922ea79c3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6130,6 +6130,8 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         return;
     }
     if (dc->base.singlestep_enabled) {
+        update_cc_op(dc);
+        tcg_gen_movi_i32(QREG_PC, dc->pc);
         gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
         return;
     }
-- 
2.21.0


