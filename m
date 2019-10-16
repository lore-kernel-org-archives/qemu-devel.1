Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33493FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F223720854
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe2or1AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F223720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKj3h-00089D-4l
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 09:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lantianyu1986@gmail.com>) id 1iKj1c-0006oN-8U
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lantianyu1986@gmail.com>) id 1iKj1b-0005sY-0x
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:07:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lantianyu1986@gmail.com>)
 id 1iKj1a-0005sB-PM
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:07:34 -0400
Received: by mail-pf1-x443.google.com with SMTP id y22so14709592pfr.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wQCJmNzmQsC9KNIjHMU1j2cgYJLfCM+agj01R4DYfjE=;
 b=Oe2or1AEnGi2tuxYEI+dDM6EqbS93wmPnH5+gXDxmvkVXF7KJnYVqfREtqDuHPwtlL
 KrhCNoGau/eOsWVoyWIgQSEtiJgmoJlgYtoltCXwYia7/dCmM7rbKoCes9HsTPyJrpE4
 UOp/N0DqDyEmHKreDXM6Z+B27pUGnsIt744FeHQwu9mDIVqnQoX6t0y0nKRdmLE6ZSj4
 wTSd9iRtTAYZOf0EEwxu/1ZzJozZUzpOFdPy4FPogV1acswssVFeQQq3Piiy0lx0J1zP
 2HnANWPP62uVD0rRtGdzecsjICguXgfIPYag+D0RLBOHv19e1AEuTKSVYd1zwkNja7D4
 q+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wQCJmNzmQsC9KNIjHMU1j2cgYJLfCM+agj01R4DYfjE=;
 b=mQn15FmvrAJZ3hZcZ4dlC0hxs7xHEFJQW8M66fUI8on2QF4yIJa/oZmPFCXntghFDg
 v8bVXWM4Bq7dFZszQKo9PA9xF6VGgIwzTC0LUFLXMJuC8e3V3QDpEUTZ9yBlwFPX+0Bv
 C0GgvoGdfE9TX94/7+zUXUx2t67XQ/ssk5KducMy8olWY2a86Ghp8TW6Y+PjliNKWWaG
 MAznrMwCDYxvbhRS3nyNuZ80VT4Blu7jMD5ZpeIIPvZuDxr0w/6kqD4pgM8B4zHPF2kQ
 xvO0CfPD/mq7VVidOYlIObEqBn2YOLcCF07IzTs9Hnu/a5YeH4A/s0+8BcX2HUp/Rwam
 OByg==
X-Gm-Message-State: APjAAAV6G02RCM+Njfx09DDszVy/13TkNCVK4idVag+VNZRHSnz2T5T+
 T5tzToma/O9tkz2quqxV+OU=
X-Google-Smtp-Source: APXvYqz86v6HgU7P7jaCkPhMGAi8X8SUCsEErtJmXv76sPMHpWi5QQGtmQNnOcoKXrKc30+cx6p6Aw==
X-Received: by 2002:aa7:96ba:: with SMTP id g26mr44752072pfk.45.1571231253825; 
 Wed, 16 Oct 2019 06:07:33 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.39])
 by smtp.googlemail.com with ESMTPSA id s97sm2792296pjc.4.2019.10.16.06.07.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Oct 2019 06:07:33 -0700 (PDT)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mtosatti@redhat.com, rkagan@virtuozzo.com,
 vkuznets@redhat.com
Subject: [PATCH V3 0/2] target/i386/kvm: Add Hyper-V direct tlb flush support
Date: Wed, 16 Oct 2019 21:07:23 +0800
Message-Id: <20191016130725.5045-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patchset is to enable Hyper-V direct tlbflush
feature. The feature is to let L0 hypervisor to handle
tlb flush hypercall for L1 hypervisor.

Tianyu Lan (2):
  linux headers: update against Linux 5.4-rc2
  target/i386/kvm: Add Hyper-V direct tlb flush support

 docs/hyperv.txt                              | 10 ++++
 include/standard-headers/asm-x86/bootparam.h |  2 +
 include/standard-headers/asm-x86/kvm_para.h  |  1 +
 include/standard-headers/linux/ethtool.h     | 24 ++++++++++
 include/standard-headers/linux/pci_regs.h    | 19 +++++++-
 include/standard-headers/linux/virtio_ids.h  |  2 +
 include/standard-headers/linux/virtio_pmem.h |  6 +--
 linux-headers/asm-arm/kvm.h                  | 16 ++++++-
 linux-headers/asm-arm/unistd-common.h        |  2 +
 linux-headers/asm-arm64/kvm.h                | 21 +++++++-
 linux-headers/asm-generic/mman-common.h      | 18 ++++---
 linux-headers/asm-generic/mman.h             | 10 ++--
 linux-headers/asm-generic/unistd.h           | 10 +++-
 linux-headers/asm-mips/mman.h                |  3 ++
 linux-headers/asm-mips/unistd_n32.h          |  2 +
 linux-headers/asm-mips/unistd_n64.h          |  2 +
 linux-headers/asm-mips/unistd_o32.h          |  2 +
 linux-headers/asm-powerpc/mman.h             |  6 +--
 linux-headers/asm-powerpc/unistd_32.h        |  2 +
 linux-headers/asm-powerpc/unistd_64.h        |  2 +
 linux-headers/asm-s390/kvm.h                 |  6 +++
 linux-headers/asm-s390/unistd_32.h           |  2 +
 linux-headers/asm-s390/unistd_64.h           |  2 +
 linux-headers/asm-x86/kvm.h                  | 28 ++++++++---
 linux-headers/asm-x86/unistd.h               |  2 +-
 linux-headers/asm-x86/unistd_32.h            |  2 +
 linux-headers/asm-x86/unistd_64.h            |  2 +
 linux-headers/asm-x86/unistd_x32.h           |  2 +
 linux-headers/linux/kvm.h                    | 12 ++++-
 linux-headers/linux/psp-sev.h                |  5 +-
 linux-headers/linux/vfio.h                   | 71 ++++++++++++++++++++--------
 target/i386/cpu.c                            |  2 +
 target/i386/cpu.h                            |  1 +
 target/i386/kvm.c                            | 24 ++++++++++
 34 files changed, 262 insertions(+), 59 deletions(-)

-- 
2.14.5


