Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4A2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688662075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIFsw/93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688662075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelrw-0007l3-HN
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqX-0005hX-43
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:18 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:35677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqV-0000e7-S3
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id q16so1705757plr.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w1W80LI37XifJiBdMXsN+sad+Phr9kWINJYefaK6VIg=;
 b=YIFsw/933SZGKHjIxCRowbAJrjVgXRPOYxhX6ZRqwZ8uZ7cZxDC2y2f6LVKf39hU+6
 wI+VBa6CtG4f2xT++AlnSDuSq0Opp7KvccvCVOmhjqYbcfT/Eo1wuV7vnfpXN2QIDVdu
 CT4UooXQULl/y9Un94ZTYsgisJxz4Uvh1NemLeRMATbzB++P8AVyFEJZJ6xB+XYCaXJK
 L8ImYoqEJC+xRv2tkitiz7bwQ3REGTzcei9ZHKBAd/dPxI7RhqsS6ctMOFfLlRGlXriN
 kJVdSGmHDgrEZmnQOXZR03qAD91LWqWPdt+V0sw7xziI6IeMiDOFr2LlfdX5ylycCU5A
 heoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w1W80LI37XifJiBdMXsN+sad+Phr9kWINJYefaK6VIg=;
 b=f0CUAfFL+Vb6oaDQOaDxsv3cyFYJh5k+wB8Fjw9n25L63nAzYGBTfO6RnJevYQsXdS
 L9vgI1A+oiBoKuMfystKPqRVfiO7WBsNy2kj2/5Wy7BH0W0NeuPk+UoEZOylEpdpubH4
 cluXMTucWqzj1bQBPUuiW6M36w5+mpKqSRdRq7G47OlyklK7BtikaU3yU5U/QWpL0Tax
 fQ/vKDIKFdxNTvm9KZ9/LDDB+Tm6zweVmQhe7NGyDFFwTB90mUMQESBI1OdIDKXtot2z
 z0sIRPZj+/Pw3P2547equXC9+LL7LejEJqzVVk6rGByyiGHwCfuzoQcHndERf9ABvIW4
 KcxQ==
X-Gm-Message-State: AOAM5330vTMx8/gpa3ChSX0oDPcXrQl38dQIJTXaMG6O/LxaPTbEiX0m
 rGH7w2ETD18N5WHsRpyVHhZRhR2pS5y34A==
X-Google-Smtp-Source: ABdhPJxd1DLu4DFPBmciN+lGl5ugd7q607oXD+KBn/A6X7eClLeNFVMoU4TZlPQAgZDG5S6crM0O5w==
X-Received: by 2002:a17:902:6b4b:: with SMTP id
 g11mr10668820plt.9.1590784994156; 
 Fri, 29 May 2020 13:43:14 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id t12sm282839pjf.3.2020.05.29.13.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 13:43:13 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 01/12] tests/vm: pass args through to BaseVM's __init__
Date: Fri, 29 May 2020 16:34:47 -0400
Message-Id: <20200529203458.1038-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529203458.1038-1-robert.foley@linaro.org>
References: <20200529203458.1038-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x62b.google.com
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
---
 tests/vm/basevm.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a2d4054d72..fbefda0595 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -61,9 +61,9 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None, genisoimage=None):
+    def __init__(self, args):
         self._guest = None
-        self._genisoimage = genisoimage
+        self._genisoimage = args.genisoimage
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
@@ -76,7 +76,7 @@ class BaseVM(object):
         self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
         open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
 
-        self.debug = debug
+        self.debug = args.debug
         self._stderr = sys.stderr
         self._devnull = open(os.devnull, "w")
         if self.debug:
@@ -90,8 +90,8 @@ class BaseVM(object):
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
@@ -438,8 +438,7 @@ def main(vmcls):
             return 1
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs,
-                   genisoimage=args.genisoimage)
+        vm = vmcls(args)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


