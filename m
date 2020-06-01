Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11989C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0662073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8S7MfXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0662073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfrnw-0003Db-Qw
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmT-0001cT-DL
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:37 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmO-0006To-3r
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:37 -0400
Received: by mail-pg1-x52d.google.com with SMTP id j21so4053785pgb.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YdJ/B9O5ArjScFjmcZvMgsnG616gX1+G8Nql6rKNdMY=;
 b=w8S7MfXJia0+uVT8JA/j7klliS6X/ixRMCeEgoVQ5E8UKEa0mEM/3ghOZbP/X3IJdd
 eqzMcwZkSVDBhfZF4nvGaNmse1eQ6BfecBclC40ZsvxHwmQpQdeFkSd/FNXJDnxi2V75
 A0DI6g+eZb3CCAR7HdpCVh/ubUSKyvvKc/hwIJfdLBjSmy3HnD9GLhUPlkJPaciX6/jv
 BH96KghYBh7hvcXDNUfImMsCBbvl4CgJl2efuBhmFWLjPqsRLjH2W6qW0FZ1RWk2y9xP
 zi8XSVt4feq2uTbNq2PHXOLhqn69Duuo9tGL8tAygClFLO3zH0A7+YYEmUpfysIBAUMQ
 ctNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YdJ/B9O5ArjScFjmcZvMgsnG616gX1+G8Nql6rKNdMY=;
 b=o1nPof72c3aTUmmJvASeQGVQWaA4cSk/YuUuefvb9nbrcIUTmbIU1DVs6yVv0hJ2zF
 FMZqQ2W3T9v2eQLmkNnSAvWSxY2EZ3nEH75/PicAHHOetzqH7mpyqzD53eSPDXusC77I
 P+O+wlonlDRkJK5fl6wPWqN9QCz+FRWwBLkqwxBCpfi8RY3bI/Cbm0y88mR63OgVjVsV
 hH3Cp4mGO0Wk738DIR3DrLeAQxNG2Rj/OHy2goAFJ92ewDMEcxMEZm7iknC8nVxxXrZR
 O2e6sN6JVEFMIFXo0COhafMUULbQNF3j8SbxKeetOOj6jH2Cus5EmEhFu7HkEw3YiSos
 +uAw==
X-Gm-Message-State: AOAM530K6QIx4SoExP/4YeaQBEgxVtmKkwwWcjeEaqICiZWK9W9+Ucdo
 eMTHTOTH9IBvYQlFH4lN8o0NLbt7bd2R0A==
X-Google-Smtp-Source: ABdhPJzQDSHgwdULxh2FHzFugHs02UKFrTqIjVs+KKLK1KKNJmblk1wBMGx/ftIPLdVc+g1fiuX8DQ==
X-Received: by 2002:a62:15c7:: with SMTP id 190mr22262910pfv.190.1591046130364; 
 Mon, 01 Jun 2020 14:15:30 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:85d8:9a30:f0f7:b100])
 by smtp.gmail.com with ESMTPSA id j24sm330131pga.51.2020.06.01.14.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 14:15:29 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 1/9] tests/vm: pass args through to BaseVM's __init__
Date: Mon,  1 Jun 2020 17:14:13 -0400
Message-Id: <20200601211421.1277-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601211421.1277-1-robert.foley@linaro.org>
References: <20200601211421.1277-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding the args parameter to BaseVM's __init__.
We will shortly need to pass more parameters to the class
so let's just pass args rather than growing the parameter list.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/vm/basevm.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a80b616a08..5a58e6c393 100644
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
2.17.1


