Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F7C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F1920833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6veRl11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F1920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctXD-0004Qi-Bg
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4w-0000SX-O5
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4u-0007Mm-7z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hct4t-0007JK-PP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so2238093wrs.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=33Yo7NTImVN+1qL1xc2D0HzY3XTyzXwVzfG9kmHBf/I=;
 b=N6veRl11p2+McGwXXraEg+2wDRtY05iq5UVtPM5DxnSmCiVWiecYguCHU7ztQoD/15
 0GGxZrI429p0r5GXzMLAFOcyrEsh/r89wWLzW68UDQM8LG5avoIvN3uW+dM1Ug9yiYJK
 Jb0lmvdU6kUTq5WKpe5pqLJfvjheIpU0r5Yk6RWLSp0b5s1nC1dYHWbtsuUluhGDDh+j
 XYMLoa71oguvrDGV/bMF9m7gQilzZTd0rHwLNL5+dit4srsQjymkVc8SkaHMDvYpOcFG
 Lf0vtrTCs3stZxfHaUvStc81ZKOUQAPnae9lyuLYe9GAm4Ww6NfdgDydfj2WjDJ4yhMJ
 G9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=33Yo7NTImVN+1qL1xc2D0HzY3XTyzXwVzfG9kmHBf/I=;
 b=efJlk7SlRMFJE3alHR0wdr368haVrV3NM9GlKhMi7u9Sbddw2/S2aCXwaNfL2bQQZr
 020KnXoh1fZWNIbaOn+HTH6Ml5Q9MQSiNSnIYigWLFrS2/uy41BN1xTb0KGyawb3SmOl
 K6rp9HoC4TmwBq8p+yQwFBSx2jio0VRyDxgTlhfCHUkjHr7ZUKHlgDij5l7fAqZtJMKr
 8Ic39zITpHve8P+Wg8kSBNJz7EuSrCvnwd/0XpdcSMgfZPTJ5oOIIes886etSecI02DG
 7FxvSuMy3RSEp08SViVrFTDy775bXjwuxStyKxTNkOgpOFFaybeD+lgaKO7Bj37TXh4C
 5Rog==
X-Gm-Message-State: APjAAAWws+94Ozn/gR6qgy0i+Fpd2jNCbfO6JR+ola47BTNv3Tf8M0Ak
 P/NXerKtVRJeaprA3coR2wrX6P8IEpkorA==
X-Google-Smtp-Source: APXvYqwAN8+RTBxBWrpJcsOwfrGcdHFyUMx1hqcs69EXRrJGTtfCwg9tB1Dqpt/g4Yzev0E26UQeEQ==
X-Received: by 2002:a5d:4708:: with SMTP id y8mr12351947wrq.85.1560783464492; 
 Mon, 17 Jun 2019 07:57:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14690750wmf.8.2019.06.17.07.57.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:57:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:57:38 +0100
Message-Id: <20190617145740.9881-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617145740.9881-1-peter.maydell@linaro.org>
References: <20190617145740.9881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 2/4] qemu-tech.texi: Remove "QEMU compared to
 other emulators" section
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

The "QEMU compared to other emulators" section of our documentation
hasn't been updated since 2015 (and parts of the text are even older).
We're clearly not very well placed to track the evolution of a
dozen other emulation projects, and an inaccurate or out of date
comparison doesn't serve anybody, so we're best off just removing
the whole documentation section.

If anybody cares strongly about maintaining a comparison page,
it's probably better to do that on the project's wiki where
we can update it more dynamically.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190607152827.18003-3-peter.maydell@linaro.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-tech.texi | 107 -------------------------------------------------
 1 file changed, 107 deletions(-)

diff --git a/qemu-tech.texi b/qemu-tech.texi
index eb430daacf2..3451cfaa5be 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -161,57 +161,6 @@ may be created from overlay with minimal amount of hand-written code.
 
 @end itemize
 
-@node QEMU compared to other emulators
-@section QEMU compared to other emulators
-
-Like bochs [1], QEMU emulates an x86 CPU. But QEMU is much faster than
-bochs as it uses dynamic compilation. Bochs is closely tied to x86 PC
-emulation while QEMU can emulate several processors.
-
-Like Valgrind [2], QEMU does user space emulation and dynamic
-translation. Valgrind is mainly a memory debugger while QEMU has no
-support for it (QEMU could be used to detect out of bound memory
-accesses as Valgrind, but it has no support to track uninitialised data
-as Valgrind does). The Valgrind dynamic translator generates better code
-than QEMU (in particular it does register allocation) but it is closely
-tied to an x86 host and target and has no support for precise exceptions
-and system emulation.
-
-EM86 [3] is the closest project to user space QEMU (and QEMU still uses
-some of its code, in particular the ELF file loader). EM86 was limited
-to an alpha host and used a proprietary and slow interpreter (the
-interpreter part of the FX!32 Digital Win32 code translator [4]).
-
-TWIN from Willows Software was a Windows API emulator like Wine. It is less
-accurate than Wine but includes a protected mode x86 interpreter to launch
-x86 Windows executables. Such an approach has greater potential because most
-of the Windows API is executed natively but it is far more difficult to
-develop because all the data structures and function parameters exchanged
-between the API and the x86 code must be converted.
-
-User mode Linux [5] was the only solution before QEMU to launch a
-Linux kernel as a process while not needing any host kernel
-patches. However, user mode Linux requires heavy kernel patches while
-QEMU accepts unpatched Linux kernels. The price to pay is that QEMU is
-slower.
-
-The Plex86 [6] PC virtualizer is done in the same spirit as the now
-obsolete qemu-fast system emulator. It requires a patched Linux kernel
-to work (you cannot launch the same kernel on your PC), but the
-patches are really small. As it is a PC virtualizer (no emulation is
-done except for some privileged instructions), it has the potential of
-being faster than QEMU. The downside is that a complicated (and
-potentially unsafe) host kernel patch is needed.
-
-The commercial PC Virtualizers (VMWare [7], VirtualPC [8]) are faster
-than QEMU (without virtualization), but they all need specific, proprietary
-and potentially unsafe host drivers. Moreover, they are unable to
-provide cycle exact simulation as an emulator can.
-
-VirtualBox [9], Xen [10] and KVM [11] are based on QEMU. QEMU-SystemC
-[12] uses QEMU to simulate a system where some hardware devices are
-developed in SystemC.
-
 @node Managed start up options
 @section Managed start up options
 
@@ -247,59 +196,3 @@ depend on an initialized machine, including but not limited to:
 @item query-status
 @item x-exit-preconfig
 @end table
-
-@node Bibliography
-@section Bibliography
-
-@table @asis
-
-@item [1]
-@url{http://bochs.sourceforge.net/}, the Bochs IA-32 Emulator Project,
-by Kevin Lawton et al.
-
-@item [2]
-@url{http://www.valgrind.org/}, Valgrind, an open-source memory debugger
-for GNU/Linux.
-
-@item [3]
-@url{http://ftp.dreamtime.org/pub/linux/Linux-Alpha/em86/v0.2/docs/em86.html},
-the EM86 x86 emulator on Alpha-Linux.
-
-@item [4]
-@url{http://www.usenix.org/publications/library/proceedings/usenix-nt97/@/full_papers/chernoff/chernoff.pdf},
-DIGITAL FX!32: Running 32-Bit x86 Applications on Alpha NT, by Anton
-Chernoff and Ray Hookway.
-
-@item [5]
-@url{http://user-mode-linux.sourceforge.net/},
-The User-mode Linux Kernel.
-
-@item [6]
-@url{http://www.plex86.org/},
-The new Plex86 project.
-
-@item [7]
-@url{http://www.vmware.com/},
-The VMWare PC virtualizer.
-
-@item [8]
-@url{https://www.microsoft.com/download/details.aspx?id=3702},
-The VirtualPC PC virtualizer.
-
-@item [9]
-@url{http://virtualbox.org/},
-The VirtualBox PC virtualizer.
-
-@item [10]
-@url{http://www.xen.org/},
-The Xen hypervisor.
-
-@item [11]
-@url{http://www.linux-kvm.org/},
-Kernel Based Virtual Machine (KVM).
-
-@item [12]
-@url{http://www.greensocs.com/projects/QEMUSystemC},
-QEMU-SystemC, a hardware co-simulator.
-
-@end table
-- 
2.20.1


