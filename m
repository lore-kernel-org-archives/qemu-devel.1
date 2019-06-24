Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B3C48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7C320820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lbx1R/JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7C320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPRj-00083G-JF
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPP4-00060h-R5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPP2-0001D9-Pq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:53:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPP2-0001BS-Ip
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:53:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id d18so14029032wrs.5
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JwqqKvF7VNQMlcY7yI6rqE4GBREhj+ZNU7fBJq4Qxvs=;
 b=Lbx1R/JXUSM1xqCRYKx1MCR01V06vnc/y53HX9FR1Kn2iAx5U6+oCAAO5orQLAkWrw
 0oVysE0RE2gNIr+EhwmRfSc7c3LQfjxDk1RfReNxUChd+cax1vVD1b67Es2D4EXQ8rDG
 DoIZ9uRaKMrmDJk2zm0V4q19XXkhgyZwv2TBf4QCoN5AbUPFHa3idjAoiZN3Kpr9+JBq
 c1xYObhnH0v9KBlF6q7favZGRrHh/8XETfnsME6LJtlCSsIptmR/05Pq4ODSRIIbsIBw
 pS0Dh0PXbY95tuX/18+wTGcXNJ6xyL7eJcA0d02Y0SL5bEN+Uk/lpJitUyI3h2Bydoqa
 MsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JwqqKvF7VNQMlcY7yI6rqE4GBREhj+ZNU7fBJq4Qxvs=;
 b=No4dbSqYjmj8XNWPE5Ko11LLn8qSn+TtgtSwY04vxxDT6dRkVLE5nThbJE9CG68YZP
 fZvZCjJ33UROzxNMDyWGQTrJWsNolr5JcKYUOVlDP+UfPgWp9CYSUWdf71rk90g54dV4
 zfFVC4bOTrfxYrVEB4miL/CLSrp5+tTREv48YbnKqfKHJtGOJLhGJK7MoHk5V4lcqb46
 f06kygQmYv8B+n1cRpyCYRojGI25s9tO+M3oa6WglsvAM9xQWgro1NP5H2kVywBbGxY0
 pLaPyxj2yP6AbT9O9pHXyUyHjhaXTauxom8v5NSOCcmm8EV6ClqdJZrkMEAbdEbodVIZ
 ujsw==
X-Gm-Message-State: APjAAAVACL6ONHM3jYl4vwcbhezUpUfaPU3H8SPMkjVoIoEuu+KnyKJm
 uHcd2w/bH28rfJA4yAWaNL9WnA==
X-Google-Smtp-Source: APXvYqyLvl4eBO2vUrtCaSCJlL3SI4O4Nvx5c6arZJZ2kANRGi40Xui2980HzIcM+LitfNDCU9M/2A==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr36912099wrv.346.1561384378583; 
 Mon, 24 Jun 2019 06:52:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g131sm8401807wmf.37.2019.06.24.06.52.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:52:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C5CFD1FF9E;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:33 +0100
Message-Id: <20190624134337.10532-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 15/19] tests/vm: ubuntu.i386: apt proxy setup
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Configure apt proxy so package downloads
can be cached and can pass firewalls.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-12-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3ea459ee20..38f740eabf 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -51,6 +51,10 @@ class UbuntuX86VM(basevm.BaseVM):
                           "    ssh-authorized-keys:\n",
                           "    - %s\n" % basevm.SSH_PUB_KEY,
                           "locale: en_US.UTF-8\n"])
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            udata.writelines(["apt:\n",
+                              "  proxy: %s" % proxy])
         udata.close()
         subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
                                "-volid", "cidata", "-joliet", "-rock",
-- 
2.20.1


