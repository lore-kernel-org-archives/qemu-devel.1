Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5089CC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201CD20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdd06lq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201CD20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dFj-0000ON-9l
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6dDf-0005u6-PH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6dDe-0004Lm-Ah
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:03 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6dDe-0004LG-4K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:02 -0500
Received: by mail-wr1-x429.google.com with SMTP id j7so2988242wrp.13
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uGepI8Ex+4CurOhs/5gC6fV7ZVXGsbEMjYfPjB8FFPg=;
 b=gdd06lq2vG4mta7hGzkfvv3eG3gOMX+IYHV34Th3aW9NbkujIuYey4x0ZTDBgG9NjL
 QNQVfot/vrQCgo9AnsniodBmrR07tpyP9JAeqUqTSnZO7BAGP2fV7sfPT+8FhcurdVsf
 Z+5dNfpx/7Gr5sp/tFaBHTH7pBzejhVRejO0Bvh+ghoC/ZjcagFoVUIzihe8z/wXLrKX
 bfVn0rdEOVIGvT20m1W0HtKmLxBxTy0wDXllLfEtgMlRYfH/7N5Qu5eYZledi8BKJd/0
 b9v800hNiTAYKBkvbQnsMMPJrA7CIK0VEHsjev1jROK4SDcMeZgEvad89PIiTXuhab/W
 1CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uGepI8Ex+4CurOhs/5gC6fV7ZVXGsbEMjYfPjB8FFPg=;
 b=QUMfi5s0GBRc+xkaEMpF5b5HcsHBidJjSXZy9zSEoN6SNrUS7ooZoBRhH63glmteYi
 OX0qGxYKSIWl9+EJYv88lzh95msoiqB3PeQxmZ/1qG7u5hIL5RTSG08JOh5nL4yrVpE1
 Ce/u6DDgwog2RfFNRGrhtAtoc/bCH//LernzMujeBMydvg0MXQd6JddaYwrgKTK4vd1O
 9tCKBJFJUUfyO7ibpRQPITZFGnm7oTw7zUmGNk+L4WiXBwE+ffk9qDSFRKpl4CZL62oq
 0aUzynLRllH1nOpyQL/VGa8drg0hCjQYQJS081/dOuE7aAxNZbK0m7XWYUYIu29z2+kC
 s3mw==
X-Gm-Message-State: APjAAAVmOW1Idi0LWuJSZ4rqMk2RChUH/TYPFwufw7KqZnHpBJBDoRDT
 wnfW9UX6mX72kxwNPvjzOvpyS3uk
X-Google-Smtp-Source: APXvYqy3p9FI3Ehh+fyrpqpl/WdmJ5FXrgRx2xIDAV6s5q7Hm1Rlkio4dj3muCO2ltcOP5wLxVqJ4w==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr75168068wrs.237.1582648680436; 
 Tue, 25 Feb 2020 08:38:00 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id q6sm18171398wrf.67.2020.02.25.08.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 08:37:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] docs: system: remove target OS documentation
Date: Tue, 25 Feb 2020 17:37:55 +0100
Message-Id: <20200225163758.12996-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225163758.12996-1-pbonzini@redhat.com>
References: <20200225163758.12996-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This section covers OSes up to Windows 2000, and as such it is mostly
obsolete.  Zap it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 96 ---------------------------------------------------
 1 file changed, 96 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 33b9597b1d..56d3e57cfb 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -149,7 +149,6 @@ accelerator is required to use more than one host CPU for emulation.
 * vnc_security::       VNC security
 * network_tls::        TLS setup for network services
 * gdb_usage::          GDB usage
-* pcsys_os_specific::  Target OS specific information
 @end menu
 
 @node pcsys_introduction
@@ -1606,101 +1605,6 @@ received: "OK"
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
2.21.1



