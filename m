Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F374CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD90D20760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9hRZQvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD90D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfOw-0004Dg-VT
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqfL9-0007GY-8a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:12:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqfL6-0006Gu-Gk
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:12:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so23020231wmh.4
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cOgbqI8IByJK4hKbNOF3vXqsSmzYFMqTxbljVvHqKbI=;
 b=A9hRZQvsvnWolLV/1g+zGO5b8ovhFkRVxmmpl4IvSiFyB/LGpj8/oD2KBVcRfiJ7Mn
 Sy9ZEGPjjNd52wQwAL73n3fqvA7EP3SWvsXDL00V+5NSSLMHQBZ7tSHzHxtrZLrIzXDK
 c+2EQEicc6VS9g/YlvVRSLUq0D/XqhHd9Oyu1u1v54uoeEEjeLXSsxDCTSQo5QBJDbD7
 VpGTJw7SG5JpD7tR11NhuXtNaT45BiEPqok4jHGc/YtZ0w9MUHD+Jl9vb03zd5XEmsp0
 kM8bFf4nfX+3Rs+8rocEMPry5mPnURFaurg0AX6DQv+LmOCES5NsNajEOd29gDxxcRG5
 ohEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cOgbqI8IByJK4hKbNOF3vXqsSmzYFMqTxbljVvHqKbI=;
 b=KUAZ3ZmM+xFziwtAhNYQqe6ve746/0J1vLqele9t/WI3xfdSqoHvf9C6jmUKMZYknQ
 WYYxxHjYrKcDufHDCIaCEJFLSs75vEOME/PlHWWX2XVxp9q5F5ugvyx5OqQ0A4HQCBeL
 wBLYBVghc0rRGcFmjDFgfzMFn5R0I2t7JwturYItrqbV6VTmC5M3nEwssWkiRSbu3+LN
 9RI4isq9NHOu0B6c/XUP/F+joFAXY9YeeaV3SB/cv5tCWJ0UbI1x+C6/n6c2cBwlV9bX
 ZTq8Jg9b9oNv8ta79nH3t//It3HiY0bINjYtMmyABr6CrQFKivfzEF3+CbO+AGeu4irA
 fhNw==
X-Gm-Message-State: AOAM531kdzUDSe97mAWK1JeCxxIRxjlubnySSjDAar5FetKC6wzyvWbg
 dA14gHjaJ9cjPYhrAcUr7FQGuw==
X-Google-Smtp-Source: ABdhPJy83Q7nFIG1gUhlnNMSGxC2O0i4yVGJQEoYMgu1OSUOg7Gd81m35utDOS+IiElQswccMq9m7A==
X-Received: by 2002:a1c:398b:: with SMTP id g133mr26420177wma.76.1593619917789; 
 Wed, 01 Jul 2020 09:11:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s18sm8655356wra.85.2020.07.01.09.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 09:11:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 685B01FF87;
 Wed,  1 Jul 2020 17:11:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 1/3] docs/booting.rst: start documenting the boot process
Date: Wed,  1 Jul 2020 17:11:51 +0100
Message-Id: <20200701161153.30988-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701161153.30988-1-alex.bennee@linaro.org>
References: <20200701161153.30988-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While working on some test cases I realised there was quite a lot of
assumed knowledge about how things boot up. I thought it would be
worth gathering this together in a user facing document where we could
pour in the details and background to the boot process. As it's quite
wordy I thought it should be a separate document to the manual (which
can obviously reference this).

The document follows the socratic method and leaves the reader to ask
themselves some questions in an effort to elucidate them about any
problems they may be having.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190308211557.22589-1-alex.bennee@linaro.org>

---
v2
  - fix a lot of it's/its
  - mention microvm style booting
  - add some questions to the end
---
 docs/interop/booting.rst | 159 +++++++++++++++++++++++++++++++++++++++
 docs/interop/index.rst   |   1 +
 2 files changed, 160 insertions(+)
 create mode 100644 docs/interop/booting.rst

diff --git a/docs/interop/booting.rst b/docs/interop/booting.rst
new file mode 100644
index 00000000000..8579a775d04
--- /dev/null
+++ b/docs/interop/booting.rst
@@ -0,0 +1,159 @@
+..
+  Copyright (c) 2019-2020 Linaro Ltd.
+
+  This work is licensed under the terms of the GNU GPL, version 2 or
+  later. See the COPYING file in the top-level directory.
+
+=====================================
+Anatomy of a Boot, a QEMU perspective
+=====================================
+
+This document attempts to give an overview of how machines boot and
+how this matters to QEMU. We will discuss firmware and BIOSes and the
+things they do before the OS kernel is loaded and your usable system
+is finally ready.
+
+Firmware
+========
+
+When a CPU is powered up it knows nothing about its environment. The
+internal state, including the program counter (PC), will be reset to a
+defined set of values and it will attempt to fetch the first
+instruction and execute it. It is the job of the firmware to bring a
+CPU up from the initial few instructions to running in a relatively
+sane execution environment. Firmware tends to be specific to the
+hardware in question and is stored on non-volatile memory (memory that
+survives a power off) usually a ROM or flash device on the computers
+main board.
+
+Some examples of what firmware does include:
+
+Early Hardware Setup
+--------------------
+
+Modern hardware often requires configuring before it is usable. For
+example most modern systems won't have working RAM until the memory
+controller has been programmed with the correct timings for whatever
+memory is installed on the system. Processors may boot with a very
+restricted view of the memory map until RAM and other key peripherals
+have been configured to appear in its address space. Some hardware
+may not even appear until some sort of blob has been loaded into it so
+it can start responding to the CPU.
+
+Fortunately for QEMU we don't have to worry too much about this very
+low level configuration. The device model we present to the CPU at
+start-up will generally respond to IO access from processor straight
+away.
+
+BIOS or Firmware Services
+-------------------------
+
+In the early days of the PC era the BIOS or Basic Input/Output System
+provided an abstraction interface to the operating system which
+allowed them to do basic IO operations without having to directly
+drive the hardware. Since then the scope of these firmware services
+have grown as systems become more and more complex.
+
+Modern firmware often follows the Unified Extensible Firmware
+Interface (UEFI) which provides services like secure boot, persistent
+variables and external time-keeping.
+
+There can often be multiple levels of firmware service functions. For
+example systems which support secure execution enclaves generally have
+a firmware component that executes in this secure mode which the
+operating system can call in a defined secure manner to undertake
+security sensitive tasks on its behalf.
+
+Hardware Enumeration
+--------------------
+
+It is easy to assume that modern hardware is built to be discover-able
+and all the operating system needs to do is enumerate the various
+buses on the system to find out what hardware exists. While buses like
+PCI and USB do support discovery there is usually much more on a
+modern system than just these two things.
+
+This process of discovery can take some time as devices usually need
+to be probed and some time allowed for the buses to settle and the
+probe complete. For purely virtual machines operating in on-demand
+cloud environments you may operate with stripped down kernels that
+only support a fixed expected environment so they can boot as fast as
+possible.
+
+In the embedded world it used to be acceptable to have a similar
+custom compiled kernel which knew where everything is meant to be.
+However this was a brittle approach and not very flexible. For example
+a general purpose distribution would have to ship a special kernel for
+each variant of hardware you wanted to run on. If you try and use a
+kernel compiled for one platform that nominally uses the same
+processor as another platform the result will rarely work given a
+processor rarely works in isolation.
+
+The more modern approach is to have a "generic" kernel that has a
+number of different drivers compiled in which are then enabled based
+on a hardware description provided by the firmware. This allows
+flexibility on both sides. The software distribution is less concerned
+about managing lots of different kernels for different pieces of
+hardware. The hardware manufacturer is also able to make small changes
+to the board over time to fix bugs or change minor components.
+
+The two main methods for this are the Advanced Configuration and Power
+Interface (ACPI) and Device Trees. ACPI originated from the PC world
+although it is becoming increasingly common for "enterprise" hardware
+like servers. Device Trees of various forms have existed for a while
+with perhaps the most common being Flattened Device Trees (FDT).
+
+Boot Code
+=========
+
+The line between firmware and boot code is a very blurry one. However
+from a functionality point of view we have moved from ensuring the
+hardware is usable as a computing device to finding and loading a
+kernel which is then going to take over control of the system. Modern
+firmware often has the ability to boot a kernel directly and in some
+systems you might chain through several boot loaders before the final
+kernel takes control.
+
+The boot loader needs to do 3 things:
+
+  - find a kernel and load it into RAM
+  - ensure the CPU is in the correct mode for the kernel to boot
+  - pass any information the kernel may need to boot and can't find itself
+
+Once it has done these things it can jump to the kernel and let it get
+on with things.
+
+Kernel
+======
+
+The Kernel now takes over and will be in charge of the system from now
+on. It will enumerate all the devices on the system (again) and load
+drivers that can control them. It will then locate some sort of
+file-system and eventually start running programs that actually do
+work.
+
+Questions to ask yourself
+=========================
+
+Having given this overview of booting here are some questions you
+should ask when diagnosing boot problems.
+
+Hardware
+~~~~~~~~
+
+ - is the platform fixed or dynamic?
+ - is the platform enumeratable (e.g. PCI/USB)?
+
+Firmware
+~~~~~~~~
+
+ - is the firmware built for the platform your are booting?
+ - does the firmware need storage for variables (boot index etc)?
+ - does the firmware provide a service to kernels (e.g. ACPI/EFI)?
+
+Kernel
+~~~~~~
+
+ - is the kernel platform specific or generic?
+ - how will the kernel enumerate the platform?
+ - can the kernel interface talk to the firmware?
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 049387ac6de..58d587444b3 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -12,6 +12,7 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
+   booting
    bitmaps
    dbus
    dbus-vmstate
-- 
2.20.1


