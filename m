Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5878C17442
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B48222D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+MBpC+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B48222D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtpK-0007WU-4R
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtna-0005hp-IJ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnZ-0006Ht-H2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:10 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtnZ-0006HT-An
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id l1so2258811wme.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=34nGcZj4xea5+smY48xXr/h0k+G3Y+D6V6WvkQpf2m4=;
 b=B+MBpC+wr+Ofawkskp/n3a3/8/bGg4H3NWxg46sJOJJjX9JYv8YVuQZPTdVMcLnOnk
 HP6wBMFyYJ79Ds4l2P+R/mIamZGGd/OGlXHZJg7MtrXiSLw3GscCdYgYEQH8SrWyjD7V
 fYiiUlhE07nIjFP/hjLS7noeH4h1HC/416G0mulkDJ6EN458Nm2NFlwbF1ZsUGJikaHj
 d7BkvfTSNDWqGYcX6KTg+En/0D0Zy1MiMsxHX2xgrU1XKB9SbvSzvp3cRDTQN/wyX47B
 YSL6V9SolQfULg6UaDgW1ho1AB8edvS58GjKX1cG5P58K0Q2Aj8aC6Kx+7wuVAfScfx5
 za6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=34nGcZj4xea5+smY48xXr/h0k+G3Y+D6V6WvkQpf2m4=;
 b=BdNPAtgwmm1yw0FPKbcnw4dXcklW4poGSF3H6y2uTLRRswt8iaVyOdxW9trKrKguzl
 3T2rHnxvrclni8PtRJ6Qgk8zXTV0fheAffTdikwstWRDCTVHZfvwMbJQcoV0G4RGwIUY
 aBTSh1s+ZMzLeyL0ifNBYF401bmU2w0dbHeO2j8U4vfz84tAVkXyaMiCJ+/dE8r1C9hZ
 UU61roHq8tahyK0rZnVBSRHH83AlDisb/akhnC8DfEavW/Y/Y1fdmcBRRJ2u2S5JjKDL
 354w/Ixy7u+I7oYgFprG8smrBgHIa4R5dcnKjfbQxhlyer2cvrgN8vaQD2PGz0FpxJg4
 BZng==
X-Gm-Message-State: APjAAAWTH+tnQTaSsoRlKWNDWSMu3Kubi9K6x8ZljbtU8urfJi5TP3sY
 LLSJ1Q9hm+r+ZuyqIMSFavUJbhVM
X-Google-Smtp-Source: APXvYqxF+sxL2uhBv5mt0b7lcW3OdIiEy3wyo5kk8QEedYOWkS3u6wUayLsiiVEd4YjeyQhk7CVotA==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr2989902wme.165.1573655947014; 
 Wed, 13 Nov 2019 06:39:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 00/16] Complete the implementation of -accel
Date: Wed, 13 Nov 2019 15:38:49 +0100
Message-Id: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series completes the implementation of -accel:

- Alternative accelerators can be specified with multiple -accel options,
  and each -accel option will configure the respective accelerator.
  This is implemented in patches 1 to 6, with a small addendum in patch 7.

- Accelerators can now support arbitrary options, which are implemented
  in terms of QOM properties.  This is implemented in patches 8 to 11,
  together with the conversion of the sole existing "-accel" option to QOM.

- Accelerator-related machine options, and legacy options such as -tb-size,
  forward to accelerator objects for backwards compatibility, but they
  do not exist anymore as QOM properties.  This is implemented in patch
  6 for "-machine accel" and patches 12 to 16 for everything else.

Paolo

Paolo Bonzini (16):
  memory: do not look at current_machine->accel
  vl: extract accelerator option processing to a separate function
  vl: merge -accel processing into configure_accelerators
  vl: move icount configuration earlier
  vl: introduce object_parse_property_opt
  vl: configure accelerators from -accel options
  vl: warn for unavailable accelerators, clarify messages
  qom: introduce object_register_sugar_prop
  qom: add object_new_with_class
  accel: pass object to accel_init_machine
  tcg: convert "-accel threads" to a QOM property
  tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"
  xen: convert "-machine igd-passthru" to an accelerator property
  kvm: convert "-machine kvm_shadow_mem" to an accelerator property
  kvm: introduce kvm_kernel_irqchip_* functions
  kvm: convert "-machine kernel_irqchip" to an accelerator property

 accel/accel.c             |  67 +-------------
 accel/kvm/kvm-all.c       | 117 ++++++++++++++++++++++-
 accel/tcg/tcg-all.c       | 149 +++++++++++++++++++++++++++++-
 cpus.c                    |  72 ---------------
 hw/core/machine.c         | 141 ----------------------------
 hw/ppc/e500.c             |   4 +-
 hw/ppc/spapr_irq.c        |  10 +-
 hw/xen/xen-common.c       |  16 ++++
 include/hw/boards.h       |   7 --
 include/qom/object.h      |  13 +++
 include/sysemu/accel.h    |   4 +-
 include/sysemu/cpus.h     |   2 -
 include/sysemu/kvm.h      |   7 +-
 memory.c                  |   5 +-
 qemu-deprecated.texi      |   6 ++
 qemu-options.hx           |  30 +++---
 qom/object.c              |  28 +++++-
 target/arm/kvm.c          |   8 +-
 target/i386/cpu.c         |   8 +-
 target/i386/kvm.c         |   6 +-
 target/mips/kvm.c         |   2 +-
 target/ppc/kvm.c          |   2 +-
 target/s390x/cpu_models.c |   4 +-
 target/s390x/kvm.c        |   2 +-
 vl.c                      | 231 ++++++++++++++++++++++++++++++++--------------
 25 files changed, 534 insertions(+), 407 deletions(-)

-- 
1.8.3.1


