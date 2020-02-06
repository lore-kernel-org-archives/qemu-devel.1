Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E32C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06D420658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOH8o6MT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06D420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izWAX-0007Sn-T5
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVon-0001PY-91
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVol-0004ha-Ua
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:57 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVol-0004eV-Jk; Wed, 05 Feb 2020 20:18:55 -0500
Received: by mail-wr1-x42c.google.com with SMTP id y17so5137762wrh.5;
 Wed, 05 Feb 2020 17:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bfg/bz0k7eHq+lcueYwbpEz5J1xmofDzQUqOznNEtbg=;
 b=vOH8o6MTTe7aft2X2dofYaixmx9ope/7cW9LvscNzyG1Mk/0ipVmKCsUjnGDgavPPt
 pqyxLC88jZjd4jh6YySdL45JGTyG1NmjkoHZPagayZrpjyi8V8w3Lic1e6154eSbEUPW
 spfhuXGns2UYDk+swzu+SuJNycP/GhFwR+h3H8O+kx/jtEPfptbvMKX26bBzvsipjqxV
 oZJmhsKgvI6nLmTamyyhUQNsRZPI3VJI49mr9h6Ybm43UgHH1kLdagIVgwJIIHZPtBHO
 +OgY3OaVzDQCWc4qChbNr7o4F4VZsITT3qxG4kqCcRceUZqGwEAqMfC94unKOEG12iAw
 sTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bfg/bz0k7eHq+lcueYwbpEz5J1xmofDzQUqOznNEtbg=;
 b=NQlPctfyqqcPUO6eiq5Obkdb7vmtHocTa8R4DpU5jm4zzeszEzoFlqhJR5la66ryW+
 flEalq6FDuvJ9kbXSWtH/bV4fjFpjM87+maX6G1raxHj9odQSXsAj/ZtLTyIZl+eIMRq
 xcwDWULUnLhqu4HA5ub9gfFB12zTl4qs4GtoU39d+Airzp5au6Q7ySib5eyXVsDUcjec
 nY3bVCfxJ/lbvJiEpNmJN2980rJbIvyGgyrEYEYOnIwp40xVoZvJPm21J6rFE5qBmrBT
 5Rl7W2OFPCPVvzNmwkqChWPPeTU++kBp5rfBsOpPSfFgmyx/tau+50ppdmVKhPOmIAXu
 814w==
X-Gm-Message-State: APjAAAW9UNaoVALkqAPxigXRw/WVgFeWjAPpGqjWrxF7qbGNxm/TVZ0L
 imPQB3BbWPL1TPwwcOlwXZKifjZs
X-Google-Smtp-Source: APXvYqy4WAVZ9VPTwE3eiu0WAFqNiDWJb1E8HH2oI0sZ9HZZoHIcpnNRbtSKx47Q3yFB4/jlLmSKvw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr411443wrp.54.1580951934397;
 Wed, 05 Feb 2020 17:18:54 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/30] python/qemu/machine: Allow to use other serial
 consoles than default
Date: Thu,  6 Feb 2020 02:17:52 +0100
Message-Id: <20200206011756.2413-27-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the QEMU Python module limits the QEMUMachine class to
use the first serial console.

Some machines/guest might use another console than the first one as
the 'boot console'. For example the Raspberry Pi uses the second
(AUX) console.

To be able to use the Nth console as default, we simply need to
connect all the N - 1 consoles to the null chardev.

Add an index argument, so we can use a specific serial console as
default.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200120235159.18510-5-f4bug@amsat.org>
[PMD: zero-initialize _console_index in __init__()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 734efd8536..183d8f3d38 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -112,6 +112,7 @@ class QEMUMachine(object):
         self._sock_dir = sock_dir
         self._launched = False
         self._machine = None
+        self._console_index = 0
         self._console_set = False
         self._console_device_type = None
         self._console_address = None
@@ -241,6 +242,8 @@ class QEMUMachine(object):
                          'chardev=mon,mode=control'])
         if self._machine is not None:
             args.extend(['-machine', self._machine])
+        for i in range(self._console_index):
+            args.extend(['-serial', 'null'])
         if self._console_set:
             self._console_address = os.path.join(self._sock_dir,
                                                  self._name + "-console.sock")
@@ -527,7 +530,7 @@ class QEMUMachine(object):
         """
         self._machine = machine_type
 
-    def set_console(self, device_type=None):
+    def set_console(self, device_type=None, console_index=0):
         """
         Sets the device type for a console device
 
@@ -548,9 +551,14 @@ class QEMUMachine(object):
                             chardev:console" command line argument will
                             be used instead, resorting to the machine's
                             default device type.
+        @param console_index: the index of the console device to use.
+                              If not zero, the command line will create
+                              'index - 1' consoles and connect them to
+                              the 'null' backing character device.
         """
         self._console_set = True
         self._console_device_type = device_type
+        self._console_index = console_index
 
     @property
     def console_socket(self):
-- 
2.21.1


