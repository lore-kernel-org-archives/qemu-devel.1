Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A450C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D883B2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2TyY/nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D883B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB2r-0007eY-1W
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsN-0004Ai-IH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsH-0005dJ-Ib
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:43 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAsH-0005b4-A4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:37 -0500
Received: by mail-wm1-x32f.google.com with SMTP id m3so1937265wmi.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=16OwmzPRHLOaxlQLblRm3xfkd1LYqopUI1wfjaSJuJQ=;
 b=u2TyY/nk6+4UCEeQz0F5Is2HumTW/di9pbGGxl9iv7RW+tB9sq0JkxHPNAdZNN+TFo
 UyPLbTYehIOI6X6TKIXYQjm6at//ECjenKJQjQ9vr4xxkzgn7q121TKkmPLwpJlYPdFD
 f/RrNLRk+r11CNtDn5HGTS9TVQFMkoP/V9d7E71MxkU2XVWYFV1sJlFrAg6lpKK2yJ2I
 VOtJSH+rDI65jl+9Z09YCNee/aowdVERuDHRgJ3HwQN0NASsEys/vMZb/hHFI5MGvDcS
 OjgJigRkS62b8ha7dMzOHP3jKjhn9JbH5kLB/vbYeMQxhRUdZKHidWH0DKfRY2HSz0xX
 eC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=16OwmzPRHLOaxlQLblRm3xfkd1LYqopUI1wfjaSJuJQ=;
 b=M68mS+6xHu/fjHDoYN12OunvS6Zfa4HOO81+nT7wvDNcX9MDwNxU7qE2MXQdJ7Eodf
 eIynjn/DN0Ao+K6Tz1rVUbF9Z74QB/tgUALr8Gdpb5vOP1pyDBUWuRxTQbGgKqZDfKkO
 bXeRy+nu8Jp7OXhh3irVnzgRpNncjhhJsnHL8Oj18xJaBVUzzL9HgqG5gk9YFcsUY1N/
 ald5Zp0ywi9k8nd0jmiwrHVTnHEeLHtKmbZiqZQn/hXC5G+V7dtxkMHutJ29qOJ+4sHx
 9d1iSAxwiII6PKkYipfBYVkQZzxZWGFU1uAymsGMv1Vv6mARCwyxHurYNawZOetsChUZ
 lcCw==
X-Gm-Message-State: ANhLgQ3Xd6i6VEz//phvRO1TtTj5YDMnaVvg9KpU4kQu409w6GjkcoOb
 LsFYwBBDZyN70NHyyYS/iz5gzd3hUSnOJw==
X-Google-Smtp-Source: ADFU+vt7IqiNADOWnlcJXVUaDlJvWP3QxKcW5voUwMScZdn3ZlKCRVtLcmq0+kNLzQhVIOuUAslqkQ==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr3377392wme.173.1583493035855; 
 Fri, 06 Mar 2020 03:10:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/33] docs: Roll semihosting option information into
 qemu-options.hx
Date: Fri,  6 Mar 2020 11:09:49 +0000
Message-Id: <20200306110959.29461-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-24-peter.maydell@linaro.org
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
index 5a4ac8e2396..753bfce411d 100644
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


