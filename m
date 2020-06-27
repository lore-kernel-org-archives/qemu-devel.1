Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3015C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2432184D
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNVe3GuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2432184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpCjU-0005Er-Ny
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 11:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpCik-00049m-0E
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:26:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpCii-0007SG-85
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:26:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id z15so1002496wrl.8
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=/m5mkGKgtE7TjZA080Li1qh2nYl8NNeDGiBLeOpwFJo=;
 b=kNVe3GuFiUeXwCsfG2Eq5K2BglY0ES0Gr/INHyYw6t8an42v+tbRggl/WTBc64RC/n
 6T0lJSR+QuMzKrhlQW8v4GQ8c6u9qRipzWcgcDUvxp6/jBwZ0b8WGkUYkj5jlcWv0yz/
 8apa/3iII9C6wrB6j/YNT7tewL7OUH3jUdxfOVZczIXyhRHyy6wLGdd6oLi23esux+jm
 VY0hRKOlYHB0lx/I5tWX9uzxDjpMYFGZjS7/sD3itt80DgFyLryPy5OmHHHqMB2zAATv
 s2SytPEIHifhLCnVIFKc7yJaPAfXrAuR6QlWQzwN26C7q8bZhzlfgEt2ayhejF8GMhC0
 AO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/m5mkGKgtE7TjZA080Li1qh2nYl8NNeDGiBLeOpwFJo=;
 b=sRgTW2CfzUF9khDOzKvHbnBfyT91R9BTP1pGQzHq+UDBnqDNN0VuQo5NlSz9gajflK
 goQwsV+pf6KSMDcpvAlhNcqvu1BVr3Oh3i9XWWVSfVPetwJu6F0XY6bj/SWqA1nTozez
 OEnCE3vAE4eTPilOFxA3EfcZN36rbKfia/tfKnxfmlh7RYR/m6VHU/32jkv76lrXf1xf
 ASzv/ACTeOJm/y885Eq+wloBnshJg0kNW6+DtTv/GKc2cysDJuXz2LX53In6mUIYv6wQ
 FjdqwIKVNced1J4VMdbYK4AIC4aaMfVU97CF+3ogN5jETuD0geEQhPA2Uo3TwHUQB+d+
 Y9vA==
X-Gm-Message-State: AOAM533PXcQNCC8KayYl/mGhHL6jckrY2R1tkg1HnwviUsRwkZtDUgX+
 p8TKuAAB1s7PRi9dFvG08RErxXVRXTqIkw==
X-Google-Smtp-Source: ABdhPJytZwJgPWrPXLFY8FUO8YhnxyDvbSYj2WOOTlZDTwlkA22oezC1GI4qqG3pYYNTR2laWiDCDg==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr8780574wrr.196.1593271577800; 
 Sat, 27 Jun 2020 08:26:17 -0700 (PDT)
Received: from moi-limbo-9350.home (host-92-18-20-3.as13285.net. [92.18.20.3])
 by smtp.gmail.com with ESMTPSA id
 c6sm20965438wma.15.2020.06.27.08.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 08:26:17 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Sat, 27 Jun 2020 16:25:54 +0100
Message-Id: <20200627152556.7391-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=beata.michalska@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, Christoffer.Dall@arm.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the ARMv7 & ARMv8 load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate the instruction which is one of the
(many) reasons why KVM will not even try to do so.

So far, if a guest made an attempt to access memory outside the memory slot,
KVM reported vague ENOSYS. As a result QEMU exited with no useful information
being provided or even a clue on what has just happened.

ARM KVM introduced support for notifying of an attempt to execute
an instruction that resulted in dabt with no valid ISS decoding info.
This still leaves QEMU to handle the case, but at least now it gives more
control and a start point for more meaningful handling of such cases.

This patchset relies on KVM to insert the external data abort into the guest.


----------------------
v7:
 - Rephrasing the comment regarding abort injection and vcpu synchronization
 - switching to struct initialization instead of memset

v6:
 - replacing calling kvm_put_vcpu_events with an actual ioctl call
 - making the handler function static

v5:
 - Drop syncing vcpu regs in favour of calling kvm_put_vcpu_events directly
 - Fix decoding DFSC for LPAE case
 - Add/clarify comments
 - Switch to reporting error case failure when enabling the cap

v4:
 - Removing one of the patches as it is being picked-up separately
     target/arm: kvm: Inject events at the last stage of sync
 - Moving handling KVM issue to a separate patch
 - Minor changes wrt the review comments

v3:
 - Fix setting KVM cap per vm not per vcpu
 - Simplifying the handler to bare minimum with no default logging to address
   the potential risk of overflooding the host (adding support for rate
   limiting the logs turned out to be bit too invasive to justify the little
   add-on value from logs in this particular case)
 - Adding handling KVM bug (for small range of affected kernels):
   little bit of trade-off between what's reasonable and what's effective:
   aborting qemu when running on buggy host kernel

v2:
- Improving/re-phrasing messaging
- Dropping messing around with forced sync (@see [PATCH v2 1/2])
  and PC alignment



Beata Michalska (2):
  target/arm: kvm: Handle DABT with no valid ISS
  target/arm: kvm: Handle misconfigured dabt injection

 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 34 +++++++++++++++++++++
 target/arm/kvm64.c   | 49 ++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 10 ++++++
 5 files changed, 180 insertions(+), 1 deletion(-)

-- 
2.7.4


