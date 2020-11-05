Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F88C55ABD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C180206A4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZZtsvUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C180206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajZl-00068N-9e
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQm-0004A3-TE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:16 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQi-0004qC-RP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:16 -0500
Received: by mail-wm1-x341.google.com with SMTP id h2so2456950wmm.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7OQVV+4dDAK9BrsulGq6EIUpoaeySsacRv+eB9jEMfg=;
 b=VZZtsvUA/uHzyLX4oTtY1/6crPwkWLCDocuE/ohMOC2fsqr8Ndq7VLKjb7ZQ2uK7rR
 tmcW6h4wJVl67Cyqu9raO6o7xpy8XsTNEBr9K76gsGUqxjyqhWXMSuaud9o1I0vjDPZf
 1oYkLrS/Y4fsfTdTT/MFNphjOEL/u05Im3oCsodFQivLBjKblk13KA73ac7xU+itZVjE
 mgZOcAKr82TgAaPS6PqnCijweSQg7wso9bCyKArSJohJsNz+v0KyraFY7jA7/ODF+tA5
 4brbxJ4Xk+NX6+1YUN1yL4OA+4EXPFuc6/9xGJAjBEFd9RWIkkNIeiRixDjMOgNcHdLR
 nJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7OQVV+4dDAK9BrsulGq6EIUpoaeySsacRv+eB9jEMfg=;
 b=chfS2wxdTKiB/VQVq52oeBtHUasXOZfxuJgbGH/IxvuL/cmVwpaJ5vZJs2vniBdwJ0
 8QN3HQsdmMlxjU5ZtS3LWQtqaHBDGlgMi/HELkycl1Ngi8T3mPs0QLpgu78o5m7dbx/5
 ycLufmzQ8mDCjiM5V4o62LW1/tU+6haFvunpkW1OZ0IIrfNa0eHU5Iitnm7py8PKkDFd
 bfawuvsurUQdG+/JH5vPug0srFMKHvPrqOsDbGsp0QqiuuQUv6/vvuqB778FLAjaZ9eM
 lcZAWfafd55cAmpQVz6CZSCPmE4PImWtsOLB61QgZbzw4bNer4zMA9p82v3YcWg0WsOW
 q02g==
X-Gm-Message-State: AOAM533ZjY+oUJ40WDOnPnDIifxEC2ZI91wlPzc2uyIFmIEaC3QE7Rgm
 jMSQthGaZvM/EuL5tUdLPb/pTQ==
X-Google-Smtp-Source: ABdhPJxrAHuCe6VDInEX4wLfPxKjiJZjj04n2QThFEG8TF8xsbjOQ1z7jMzDxi2NwMGvljwRkdQemg==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr3909151wmi.122.1604598731412; 
 Thu, 05 Nov 2020 09:52:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 90sm3736469wrl.30.2020.11.05.09.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39BFB1FF91;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 05/15] docs: move generic-loader documentation into the
 main manual
Date: Thu,  5 Nov 2020 17:51:43 +0000
Message-Id: <20201105175153.30489-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We might as well surface this useful information in the manual so
users can find it easily. It is a fairly simple conversion to rst with
the only textual fixes being QemuOps to QemuOpts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/generic-loader.txt        |  92 --------------------------
 docs/system/generic-loader.rst | 117 +++++++++++++++++++++++++++++++++
 docs/system/index.rst          |   1 +
 3 files changed, 118 insertions(+), 92 deletions(-)
 delete mode 100644 docs/generic-loader.txt
 create mode 100644 docs/system/generic-loader.rst

diff --git a/docs/generic-loader.txt b/docs/generic-loader.txt
deleted file mode 100644
index a9603a2af7..0000000000
--- a/docs/generic-loader.txt
+++ /dev/null
@@ -1,92 +0,0 @@
-Copyright (c) 2016 Xilinx Inc.
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-the COPYING file in the top-level directory.
-
-
-The 'loader' device allows the user to load multiple images or values into
-QEMU at startup.
-
-Loading Data into Memory Values
--------------------------------
-The loader device allows memory values to be set from the command line. This
-can be done by following the syntax below:
-
-     -device loader,addr=<addr>,data=<data>,data-len=<data-len>
-                   [,data-be=<data-be>][,cpu-num=<cpu-num>]
-
-    <addr>      - The address to store the data in.
-    <data>      - The value to be written to the address. The maximum size of
-                  the data is 8 bytes.
-    <data-len>  - The length of the data in bytes. This argument must be
-                  included if the data argument is.
-    <data-be>   - Set to true if the data to be stored on the guest should be
-                  written as big endian data. The default is to write little
-                  endian data.
-    <cpu-num>   - The number of the CPU's address space where the data should
-                  be loaded. If not specified the address space of the first
-                  CPU is used.
-
-All values are parsed using the standard QemuOps parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
-
-An example of loading value 0x8000000e to address 0xfd1a0104 is:
-    -device loader,addr=0xfd1a0104,data=0x8000000e,data-len=4
-
-Setting a CPU's Program Counter
--------------------------------
-The loader device allows the CPU's PC to be set from the command line. This
-can be done by following the syntax below:
-
-     -device loader,addr=<addr>,cpu-num=<cpu-num>
-
-    <addr>      - The value to use as the CPU's PC.
-    <cpu-num>   - The number of the CPU whose PC should be set to the
-                  specified value.
-
-All values are parsed using the standard QemuOps parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
-
-An example of setting CPU 0's PC to 0x8000 is:
-    -device loader,addr=0x8000,cpu-num=0
-
-Loading Files
--------------
-The loader device also allows files to be loaded into memory. It can load ELF,
-U-Boot, and Intel HEX executable formats as well as raw images.  The syntax is
-shown below:
-
-    -device loader,file=<file>[,addr=<addr>][,cpu-num=<cpu-num>][,force-raw=<raw>]
-
-    <file>      - A file to be loaded into memory
-    <addr>      - The memory address where the file should be loaded. This is
-                  required for raw images and ignored for non-raw files.
-    <cpu-num>   - This specifies the CPU that should be used. This is an
-                  optional argument and will cause the CPU's PC to be set to
-                  the memory address where the raw file is loaded or the entry
-                  point specified in the executable format header. This option
-                  should only be used for the boot image.
-                  This will also cause the image to be written to the specified
-                  CPU's address space. If not specified, the default is CPU 0.
-    <force-raw> - Setting force-raw=on forces the file to be treated as a raw
-                  image.  This can be used to load supported executable formats
-                  as if they were raw.
-
-All values are parsed using the standard QemuOps parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
-
-An example of loading an ELF file which CPU0 will boot is shown below:
-    -device loader,file=./images/boot.elf,cpu-num=0
-
-Restrictions and ToDos
-----------------------
- - At the moment it is just assumed that if you specify a cpu-num then you
-   want to set the PC as well. This might not always be the case. In future
-   the internal state 'set_pc' (which exists in the generic loader now) should
-   be exposed to the user so that they can choose if the PC is set or not.
diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
new file mode 100644
index 0000000000..59f28d1230
--- /dev/null
+++ b/docs/system/generic-loader.rst
@@ -0,0 +1,117 @@
+..
+   Copyright (c) 2016, Xilinx Inc.
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.  See
+the COPYING file in the top-level directory.
+
+Generic Loader
+--------------
+
+The 'loader' device allows the user to load multiple images or values into
+QEMU at startup.
+
+Loading Data into Memory Values
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+The loader device allows memory values to be set from the command line. This
+can be done by following the syntax below::
+
+   -device loader,addr=<addr>,data=<data>,data-len=<data-len> \
+                   [,data-be=<data-be>][,cpu-num=<cpu-num>]
+
+``<addr>``
+  The address to store the data in.
+
+``<data>``
+  The value to be written to the address. The maximum size of the data
+  is 8 bytes.
+
+``<data-len>``
+  The length of the data in bytes. This argument must be included if
+  the data argument is.
+
+``<data-be>``
+  Set to true if the data to be stored on the guest should be written
+  as big endian data. The default is to write little endian data.
+
+``<cpu-num>``
+  The number of the CPU's address space where the data should be
+  loaded. If not specified the address space of the first CPU is used.
+
+All values are parsed using the standard QemuOps parsing. This allows the user
+to specify any values in any format supported. By default the values
+will be parsed as decimal. To use hex values the user should prefix the number
+with a '0x'.
+
+An example of loading value 0x8000000e to address 0xfd1a0104 is::
+
+    -device loader,addr=0xfd1a0104,data=0x8000000e,data-len=4
+
+Setting a CPU's Program Counter
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The loader device allows the CPU's PC to be set from the command line. This
+can be done by following the syntax below::
+
+     -device loader,addr=<addr>,cpu-num=<cpu-num>
+
+``<addr>``
+  The value to use as the CPU's PC.
+
+``<cpu-num>``
+  The number of the CPU whose PC should be set to the specified value.
+
+All values are parsed using the standard QemuOpts parsing. This allows the user
+to specify any values in any format supported. By default the values
+will be parsed as decimal. To use hex values the user should prefix the number
+with a '0x'.
+
+An example of setting CPU 0's PC to 0x8000 is::
+
+    -device loader,addr=0x8000,cpu-num=0
+
+Loading Files
+^^^^^^^^^^^^^
+
+The loader device also allows files to be loaded into memory. It can load ELF,
+U-Boot, and Intel HEX executable formats as well as raw images.  The syntax is
+shown below:
+
+    -device loader,file=<file>[,addr=<addr>][,cpu-num=<cpu-num>][,force-raw=<raw>]
+
+``<file>``
+  A file to be loaded into memory
+
+``<addr>``
+  The memory address where the file should be loaded. This is required
+  for raw images and ignored for non-raw files.
+  
+``<cpu-num>``
+  This specifies the CPU that should be used. This is an
+  optional argument and will cause the CPU's PC to be set to the
+  memory address where the raw file is loaded or the entry point
+  specified in the executable format header. This option should only
+  be used for the boot image. This will also cause the image to be
+  written to the specified CPU's address space. If not specified, the
+  default is CPU 0. <force-raw> - Setting force-raw=on forces the file
+  to be treated as a raw image. This can be used to load supported
+  executable formats as if they were raw.
+
+All values are parsed using the standard QemuOpts parsing. This allows the user
+to specify any values in any format supported. By default the values
+will be parsed as decimal. To use hex values the user should prefix the number
+with a '0x'.
+
+An example of loading an ELF file which CPU0 will boot is shown below::
+
+    -device loader,file=./images/boot.elf,cpu-num=0
+
+Restrictions and ToDos
+^^^^^^^^^^^^^^^^^^^^^^
+
+At the moment it is just assumed that if you specify a cpu-num then
+you want to set the PC as well. This might not always be the case. In
+future the internal state 'set_pc' (which exists in the generic loader
+now) should be exposed to the user so that they can choose if the PC
+is set or not.
+
+
diff --git a/docs/system/index.rst b/docs/system/index.rst
index c0f685b818..3cff0ca98f 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -24,6 +24,7 @@ Contents:
    usb
    ivshmem
    linuxboot
+   generic-loader
    vnc-security
    tls
    gdb
-- 
2.20.1


