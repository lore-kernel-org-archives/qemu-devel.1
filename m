Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0E8C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD32206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7cf3Tpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD32206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J1K-00006G-D4
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijq-0000jk-Dq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijn-00030G-Vs
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijn-0002tL-Nt
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:19 -0500
Received: by mail-wm1-x330.google.com with SMTP id a9so7778035wmj.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2dmYuTKXtlDf7qo2rxYhEFkrRnpA4jjhd2faKlrwZ8Q=;
 b=M7cf3Tpv0TbiH4jAA+mpprfGsTBqeF2jucRhoLItmQLYJ1e3E1dPU88k7KejoRx/ra
 1fJ6Civlw2zODEJi4/LuZVyZsDFgvKeCUqSyiPON+ENzA3oRLL7YPOI3ojAuzbb5S1Z7
 yCKrShgHT9D1LCmN1K59r2vKKtinH26w4ZxOtErn+zggkkWLojvJLUrtzUpPN+Y8AsHj
 jbm+BOs9vE1i1YB2mAY1KemkNKKIe8tKfyucLTHWFIpjObBiGblN9bXDs8tYiKg18mZX
 Z10vVmnA/8rIRt8dGyjjSgVEtGB4O4S9sqazEm72TWGWQkrPAx3AGICOaA7dZYRetRkC
 3dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2dmYuTKXtlDf7qo2rxYhEFkrRnpA4jjhd2faKlrwZ8Q=;
 b=ODljdvD//Ral6ymXKQp+REeV78bKeSy6NiLl4Z6FCH2H2gEvAhceCN5CWDUV5p4uc3
 wSQerG+ShPln++Ifg2jGma5VHXn8Yv2Dgb2Seop1X3DEmcVbFzyTJli1dujtn4gdmdpT
 vth2S7uRj966M8o6KKujt2MfO9vvWQJGM2Q6+8sETWVXHY4vzJsP41S4B21vggUj5Ws9
 tIXMLKnqCVw5fK6+dqWQRJ0jVHyS5E+Xyp3zNdCjETVzk6NFiPLNmA0Q4Ote623aqVuy
 9qIl+RZwZ+iBZDP3f3i104z00x7KJe7pfpjuLrvbxGph0rDmuCVrnDnN0KGJHujhhqI3
 eabA==
X-Gm-Message-State: APjAAAUeJ+XmtR5bYwkZaC4HonWSIXidjkP7x2G7BwAYo1VQE3BKHYfy
 YZa/gzfrvIRWep0YTkBGXvILXuy30/g=
X-Google-Smtp-Source: APXvYqz0AHlryDTdfJc6gV0fixv8cb8f0deB/gXf6AdXh/o6vFiiNNOFJi4scSCnnAAr7mZJfEolDg==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr6835616wmb.81.1581616634400;
 Thu, 13 Feb 2020 09:57:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/30] qapi/migration.json: Replace _this_ with *this*
Date: Thu, 13 Feb 2020 17:56:34 +0000
Message-Id: <20200213175647.17628-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MigrationInfo::setup-time documentation is the only place where
we use _this_ inline markup for emphasis, commonly rendered in
italics.  rST doesn't recognize that markup and emits literal
underscores.

Switch to *this* instead.  Changes markup to strong emphasis with
Texinfo, commonly rendered as bold.  With rST, it will go right back
to emphasis / italics.

rST also uses **this** for strong (commonly rendered bold) where
Texinfo uses *this*. We have one place in the doc comments
which uses strong/bold markup, in qapi/introspect.json:
    Note: the QAPI schema is also used to help define *internal*

When we switch to rST that will be rendered as emphasis / italics.
Markus (who wrote that) thinks that using emphasis / italics
there is an improvement, so we leave that markup alone.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
v1->v2: updated commit message. Paras 1 and 2 are from Markus;
paras 3 and 4 are new, and mention a non-change agreed in
the thread off the cover letter of the v1 patch series.
---
 qapi/migration.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 11033b7a8e6..52f34299698 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -178,8 +178,8 @@
 #                     expected downtime in milliseconds for the guest in last walk
 #                     of the dirty bitmap. (since 1.3)
 #
-# @setup-time: amount of setup time in milliseconds _before_ the
-#              iterations begin but _after_ the QMP command is issued. This is designed
+# @setup-time: amount of setup time in milliseconds *before* the
+#              iterations begin but *after* the QMP command is issued. This is designed
 #              to provide an accounting of any activities (such as RDMA pinning) which
 #              may be expensive, but do not actually occur during the iterative
 #              migration rounds themselves. (since 1.6)
-- 
2.20.1


