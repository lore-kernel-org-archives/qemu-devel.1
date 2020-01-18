Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257C4C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E537D2468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2jUqxi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E537D2468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istcD-0001wK-9b
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1istaE-0008Th-Fs
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1istaD-0001UI-CL
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:16:34 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1istaD-0001Tc-6Z; Sat, 18 Jan 2020 14:16:33 -0500
Received: by mail-wr1-x441.google.com with SMTP id j42so25681291wrj.12;
 Sat, 18 Jan 2020 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wj10eBNNliOseBoV3NfXic+RLhYYHXWcALJg05xTsWU=;
 b=V2jUqxi05t4BSeYoj6trfR6gTwh6MxcBoc6zIYpbGvoSLTWpOuNs5jekY1Z+C7A7mV
 OYFJvA2aLvq16COKHeI9sxLOHioLsjBXMsLPTHm/X+lulb1tJwbWf93kna3iVWhWc30n
 Zh4+wuTBfdO8AKAw2Q6fjsnex4MkxWwZxttzVMK6cTEeQ/+Zd4/7JYbm1mo3xfrAZ9gw
 4M7gMmsEX0COImb5aXEgPoOWH7Cr7Utw9kg/Vu/uy3r6ssC+tarLexaofqNs29k25iKy
 pK7acuaGOBC/JCTLFySOA829FOtzTzfki91ci+wv01mcMHAzkxsakFxNiot/XfP1hKsa
 OWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Wj10eBNNliOseBoV3NfXic+RLhYYHXWcALJg05xTsWU=;
 b=LBbyjjqfCdavH6GqAtLAdrlybpxBCMLH8Q0uyTmbSSHApeTN/YGkMOsrV4GKFeEJwf
 ZwrFKvowCy0ChBYou8gK0Xpl127ax0uOCEcnbLrLNvjM+o+arKQcxkVmqexBDU/nHNr3
 FkP2Z6UXrN9oalz7SdsoLZS21tGQsXMupKI68c36kNZ5lWP1o60STeWXBYE2lQ8SsJW+
 hF3mHIcgE2kAVrkDvMV0/MwPBPc4TekkB1J+uEh+IFatWnlimCfzwCGg4PJXyWQr/XyI
 Pkg6WZfSt6fyHsO52UjZmdotXfDkD9+so6kAf9DB/ti6fkJ+fwLA0/OG1Dfutvw1eb3W
 D/ng==
X-Gm-Message-State: APjAAAUm+ieSkNptp5tkydJVIVPARFaRUPqFCHr81DEfB9u5B6nJRszz
 9gaPAOOqf8269cIouqz+F583Awyx
X-Google-Smtp-Source: APXvYqyDxgWA6j4xBS1u4fbW08f3Al6ZIwrCyS4GyjjnIYEls4PheZajK9waS6cCTsRG22517ZzPXw==
X-Received: by 2002:adf:d184:: with SMTP id v4mr9755024wrc.76.1579374991986;
 Sat, 18 Jan 2020 11:16:31 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z11sm41339690wrt.82.2020.01.18.11.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 11:16:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 4/4] .travis.yml: Allow untrusted code and large files
Date: Sat, 18 Jan 2020 20:16:23 +0100
Message-Id: <20200118191623.32549-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200118191623.32549-1-f4bug@amsat.org>
References: <20200118191623.32549-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As Travis CI runs our tests in a disposable environment, we don't
care much if the binaries are trusted. The more we test the better.

Also, as of this commmit, the smallest available announced [1] is
"approx 18GB", plenty of space to run our acceptance tests.

Enable the proper environment variables to allow Avocado download
from untrusted sources, and to download large files.

Note: As of this commit, all our tests "Ran for 17 min 7 sec"
before succeeding, see [2].

[1] https://docs.travis-ci.com/user/reference/overview/#virtualisation-environment-vs-operating-system
[2] https://travis-ci.org/philmd/qemu/jobs/638823612#L3817

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 638fba4799..b8b9df65a6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -260,6 +260,8 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
+        - AVOCADO_ALLOW_LARGE_STORAGE="yes"
+        - AVOCADO_ALLOW_UNTRUSTED_CODE="sure"
         - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD="make check-acceptance"
       after_failure:
-- 
2.21.1


