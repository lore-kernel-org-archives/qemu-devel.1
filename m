Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D9CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B1D23C16
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANL3jf3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B1D23C16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsBU-0000M6-3f
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpsAN-0007PQ-SW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:41:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpsAL-0005IU-Ux
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:41:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id w3so3331159wmi.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=35DefQSlDniBHNXxGwbXkQ0Ae4JMwjKJXltjc+2+jKU=;
 b=ANL3jf3FrDnXSbO2YeLHJZqIVP3nvNscZiBMvK44bM34qCdmdgqN9aXHBuTxP+w70R
 QxBA9m0WF89OWH1z4IKMuy71WEeld9p5RrFN1iYdphUb8K4o5o4522H5O4OdJLw36qls
 dhK2wP/oNJ5a9QoQSwnO6xwdVYkixZ8kzZ8Ny0jP0GlyRP8AlSpAelbtzDllt+JVDaIy
 9MgmfMWTBBnOGOrLnCkdpiw0yKbHmugY0rr5yUWXJPlY/LP5W97BdQQtSgGJYVo4yTU/
 QFuUTPOtGj/g0O6azPN4XgZniOAnWQy4MK8pPsdy/cBjuaUaEr35l6I7ZN1viYa41pEP
 yUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=35DefQSlDniBHNXxGwbXkQ0Ae4JMwjKJXltjc+2+jKU=;
 b=r+e4M9i2w82r0SEh27mR4V7nNS5LRvRxdgbIHS4kKye4qATwZ70Z17ef3RcEaIl0Lp
 bWF87c3z3/iVm/yZpW7ttWwl2HLNlivD+qVwi5KUXHLd6ka/8Z9KqTVYeh8D3NwETlNs
 jwysg2o1OCkXEXFTEtGvU8MJhSqHYP5BumMYm7q1djUoR/R7Kl8LNRWxSChAz7pUXbEm
 PFi124iQZpyON3DCl3rXbkVrix2tpX6RCS5FRpwk2Bgq+3qkxoTfC2dTUWnYYJlhDWo5
 P0DzDUyLsxEmcISIcr3XRo4LXGD2G0DN61OpYf0b6dr3M6+su/Yiqm4IHwjCmTRTOY7v
 tZUA==
X-Gm-Message-State: AOAM5328b3JU8kFhtUI7rQZoFbahuyg2EEJnTRwWAFUFOXUrcBgqVDeZ
 Zb1qVeB5c9DGtQJyoX1g85oQuZ/QAoedjA==
X-Google-Smtp-Source: ABdhPJzgbhIHLvVDXWe6nPPX7AW/KZaX4bGuf4K4De/t2NvM97EDWgEUhFql9EFUqniMaZvjOpeVug==
X-Received: by 2002:a7b:c250:: with SMTP id b16mr9154890wmj.30.1593430895545; 
 Mon, 29 Jun 2020 04:41:35 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-139-146-71.range86-139.btcentralplus.com. [86.139.146.71])
 by smtp.gmail.com with ESMTPSA id c2sm49486357wrv.47.2020.06.29.04.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 04:41:35 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Mon, 29 Jun 2020 12:41:08 +0100
Message-Id: <20200629114110.30723-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=beata.michalska@linaro.org; helo=mail-wm1-x343.google.com
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
v9:
 - formatting fixes

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
 target/arm/kvm.c     | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   | 34 ++++++++++++++++++++++
 target/arm/kvm64.c   | 49 ++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 10 +++++++
 5 files changed, 175 insertions(+)

-- 
2.7.4


