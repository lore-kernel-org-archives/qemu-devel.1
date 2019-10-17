Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA7ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0C220872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU+Kioq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0C220872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9PN-0003jx-Lh
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91N-0001R5-Fo
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91M-0006gs-Hi
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91M-0006ga-BK; Thu, 17 Oct 2019 12:53:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id o18so3139020wrv.13;
 Thu, 17 Oct 2019 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KQeT1DkCT64ITk+vuTTSbwBhjZrtonMbDVqJGwi3dbY=;
 b=lU+Kioq4ig5Ep79BvqHNOeGG4QcQu8sDdrww3nIIX/yJ5mj6+6MnOigZYVUU3oOeP0
 so4cbVMiXRsddADWM0zrjc/7ElMke68NFrTdD47ShgXrdWOUhWzUPw0HYMSA2Tgg9Tuw
 F4f9zB4MH3KNFBIs1S4zCN/A6PV0eg2TF9XgzFKb6k4jQ4nteLjQQMaRTHUZ2ko8xMTo
 e92/zTzdfuiio0Q8XI9HRVzRDaFhBXdYyEjqstyNoNbBYnO24F1FczaG3zgr3/rro2Ci
 JYjuDuDTsmsCwVq057T8UI9u9rNRJEmoOc5d5+M94M2963SHIvWhD9QGhqtvy1Ki1vkM
 UgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KQeT1DkCT64ITk+vuTTSbwBhjZrtonMbDVqJGwi3dbY=;
 b=ilyCIoR/FsEj467nnuugqXjlliSwTQeVSs19HmqfM2Fdnn2cw/kxQM3vqN95QFdzvu
 YJVuyC5IDt8Sj/bbPsar8st3WSWZV8foPU+O44u6RUbzalpgnBXh8fM0l2vxwrWAIuA+
 OKpv+kNpTBScsWdJxgvlMFeM7vPppGq32l0D97IZzf+Fe+5PcOvdv2mEQxiP/IIdsku9
 +c04ylL4nAv5RJqQxhGEmC1jYVwCylurVNsnMH0QSehBLFpWT91eOBjhKIECJ81ybqsW
 j+eWTFCxvirk+kNfoFG1qNQd4D6nyucU6RHau7RGq0gDOZc1v7HT7QB4cb+N7i2PSrJu
 BDiw==
X-Gm-Message-State: APjAAAUJOrLv0rXkg7LEHzMqDfSucMp8pGRxX8Qs8aRWxIra4ibKGPkF
 88ei80gDWOIorkFXUcnD7WN/KUAwPaM=
X-Google-Smtp-Source: APXvYqwgDkqdzP7ilQb7bLZzKCHzwACTuShyO9/ltzXs6C3kwuiY5rto0iJ4Ef+YLcU0bqHWvLYiyQ==
X-Received: by 2002:adf:b1c6:: with SMTP id r6mr4073062wra.48.1571331183138;
 Thu, 17 Oct 2019 09:53:03 -0700 (PDT)
Received: from x1w.redhat.com (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id w22sm2557363wmc.16.2019.10.17.09.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:53:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] .travis.yml: Let the avocado job run the 40p tests
Date: Thu, 17 Oct 2019 18:52:39 +0200
Message-Id: <20191017165239.30159-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017165239.30159-1-f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9..69a37f7387 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -267,7 +267,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc64-softmmu,m68k-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu"
         - TEST_CMD="make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
-- 
2.21.0


