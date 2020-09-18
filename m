Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E596C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0085208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr0pU5PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0085208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHTH-0003BE-Kx
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJHSa-0002Lq-Uj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:34:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJHSZ-0002hH-4P
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:34:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so5890840wrn.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M68lIylRXpevc32y6J6mQmRu2ewIfMOpEuSHDTkUsYk=;
 b=Wr0pU5PSCZzrmZVgfFYZcIMC3L1QSW6QfRODpKQqit5R4aSuab0JFkfEoe5bhry6fC
 VRSA+jv3VY7z0SSGoPPoyupI4SEQputhGuNFEf4Xs5lzgaEklDE3FP14btyL5wDbFBeY
 OZOPCBitRRxR4E8CJowvUIF100hZFDnlyUrVoyQ9arNMusygsEVSM7asGaSyB3Hddw+b
 B6+3Kj8gAJ2CKksWqReqvKCw6j6cbehbpGS/rXbO90zBOcDVCQyuEG0mddmNXT1gyqEH
 iEnmr3TL6MAVK5fCmV2Scm2HbIJIS8RAheO1LDEG+1iMMfp/EVCLWanw66Ks5OTXBRI4
 U5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=M68lIylRXpevc32y6J6mQmRu2ewIfMOpEuSHDTkUsYk=;
 b=rTV84Vz3TmIF5cAs/1Jzc92A2JXCnG2HmPb7CRc5rueYuRo4edWgjiKUCB0qj1NaCj
 IDXXFihKlkaWHtItYIyWMHBXfOBgsZJzxzv5MP2hT20kHnERIIYHNG875maf9MeZB/ao
 CvxnilqeJ2MPVcG2KWCr3PU/0aB9Agt/AbLnJVUyafcgW2MwzFEm/41fVX07+ilo7skB
 3NvOtkMDxiSYbhQ3gE31JXf0otGviFDio4fbIGREUAUl+a8QsjqhW680ASJ6/60HeZ+N
 /rxMejvMLta0SqMgp1CSu38q9CwblYbzckyzN6x65PalbZZQ0lR9Xuy3AxSqSBE7Fca2
 MFrQ==
X-Gm-Message-State: AOAM5317xFm5Azc6FnXf1f9LTolpz2i1a+r1edDFh39tQaHlt7YL+Mjg
 D7t5cvuFMy+g6CzMprEoSAIwSR6rMwA=
X-Google-Smtp-Source: ABdhPJzkAFlUvjcDyaH8qw8BGyMoHmKg55nDoYz1bWAt/mGLAMTKzvrKFXYmW9kTrz1w0xaeMDb5Bw==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr39559732wrn.2.1600439637038;
 Fri, 18 Sep 2020 07:33:57 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u17sm5325013wmm.4.2020.09.18.07.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 07:33:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] tests/acceptance: Skip slow quanta-gsj U-boot+Linux test
Date: Fri, 18 Sep 2020 16:33:55 +0200
Message-Id: <20200918143355.153522-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'arm_quanta_gsj_initrd' test is timeouting on GitLab CI:
https://gitlab.com/philmd/qemu/-/jobs/745483978#L846
and also sometimes on my workstation, so proceed as with
the other slow tests: do not run it by default.
The test can still be run setting the AVOCADO_TIMEOUT_EXPECTED
environment variable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Supersedes: <20200918142344.150749-1-f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 4a366ce93e4..9b58f6f9003 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -568,6 +568,7 @@ def test_arm_cubieboard_sata(self):
                                                 'sda')
         # cubieboard's reboot is not functioning; omit reboot test.
 
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_arm_quanta_gsj(self):
         """
         :avocado: tags=arch:arm
-- 
2.26.2


