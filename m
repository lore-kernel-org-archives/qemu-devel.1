Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2564BC35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54592071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULx6S+wG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54592071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunNs-0008Ul-39
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 20:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunDB-00030K-FD
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunDA-00065g-Dq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunD6-00061E-Ri; Thu, 23 Jan 2020 19:52:36 -0500
Received: by mail-wr1-x442.google.com with SMTP id q6so57412wro.9;
 Thu, 23 Jan 2020 16:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j6DMDfLrdaIx79QPnoQNJaYSgOOf3qEa4OtSn+bluCc=;
 b=ULx6S+wGCmjSESlWs6gmzQIX+V2F62yLfRe/3qQhf8YRvNUTIBOItWN8MJfd22WNrW
 xVWdtTsApxjFxhjtVrHGVAryswGv/pYNHe/WNLFiRBIJECu5SUzcP4t/ZrhmqgVSscKp
 GcmczocFnWmO4nf5RuH1UgQ12DrtuAPxZWncS39DrzshtUt8avOtMTR4ZIqqHj96QLs4
 k+QJykgDv7l9cwqrgU9xBT6ETwOvIb9CXc5ZUOJjQomI6ab0Y+jmdqIRuvL6C5uTuBme
 g9HJQyjX5GlzFidlvp+zXwzeov864PT5+XDvqoq2nYGjg2XtPgblSjX5jVg35CF6Rl9k
 dwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=j6DMDfLrdaIx79QPnoQNJaYSgOOf3qEa4OtSn+bluCc=;
 b=hB4IIWBg8dWHbgHqYTG07mzgCxGLm4WXP4jG+XetoZVJghFi7LyyD/3vv5c+oj2Dm0
 Ds1Ad5Kb2ecddeP+P9iBE68g47e2brBEn1ilrXzkaPC97rMRhnXAQ3nhTPpI7G3aTi1T
 Alz+EiSOhgMdCOt8IRTF0Fj26v0HC7eZ0KMG3aj/KHrWHD9yspJfCHZ769PW/3X/OHTI
 sAayCenyVMu5lfW+Q5V9sLStKYxfT7LYBuevrR/alRF5zBt3P71crS8SzEXSZOWaktGK
 OORBSC8jhofDFwJYOE1B+hwtrHZLlhUHcvaDC6s3lJ8lxEQ7UKswlBWx7csfhQPcgOwh
 2V1w==
X-Gm-Message-State: APjAAAWbHm+dkFPoc+rxI+Rrd04r3BN6ph7l/fgELiYu9Z1vSsn+OvTt
 7prAQpjLXbvYIfOdqx+xIjd+Lqdb
X-Google-Smtp-Source: APXvYqwWW1nKM3gEIu9SgJn2JElMg7Tj14+yV79qCqaXRk/AEC4D1GXLwyQ6t4jqJnftrWshpZJnvQ==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr804024wrq.37.1579827151749;
 Thu, 23 Jan 2020 16:52:31 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 25/25] .travis.yml: Run the AVR acceptance tests
Date: Fri, 24 Jan 2020 01:51:31 +0100
Message-Id: <20200124005131.16276-26-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have one test so far, and it is very fast:

  $ avocado --show=app run -t arch:avr tests/acceptance/
  (1/1) tests/acceptance/machine_avr6.py:AVR6Machine.test_freertos: PASS (2.13 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 2.30 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200120220107.17825-19-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 6c1038a0f1..2301c9221e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -268,7 +268,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu,avr-softmmu"
         - TEST_CMD="make check-acceptance"
       after_script:
         - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-- 
2.21.1


