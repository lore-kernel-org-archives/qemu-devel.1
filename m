Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B60FC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CA520637
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Otn28647"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CA520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ux7-0005dc-EQ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utj-0000bN-Ul
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uti-0005m1-5h
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:55048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6uth-0005gP-TY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:38 -0500
Received: by mail-wm1-x32b.google.com with SMTP id z12so2615109wmi.4
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y1LvmpAvWY/E4+GUNJp+foSRXvnPQShOlaVFvp9wP6g=;
 b=Otn28647bpgLh1VHTA2i/W3h0tDPqNKzT5wJY8vAiXFu2h5pCBHF8XJ3O5ZraOh58H
 sdEZUHZ7bResc7uyNh7E3DG+gXZyK8bD1+WvV/K7Jl579A+++f/i23Wf/cBnV3ELPpaj
 An3k/PbxKd/NDV3DuFd+X1Ob8fOaRhFvs1MICEDlyOS8nr/TlwqkbOIE5iBf7hgX4SS1
 vMb6vcSzLOayn0Y80jVLMnEnYAL3jJXIrkiUjiFhMvtcZlzEjDm7U6ycbCGKL560jEtV
 TeM2xzzJbrQhtjzfX89uqsLUSuI7ZtMdr9iDPKUxdDwwgjAab7l/YUgyfL0SMtDfPJOj
 Y/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Y1LvmpAvWY/E4+GUNJp+foSRXvnPQShOlaVFvp9wP6g=;
 b=iSFyus+97cM9medfFsOQ8+hNXlDKJdPUZL/231iaZ0x56apuBKXF36/LDTwTSvYd6Y
 iRaUlRmPG1gyCXkPej+yjFLy5BC7XLWs7SbYesMzQj9+6gJ4ROh15mSN6kaXtNnzKNWp
 EPW+/bvkVMuNoXf88PZtn8bVNAuvyjXHoJ5W05UO9K7JPyGMEnJOA4AbgRTVrLqswkfW
 DZ5uIIMonBcEGR84udmewzMQGLueLj1YrgCWQQUEu8/WdEcHQXLaRi6guuXmYaWMaRqp
 07CAUpGh20RKugIIHMePTXyJI5/VQacgEZ1p2ugeR0P89J8kdFMhxY8SFcb3vuOS2DPt
 0rUA==
X-Gm-Message-State: APjAAAWGbA7tWzzC4CtkgLTVdn0iwNFQVW6NEoWTLnjmPnLC3GxaqCK1
 hyVWhRNhd6f5kiFAE4xcdrd2u833
X-Google-Smtp-Source: APXvYqyn0f4qo//k9v/G3CNa5QS/zLtjNrmjqlw6oNzmMloaUIimGmSwPRQpgnwVv/O4WqchCXa9Uw==
X-Received: by 2002:a05:600c:3ce:: with SMTP id
 z14mr4907852wmd.106.1582716636260; 
 Wed, 26 Feb 2020 03:30:36 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/18] qemu-doc: remove target OS documentation
Date: Wed, 26 Feb 2020 12:30:18 +0100
Message-Id: <20200226113034.6741-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 96 ---------------------------------------------------
 1 file changed, 96 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 6636816b85..e555dea4ef 100644
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
2.21.1



