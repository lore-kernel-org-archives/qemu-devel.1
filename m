Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A47C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939EF20658
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8JoIfan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939EF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLLZ-0003lN-OS
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jGLJz-0001H9-6n
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jGLJx-0006sP-KN
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jGLJx-0006rQ-5a
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id 26so8770793wmk.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=OFr1tIi8cNqRn/vqOmjCgvVbUW9BNVMVGSEGEidMUQo=;
 b=w8JoIfan95I4XznIjXQzVeNo8l6Xh0dvD7b1TIGqibhY+C7dgyZ/uXfIkOs0/tLca3
 mu5gXprM3b/6ukW0OSYSqSj2gDCyiKxXm4nAMftPVr0s4SNfld/kLo8Tt2Q7XnFf1JWc
 VSLpLWnfJjB/LpDlmkuCEmW9fxNDKJw2TwyD9jhaROX0AHoKXWd98KK0p3YVV/VOIFVO
 Xwi0Qi9/+noDPudjzi3zC1ALa+dYBodZl3uAsU6PxxIVp/Nz6O4Tr/4Y92ydDyzY6uZP
 a4QUMBMN9CD8+8HMKbQ8QSgg5FMODQV8g6/I4ALDRRRB+xkMfJfqOvG4mc+EVC5gUtfi
 0NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=OFr1tIi8cNqRn/vqOmjCgvVbUW9BNVMVGSEGEidMUQo=;
 b=DbvepbadR5tx+iNXFwrNFqQ4E4jXBlXZnHy7f5HsLxYZkc+Il1QLXwAMKzLctVNLc2
 V6YlCldYGaBwbRX6D4R1zHev11Fe1FybfTE2x1X9Im0sUlqc0EfJRCOWy4oWt7eqakFO
 gvak584SSlFaSIAaYE4alA61cXdvjnwWG9WbWNXhk+3GRWIy1txdma3CohRT1o4qTl9k
 udhO5HmsEySSyPSk9sYjedgZ/kMd1dk3MfVi/wtUL8LrnGerm1LVGdToOyX8KZ/lytXS
 8FK7UiWVm/qQO1cNc02IXBIdtyWOvtKnE5TvCtXSPqwb983E++rn2FNNpe33OOYe7FrP
 +WRA==
X-Gm-Message-State: ANhLgQ16T9kl6A5qEmnSCVzAm94gBi94fABUofD/bZnTU+tEpZCPvIUY
 6d58k7cfncbzHFhgWrxKjsecsAJb3A9dXQ==
X-Google-Smtp-Source: ADFU+vs5uuL1ljUGZORUF1InMnoZRV6esXLM/Dyeo1IxxDurQzZriTdXiOenXhOSg3ZO2nbmBuSNIg==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr26621677wme.34.1584963159658; 
 Mon, 23 Mar 2020 04:32:39 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-177-220-180.range86-177.btcentralplus.com. [86.177.220.180])
 by smtp.gmail.com with ESMTPSA id 98sm23288473wrk.52.2020.03.23.04.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 04:32:39 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Mon, 23 Mar 2020 11:32:25 +0000
Message-Id: <20200323113227.3169-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
  target/arm: kvm: Handle potential issue with dabt injection

 target/arm/cpu.h     |  3 ++
 target/arm/kvm.c     | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   | 25 ++++++++++++++++
 target/arm/kvm64.c   | 34 ++++++++++++++++++++++
 target/arm/kvm_arm.h | 21 ++++++++++++++
 5 files changed, 165 insertions(+)

-- 
2.7.4


