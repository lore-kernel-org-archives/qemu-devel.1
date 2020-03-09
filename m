Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C575C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007EC20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xISKCMDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007EC20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOwr-0003aE-3d
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvw-0001wH-M2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvv-0005BP-Kv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:28 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBOvv-0005Az-FA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id a132so956475wme.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MUtXuY++HJCf6YAR3b18aJ7DI0jQE6PA6a/VAxt1sw0=;
 b=xISKCMDTTXi/uzKuRaIgRkM/LuB0rPgjK8s8K2jPkJizeESg+VXXF+Z+k2wBoBSnWi
 az2oGnXIWucmRcEz0yqPoS5E+1UOW09D7B5DK11DjAQkSbXCzUwsx6yBD+FFvsQZtHQE
 2OiwkxbTfzfvzens89KC/OALVAvjyPcrBNckIa8L/EIhdWFIV1QhlSht5LLM3yCsj8gl
 3pfV1mH3QIe5pT8ojtca2e84jtjnxK+kFItJnSEhATMRP4tR3Lt50l5Dz4jAKhqwiZoq
 6RzPFlDCiNj+XfZD+NWMEFzMjSq32nws5ZqJp0dIxxhju1a9ht+Up2ps//PNVMR7T3XO
 eFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MUtXuY++HJCf6YAR3b18aJ7DI0jQE6PA6a/VAxt1sw0=;
 b=F97WPNXQ/0iwGi5B/taQLHmUyP37vH3UJljSkWsj3bDdHrzypGe0lE3hEc4YYDreIt
 bcifzolgpGL42RjZ4xEg18LSLOH5Mouc8nDcNW+QUF3K/4J9oyOFkCpUDoy/RfUMbl5R
 GnFOwZ1c3uUMlpIIyAJ9M8OYdFVUY8QJ+f90X3lT9mfe6L5UJoWoDeqxvMfeEfvhpllg
 vDWmpH2x1BJ5HtnWIEhpu19n5uADjuIdDnzudFvo43EoxKGD0zLokJDMk+ORWhTYkaTc
 GyRwnxose9ctv9j3mIEP1QVTy20GHVOb8DFb607nkpZhmVl4mKWh+R0/yyCokAHYiDB9
 hGlQ==
X-Gm-Message-State: ANhLgQ3TUR06hGkcC6H/Mu9dlVFirSmrJmwE5D7CBqyES4Xaa6jQc7yF
 2ld1MEkIz0CwvxVZ7ktmV0rPxA==
X-Google-Smtp-Source: ADFU+vtL05d+bu3es8+XVt0YSoRuVK8h00OsNs9xDZBEDVU0sA7FfzjpTzu/1NUy0TovGn26jRkoow==
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr104815wmc.49.1583785406392;
 Mon, 09 Mar 2020 13:23:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v8sm60809339wrw.2.2020.03.09.13.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 13:23:23 -0700 (PDT)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED3901FF91;
 Mon,  9 Mar 2020 20:23:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/5] tests/acceptance: disable two more tests while in CI
Date: Mon,  9 Mar 2020 20:23:18 +0000
Message-Id: <20200309202318.3481-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309202318.3481-1-alex.bennee@linaro.org>
References: <20200309202318.3481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These keep timing out on Travis. The reason is unknown so add a FIXME
for those who want to track down exactly why this is happening. In the
meantime you can still run check-acceptance manually without change.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/machine_mips_malta.py  | 2 ++
 tests/acceptance/machine_sparc_leon3.py | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
index 92b4f28a112..deebf532e95 100644
--- a/tests/acceptance/machine_mips_malta.py
+++ b/tests/acceptance/machine_mips_malta.py
@@ -99,6 +99,8 @@ class MaltaMachineFramebuffer(Test):
         """
         self.do_test_i6400_framebuffer_logo(1)
 
+    # FIXME: why does this keep timing out on Travis?
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         :avocado: tags=arch:mips64el
diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/machine_sparc_leon3.py
index f77e210ccb4..91d94d967de 100644
--- a/tests/acceptance/machine_sparc_leon3.py
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -13,6 +13,8 @@ class Leon3Machine(Test):
 
     timeout = 60
 
+    # FIXME: why does this keep timing out on Travis?
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_leon3_helenos_uimage(self):
         """
         :avocado: tags=arch:sparc
-- 
2.20.1


