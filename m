Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7887CC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4252720714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0rw3WYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4252720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItJS-0000hs-EO
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jItIc-0008I0-8C
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jItIb-0001VE-25
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:13:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jItIa-0001SJ-Q1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:13:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id u10so21307695wro.7
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 05:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i+My85ICmy0qF0DEe3a9VMg2W1L8PvAxyzPBdac6GnA=;
 b=A0rw3WYKOrdFyuEoCSDmXH/9kTkR4geTJc5CSCX0hRJ403uvPk41pzVC7lFLhpK+dj
 eylInfM7snt2gafEUNIoVB/sGqWPFV6cQVcH3VXt1R4NR29de2katk6qZMte9rAZGFj3
 8UvVVy7sfycGD48yHS5P0FEgy9sMgXkYRLneH8Pp/AZ8yOdeN5hcfU0G5ww8+cf4KO+J
 fQkqi4ZzPKKEEqUFj7j8vifdmAAUkvZPY2dTQyzE+4f4KDzXWaC4GSkN0lLbbDBkMQpE
 wwRd33fP3gHPE0GeRm2TfvbbEsZuPNqxDhbMmdDe7OwrI39aEP/CcjSbaEFFthi2zHtV
 lYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=i+My85ICmy0qF0DEe3a9VMg2W1L8PvAxyzPBdac6GnA=;
 b=iHwk0Jazwr1rmwBP5fpHMwn6OM47ypc+Lilhb0hcnlSrAh0jhcW56+dtgxyxKW1ieG
 lXsu8v4r1e2l8oCijXSsfFo4E0z4wBglj1QYOUUZICKIXGbgtimm/u1zjPKvLNcfkoJH
 fYmBV677WsoxWDN9ITm8Q0F5BE9UQ7OuWQwpqacI1XgF0cvpdNfJr6bOlz9xzgLFHRBG
 t/FdwjjVOXB7EypF+NIbciI6+VOIsmPmblFGepQo2Sp5YwOJK7nlsVt7UTsTCyJtN3eE
 QREbv8n0jVs1vGekwcPdQp59u7Xq0jN6yaYzbZzjeLj8g47qSkc+TTPHom6O4fEaBlxi
 UmIg==
X-Gm-Message-State: ANhLgQ3iHxfOR6tpeTrxHAC9WeisaoSyeTHRURtL3Xa5wC0Pw5cYZ7Lv
 VNyQAZbxcFaZ+MUBpm0FaJMEHVOrST4=
X-Google-Smtp-Source: ADFU+vsgd08iSXkkGxjrRHGV9E83sYcBQgvij2oPHVIsjdiUIgOgE3kvIDlwnp80AC8thC1AQfg8gQ==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr14567087wrc.294.1585570427055; 
 Mon, 30 Mar 2020 05:13:47 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k3sm22748384wrw.61.2020.03.30.05.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 05:13:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0?] decodetree: Use Python3 floor division operator
Date: Mon, 30 Mar 2020 14:13:45 +0200
Message-Id: <20200330121345.14665-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script started using Python2, where the 'classic' division
operator returns the floor result. In commit 3d004a371 we started
to use Python3, where the division operator returns the float
result ('true division').
To keep the same behavior, use the 'floor division' operator "//"
which returns the floor result.

Fixes: 3d004a371
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
We didn't notice it because only the RX port (which uses the
--varinsnwidth option, and got merged very recently) triggers
these problems.
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/decodetree.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 2a8f2b6e06..46ab917807 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1025,7 +1025,7 @@ def output_code(self, i, extracted, outerbits, outermask):
         if extracted < self.width:
             output(ind, 'insn = ', decode_function,
                    '_load_bytes(ctx, insn, {0}, {1});\n'
-                   .format(extracted / 8, self.width / 8));
+                   .format(extracted // 8, self.width // 8));
             extracted = self.width
 
         # Attempt to aid the compiler in producing compact switch statements.
@@ -1079,7 +1079,7 @@ def output_code(self, i, extracted, outerbits, outermask):
         if extracted < self.width:
             output(ind, 'insn = ', decode_function,
                    '_load_bytes(ctx, insn, {0}, {1});\n'
-                   .format(extracted / 8, self.width / 8));
+                   .format(extracted // 8, self.width // 8));
             extracted = self.width
         output(ind, 'return insn;\n')
 # end SizeLeaf
-- 
2.21.1


