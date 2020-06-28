Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80020C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 15:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AEC206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvSTJVRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AEC206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYtL-0007sf-Ga
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 11:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpYrx-0006N2-NM
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 11:05:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpYrv-0002ml-SA
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 11:05:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so13749614wmh.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=M6lp14IRbaOYrvmLjY8eliseHrIjO9Towkcno1Q8BrA=;
 b=YvSTJVRalRDDGXlsYOHyPxnWwxcQFXkN5DHNaL2qGMoIPd4zz+zmeVnYxeUn7erObx
 gXKVbVqaIYCqc3FsERWsRFah4su85ekRkxN3/WyrJAB50ZXR8GeVcLzUMIJ8wVBSXAMz
 r5izzj5euItsTra4QqYq8Q2nL1mEX/jei7xTvmj1B21rs3m0Z39upmwWf42zMJbQk7Iu
 hNqMJrbVsfcGCtSXvP8atdbT4psq99RrTBHpl1M2ChrViJu8ZQ28gqY30ttaGRq3q5+n
 UBeJIkMPTJ8U7tdcdw6Rgv2QgnWKhnf18p1sL6r8AhEWjAnan41HHYav8uKAnGgyj+q8
 SBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=M6lp14IRbaOYrvmLjY8eliseHrIjO9Towkcno1Q8BrA=;
 b=nwG58RTgyxs/T0IbufUuDbOEn1ynihgPGJW1TaVzp0Gj+cREyTUioOQqAA/qYLJZdX
 TfYtZG6zrnGL/wC4VD4sWQ0WkLm7TWrnPnVp/yvZDoCkFtkiL0lIjpGlv8R+FrdLo9so
 vX+QN+bpARr9TBvs7SLXdVVtTCKP8tWMVDvSDQRKfXEZxRo0Mhd2jP3C2HMc6yi2KpEG
 S5zNbW/DUGZMxEvV+Ozc2sopdQZuBxNVXyf1TEZYyiwwd/KQLg/wOmksAq1OcJ4CaMub
 luXmWstqizuC7uXnMbuDk+xjf2snIjkrUzjXIYYaBF2aAKBFeQM9k4124v0yXoJvH1xH
 5YJg==
X-Gm-Message-State: AOAM530xcNjP917z1HEyETebr58YgMfYP7grCyZdp/1cscZOKJJeErts
 mzw7GGrjQRlulBwSEKnUV655aI/Pal7J+Q==
X-Google-Smtp-Source: ABdhPJxaWYbSi1l7fVnH60Fr5S6YQYEdHQz5qYiFGvxnBHrKkgWEfBPcTnBlkvZU6f9lRaMHtXli8A==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr8973715wmi.35.1593356718070;
 Sun, 28 Jun 2020 08:05:18 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-139-146-71.range86-139.btcentralplus.com. [86.139.146.71])
 by smtp.gmail.com with ESMTPSA id n5sm21309350wmi.34.2020.06.28.08.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 08:05:17 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Sun, 28 Jun 2020 16:04:57 +0100
Message-Id: <20200628150459.18566-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=beata.michalska@linaro.org; helo=mail-wm1-x344.google.com
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
v8:
 - moving the comment re support for VCPU events - missed in previous patchset

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
 target/arm/kvm.c     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 34 +++++++++++++++++++++
 target/arm/kvm64.c   | 49 ++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 10 +++++++
 5 files changed, 179 insertions(+), 1 deletion(-)

-- 
2.7.4


