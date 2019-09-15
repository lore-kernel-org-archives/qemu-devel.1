Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C00C4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8298F2067D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECMXK7yV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8298F2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9c15-0008PH-L3
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw2-0003IU-Hh
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw1-0000mS-8P
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bvy-0000jo-Pz; Sun, 15 Sep 2019 17:19:50 -0400
Received: by mail-wm1-x341.google.com with SMTP id r195so7975347wme.2;
 Sun, 15 Sep 2019 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uvVbkuNWz6jF/t2SrRRYyKnap1F6KpyQna6AhH9SKWk=;
 b=ECMXK7yVnWygh6C+kVyZ5+npPWJq76S4JO1+xThfYHBketbr/BVnnygce7wNkZdFkN
 BtsZo+Y3VEWIk4rYAnSvHL+EFVa6ytzQjpOxSz3M90uFvZ0wW8C9FUg2SYYVVhOqtXQ0
 cibm9dduApXqoN9eYDL1Uwr9j13eIlxapLaKuOOQBUCzeMiOWgt8UUFeDACWLzM9AD8S
 yJEFTrgUAeGfF6ZK34stLcTZPQtsNZ11A8lHzo+Fqmtu3IUd1cwyDoalAdNdIOLXIWp1
 X6YqzeUE2peUKzHVuup3LGAvJBnm+Ci1B3Gp+wEW3wdmhFNhmAcP2SIaE406qdhjWDi2
 ZBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uvVbkuNWz6jF/t2SrRRYyKnap1F6KpyQna6AhH9SKWk=;
 b=SudaiSWE+jSwXz3wLFVDoJqa4p9Xg92wHR7o4IC2GuLiKu4L5ri+pF52dZmeIenBdh
 xxZ5ZkN2+p/5ZqIsVpyZ54CY64QNylmpGmj2ZxxHQg0P6mxIpkgnZ7P/oObRcr0NbraJ
 SPLBU+IOXkE6Rj9gPxn1JBm1/zBbGFdDDu2eTqOC5Sn/EhvqoavI/i4xh1+8FNZyP1eL
 lU/OLGChNuW+K75ZFlq5s0IbP4YvOzKjOFwwIB8nqfVp9IZfQjmBkc6Gff+ViygcOmjz
 5hR5yrnyAdCWn4afWF7QWU5MWy1QavFNYAFRorS0ReRuVJuUfj8d1P+/xUpeJhSVGiMn
 r67w==
X-Gm-Message-State: APjAAAXef7raCpWdz45VDXyCOFhi8LJNKFusRsrFmZMRlucUve9uabbt
 2GmC+CO42SXoBMYw32TXkB/wqp+X
X-Google-Smtp-Source: APXvYqwztvKeWWTlDCCqb6ACqyLTtHq3NmQTEU8ii9A3mdV41IBut3DVDpXKb3CLjxAJOZsxfvUxVA==
X-Received: by 2002:a1c:4886:: with SMTP id
 v128mr11516745wma.176.1568582389583; 
 Sun, 15 Sep 2019 14:19:49 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s1sm50271021wrg.80.2019.09.15.14.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:19:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:19:37 +0200
Message-Id: <20190915211940.30427-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915211940.30427-1-f4bug@amsat.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 3/6] tests/acceptance: Test OpenBIOS on the
 PReP/40p
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
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User case from:
https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/ppc_prep_40p.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index a0eac40d9f..87b5311b89 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -82,3 +82,35 @@ class IbmPrep40pMachine(Test):
         self.wait_for_console_pattern(fw_banner)
         prompt_msg = 'Type any key to interrupt automatic startup'
         self.wait_for_console_pattern(prompt_msg)
+
+    def test_openbios_192m(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-m', '192')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('>> OpenBIOS')
+        self.wait_for_console_pattern('>> Memory: 192M')
+        self.wait_for_console_pattern('>> CPU type PowerPC,604')
+
+    def test_openbios_and_netbsd(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        drive_url = ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
+                     'NetBSD-7.1.2-prep.iso')
+        drive_hash = '78734c1bdda79778f0b6f391969ad2458ed8981c'
+        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', drive_path,
+                         '-boot', 'd')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('NetBSD/prep BOOT, Revision 1.9')
-- 
2.20.1


