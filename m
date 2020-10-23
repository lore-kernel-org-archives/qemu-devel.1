Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EFAC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D421D208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igjiop1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D421D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVx1r-0004KF-RF
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxn-0007v2-Bd; Fri, 23 Oct 2020 09:18:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxk-0000dU-Ku; Fri, 23 Oct 2020 09:18:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id c194so1433105wme.2;
 Fri, 23 Oct 2020 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NAtjWtYoVyZRwhuRPKYlYZP7QUZVObU61H901gwMQTo=;
 b=igjiop1DHYiLLyTIYTvlp7ePWdx7ZeYD/0vK7Y7rXMes7AfJluzdh51pTKQTe9/w5V
 0Z6G9OD7AMz+HA7pqvMn676bvOzzdl0qdNb9I158pEMJrtEKk4JxbyhUgvrxWWFbHCjS
 Galkb4zSALtk1m2U0O0cBvrzfOPjyHOjGIudqjKd4Ra4XQYvaXYn1TBI6a5pZMLrrrwd
 UCuarYazfJ1CeZwAoMsuWQ/u6jIiK49Ziej68JCnNm/p7+f0cYIsdGhVzTpDPV77aoAO
 QC3/D2cA9eZ0RLpZoYJ+SBqrrO+S/yTMLGk7Q/YZ2jlR9DPkGy27380oMxfvgYTGIZ6N
 i0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NAtjWtYoVyZRwhuRPKYlYZP7QUZVObU61H901gwMQTo=;
 b=CvegJw72fTrCY3O5T4X+ckV8p6EaB17FyZgNS4kpPEnV6j0xEzfe7ZBycptW7KIZPy
 F8fShBXYbb/zgK44dW8/gRfTOakEi/7THSr4jD/X4Th0JO/6d/8Akk1PLSIjzwtDkI4Q
 O3mIJo4bU0tCF9/m3y+R5VbMaX1EG4jFs9NYV4Jwh5GH9liVi+r6Rz+gg//niN1Unnss
 fH0jwJtAsTZyt2rxqvlPrQb45TDtlQrp0fLegaVDeiN/zV/gWgCH0UYmjjfjWXtfpdIg
 mIvaERY1PVKMKHU2xFIZRj3dP7inHjdFz1hMzHcQazvmQJLqtST9KFEX8yUqiX+avvOR
 8KIw==
X-Gm-Message-State: AOAM531QgYMfLZyQPe4dpX872+RbVNXrxjNMX6u9j215eqQ5WAQUK+NK
 DjUr79lLs3gr6ryE5i4N7/qQeo9pfQg=
X-Google-Smtp-Source: ABdhPJybMTkRjGlW9gyzWtbr7fUQVH7Vasqas7ZEblD5+KSOATGQXmz3BSN74GRCLOVpWpbFXMzi5A==
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr1902838wma.28.1603459110827; 
 Fri, 23 Oct 2020 06:18:30 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c18sm3332334wrt.10.2020.10.23.06.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 06:18:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
Date: Fri, 23 Oct 2020 15:18:08 +0200
Message-Id: <20201023131808.3198005-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023131808.3198005-1-f4bug@amsat.org>
References: <20201023131808.3198005-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test U-Boot and Linux on the recent Armbian release 20.08.

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 803b4512a26..b604cfe7dab 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -829,6 +829,31 @@ def test_arm_orangepi_bionic_19_11(self):
 
         self.do_test_arm_orangepi_uboot_armbian(image_path)
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+    def test_arm_orangepi_bionic_20_08(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
+        """
+
+        # This test download a 275 MiB compressed image and expand it
+        # to 1036 MiB, but the underlying filesystem is 1552 MiB...
+        # As we expand it to 2 GiB we are safe.
+
+        image_url = ('https://dl.armbian.com/orangepipc/archive/'
+                     'Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz')
+        image_hash = ('b4d6775f5673486329e45a0586bf06b6'
+                      'dbe792199fd182ac6b9c7bb6c7d3e6dd')
+        image_path_xz = self.fetch_asset(image_url, asset_hash=image_hash,
+                                         algorithm='sha256')
+        image_path = archive.extract(image_path_xz, self.workdir)
+        image_pow2ceil_expand(image_path)
+
+        self.do_test_arm_orangepi_uboot_armbian(image_path)
+
     @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
     def test_arm_orangepi_uboot_netbsd9(self):
         """
-- 
2.26.2


