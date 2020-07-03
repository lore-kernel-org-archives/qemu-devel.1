Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA32C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0DD2084C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5FGmjMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0DD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPgc-0000bw-Ae
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jrPfW-0007xM-IW
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 13:40:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jrPfU-0007eV-3t
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 13:40:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id o2so34850636wmh.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xTtBdZoEmYeIU7YNVe2YymIzDUGlO7yqYHdq+RnoNP4=;
 b=S5FGmjMt48K5jkYGqa2v4rls7nB2/Kj6NWq1fD6kzMbgPsVtgIefvINtDPMnWDuWGq
 W4KoQ3ZWDo+WT308EmHxUyNCqgE0NlzdYVltdk3/7aMnwKuTlY5hkIPqfnKM+yLrwxm8
 f6TBQdDQz3BJ+1zuMT7oSfZHa47VjrMRnkx0NeLYQi14IgzQ4ogFQwGIaaFirAOfVlsB
 seY+NBkP4gfVgFNCgOem04A61gX0COLAF0y/kzme0J4LJN4NbYPEKiVwcZ8BjCyTFwkB
 SVByR81BRf/9s7AfI4w0C+V/9vHfsSeBUS2xhKU0hJmSHqVFfbly1NU1pjFXPAQ3wWN3
 Laqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xTtBdZoEmYeIU7YNVe2YymIzDUGlO7yqYHdq+RnoNP4=;
 b=GB1nq2OyeS/ax5AmtQH54owmxF5i8uWuYLHpmJe6yBfHyvw2ghG2XtUD3iaDOOHPE4
 DJN6jJOPxYoQHkdZ8Og+PhYyzzGCCRPJ59RuuqV1r7KxHTsAFmtaAGnKVGXsTrZ2YCLO
 nE1HtPJuARlF8KRc0xofwLCLBkThZYYEJnrweB9GOXfRokdIZKwZTZ/EUB2NmL1MLtsk
 kIEl9GS8Eo5+sppbLbJpiSvz4I5n1Re70U9auWEq+oHTrtxNY40zegbx/g2Wf9KMpVDX
 tWKE5SgaGbX3z9GyFgHIY222qjglRVgAu2XiPf9CTDs0nDkxFa4/hE0XpZp/oMPqMnPT
 pfbg==
X-Gm-Message-State: AOAM532gvPDfsbGctRv7uXHoD0alcEhBupR4/+Yu9CbDtCVtaRg3OZDa
 MLFXBhNGSlqysZM2mXStseWzCQ==
X-Google-Smtp-Source: ABdhPJzMNSRsU2YV6wBH4Fy6F5ytCN0VJQ3gWvhyzM/87H8q3/i/mSLcspV/lzz1vJyKlMo+TjGdmg==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr39357237wmb.92.1593798006017; 
 Fri, 03 Jul 2020 10:40:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q4sm13737103wmc.1.2020.07.03.10.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 10:40:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 55A8E1FF7E;
 Fri,  3 Jul 2020 18:40:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] blog post: Anatomy of a Boot, a QEMU perspective
Date: Fri,  3 Jul 2020 18:39:48 +0100
Message-Id: <20200703173948.22156-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: pbonzini@redhat.com, thuth@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While working on some test cases I realised there was quite a lot of
assumed knowledge about how things boot up. I thought it would be
worth gathering this together in a user facing document where we could
pour in the details and background to the boot process. The consensus
seems to be this is better as a blog post.

The post follows the socratic method and leaves the reader to ask
themselves some questions in an effort to elucidate them about any
problems they may be having before telling them that they probably
wanted to use virt-manager all along.

Based on Message-Id: <20200701161153.30988-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[rth: review of doc form]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v3
  - convert from doc to blog post
  - address pm's comments
  - new intro/outro for blog style
---
 _posts/2020-07-03-anatomy-of-a-boot.md | 161 +++++++++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 _posts/2020-07-03-anatomy-of-a-boot.md

diff --git a/_posts/2020-07-03-anatomy-of-a-boot.md b/_posts/2020-07-03-anatomy-of-a-boot.md
new file mode 100644
index 0000000..67aa72c
--- /dev/null
+++ b/_posts/2020-07-03-anatomy-of-a-boot.md
@@ -0,0 +1,161 @@
+---
+layout: post
+title:  "Anatomy of a Boot, a QEMU perspective"
+date:   2020-07-3 18:00:00:00 +0000
+last_modified_at: 2020-07-3 18:00:00:00 +0000
+author: Alex Bennée
+categories: [boot, softmmu, system, firmware]
+---
+
+Have you ever wondered about the process a machine goes through to get
+to the point of a usable system? This post will give an overview of
+how machines boot and how this matters to QEMU. We will discuss
+firmware and BIOSes and the things they do before the OS kernel is
+loaded and your usable system is finally ready.
+
+## Firmware
+
+When a CPU is powered up it knows nothing about its environment. The
+internal state, including the program counter (PC), will be reset to a
+defined set of values and it will attempt to fetch the first
+instruction and execute it. It is the job of the firmware to bring a
+CPU up from the initial few instructions to running in a relatively
+sane execution environment. Firmware tends to be specific to the
+hardware in question and is stored on non-volatile memory (memory that
+survives a power off), usually a ROM or flash device on the computers
+main board.
+
+Some examples of what firmware does include:
+
+### Early Hardware Setup
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
+start-up will generally respond to IO access from the processor straight
+away.
+
+### BIOS or Firmware Services
+
+In the early days of the PC era the BIOS or Basic Input/Output System
+provided an abstraction interface to the operating system which
+allowed the OS to do basic IO operations without having to directly
+drive the hardware. Since then the scope of these firmware services
+has grown as systems become more and more complex.
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
+### Hardware Enumeration
+
+It is easy to assume that modern hardware is built to be discoverable
+and all the operating system needs to do is enumerate the various
+buses on the system to find out what hardware exists. While buses like
+PCI and USB do support discovery there is usually much more on a
+modern system than just these two things.
+
+This process of discovery can take some time as devices usually need
+to be probed and some time allowed for the buses to settle and the
+probe to complete. For purely virtual machines operating in on-demand
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
+processor as another platform the result will generally not work.
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
+## Boot Code
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
+## Kernel
+
+The Kernel now takes over and will be in charge of the system from now
+on. It will enumerate all the devices on the system (again) and load
+drivers that can control them. It will then locate some sort of
+file-system and eventually start running programs that actually do
+work.
+
+## Questions to ask yourself
+
+Having given this overview of booting here are some questions you
+should ask when diagnosing boot problems.
+
+### Hardware
+
+ - is the platform fixed or dynamic?
+ - is the platform enumeratable (e.g. PCI/USB)?
+
+### Firmware
+
+ - is the firmware built for the platform you are booting?
+ - does the firmware need storage for variables (boot index etc)?
+ - does the firmware provide a service to kernels (e.g. ACPI/EFI)?
+
+### Kernel
+
+ - is the kernel platform specific or generic?
+ - how will the kernel enumerate the platform?
+ - can the kernel interface talk to the firmware?
+
+## Final Thoughts
+
+When users visit the IRC channel to ask why a particular kernel won't
+boot our first response is almost always to check the kernel is
+actually matched to the hardware being instantiated. For ARM boards in
+particular just being built for the same processor is generally not
+enough and hopefully having made it through this post you see why.
+This complexity is also the reason why we generally suggest using a
+tool like [virt-manager](https://virt-manager.org/) to configure QEMU
+as it is designed to ensure the right components and firmware is
+selected to boot a given system.
+
-- 
2.20.1


