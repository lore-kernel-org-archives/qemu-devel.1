Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DB8C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B40C20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYHsbDOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B40C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54079 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQeXs-0001Rk-EB
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:01:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV3-0007lo-IS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIj-0007Yw-MZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:30 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeIj-0007Tz-4H
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:29 -0400
Received: by mail-lj1-x243.google.com with SMTP id 14so501763ljj.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wQy3/F5joNergsR/ABXk05EEEem/roqnfLo8tHgTfa8=;
	b=aYHsbDOpRKkHD1//NPrG1MNWmGTXj4BQKpBZ5pmGn10shL69RFedWr+h1TT5qApvVP
	3RLXY2/mNS4pAkNPf6Qr38+H9TU0OvJyZJm8LmsHibCRTgybKqwtxTKyf7Navx74PaPG
	DeTxF7CAGxNw5ZAR92oO/9gT1hN1C3H444BLnqBJWnFozmeEGX1euzxtm+bQYCa8FrbV
	IH6PPeskuSoPpE+sg4bB/Eu3g2rnvzjCqaI85eWKzgwOzjDlnh401JsQmnP597Odt1Z+
	CIBDQa1L3xmyoKRKucL4CurLzwcXX7ga7KZE1xkLSEDEHRU5hV0Jnb2aDAUtkdMW5Trf
	yMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=wQy3/F5joNergsR/ABXk05EEEem/roqnfLo8tHgTfa8=;
	b=HzbpzzCMYmnPdRg5CmKOC6EssmS6/yRYc6BdiY3tN3AX4H402SatGZZUgbKlL0hW0X
	zpKlfCVD0iOmhtqsqQKe42Xo3l2M4TXM9S8Bhev/VDweOcP4REuV0it92a8TAZ1uoa4C
	Ke5bkiyO1rYZ+yDyAb3Sq26RrTZJBQydk3oUJilhpscXxR+eot1F8BfPm6y5EVlu2SHx
	Y+/oBIVOu7Seh4OnbK1AASoXv/EOM0w8EnKxx+FErtEguq1i7qBfEOIPjUkC2KBDSWMF
	/TvIdgFVwk9aCyNFjV8XKcFc7wzKzdrpbPNOyuPOx24VIPyhccb6pKWWaBrxFbKEPskB
	rVEw==
X-Gm-Message-State: APjAAAUKwdHROhON031pslrn8hRjW8skXbWtu2sXKPMebwyMijBdda6b
	Z5TZj78QhwLA8J+l9YWmNIG57fsUsdg=
X-Google-Smtp-Source: APXvYqyCHAmIqOFxvd/ykkIeYJDB2r+CsqKeDCyY6UBlgdSkd0IuS5vOISQHUwxqk23b4J3FbOppag==
X-Received: by 2002:a2e:9ada:: with SMTP id p26mr17592870ljj.167.1557866722717;
	Tue, 14 May 2019 13:45:22 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:22 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:45 -0700
Message-Id: <20190514204447.17486-8-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: [Qemu-devel] [PATCH 7/9] target/xtensa: implement block prefetch
 option opcodes
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Block prefetch option adds a bunch of non-privileged opcodes that may be
implemented as nops since QEMU doesn't model caches.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 24eb70d619d5..356eb9948701 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3078,6 +3078,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_dcache,
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "dhi.b",
+        .translate = translate_nop,
+    }, {
         .name = "dhu",
         .translate = translate_dcache,
         .op_flags = XTENSA_OP_PRIVILEGED,
@@ -3085,9 +3088,15 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "dhwb",
         .translate = translate_dcache,
     }, {
+        .name = "dhwb.b",
+        .translate = translate_nop,
+    }, {
         .name = "dhwbi",
         .translate = translate_dcache,
     }, {
+        .name = "dhwbi.b",
+        .translate = translate_nop,
+    }, {
         .name = "dii",
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
@@ -3112,15 +3121,33 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_dcache,
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "dpfm.b",
+        .translate = translate_nop,
+    }, {
+        .name = "dpfm.bf",
+        .translate = translate_nop,
+    }, {
         .name = "dpfr",
         .translate = translate_nop,
     }, {
+        .name = "dpfr.b",
+        .translate = translate_nop,
+    }, {
+        .name = "dpfr.bf",
+        .translate = translate_nop,
+    }, {
         .name = "dpfro",
         .translate = translate_nop,
     }, {
         .name = "dpfw",
         .translate = translate_nop,
     }, {
+        .name = "dpfw.b",
+        .translate = translate_nop,
+    }, {
+        .name = "dpfw.bf",
+        .translate = translate_nop,
+    }, {
         .name = "dpfwo",
         .translate = translate_nop,
     }, {
@@ -3628,6 +3655,21 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){true},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "pfend.a",
+        .translate = translate_nop,
+    }, {
+        .name = "pfend.o",
+        .translate = translate_nop,
+    }, {
+        .name = "pfnxt.f",
+        .translate = translate_nop,
+    }, {
+        .name = "pfwait.a",
+        .translate = translate_nop,
+    }, {
+        .name = "pfwait.o",
+        .translate = translate_nop,
+    }, {
         .name = "pitlb",
         .translate = translate_ptlb,
         .par = (const uint32_t[]){false},
-- 
2.11.0


