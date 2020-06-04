Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C905C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2FC206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="aSTdigRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2FC206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpQ3-0004zx-Ev
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jgpPT-0004S5-5i
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:55:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jgpPR-00058m-Fy
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:55:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id l10so5962915wrr.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=rUu6a9rJHGf3ex3AMdBdG2Vh97Xd8nCLDS9SYciVjVo=;
 b=aSTdigRbk0UwqIv6Dk3LEI947Z7u2w5LKNa5ZCrnGqpoxynUfbmljSCGJR9AyrRe32
 3Myvvz4rsQqpHpDE2i1A4d0IIZJTMqjTAdBO2L0EFpTfVK7rrVN5OuNFwunmJFxE/AzH
 VIXx8ai5BcX804SU0zZ4iahNM7++RuZ9bXLzdRnHEf4NQf4KMaaxSMC8X/2tgLsQkMm6
 wW+ImzwY6WUaY6hHIrnnuSxTgUEEpei2SFYPDP1OCzA7inTHKCsBc8jTyqwTY32nACUB
 Q20NvwbipnBOLaTPeqW6C4VUDkh7CT+NPnWdufNIuOkHA4iGAxPwzk3Q/HLi72Ju/Aoe
 Zyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=rUu6a9rJHGf3ex3AMdBdG2Vh97Xd8nCLDS9SYciVjVo=;
 b=Xq6Co+BUS9bdxktXhgm9XUWg7YxCCZYhc81zakUxBE/jSJE9LbH7zsi/hhK+TzUTm7
 HlJo/UBzIz7iHV87bn6NlrlQabx45JEToYsTImeARHS/ejzdT4fgsWRqYLJTa22a62rH
 CgyemlpXkPlCZWRD3bP+VhrKfJf5ougKvVHZCnBD54wBVmgNRw9g+r5HOBVyPKc19GXX
 XCo3A1xK3sw7SoKA8YTMEe7wrJZYzDUHP4QL561ZUehRr366Vft/dJbf0KljvNbE4A58
 8w0DD0J22mlHEsOBZwa0HAsqHsAahtwI55Fx5Qxh5Krd7pB09co2iOCzdk1wTegYAEIT
 +U0g==
X-Gm-Message-State: AOAM530loEoDaONq614AGbG6N7nl1EP1+doSV+VlUpinv64WcynQVC7f
 B5EF06U/zPCRVt0ZdqRyVUgg2XH6gJrd2HG79ELUwwcosj8XgzBOX804Q1gqLtjdTCNm53bJhuh
 cJF8I9k05tmUsK8VzWKvSxjig6PmXdar35Xcg15mkMblIX2HoiNevoGgxztjgHQMir30=
X-Google-Smtp-Source: ABdhPJzJmv7Xjnz+Zmzo5pLyZkYOwlL/lBh9+pi7GgAVkSqDd64bL/imq6kJQTi96UC/dUyaPI1E4g==
X-Received: by 2002:adf:f812:: with SMTP id s18mr4147864wrp.28.1591275347408; 
 Thu, 04 Jun 2020 05:55:47 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id f9sm7627646wre.65.2020.06.04.05.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 05:55:46 -0700 (PDT)
Date: Thu, 4 Jun 2020 13:55:44 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: qemu-devel@nongnu.org
Subject: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
Message-ID: <20200604125544.GW28566@vanye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi there,

(all this done on current HEAD: 66234fee9c)

I was looking through the definition of the aarch64 "max" cpu, and
noticed it invokes aarch64_a57_initfn as a template, followed by
overriding some feature and ID fields to enable additional
functionality.

I then noticed it does not override kvm_target, which hence remains
set as QEMU_KVM_ARM_TARGET_CORTEX_A57. Of course, this only happens on
the else side of the if (kvm_enabled()) branch, so doesn't affect it.

However, while looking at this, I noticed aarch64_a72_initfn doesn't
initialise kvm_target at all.

Then I looked at the definition of QEMU_KVM_ARM_TARGET_CORTEX_A57,
found there was also a KVM_ARM_TARGET_CORTEX_A57, and then I noticed
there exists a KVM_ARM_TARGET_CORTEX_A57 (in
linux-headers/asm-arm64/kvm.h), and *then* I noticed there exists a
KVM_ARM_TARGET_GENERIC_V8 definition there as well - plus a comment
saying "please don't add any more targets unless you really need to".
Then I noticed there isn't a corresponding
QEMU_KVM_ARM_TARGET_GENERIC_V8 in target/arm/kvm-consts.h.

So, then I decided to actually test things, and found that
(with -enable-kvm):
- on Cortex-A53 hardware
  - "max" kvm_target gets initialized to 4 (KVM_ARM_TARGET_CORTEX_A53)
    by kvm_arm_get_host_cpu_features (as returned from the kernel for
    vm_arm_create_scratch_host_vcpu)
  - cortex-A72 fails to start with "KVM is not supported for this guest
    CPU type"
  (fair enough, it's later than A53)
- on Cortex-A72 hardware
  - "max" kvm_target gets initialized to 5 (KVM_ARM_TARGET_GENERIC_V8)
    by kvm_arm_get_host_cpu_features
  - "cortex-A72" fails to start (umm...)

However ... if I haven't managed to confuse myself somewhere in here
(which is completely possible), would it be OK if I submitted a set of
patches that:
- add a QEMU_KVM_ARM_TARGET_GENERIC_V8 to match the kernel one
- set kvm_target for Cortex-A72 to QEMU_KVM_ARM_TARGET_GENERIC_V8
  - alternatively drop the explicit settings for A57/A53
- drop the call from aarch64_max_initfn to aarch64_a57_initfn, and
  copy the relevant bits into the former for the !kvm case

?

/
    Leif

