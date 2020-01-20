Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B3C33CAA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE24206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuN8sqJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE24206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgrg-0002ZO-88
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq2-0000qE-PC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq1-0007YI-Nv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:10 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq1-0007Xo-IB; Mon, 20 Jan 2020 18:52:09 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so1294990wrw.8;
 Mon, 20 Jan 2020 15:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aEBTxw5dxXldbptfzGuLoP7HN5dwcK1pAxxrXdVbFGw=;
 b=OuN8sqJ+46BNhueMqUgdhNwS/oJkcMc26d3FfPIFiyRrnMULh8G7eaw9Ezmy8/SshI
 ERSBy1vobYxZ3Ml/SWqtktCS89ohJYXVBqzN482s07O/eysvi6+fLBQf2FPVVcvA0yTT
 SfptKQ64HlTt7pjaD3NksuZMkBjtVbPulxMOzBgjUEyT0D/xQ4C4d9PwYBt1yrORHulo
 Ui86+/89SVfMQ6EX0WI1cAY3MdRNwCqyYkALYRmpxstF7p6A1tv/iQmnOTFn0tXMDfNL
 gUPiIaSlK+m2LnXwzw2x/2DiL/XLok1F4EqimE0Xeh/aPtipRGVtBvALi0mlm4DGIflE
 0yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aEBTxw5dxXldbptfzGuLoP7HN5dwcK1pAxxrXdVbFGw=;
 b=UouEf+nlH49zXmRvYEzzspgHyxSQaVubctX5hmx+hL6CKkRpm5Av9pgdrk4F8B1R4d
 O2hD1mseD8zIG24OnXJTaxb3npylNpXZlVngiD99VIMzYC4u7zdbmrWk3AzaNikndmVk
 H4IiTw9FlC+1e5EufbYP9DN2BdHh2OkUzn0UrAdIbCMpuy1cUKiRSggsC+i7SuNjXl0s
 d3/00qLjwJUe+BBld63feutmtIQPXw2ZR9ChENP4475bXskuVnmMvgquPVuhLJwCV243
 y8OqbhNgYpncYGYrNKtRrQHZUn9wFCtjennezc1xHghHum5rbhruhGVOhJB1Ho8tq82i
 O0nA==
X-Gm-Message-State: APjAAAWtNSwEOT/8Rra9qT8nVPJnLcp9VAisuf340ZDxiKRdva/myXYV
 R3LdoPsm9SjTxD41fgWlV8KiI8hU
X-Google-Smtp-Source: APXvYqwtefE8PNG3BRbUSqN8OO4ScMbKzke5alBM/L4uH03Vz/GJZgPBIyroxlU2BAzLGaU2kTmNKw==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr1735996wrw.327.1579564328329; 
 Mon, 20 Jan 2020 15:52:08 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm48655269wrx.71.2020.01.20.15.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 15:52:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/7] python/qemu/machine: Allow to use other serial
 consoles than default
Date: Tue, 21 Jan 2020 00:51:56 +0100
Message-Id: <20200120235159.18510-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120235159.18510-1-f4bug@amsat.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
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
---
v2:
- renamed 'console_index', added docstring (Cleber)
- reworded description (pm215)
---
 python/qemu/machine.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 734efd8536..ef9f5b213f 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -241,6 +241,8 @@ class QEMUMachine(object):
                          'chardev=mon,mode=control'])
         if self._machine is not None:
             args.extend(['-machine', self._machine])
+        for i in range(self._console_index):
+            args.extend(['-serial', 'null'])
         if self._console_set:
             self._console_address = os.path.join(self._sock_dir,
                                                  self._name + "-console.sock")
@@ -527,7 +529,7 @@ class QEMUMachine(object):
         """
         self._machine = machine_type
 
-    def set_console(self, device_type=None):
+    def set_console(self, device_type=None, console_index=0):
         """
         Sets the device type for a console device
 
@@ -548,9 +550,14 @@ class QEMUMachine(object):
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


