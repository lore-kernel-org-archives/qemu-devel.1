Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D682246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXcyW0qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D682246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hon-00088j-Ac
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhF-0001JU-Vi
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhE-000541-9L
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:01 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hhE-00053V-2A
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:00 -0500
Received: by mail-wm1-x344.google.com with SMTP id d138so2061464wmd.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rcTOxmGJvEcnHNYtm2Z20U2zPTmk9K/wu8AwBVdhKP4=;
 b=gXcyW0qg7lCQOTjYSKdbNj0e4j0bPUiQs2pLGdpXznU1St3IdmVTry2/cLhXr5Xo3a
 zf3OlkAIUEMIyWvLUfdmWglR2q67kbdcxD+7e/KuhMsEaxNag63GjNObuMDyaqctx2eh
 TCUuewU0FH3K35uHCGXMFbCkKe/9cZ23MbyWAak25gKdKDzWRi8BZR07OdB3muxWnj5f
 Di4NBkbSInWJDYeeHdrXxCcyFoNPuRv492iLNaTya3vugo5JRdCOz9XQlhiIE8Nm1iB9
 VSuAP4Y8gQOlsrL2P375vNpJA58YM3yYIo5tSaqfxAu1QLq4xE2kSVy1zzcrMQVPX8Pr
 HEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rcTOxmGJvEcnHNYtm2Z20U2zPTmk9K/wu8AwBVdhKP4=;
 b=Triksv1Lb/woyAx2y4bIhBB3fo94YBweZgodatxK2LvVtmTHjCS0+hqDg/r1VS2cb2
 BSS0dzU0W7fXhFxHaaRTnOhkfeWN22ddqNq2Tr9b/IGF+bw/QA+2Z+4TbyOpCOKHYfbY
 1NN9zP9R0Z0+l9PPj5bceHFmJ86GlLSEVpPodF14Y0XJQDlcdBoT78svod1ahQ6Gt+vg
 8fppfs3/xR3dKC8LaAdRqrYVLFprPvtTT2L/yz4MSnd29q/GM24ZkMGbGjooNgUCzuCp
 7uYo7ZJCvIMNg+3SVzAftEokdoXBilvAgmEZMxONhe5WuhSixhlLHU32iNrJKYBbjUyv
 h76A==
X-Gm-Message-State: APjAAAUStWIuYYwhfaU7yaSj/23yJEny5143t5olin96WKssTeoWT/+O
 tSk7zebZIxmb36H9bA/P0QVxKOaJ/S5crQ==
X-Google-Smtp-Source: APXvYqy0BwRtnkxQV9i3//ImsyD2plvpQh9yy6Vkb7P7mJ0eIFJLl6gChEL78vlqbbik4D/XHS7cIg==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr5640997wme.82.1582904218695; 
 Fri, 28 Feb 2020 07:36:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/33] docs: Roll semihosting option information into
 qemu-options.hx
Date: Fri, 28 Feb 2020 15:36:09 +0000
Message-Id: <20200228153619.9906-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the per-target documentation for those targets that
implement semihosting includes a bit of text that goes into both the
manual and the manpage about options specific to the target.  This
text is redundant with the earlier generic option description of the
semihosting option produced from qemu-options.hx. To avoid having
to create a lot of stub include files to include into the rST
generated qemu.1 manpage, roll target-specific bits of information
into the qemu-options.hx text, so the user doesn't have to look
in two places for this information.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Yes, it would in theory make sense to do this before generating
the rst from the texi docs, but I didn't realize this was a
good idea until well after Paolo had done that part.
---
 docs/system/target-arm.rst     | 10 ----------
 docs/system/target-arm.texi    | 18 ------------------
 docs/system/target-m68k.rst    | 11 -----------
 docs/system/target-m68k.texi   | 19 -------------------
 docs/system/target-xtensa.rst  | 12 ------------
 docs/system/target-xtensa.texi | 20 --------------------
 qemu-options.hx                | 18 ++++++++++++++++++
 7 files changed, 18 insertions(+), 90 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 0490be55871..d2a3b44ce88 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -215,13 +215,3 @@ emulation includes the following elements:
 
 A Linux 2.6 test image is available on the QEMU web site. More
 information is available in the QEMU mailing-list archive.
-
-The following options are specific to the ARM emulation:
-
-``-semihosting``
-   Enable semihosting syscall emulation.
-
-   On ARM this implements the \"Angel\" interface.
-
-   Note that this allows guest direct access to the host filesystem, so
-   should only be used with trusted guest OS.
diff --git a/docs/system/target-arm.texi b/docs/system/target-arm.texi
index c56b5f6ebfe..eb80dd35f0b 100644
--- a/docs/system/target-arm.texi
+++ b/docs/system/target-arm.texi
@@ -243,21 +243,3 @@ Three on-chip UARTs
 A Linux 2.6 test image is available on the QEMU web site. More
 information is available in the QEMU mailing-list archive.
 
-@c man begin OPTIONS
-
-The following options are specific to the ARM emulation:
-
-@table @option
-
-@item -semihosting
-Enable semihosting syscall emulation.
-
-On ARM this implements the "Angel" interface.
-
-Note that this allows guest direct access to the host filesystem,
-so should only be used with trusted guest OS.
-
-@end table
-
-@c man end
-
diff --git a/docs/system/target-m68k.rst b/docs/system/target-m68k.rst
index 50b7dd9d639..d28d3b92e5e 100644
--- a/docs/system/target-m68k.rst
+++ b/docs/system/target-m68k.rst
@@ -19,14 +19,3 @@ The AN5206 emulation includes the following devices:
 -  MCF5206 ColdFire V2 Microprocessor.
 
 -  Two on-chip UARTs.
-
-The following options are specific to the ColdFire emulation:
-
-``-semihosting``
-   Enable semihosting syscall emulation.
-
-   On M68K this implements the \"ColdFire GDB\" interface used by
-   libgloss.
-
-   Note that this allows guest direct access to the host filesystem, so
-   should only be used with trusted guest OS.
diff --git a/docs/system/target-m68k.texi b/docs/system/target-m68k.texi
index a77b19ea0f1..dcce7bc8c56 100644
--- a/docs/system/target-m68k.texi
+++ b/docs/system/target-m68k.texi
@@ -23,22 +23,3 @@ MCF5206 ColdFire V2 Microprocessor.
 @item
 Two on-chip UARTs.
 @end itemize
-
-@c man begin OPTIONS
-
-The following options are specific to the ColdFire emulation:
-
-@table @option
-
-@item -semihosting
-Enable semihosting syscall emulation.
-
-On M68K this implements the "ColdFire GDB" interface used by libgloss.
-
-Note that this allows guest direct access to the host filesystem,
-so should only be used with trusted guest OS.
-
-@end table
-
-@c man end
-
diff --git a/docs/system/target-xtensa.rst b/docs/system/target-xtensa.rst
index 43cab8dc4da..8d703ad769e 100644
--- a/docs/system/target-xtensa.rst
+++ b/docs/system/target-xtensa.rst
@@ -25,15 +25,3 @@ The Avnet LX60/LX110/LX200 emulation supports:
 -  16550 UART
 
 -  OpenCores 10/100 Mbps Ethernet MAC
-
-The following options are specific to the Xtensa emulation:
-
-``-semihosting``
-   Enable semihosting syscall emulation.
-
-   Xtensa semihosting provides basic file IO calls, such as
-   open/read/write/seek/select. Tensilica baremetal libc for ISS and
-   linux platform \"sim\" use this interface.
-
-   Note that this allows guest direct access to the host filesystem, so
-   should only be used with trusted guest OS.
diff --git a/docs/system/target-xtensa.texi b/docs/system/target-xtensa.texi
index 40327de6fa7..1e6c04dccd6 100644
--- a/docs/system/target-xtensa.texi
+++ b/docs/system/target-xtensa.texi
@@ -33,23 +33,3 @@ A range of Xtensa CPUs, default is the DC232B
 @item
 OpenCores 10/100 Mbps Ethernet MAC
 @end itemize
-
-@c man begin OPTIONS
-
-The following options are specific to the Xtensa emulation:
-
-@table @option
-
-@item -semihosting
-Enable semihosting syscall emulation.
-
-Xtensa semihosting provides basic file IO calls, such as open/read/write/seek/select.
-Tensilica baremetal libc for ISS and linux platform "sim" use this interface.
-
-Note that this allows guest direct access to the host filesystem,
-so should only be used with trusted guest OS.
-
-@end table
-
-@c man end
-
diff --git a/qemu-options.hx b/qemu-options.hx
index 5fbfa2797cb..4bc8048f60b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4116,6 +4116,12 @@ STEXI
 @item -semihosting
 @findex -semihosting
 Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
+
+Note that this allows guest direct access to the host filesystem, so
+should only be used with a trusted guest OS.
+
+See the -semihosting-config option documentation for further information
+about the facilities this enables.
 ETEXI
 DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
     "-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,arg=str[,...]]\n" \
@@ -4126,6 +4132,18 @@ STEXI
 @item -semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,arg=str[,...]]
 @findex -semihosting-config
 Enable and configure semihosting (ARM, M68K, Xtensa, MIPS, Nios II only).
+
+Note that this allows guest direct access to the host filesystem, so
+should only be used with a trusted guest OS.
+
+On Arm this implements the standard semihosting API, version 2.0.
+
+On M68K this implements the "ColdFire GDB" interface used by libgloss.
+
+Xtensa semihosting provides basic file IO calls, such as
+open/read/write/seek/select. Tensilica baremetal libc for ISS and
+linux platform "sim" use this interface.
+
 @table @option
 @item target=@code{native|gdb|auto}
 Defines where the semihosting calls will be addressed, to QEMU (@code{native})
-- 
2.20.1


