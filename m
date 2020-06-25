Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 22:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B5620781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 22:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jfo/beSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B5620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joZzu-0002Po-VN
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 18:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1joZyh-0001W6-HL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 18:04:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1joZyf-0001Pg-QJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 18:04:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id s10so7419524wrw.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=dhNRoBg5bwpJi8jqJOz5Pclx/wgnmMVQ4FYzgXqH1GI=;
 b=Jfo/beScBb8NqlCqTrzCtVVwcAgNebsFj272lm3s4ysDEL1egJNxtbzpSuyzodo8av
 ZlVnNZ/ASn2AYqRFq/5BEpyxX8WA1gsrFosUzgi2axcQGNKdMCuMDJxYvUXqhvbpXfNm
 keRJJo6cuI8bRnSAvWCtSOr9Vu7ZgQ+RCvQazVW/b6klF+hns/aN5oT18ZbkyQFNsH6K
 6AJp8W0UltKwzahDTzRZv64AMRumcopvNT46k7MkY+HQ7YK/oDy4cJj8slraNlNN8uyJ
 TdJebyu/t3Vvhw00vwvrD2Ud09pUnX1maE3Hp265bvPppOSgSNW3R5Ij+wRwE5njy+w3
 uO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dhNRoBg5bwpJi8jqJOz5Pclx/wgnmMVQ4FYzgXqH1GI=;
 b=iefvtm3D0QWmX0sviUf0BsrlhayIdP5RnPiNZ5t2m+gQuIWNjDDVW/vdYpty+raz67
 +89o7kSi4uiMygKv3cISGX4G8bRH3yM9448Qy1yE6zI9jtTmIjT4I4vFPJwSH+yAqA0L
 3nTboC1DCHPGm4j/VS78YHMSqAJxXnbQsll+YL5eGgWxQ9Dznbm2YkCUlsEVWsoQDNa8
 flQo2VYXNGbfRh6P2zqO3dlab6fb+69jOMDan75l90U1R2rjidmXbLjtfAB2pXvZ6Aya
 sUEitA9ns9B1R0ZHu4FlAvH8/XQdVP/hi+sJBbWu7hpWiHiwkUusU9VuZl6NMbW6Hwmj
 XaKQ==
X-Gm-Message-State: AOAM533VeAWVPpl060wbv1oYJv2Viv61RGRuLl1B0ty2fvB8bqK2X8UW
 nKNYlUfzz6TpPudkr9DDhXSYlwD3ik2HWw==
X-Google-Smtp-Source: ABdhPJwN9ZxjCAPTWtPaqGgrXRGKRNkBtDO5dO+NJw8LppNkrhsPp7c9+atcKtMRzy6oKj2upYJDZw==
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr348715wrq.250.1593122651573;
 Thu, 25 Jun 2020 15:04:11 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-139-146-71.range86-139.btcentralplus.com. [86.139.146.71])
 by smtp.gmail.com with ESMTPSA id l190sm13939277wml.12.2020.06.25.15.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 15:04:11 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Thu, 25 Jun 2020 23:03:34 +0100
Message-Id: <20200625220336.10186-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=beata.michalska@linaro.org; helo=mail-wr1-x444.google.com
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
 target/arm/kvm.c     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 34 ++++++++++++++++++++
 target/arm/kvm64.c   | 49 +++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 10 ++++++
 5 files changed, 181 insertions(+), 1 deletion(-)

-- 
2.7.4


