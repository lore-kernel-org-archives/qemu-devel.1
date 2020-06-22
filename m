Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEC7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FBC20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGBYxPyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FBC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNdO-000418-7U
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUb-0006qX-6k
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:33186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUY-0005eM-SE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id l11so16942630wru.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m1Iumf3YfxuO4NhxteboEtLnibs/CAVIrPHuCmkmoi4=;
 b=oGBYxPyOAYgmZ0GopkO8p/KIEz05emt4dkR/2HqeZUD9ZoWK0WNhvz/X9s35UsfWqB
 Vwfr8xkTrbh5gp3JaueBe1o2YJdiLPG8dUi5AnVFO0Q22/YPgedfBwP1XpES+PSIMyYA
 jUWj35azekwx7kmi1ymlx1SWiMl6d1XkjJlg6zTvPEHC2hPeoGsruXYf/CdcMNSKAUho
 nZJz4XYAl/QrUIZRWGj9hj2ZUWgyNhcEeL/H1Nf2vTmQIkpTA6ekErXYGUbDlnbu6po3
 MIAAfB561yc969VzTB0gREPmg719VvcYY4WQ26SEqcm1K9DZohD4TtlpIfEEXNAeNVKo
 mOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m1Iumf3YfxuO4NhxteboEtLnibs/CAVIrPHuCmkmoi4=;
 b=aCYe/RYNpFKwKHVJm7u4xpGP9XYKVEju28X4aLaXbVHypDQaBeElsQBG3wEizwF+y5
 LvSP+K0Akc2o8/jb2en2XoP8SEULTsjWWyItDyBaL2G9EH2HGGwFVhXor3BCdS5JpbVJ
 FWG2h4rD5fKsr9JmLoho8t3EYT7/4dSyZ32F5GOKq6Ds1wPDv6pHhmI7zjAKpDShmXU9
 LYULQW/3xsplmll+tectQMemUgBvV6gSCQ4RAYNl0ztzQR0eb15QQthC2xWtX3SEw9Er
 0RDnekTDW/Sa6GTj36lEBFUYdxElHHMr6t5xQUTtoUxHCfW35oJyb2g1u/Qu9wcyqoj/
 Dp6g==
X-Gm-Message-State: AOAM531dDH/3ib+6f6bspJnLLyr04M9OOEmUWxYCxkzLoCmgf+pQ8uLv
 eX01UzTgziJLMACIVJpY2M/68w==
X-Google-Smtp-Source: ABdhPJzs3y3WsnBiiiGT7ohytiyXv5ojrJvSdKDYytstzI2QT6zt+sQE6rc1qK1hC5M/j1aDGR33Mw==
X-Received: by 2002:adf:e811:: with SMTP id o17mr5962257wrm.53.1592836329459; 
 Mon, 22 Jun 2020 07:32:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o6sm18265567wrp.3.2020.06.22.07.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:32:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3E571FF8C;
 Mon, 22 Jun 2020 15:32:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/18] tests/vm: pass args through to BaseVM's __init__
Date: Mon, 22 Jun 2020 15:31:48 +0100
Message-Id: <20200622143204.12921-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Adding the args parameter to BaseVM's __init__.
We will shortly need to pass more parameters to the class
so let's just pass args rather than growing the parameter list.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601211421.1277-2-robert.foley@linaro.org>
---
 tests/vm/basevm.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a80b616a08d..5a58e6c3930 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -61,11 +61,10 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None, genisoimage=None,
-                 build_path=None):
+    def __init__(self, args):
         self._guest = None
-        self._genisoimage = genisoimage
-        self._build_path = build_path
+        self._genisoimage = args.genisoimage
+        self._build_path = args.build_path
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
@@ -78,7 +77,7 @@ class BaseVM(object):
         self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
         open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
 
-        self.debug = debug
+        self.debug = args.debug
         self._stderr = sys.stderr
         self._devnull = open(os.devnull, "w")
         if self.debug:
@@ -92,8 +91,8 @@ class BaseVM(object):
                        (",ipv6=no" if not self.ipv6 else ""),
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20"]
-        if vcpus and vcpus > 1:
-            self._args += ["-smp", "%d" % vcpus]
+        if args.jobs and args.jobs > 1:
+            self._args += ["-smp", "%d" % args.jobs]
         if kvm_available(self.arch):
             self._args += ["-enable-kvm"]
         else:
@@ -456,8 +455,7 @@ def main(vmcls):
             return 1
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs,
-                   genisoimage=args.genisoimage, build_path=args.build_path)
+        vm = vmcls(args)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.20.1


