Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DEBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 18:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CDA20716
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJtvvjjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CDA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivQOc-0000uU-Tc
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 13:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQO0-0000V8-UF
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQNz-0004sa-QQ
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:42:24 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQNz-0004qz-KZ
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:42:23 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so5963187wro.9
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 10:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bnV/kBvVuxIQp3fLihplwxvS4FLN5o1zNqNif+o/mvw=;
 b=kJtvvjjjUd2FF9nBMEwslAiseaL+Gejnq6ofxWuc14tsPmyz9pqoPJCGS9Pbe/ieSr
 CFtQq7OIstDZ9jE1ze032/eZeQxJ8zmew6mFEg02jwfcEtrqmAvdS2pJI9m0IJXnCTXf
 83p4WJ0l3PcGn6jib/bUKny5tNXLyvXikuO6+DY0+J3flNJ2RwUZDHEckHZQH0VCUm7R
 zImSTlIuvmhikSdbxc3HBn86hwTL7eOke61G36tSi1zJD0o3n1jxp68CEUUeKnUDu2hY
 EWMRGcqVgt82tRqIlUpZRJ4epk6LxgnWrEAApkjhFW9rjcVobQ//LwowNyHG0YN3UNMb
 rGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=bnV/kBvVuxIQp3fLihplwxvS4FLN5o1zNqNif+o/mvw=;
 b=KDGAi7DlPUkgQ7SYqsYuXZFxKCHeGRu6BZGfwpFSq9Oc81FSN+w5qjCalnRP5+5nHN
 YCUYYKszntaMd95lgqocZQrbzd94dfS7GgPctu1D3W2fq2R5AOA6oqsw+iw1njt2h4mp
 JM79xVA5hsrUUsZ+JOxhXrgGT5Y2wtiHZw7PuwDkxhrSEjn4gCMFT8QylzeL0gC5ZfyF
 xfGj8RVfwcOVIiohjhfA5no2z8N10hmDX/F5dx/qOWSEM41XSlGxRXp79Dh18pZckiWA
 XE3nMe7hnIdTg0tg0pdsavxOoTN/gQ+PoM4LYufCRZJ32f2z+Et91NUgCp9HtIj977+S
 8Pwg==
X-Gm-Message-State: APjAAAXLR9xob8ig4FzkmmK+ex+70lQTQ+MzVrdnJch0lLd80XdZ1ylB
 MgbQUxLV54JMAdXnhX7tBFaLPvjF
X-Google-Smtp-Source: APXvYqxO4eYvMRtd2SfZqO/fUUE8aeY6dzVRXuaLnqgrGP5Q12olqp20kx1EsNOHXMJX3N18Vacsqw==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr11906645wrx.288.1579977741706; 
 Sat, 25 Jan 2020 10:42:21 -0800 (PST)
Received: from localhost.localdomain
 (113.red-83-57-172.dynamicip.rima-tde.net. [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id y20sm3266258wmj.23.2020.01.25.10.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2020 10:42:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: Drop superfluous use of --python=python3
 parameter
Date: Sat, 25 Jan 2020 19:42:17 +0100
Message-Id: <20200125184217.30034-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we require Python3 since commit ddf9069963, we don't need to
explicit it with the --python=/usr/bin/python3 configure option.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 6c1038a0f1..ee93180283 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -268,7 +268,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
+        - CONFIG="--target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD="make check-acceptance"
       after_script:
         - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-- 
2.21.1


