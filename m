Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD116C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9285B207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAry0/EU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9285B207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2Is-0000W2-Nf
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gk-0004tP-A9
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:26:54 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832]:43539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gj-0008Iq-FP
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:26:54 -0400
Received: by mail-qt1-x832.google.com with SMTP id o19so11031374qtr.10
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3Vk2YxYa+tG5UTyKoahl0yAp9z7THOYwxY7ndiKe1+U=;
 b=FAry0/EUJF89bPOTbUwE01jocSeVcd7yzl7o3W/1pnXiycMiSEAGLqUQNEMIS7E+SR
 okZRbUN+xiSRwgnqMYtK//a+rLPp95E3aomaneQm4+VU6vUiFNKHXk24eSLuonCRBU7V
 lXpwcz+bDrUKJZh1wuhszf1G34rWvmYYbOpkKiNE5tMIogbWOTnP+ALBSMdFGtbuGhrB
 5VTjecEUnwEMc7gmDAEah/Iu3/s2IDN0+1IVkQyC9GGD6f84/geay6J8PN8Fz73fkjdv
 rNlbFYG+Wk/TPby7ZdqTYu+mxKjkkK+qWshPyR+uqUwovDb8k8Be32VUkFZBd3UPCVFh
 Bc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3Vk2YxYa+tG5UTyKoahl0yAp9z7THOYwxY7ndiKe1+U=;
 b=U/NUDt0b6l5AgZ/XjqIMobZEpIWYvRtRJ9lhmk8+gCN6r6wX3epT/9jsw0QYQtQ0uy
 dCYJdGLCFMBymVQPrJd1gRN3t4GkIK4HOwp+iBdyVx7pTB9R+pnQX59xiMqrw4pdYOCm
 3vtooDrTVxb5DNp5A80vjMblSi62vF9SJbklOd0gSyUlsfhlsOEyJoU7iCu3wgZIx0QH
 HccUW+lphBnwrQ3cYuurMW3caBu1ORLkVqVB/p8dUqzpDcEvCNFo5La1OoWKLNX7zSQw
 7DXr5PHFJDjoKsYTLETV5GNRrUHkvIU94EwUK4bvTsIvYUalWf3f+bnuJIEEYUWpHM8Z
 5SaA==
X-Gm-Message-State: AOAM5304mxvvUJt/0uVvV6WgjaMh8ihYA1bhwu2EvMXK/mvM4mTsfOk2
 aN7jymfp5N0P/wQXlFoY6Ui6GdWOLSM2Aw==
X-Google-Smtp-Source: ABdhPJyZwdkXKKTg+7GYqk0tjyW4TUHGjS+lo4KMIPKqkS/Zr/w1Tg1kMWHO4iIBEUCO/Ykf/Ec9Fg==
X-Received: by 2002:aed:257c:: with SMTP id w57mr21901274qtc.208.1589894812164; 
 Tue, 19 May 2020 06:26:52 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:dd6a:8c63:cd9d:ad15])
 by smtp.gmail.com with ESMTPSA id d74sm3482136qke.100.2020.05.19.06.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 06:26:51 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/12] tests/vm: pass args through to BaseVM's __init__
Date: Tue, 19 May 2020 09:22:50 -0400
Message-Id: <20200519132259.405-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519132259.405-1-robert.foley@linaro.org>
References: <20200519132259.405-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x832.google.com
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Robert Foley <robert.foley@linaro.org>
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


