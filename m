Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AF7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28737204EA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaZGRhHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28737204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfSBT-0004zm-BL
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAJ-0003c1-4d; Sun, 31 May 2020 13:54:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAI-0007ak-E5; Sun, 31 May 2020 13:54:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so9214844wru.6;
 Sun, 31 May 2020 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AEl6bT4q19zBH2BgMy7bXNnUtsc1bYKdZAFCBjIlSaw=;
 b=eaZGRhHJxQAtSw26xWGvnUufmlMGk2NZArPNF0URkkrmVRXtwPKucour5svqDI+aa2
 uyC0m4lm+G0P6RA6AWRT5/D7Uky94PrT21bsKhi01lJccbI91TIVfy/MKpyecyxrzPqd
 sWBlWcOlXd/LDU63L2mek/GMBAnSkiKwoQcGWZRMFxw993qOTA0eh3i5fxlFro1J4OtC
 fW2rgIhF3L7BZbxCzM1A4vR/SNtio9ioUCcF4wW4hHdeyBDtVz4XYCQ3B0y4wLI3+OTv
 vIppeGS8lhD6hcfqD6EZF5VIJmrkZ107g5IWtNUAWpMsKEYcKlwb+nxWFTZHVhR9HJ0G
 tEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=AEl6bT4q19zBH2BgMy7bXNnUtsc1bYKdZAFCBjIlSaw=;
 b=fLNl3v0c7QUAST4zE9uQblMCkPzqJdxFWd0pjQofeOvtp0GlO0Mb6nSLICn7edtqzA
 FUw7bS69jLr8NHYU56MK2DQEVF/oX6A0ZchjgZmUGQPL1KtdtvASssieLnsgtnoMoiTI
 rWTWEJ2gFV4acmhlPMfTmDCuMzOVzSGTikaJWe5dfxwiB6bxbzhEv0G1h3UqbZqL6SNc
 5k3QUUPMGmHUhqjQdM0UAXxDvxHhazoMf59/7qQOqfm0C0AJQI+Bh/LYb+YKuj+Z0yN8
 VDIq33uFVyVnc0yAxadbbBNXoMYwnHyrheHcUTz4ThnoaNP5dSyVCNnHUG/ciggOjsKN
 NA2g==
X-Gm-Message-State: AOAM532rVMquyJMSReYJIh61VVwTi8nBUBVWfhi/uLMJrGzJlYcJTvOO
 xT/u+EQLsDJhF8bVVltaOpZLhVvr
X-Google-Smtp-Source: ABdhPJwch/GkIKUiPnNFA25+KBIqsDPqRO07CbQNWi4W8Cb11C4KZeSL4sBlKl9CM0qYH8NaoSpAjg==
X-Received: by 2002:adf:fac2:: with SMTP id a2mr18199433wrs.304.1590947667965; 
 Sun, 31 May 2020 10:54:27 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z7sm17862531wrt.6.2020.05.31.10.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:54:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] exec/memory: Rework some address and access size limits
Date: Sun, 31 May 2020 19:54:19 +0200
Message-Id: <20200531175425.10329-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches are extracted from a bigger series which
- remove generic ISA space, restricting it to the hw
  that really has it (mostly PCI-ISA bridges)
- allow QTest/GDB to use any address space
- make I/O address space target-specific (only X86 and
  AVR have a CPU connected to it)
- better handle Harvard architectures

Various patches only make sense if the AVR arch is merged,
so instead of waiting and keeping rebasing/testing, let's
share what is generic and might be worthwhile.

Currently the QMP/QTest commands only use the 1st CPU
address space, which has already been reported to limit
fuzzing/fault_injection/gdbstub.

I'll probably follow with the PCI-ISA bridge part, but
let's first see the feedback for this batch.

Regards,

Phil.

Philippe Mathieu-Daudé (6):
  target/s390x/mmu_helper: Use address_space_rw() in place
  hw/dma/rc4030: Use DMA address space to do DMA accesses
  hw/sd/allwinner-sdhost: Do DMA accesses via DMA address space
  exec/cpu-common: Do not restrict CPU to 32-bit memory access maximum
  exec: Restrict 32-bit CPUs to 32-bit address space
  memory: Use CPU register size as default access_size_max

 include/exec/cpu-common.h        |  4 ++--
 include/hw/sd/allwinner-sdhost.h |  4 ++++
 exec.c                           | 10 ++++++++-
 hw/dma/rc4030.c                  |  3 ++-
 hw/sd/allwinner-sdhost.c         | 36 ++++++++++++++++++++++++++------
 hw/usb/hcd-musb.c                | 12 +++++------
 memory.c                         |  2 +-
 target/s390x/mmu_helper.c        |  6 ++++--
 8 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.21.3


