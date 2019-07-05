Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E108C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F90E2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4Az28aD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F90E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUG9-0007LQ-Fp
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEJ-0005LC-It
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEI-00045X-J8
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEI-00043H-9C
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id v19so10720812wmj.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XsBjbOIOnF0NdNk38gbkzat6rzrjMaJMR2gk3cNRDd4=;
 b=J4Az28aD6REx1TLqBpd/q2tJa1iDUgprAW9a7COmESqxYkQkWTrgtnYt4AFgFsjLs+
 3oaHIvb2+Mb1s9q10JbaNG8ao423/xg7FjUYyAtJuLof4gY5adQuWuBnoLzMgL7/1J8+
 3qqvcDkqVx2fHvRvITGQ3pJzali7vB0L9czP3aBPczhUTexzRSG6GM2qDaw1T+t8CZFr
 OAG0pdpm0cHI8nKxA/DWkDAxw9xMrUZCiAYcy6sIPehyF7Xo++rSgzIyLAWx4rNHvm03
 7BrnmCbdZ9XL0o+FlAUsUB/xY3QK5b4IN31HS3xSPzIvLYKnCMz2ktnopYmYy4qnwzEt
 C5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=XsBjbOIOnF0NdNk38gbkzat6rzrjMaJMR2gk3cNRDd4=;
 b=aPQFLTJ5PMEcMuQP2mexbAICDXwyNWdZ1zQXNuXomjbi6kDl6dHUQyIAF0ddiGhzVU
 /7l79zZ21rf7fn5ojTX+77MuwVC/kJnWDwwxdqXeIt4Azsum6EzaLINJEIkN+LBcXLeT
 cVYOrfeP/mZdqwD+y9yaD8YqPSukz4UrjZ74rRNsCr2NYY0sYV97619HPuMFCpd6+hg6
 h2kzGiwFbP563l1fktPfLHYA4a7k5tjNTQeKfHQR7jZmsmuQ3/aY3biKscV9jKm8zvIC
 a7SKC3NQTQDQU5qDo79dPcHpZrrrUu7kCn+OWdHR+2PCUKOSEhuP/uLX98t3TxX8smtM
 cjJA==
X-Gm-Message-State: APjAAAVKhOiMFZoYdq41gkW6tHtCfA0TKZdTYzm4u4Vo/OmyTb8qam00
 GpPSGZsM6EwDo6KW+CEM1OgUeppoqu8=
X-Google-Smtp-Source: APXvYqxR6lR1sAfUp/8BCJGejV2FHKzORqULAjET7ttiGMBgZ51o/vsspPjDD01nl0kNH9j9KAfJGg==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr4465825wmb.17.1562356242618; 
 Fri, 05 Jul 2019 12:50:42 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:27 +0200
Message-Id: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 00/12] Misc bugfixes for QEMU hard freeze
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

The following changes since commit 68d7ff0cff0c4905802104843cf0100543b47314:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-06-21 13:32:10 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2994e7e66a8902d0e42c5e528489ca6484c66d2d:

  ioapic: use irq number instead of vector in ioapic_eoi_broadcast (2019-07-05 18:35:43 +0200)

----------------------------------------------------------------
Bugfixes.

----------------------------------------------------------------
Alex Bennée (1):
      target/i386: fix feature check in hyperv-stub.c

Igor Mammedov (1):
      pc: fix possible NULL pointer dereference in pc_machine_get_device_memory_region_size()

Julio Montes (2):
      Makefile: generate header file with the list of devices enabled
      hw/i386: Fix linker error when ISAPC is disabled

Li Qiang (2):
      ioapic: clear irq_eoi when updating the ioapic redirect table entry
      ioapic: use irq number instead of vector in ioapic_eoi_broadcast

Liran Alon (1):
      target/i386: kvm: Fix when nested state is needed for migration

Max Reitz (1):
      i386/kvm: Fix build with -m32

Paolo Bonzini (2):
      checkpatch: do not warn for multiline parenthesized returned value
      minikconf: do not include variables from MINIKCONF_ARGS in config-all-devices.mak

Peter Xu (1):
      intel_iommu: Fix unexpected unmaps during global unmap

Yan Zhao (1):
      intel_iommu: Fix incorrect "end" for vtd_address_space_unmap

 Makefile.target           |  5 ++++
 hw/i386/intel_iommu.c     | 71 ++++++++++++++++++++++++++++-------------------
 hw/i386/pc.c              |  6 +++-
 hw/i386/pc_piix.c         | 12 ++++++--
 hw/intc/ioapic.c          | 11 ++++----
 scripts/checkpatch.pl     |  3 +-
 scripts/clean-includes    |  2 +-
 scripts/create_config     |  2 ++
 scripts/minikconf.py      |  5 +++-
 target/i386/hyperv-stub.c |  2 +-
 target/i386/kvm.c         |  7 +++--
 target/i386/machine.c     |  5 ++--
 12 files changed, 84 insertions(+), 47 deletions(-)
-- 
1.8.3.1


