Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4108DC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDD9206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvH3pfMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDD9206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMKy-0004dZ-6q
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGH-0003ju-Gs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMGF-00026j-02
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMGE-00026D-Pi
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id m3so5916274wmi.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eBeviPrcWH2dai694kmgJG+Ywc1WYHHnCivC/RAq/0g=;
 b=xvH3pfMrGHi1BcGKbUq1vR52SrR8gcFFdtwAx9gSd+caqvZG0yByMlDcgS9/oRt8Fe
 AsPQbfIjpSnglGMupWoLe3AW207cn5hKpjIlaumkfyOMfZU9+lJpZ4s5iQ5rRR6Cjjqf
 TDcw4U9SXYXwkQzgyEZrJHVDUd2jb2eRMVIyElzfWLD5iwuYocqJeG7pBqEyvzDTKRqE
 hlQQKPTHAZnJApGHACivVmEJG+J/805Rpy/36aIQqzlaxgd9dXFjNSPn22u9DZBNV+1d
 kQ+g4k09FUOxsOWmHdbgDxIkdxpzcroi8bFtluMtKXfZygvxpTHXs31/OroQr0D9YN2d
 vgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eBeviPrcWH2dai694kmgJG+Ywc1WYHHnCivC/RAq/0g=;
 b=IkwJzXAzUbWkS5VOBEPTCqxUo+LsEntQu3BVz55IroLVFUUJyY0xGkYAvFkge0UYGN
 TPn9feepiQgeR73MreO32+gtUVDhpNlZJyemsS/gieFal9xzf5izqd9VxZ2qEDz2bxIv
 5EMlmzKRjQ871xlmFFbSMGhxWO/Eq2+ZzIkBUtT/7o0SYXqxVwgQDelsWQoGxu8WtUKn
 i4FhL0IfA61/n4fLxeIT0RvIegfUqfp5KIVhgRFSp3JRdmYslmX3BCgO/7aqqsCyuiRq
 Wv1qbvmE4g3jLqNapCPtmCz08SKDjbu877HrBx60rPDpEQc4e7gAJllq4T0Q+c2F1mDg
 WoUA==
X-Gm-Message-State: ANhLgQ2nFA4dxgPldf2nGobQMBgBiungKsdMyb4K4EiGsYR3EVnzJRqg
 n/3XsAJPW+oofqAZyKP44+e3RQVKpEtwmg==
X-Google-Smtp-Source: ADFU+vvhspBUKYHgtA7IEj/VLpATN4ocKPDs216Xmvm0pe5I2tMjyyqI3nftazUGfuAM3IkzSKfjaA==
X-Received: by 2002:a7b:c454:: with SMTP id l20mr4699475wmi.189.1584013461450; 
 Thu, 12 Mar 2020 04:44:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] docs/system/target-arm.rst: Add some introductory text
Date: Thu, 12 Mar 2020 11:44:06 +0000
Message-Id: <20200312114408.16891-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we've moved the various bits of per-board documentation into
their own files, the top level document is a little bare. Add
some introductory information, including a note that many
of the board models we support are currently undocumented.

(Most sections of this new text were originally written by me
for the wiki page https://wiki.qemu.org/Documentation/Platforms/ARM)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200309215818.2021-4-peter.maydell@linaro.org
---
 docs/system/target-arm.rst | 66 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index c7df6fc1f97..86ea6f2f568 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -1,9 +1,71 @@
 .. _ARM-System-emulator:
 
-ARM System emulator
+Arm System emulator
 -------------------
 
-Use the executable ``qemu-system-arm`` to simulate a ARM machine.
+QEMU can emulate both 32-bit and 64-bit Arm CPUs. Use the
+``qemu-system-aarch64`` executable to simulate a 64-bit Arm machine.
+You can use either ``qemu-system-arm`` or ``qemu-system-aarch64``
+to simulate a 32-bit Arm machine: in general, command lines that
+work for ``qemu-system-arm`` will behave the same when used with
+``qemu-system-aarch64``.
+
+QEMU has generally good support for Arm guests. It has support for
+nearly fifty different machines. The reason we support so many is that
+Arm hardware is much more widely varying than x86 hardware. Arm CPUs
+are generally built into "system-on-chip" (SoC) designs created by
+many different companies with different devices, and these SoCs are
+then built into machines which can vary still further even if they use
+the same SoC. Even with fifty boards QEMU does not cover more than a
+small fraction of the Arm hardware ecosystem.
+
+The situation for 64-bit Arm is fairly similar, except that we don't
+implement so many different machines.
+
+As well as the more common "A-profile" CPUs (which have MMUs and will
+run Linux) QEMU also supports "M-profile" CPUs such as the Cortex-M0,
+Cortex-M4 and Cortex-M33 (which are microcontrollers used in very
+embedded boards). For most boards the CPU type is fixed (matching what
+the hardware has), so typically you don't need to specify the CPU type
+by hand, except for special cases like the ``virt`` board.
+
+Choosing a board model
+======================
+
+For QEMU's Arm system emulation, you must specify which board
+model you want to use with the ``-M`` or ``--machine`` option;
+there is no default.
+
+Because Arm systems differ so much and in fundamental ways, typically
+operating system or firmware images intended to run on one machine
+will not run at all on any other. This is often surprising for new
+users who are used to the x86 world where every system looks like a
+standard PC. (Once the kernel has booted, most userspace software
+cares much less about the detail of the hardware.)
+
+If you already have a system image or a kernel that works on hardware
+and you want to boot with QEMU, check whether QEMU lists that machine
+in its ``-machine help`` output. If it is listed, then you can probably
+use that board model. If it is not listed, then unfortunately your image
+will almost certainly not boot on QEMU. (You might be able to
+extract the filesystem and use that with a different kernel which
+boots on a system that QEMU does emulate.)
+
+If you don't care about reproducing the idiosyncrasies of a particular
+bit of hardware, such as small amount of RAM, no PCI or other hard
+disk, etc., and just want to run Linux, the best option is to use the
+``virt`` board. This is a platform which doesn't correspond to any
+real hardware and is designed for use in virtual machines. You'll
+need to compile Linux with a suitable configuration for running on
+the ``virt`` board. ``virt`` supports PCI, virtio, recent CPUs and
+large amounts of RAM. It also supports 64-bit CPUs.
+
+Board-specific documentation
+============================
+
+Unfortunately many of the Arm boards QEMU supports are currently
+undocumented; you can get a complete list by running
+``qemu-system-aarch64 --machine help``.
 
 .. toctree::
 
-- 
2.20.1


