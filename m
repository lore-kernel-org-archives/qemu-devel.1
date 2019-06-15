Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA804C31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACB220866
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP5UBI4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACB220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbwvZ-0006UG-N5
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmb-0000Vq-Rg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwma-0004Ao-OL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hbwmZ-00047p-Tg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so3979882wma.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UAWiuWfF2SIYKrnneYta9vehkddANMGoObHXOzIF0W4=;
 b=DP5UBI4XcDEJnUPEtG6UQtQeRu9GB2us9oguWb/H9LGYjwK/uKLwu682abT2g5vR/P
 c1M0qxVQft0jz5Mi2KlVJ86bYHpUBfqfNtV09KtE8CTqGK9qtJ4y6bNwu5IMFNBlcL0S
 rLYZAMvgtJlpyOhRUuq6ZGc2y7O+qqT+htUU07l94XtgFI7sBmQD8Gv6PpcUgMPgQVQe
 ndFUMSrPc2xLNcoY+tRCMsPdZ/f31GPzMEDH99nuu5vDrKlojYH0DfV8dsT5ID3Oxi8v
 GibqRvTKi1lTPowcQWGgkFLWonZlEUS6obdO+quq13Kpr/g7HebH2X+SrFCDs6iYs1Di
 ShJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UAWiuWfF2SIYKrnneYta9vehkddANMGoObHXOzIF0W4=;
 b=CEKT+eZqOCCC+UrJsFzUPWYafZTQh6E8IZebQmElimY/jOiv+vp7abyvDNwvWaZVfm
 fkmF8zS6kUWaAI0fEGcuHePF3JGOdtJhKdfmoBoCeDdCWA08yX6RziT/qrrCiiNX3Ix0
 yEyQHgy7vI46x4/eFycFMbLVkG7N3T9Esc9wZZkGmxFOml9ffv0gzhayg3CE5k1XTUo1
 ICfzs9/PEQ/pwH16wl1SxHyNKkNXrD5gZDVztDecT3EGqTyFlMJxM4PV9i8rmLHTzlE5
 H9Lz2sCyQzqUY2Ot+wTnRixbEHCLIlIg8WIlbLCEXefXzEJVJBzUjE6J1hOiBoCM/Lqd
 DHyA==
X-Gm-Message-State: APjAAAX5kNVTA+geHFNa64fmNhv6AcuTUaJorYNJQrfFRlGM2e+RDSQf
 T5EcrMv29KL1uCe8XZOMDe/m22JX
X-Google-Smtp-Source: APXvYqymxa/AEI+Lt/08nGrGTcLEtlwirdCPNwHp7KkTtcTsWTC4mbBLBi8G8jqLgf1xWiKlWO/utg==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr10262512wmc.14.1560559375992; 
 Fri, 14 Jun 2019 17:42:55 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:1da0:213e:1763:a1a8])
 by smtp.gmail.com with ESMTPSA id m21sm3774234wmc.1.2019.06.14.17.42.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 17:42:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 02:42:49 +0200
Message-Id: <20190615004256.16367-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH preliminary 0/7] target-i386/kvm: live
 migration support for nested VMX
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
Cc: liran.alon@oracle.com, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is mostly Liran's work.  It's preliminary because he found some cases
that break but he hasn't debugged them fully yet (a kernel bug is suspected
though) and because my version, which only requires a very small and
backwards-compatible linux-headers change (patch 4), has seen even less testing.

Paolo

Liran Alon (6):
  KVM: i386: Use symbolic constant for #DB/#BP exception constants
  KVM: i386: Re-inject #DB to guest with updated DR6
  KVM: i386: Add support for KVM_CAP_EXCEPTION_PAYLOAD
  vmstate: Add support for kernel integer types
  KVM: i386: Add support for save and restore nested state
  Revert "target/i386: kvm: add VMX migration blocker"

Paolo Bonzini (1):
  linux-headers: import improved definition of KVM_GET/SET_NESTED_STATE
    structs

 accel/kvm/kvm-all.c         |   8 ++
 include/migration/vmstate.h |  18 +++
 include/sysemu/kvm.h        |   1 +
 linux-headers/asm-x86/kvm.h |  11 ++
 target/i386/cpu.c           |  10 +-
 target/i386/cpu.h           |  16 ++-
 target/i386/hvf/hvf.c       |  10 +-
 target/i386/hvf/x86hvf.c    |   4 +-
 target/i386/kvm.c           | 160 ++++++++++++++++++++----
 target/i386/machine.c       | 243 +++++++++++++++++++++++++++++++++++-
 10 files changed, 440 insertions(+), 41 deletions(-)

-- 
2.21.0


