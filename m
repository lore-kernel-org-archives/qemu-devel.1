Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D12C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF888246AE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TycxlpzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF888246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hhn-00028A-QW
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgi-0000Q7-9E
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgg-0004iZ-Pt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:28 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hgg-0004i2-Ja
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id m3so3680663wmi.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qga3wQCpFPtxhxjWgweb1CumXVlN+As5UcrMUSwe4/k=;
 b=TycxlpzPRLU+FZ4hxgGBHxz/0558AFLacv3L8xufxYkS0po3VNdLFJ+v3bEEOdNlmN
 UoO8TBoDKA03b5JhdVb2rSkNozwgA1jLLGznJABvYvs/ff+ZMwYNvsdykqyMCY6Ni2qb
 gJ/EOKPRty0dfroAz0tEl5TYATkyOdzkGM5cT5M2M4OADPTD0co5BQ+7xcq5+HDr9h4k
 sBd83WZyjq+uZF1MvntP/43ofvSlJgSQHVA4GrZy/FNNnULlqVhCa9ef5ARgoVBRZKr8
 NXx9iiNGuy3fkO3kKlEtPOuBiVtzJ1vqt1pykwz8CTvygAIsXYX1dqvlShH/kbkuW2j5
 I1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qga3wQCpFPtxhxjWgweb1CumXVlN+As5UcrMUSwe4/k=;
 b=d1thGX+P5yOeP/ZkNHDn8BNxqXbmYGgeB0dEmA6Bh+f1JnXqLRkY28O4f90b6ibv8b
 WdpwDVrCbKPiHS9QL72oBRN29n/bLhrbW0h8LSBcDVqJEpFALH2qzfnUUa+mt1iNUCdg
 OE0XlwFfZGkLReakfJtAyo7zqgwhCnRCqv9RUMAELzL0w/1dkrkwnJgj4BAFwS1ptp9V
 9HpcaMAbLXkIGaQYbxtxRvsg+GcTDTV8HKrMZQkktosguTi2lvRXnhLeRG0vh2f2vB6c
 EYVTWEGANLep3biVne2zxwX+3uAmPxEkc1Su0m83CcHn7Zn0UbQ7Bk4ENsVpxuK1CXWG
 5yjQ==
X-Gm-Message-State: APjAAAWfBBZ/HhasILlnLMQKzECvcsNgkDtvQ2qE1eswtdY1qPYWIzVk
 2JFR/6bzAGUzm+O5j5EypXXfgq0+sKdG5g==
X-Google-Smtp-Source: APXvYqx1z5hffNiw1lxuD7BZxumdNpFI3cOvQ+jNxDiriM8zR1xqGo0cz/M+1pw42PUA7tMR0Qs5sw==
X-Received: by 2002:a7b:c30a:: with SMTP id k10mr58229wmj.20.1582904185131;
 Fri, 28 Feb 2020 07:36:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/33] qemu-doc: remove target OS documentation
Date: Fri, 28 Feb 2020 15:35:48 +0000
Message-Id: <20200228153619.9906-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

From: Paolo Bonzini <pbonzini@redhat.com>

This section covers OSes up to Windows 2000, and as such it is mostly
obsolete.  Zap it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200226113034.6741-3-pbonzini@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-doc.texi | 96 ---------------------------------------------------
 1 file changed, 96 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 6636816b85f..e555dea4ef6 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -148,7 +148,6 @@ accelerator is required to use more than one host CPU for emulation.
 * vnc_security::       VNC security
 * network_tls::        TLS setup for network services
 * gdb_usage::          GDB usage
-* pcsys_os_specific::  Target OS specific information
 @end menu
 
 @node pcsys_introduction
@@ -1605,101 +1604,6 @@ received: "OK"
 @end example
 @end table
 
-@node pcsys_os_specific
-@section Target OS specific information
-
-@subsection Linux
-
-To have access to SVGA graphic modes under X11, use the @code{vesa} or
-the @code{cirrus} X11 driver. For optimal performances, use 16 bit
-color depth in the guest and the host OS.
-
-When using a 2.6 guest Linux kernel, you should add the option
-@code{clock=pit} on the kernel command line because the 2.6 Linux
-kernels make very strict real time clock checks by default that QEMU
-cannot simulate exactly.
-
-When using a 2.6 guest Linux kernel, verify that the 4G/4G patch is
-not activated because QEMU is slower with this patch. The QEMU
-Accelerator Module is also much slower in this case. Earlier Fedora
-Core 3 Linux kernel (< 2.6.9-1.724_FC3) were known to incorporate this
-patch by default. Newer kernels don't have it.
-
-@subsection Windows
-
-If you have a slow host, using Windows 95 is better as it gives the
-best speed. Windows 2000 is also a good choice.
-
-@subsubsection SVGA graphic modes support
-
-QEMU emulates a Cirrus Logic GD5446 Video
-card. All Windows versions starting from Windows 95 should recognize
-and use this graphic card. For optimal performances, use 16 bit color
-depth in the guest and the host OS.
-
-If you are using Windows XP as guest OS and if you want to use high
-resolution modes which the Cirrus Logic BIOS does not support (i.e. >=
-1280x1024x16), then you should use the VESA VBE virtual graphic card
-(option @option{-std-vga}).
-
-@subsubsection CPU usage reduction
-
-Windows 9x does not correctly use the CPU HLT
-instruction. The result is that it takes host CPU cycles even when
-idle. You can install the utility from
-@url{https://web.archive.org/web/20060212132151/http://www.user.cityline.ru/~maxamn/amnhltm.zip}
-to solve this problem. Note that no such tool is needed for NT, 2000 or XP.
-
-@subsubsection Windows 2000 disk full problem
-
-Windows 2000 has a bug which gives a disk full problem during its
-installation. When installing it, use the @option{-win2k-hack} QEMU
-option to enable a specific workaround. After Windows 2000 is
-installed, you no longer need this option (this option slows down the
-IDE transfers).
-
-@subsubsection Windows 2000 shutdown
-
-Windows 2000 cannot automatically shutdown in QEMU although Windows 98
-can. It comes from the fact that Windows 2000 does not automatically
-use the APM driver provided by the BIOS.
-
-In order to correct that, do the following (thanks to Struan
-Bartlett): go to the Control Panel => Add/Remove Hardware & Next =>
-Add/Troubleshoot a device => Add a new device & Next => No, select the
-hardware from a list & Next => NT Apm/Legacy Support & Next => Next
-(again) a few times. Now the driver is installed and Windows 2000 now
-correctly instructs QEMU to shutdown at the appropriate moment.
-
-@subsubsection Share a directory between Unix and Windows
-
-See @ref{sec_invocation} about the help of the option
-@option{'-netdev user,smb=...'}.
-
-@subsubsection Windows XP security problem
-
-Some releases of Windows XP install correctly but give a security
-error when booting:
-@example
-A problem is preventing Windows from accurately checking the
-license for this computer. Error code: 0x800703e6.
-@end example
-
-The workaround is to install a service pack for XP after a boot in safe
-mode. Then reboot, and the problem should go away. Since there is no
-network while in safe mode, its recommended to download the full
-installation of SP1 or SP2 and transfer that via an ISO or using the
-vvfat block device ("-hdb fat:directory_which_holds_the_SP").
-
-@subsection MS-DOS and FreeDOS
-
-@subsubsection CPU usage reduction
-
-DOS does not correctly use the CPU HLT instruction. The result is that
-it takes host CPU cycles even when idle. You can install the utility from
-@url{https://web.archive.org/web/20051222085335/http://www.vmware.com/software/dosidle210.zip}
-to solve this problem.
-
 @node QEMU System emulator for non PC targets
 @chapter QEMU System emulator for non PC targets
 
-- 
2.20.1


