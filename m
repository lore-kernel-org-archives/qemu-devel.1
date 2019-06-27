Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C4C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA3F20656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKyOY0DJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA3F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSQU-0002f2-67
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56554)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBz-0008JJ-7u
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBZ-0007zw-IX
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBZ-0007zD-68
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id c2so2027669wrm.8
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y/CPp9JInA7ANrmnXt8PbvRHB7xkvV1DBO+/ASdQwCo=;
 b=GKyOY0DJ9xDNbo5MIaV5vJVkLpheK6nzbOCDnGqsi/CQmSLir8KI14kGFa3K1huASC
 LUZyOFdksrAM9NPwc24xDLf3JfJJ9WGrRe/E7WFStwsRfWZheFlFiMfquaAZE5kiRDNh
 Ho6RGJ/5XrplGs/X0CbPoqvitoJUttzadq2pGQ8RmQShjDVoedyXXbdSW8fKkLJ9mAh+
 7OE/Eeaa+hT7TCKy/1xjD24uTL5geFBTVrR/ey4R/rhhQWQNYgd2xcFtJAQkRCRrXNQW
 3tP1qa5oasEG0KC7cW+RWdk5LwQUmVtXoJC0iNoXVg1ou3j4opmoyra0T303LTiC+3OX
 Plqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Y/CPp9JInA7ANrmnXt8PbvRHB7xkvV1DBO+/ASdQwCo=;
 b=b5U/VPmle+v1295R7fCsUvixe8R3sXx0MavHF59+Zm7YeN/5jktrKEtGDRRRq4tFll
 wH1GB1Z5YxspDHNlnUhGbA0Fl42mmwLO4JZV0Y3ww8QtCIyMGkGcJisPdlbKrvKj7+F5
 klbssFIrAmQVB26mddIkRePXzvjP/aIRMNWGX9aM3OGbexv1wMbOQC83pNAhd6IwgD0t
 nrJQ9eOG9D0yc3xEtSr6g8s2ifcsZfYGlmp6//D4ah5woNrm7F6Jh7MV12Nt8MKMi5cW
 7JpYew75klnzb3wlMDUKmLSVpnmKanbQCzQTQy9Ps65r0IdR6vJwhFESnfMIxeN2a/8/
 nGqA==
X-Gm-Message-State: APjAAAUI7NO4rxM2JxmV3Wkido1vt2irr+jImVNE3D/aOJKvNaZf+l+c
 tJJai4X1GeR7QLl7ULg2jnScp2+P
X-Google-Smtp-Source: APXvYqwV10Vgdf0DKbe8m6Ji1B5JT+Olm2Ei1ugyjJqX+CwD/ZIpqPOMYfwnMMoZ/Du6mMUXT0gUWQ==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr2876781wre.248.1561633403981; 
 Thu, 27 Jun 2019 04:03:23 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y18sm6368968wmi.23.2019.06.27.04.03.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 04:03:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 13:02:01 +0200
Message-Id: <20190627110201.1999-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627110201.1999-1-f4bug@amsat.org>
References: <20190627110201.1999-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 5/5] .travis.yml: Let the avocado job run the
 40p tests
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
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
If this list continues to grow we can
- split it (as other jobs)
- move them to GitLab where we can have multi-stage jobs,
  avocado tests run on top of build jobs.
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index aeb9b211cd..acebf0af1f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -231,7 +231,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu"
         - TEST_CMD="make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
-- 
2.19.1


