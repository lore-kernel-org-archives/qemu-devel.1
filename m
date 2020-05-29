Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61947C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293522074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkVlHAR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293522074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedCr-0006ut-7v
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jedC1-0005kI-OY
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:28:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jedBz-0002vq-PD
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:28:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id k26so3040363wmi.4
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=wKZ/XG+QT1qtovyr0q0rEdp/rI8bv2otMbHbRlqHsoY=;
 b=mkVlHAR/W7MuyANeOmDncItez0ATFdX67xIGtWfurGN7edQgrFjFgR09qFnuYJh23E
 uo2Lyg7h+Ba0/MF9oJa+0DE2OiK1yMeZCvxCWTsVr+Ydsc2wUWrTZiGrTgmNwhW6qPcS
 ZonLbKoDeFXRVYmIH84Wn6/qKuq0TKCBCLCjkkKkNBqHGe0qYAcNCy+yshzLNjrnSR3t
 zff+tj5yCvnPDFsK2oib3Lz9mGgx2OoTrav0WCXH7sXQlSLTP91UAcafNyo7lNBclrIH
 ISLqgCiwhIPSwwBj9qxjvUmk/9O4ZIR2q2S9Z/pT9vE+xbpxnqt5MFfytY22JWAr216l
 MAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wKZ/XG+QT1qtovyr0q0rEdp/rI8bv2otMbHbRlqHsoY=;
 b=P9tch3cR2pVzhbfngZWA0iiiHC6Y4AE19fHRBL+5vJCOpi5ch1u4Ur71vbkxaqBrPA
 ZxlNACk5UHmOTO/YH+3ATRtEW0qr5dh3p/FgwMkrk10zQOVseiTfkpt/x6KAUuP8p+j4
 HMSTZBQNZczJEnaaz/cJOk7S78qqy4r5z9xUpzfZ5xVx+vjCY0v3RXqxqlzXHyRCK1HL
 VtcB0wJB8qARhKz0P3GWiNI63TY6U840Rhz8FlJTryGG4SZwu4/AeDhGic7x+oZ2UC2t
 wKdtXIrkp67rpsAwuPhRos4Zpg9fT/B3qPpl1mTFwXJo/3hzvufHnbVavyaGdkvBAyBr
 Zxxw==
X-Gm-Message-State: AOAM532kvomgvg+MBFeLWb0Yldccu6Cd2+87s94LH8G1mBMRlky3VlET
 elaKgh1hkw8WCLZS128PtzYzH8LjhutprQ==
X-Google-Smtp-Source: ABdhPJzQZ4uGbfqSQUBovRMfvP/hGloVqHliKut1DrE1HXdanUmTHhCCzsrvWpzoF6VDPB7uxgqAGg==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr8436784wmh.46.1590751729031; 
 Fri, 29 May 2020 04:28:49 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-151-121-39.range86-151.btcentralplus.com. [86.151.121.39])
 by smtp.gmail.com with ESMTPSA id h188sm6449053wmh.2.2020.05.29.04.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 04:28:48 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Fri, 29 May 2020 12:27:55 +0100
Message-Id: <20200529112757.32235-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=beata.michalska@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


Thanks for all the input on the previous version!
----------------------

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

 target/arm/cpu.h     |  3 ++
 target/arm/kvm.c     | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 35 ++++++++++++++++++++
 target/arm/kvm64.c   | 49 ++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 21 ++++++++++++
 5 files changed, 199 insertions(+), 1 deletion(-)

-- 
2.7.4


