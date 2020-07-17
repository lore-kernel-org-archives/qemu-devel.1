Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1350C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF8F20734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki78wHn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF8F20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQaH-0006gh-Ry
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwQZi-0006F0-Ju; Fri, 17 Jul 2020 09:38:54 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwQZf-000884-Ue; Fri, 17 Jul 2020 09:38:54 -0400
Received: by mail-ed1-x541.google.com with SMTP id d18so7711791edv.6;
 Fri, 17 Jul 2020 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dqtqq4r7Ge1UjcYxuCx+TmgiC37E+REjTrnpxMHrirE=;
 b=ki78wHn8m6TT6jcvcQUOdJpP666Ytuto/Y4Dnb9f9k7eNYwATqIsFLMOoJ8pKPBbWs
 x4J6IkBB6UnEFfRWALxeaDEQ2/fPbnWzR5gEUOVVJs/e2H/tk90nOgiEGFRtzXnt9y7A
 JlWG2CJfmuVb2FGeH2KxwUml4d7B5gf0kSjXiJvKxDbrUEbhpyAyl8Xw9TZoWEsTaOAo
 U5nMIenBzz0g6u2xRwphBrTFMzP2iEFQw4ilikd+/EezM1NKw+HrlGNBschPRqRYz9sM
 VKGtdLylv7crsA6xGgRxOS0EkucGO03Tjt4qSsD2v9uvnq0I/2CHw7ap+5iS8j2XYGcl
 iSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=dqtqq4r7Ge1UjcYxuCx+TmgiC37E+REjTrnpxMHrirE=;
 b=UaX/UVON0MWZKxPbnhfq3c4gI5pyyrttWsehlKnJT5AO69YqaCAXty4L6+0rpxPUKg
 RnHIS/L/5/TqXiGVtHyoTisyzY7yNi991fdPF5tdZCZiy9CYvKzEM8MZCpg9Cvohd57b
 jOKGCD7mJqNF+DQOXAuQ/QW0PqftvcBHER57S05QcBFNsBH6ria7FJmqMigd9aZFShfg
 kovD/uXzi6XQCHN1oaqMEWKFg9sHp33DrgdSkdUNPqwnhF9JXYtSIYGxkromDQtObTEq
 8S8VWJcHRTrQ9UwAHYq+speRokwokWn5J8P0wC9uPvY8ske7wsZFw4tykt/zgOaUUR2F
 Imvw==
X-Gm-Message-State: AOAM5322BNGbumbO1oeuqwQXzEy3pLviq8AMFFwvHzWBB3djLx/sKtXG
 AKyxgT6s50jtWYaRnssdhZBnPR8TG0U=
X-Google-Smtp-Source: ABdhPJzJ4wZeCpM7rxoTBHi1U9X0z+1t7Q+7S4BDt/qRikLtIHGKr8XfBylqAyZy5qrRkuiInZGhyA==
X-Received: by 2002:a05:6402:1ef:: with SMTP id
 i15mr9287467edy.378.1594993129184; 
 Fri, 17 Jul 2020 06:38:49 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s24sm7898764ejv.110.2020.07.17.06.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 06:38:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1 v2] hw/ide: Avoid #DIV/0! FPU exception by setting
 CD-ROM sector count
Date: Fri, 17 Jul 2020 15:38:47 +0200
Message-Id: <20200717133847.10974-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer found an undefined behavior (#DIV/0!) in ide_set_sector()
when using a CD-ROM (reproducer available on the BugLink):

  UndefinedBehaviorSanitizer:DEADLYSIGNAL
  ==12163==ERROR: UndefinedBehaviorSanitizer: FPE on unknown address 0x5616279cffdc (pc 0x5616279cffdc bp 0x7ffcdaabae90 sp 0x7ffcdaabae30 T12163)

Fix by initializing the CD-ROM number of sectors in ide_dev_initfn().

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: b2df431407 ("ide scsi: Mess with geometry only for hard disk devices")
BugLink: https://bugs.launchpad.net/qemu/+bug/1887309
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1:
- Allow zero-sized drive images (not sure why we need them)
  but display a friendly message that this is unsupported

Unrelated but interesting:
http://www.physics.udel.edu/~watson/scen103/cdsoln.html
---
 hw/ide/qdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 27ff1f7f66..005d73bdb9 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -201,6 +201,15 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
                               errp)) {
             return;
         }
+    } else {
+        uint64_t nb_sectors;
+
+        blk_get_geometry(dev->conf.blk, &nb_sectors);
+        if (!nb_sectors) {
+            warn_report("Drive image of size zero is unsupported for 'ide-cd', "
+                        "use at your own risk ¯\\_(ツ)_/¯");
+        }
+        dev->conf.secs = nb_sectors;
     }
     if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
                                        kind != IDE_CD, errp)) {
-- 
2.21.3


