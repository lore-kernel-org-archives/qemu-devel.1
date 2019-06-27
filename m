Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C7C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81FF2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq+71/KE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81FF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSWT-0002Ih-54
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBn-0008IN-QL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBY-0007ym-67
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSBX-0007xd-Vd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so5292003wmj.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zg+OpPtpmH7tdfXZzC9HO4RqX5CGoDm1RxWQVqR637U=;
 b=Bq+71/KEMM0EZsF+Qt90Jgiysh3IARzcZPZdh+Rji+dF4n31aeievbNblwKLjNb2Kp
 ezV1lf2RxUHz5JxsqeUrtuBb5uzuTlEu4SZicvN7ThjpG5pIHlhrudMn5ypOmZBVmfJP
 Fh5nm9p5Nxf0GTLyWyVlQvuso/mIMQ4cbWbQJd1PpkfRc7TGXShrTE9K/OMJFpYizzVp
 l37SBOlXisa52LVixJiQanTmE0Rsl5In3AHXzyaSNg3op/qJOQciry3xwrLQj+e5inKP
 UhLpQBhtg2Zmf9O5EODWHPTtO+p3WQTeomcRHME/uLgYv8niA7jLXVQ1qSVEEbNd7ZY0
 Lk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zg+OpPtpmH7tdfXZzC9HO4RqX5CGoDm1RxWQVqR637U=;
 b=EWDKu8w95wJgltje3uU+NLh12lM6zN8yoH4sW/UOJ1GdQIppRCa5rYsVXVMNF0i3aZ
 L4M8rqjO4hlsPA3GO5we5UuNROvxGlHnNg5m0GVJFbOqZRAkOiL+bQy+2mj46P+PrfpJ
 z8ApFBm7V7lfB7CPs4wnGxWRH3CnBGoinYcrYB1yybqWp9ba6gFCydgkl0gvRqxq8WmU
 5diT1sFrWVRLNd75u0Jlq6Xx2E1SgmTTPPJgKBy6C3hWeUEfrDZfn3NyKuE1luoxFuwG
 dGK5saIqYnG2Ok/TltRj7xk+6hIeqcESG8aTMRMFPJYKG9WlTQWRWwAKV5scFV8ALB/y
 n0Qg==
X-Gm-Message-State: APjAAAVmFn4f1hR7M9ZJyDgYKbNeZj4OoVRp8vdMna25/0JYSLfdtPGk
 CZfdGwyXj68Kej7izYACnou5W6Ca
X-Google-Smtp-Source: APXvYqwawuqbvd9nLIqjeIAhpC/LgAOfzhNv/A/qM/avmAWJPQi1vgor2XSni/JRuUO8lAB9UD5iyw==
X-Received: by 2002:a1c:6545:: with SMTP id z66mr2771321wmb.77.1561633402523; 
 Thu, 27 Jun 2019 04:03:22 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y18sm6368968wmi.23.2019.06.27.04.03.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 04:03:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 13:02:00 +0200
Message-Id: <20190627110201.1999-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627110201.1999-1-f4bug@amsat.org>
References: <20190627110201.1999-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 4/5] tests/acceptance: Test Sandalfoot initrd
 on the PReP/40p
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User case from:
https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html

Sandalfoot info:
http://www.juneau-lug.org/sandalfoot.php

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/ppc_prep_40p.py | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index 87b5311b89..b78ad1383b 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -37,6 +37,11 @@ class IbmPrep40pMachine(Test):
                 fail = 'Failure message found in console: %s' % failure_message
                 self.fail(fail)
 
+    def exec_command_and_wait_for_pattern(self, command, success_message):
+        command += '\n'
+        self.vm.console_socket.sendall(command.encode())
+        self.wait_for_console_pattern(success_message)
+
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_factory_firmware_and_netbsd(self):
         """
@@ -114,3 +119,32 @@ class IbmPrep40pMachine(Test):
 
         self.vm.launch()
         self.wait_for_console_pattern('NetBSD/prep BOOT, Revision 1.9')
+
+    def test_sandalfoot_busybox(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        drive_url = ('http://www.juneau-lug.org/zImage.initrd.sandalfoot')
+        drive_hash = 'dacacfc4085ea51d34d99ef70e972b849e2c6949'
+        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', drive_path,
+                         '-boot', 'd')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Now booting the kernel')
+
+        msg = 'Please press Enter to activate this console.'
+        self.wait_for_console_pattern(msg)
+
+        version = 'BusyBox v0.60.0 (2001.08.19-09:26+0000) Built-in shell (ash)'
+        self.exec_command_and_wait_for_pattern('', version)
+
+        uname = 'Linux ppc 2.4.18 #5 Wed May 21 23:50:43 AKDT 2003 ppc unknown'
+        self.exec_command_and_wait_for_pattern('uname -a', uname)
+
+        cpu = 'PReP IBM 6015/7020 (Sandalfoot/Sandalbow)'
+        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo', cpu)
-- 
2.19.1


