Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4230BC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F2325741
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXn3mjEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F2325741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIK5-0005Kk-Ar
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:30:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFE-0001EH-BS
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFC-0000GS-TQ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWIFB-00007H-RY
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id c6so564940wml.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=tKMybXLMRDSBfHxe/ATk9ylSYfLE+dz7XRu9VYKxKSs=;
	b=tXn3mjEuMwSRnFRjLzCtDSFvdXivMZdk2BXVccr37weXGO8Odahf4ImzjpoAsiXLzn
	kkma9tEZYI9TF3sQXR4Fg0k/wGJSp77b/35eiUoaF9M772SUBet2i7JPLq3iiWnIstif
	veJ+LM7K3S2kFAap0cW/qKP816kRQIW4RV+n6ajayUFeJc605EJT77+5fSLwjTRVQHM0
	ZoM156VcLNCEm0ZMmysjcbxW3GZvvtGK/JswnpQFeKLSChdncboL/pHRBihAZ4wfN93m
	MFVBTC6FNZwS2/B9lE8novrMxwtCDPnBhxaj1Pc/1CRU1xPusDnx0VHHH07La+x8Nhqm
	PFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tKMybXLMRDSBfHxe/ATk9ylSYfLE+dz7XRu9VYKxKSs=;
	b=MF6nCG9gLfvn2jfBDdQfop/nP+boDLelgnYapx0nU77dsTnMwXa7vSFfV4Seo5AO/p
	Yfr7xZsk1i/7i5eDLTNfe/qaZsTW32DsTWvLIfSZBQ163IbP1X2EoZmr3kGuo5+/wPOb
	B9RGeicn+mLu05fip0dZqvDmhq5wCaab57UML+mfO0OKj1LQDw5gResM2Ep86UZl/r/I
	+z6Jkrzeg6kiF3DgMk175pA0I0nM+t2aNtuS3I57bwENzaPfY7NX5OB7br2fuvhsB3tw
	kysSqPO0me4/PNDF4drf19TylXu0t9ag7y2+MPv4aiNFJzWncXOLMxbiATMyWifg0wzn
	HsrA==
X-Gm-Message-State: APjAAAUrsj8pR4kke1J93gen5hJyyWzc4ECM3fxNZ+4CS5GrO1M2+AUr
	BShXzLYBqMQrJeXmz8MPuasTNw==
X-Google-Smtp-Source: APXvYqwqXsyY5KPJicZ1i1D436y1KKJmly/46fes3q8WvEDwBVaaHQeBQqAD3fVME+36Y6hUamq3aA==
X-Received: by 2002:a7b:c043:: with SMTP id u3mr1259501wmc.56.1559211905274;
	Thu, 30 May 2019 03:25:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id s8sm2386491wra.55.2019.05.30.03.25.02
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:25:03 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4A9231FF9F;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:52 +0100
Message-Id: <20190530101603.22254-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 15/26] tests/vm: send proxy environment
 variables over ssh
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Packages are fetched via proxy that way, if configured on the host.
That might be required to pass firewalls, and it allows to route
package downloads through a caching proxy server.

Needs AcceptEnv setup in sshd_config on the guest side to work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190520124716.30472-4-kraxel@redhat.com>
---
 tests/vm/basevm.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4847549592d..5e30bac6615 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -38,6 +38,13 @@ class BaseVM(object):
     GUEST_PASS = "qemupass"
     ROOT_PASS = "qemupass"
 
+    envvars = [
+        "https_proxy",
+        "http_proxy",
+        "ftp_proxy",
+        "no_proxy",
+    ]
+
     # The script to run in the guest that builds QEMU
     BUILD_SCRIPT = ""
     # The guest name, to be overridden by subclasses
@@ -106,6 +113,8 @@ class BaseVM(object):
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
+        for var in self.envvars:
+            ssh_cmd += ['-o', "SendEnv=%s" % var ]
         if interactive:
             ssh_cmd += ['-t']
         assert not isinstance(cmd, str)
-- 
2.20.1


