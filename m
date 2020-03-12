Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872BFC2BAEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 00:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D04206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 00:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZ24bt60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D04206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCBoh-0003ko-ED
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 20:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jCBo1-0003CB-H2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jCBo0-0001L3-70
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:34:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jCBnz-0001I4-VI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:34:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id a25so5189412wrd.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=o4wfwFzslWSogfShuzT1GXszAi31gOgslMZWdjvKfVo=;
 b=LZ24bt60gTmcfYWHhCsEWR4BHFJlkp3DexMhVT/j5ERjOXSeJ37pMmiuMRlvTyT7HK
 JqpQwkpYsoYVg3uGyXCiVNaquC3kh6E1EVRQ952U+YKVIwfRqXBsUz6VmM94LX0p0oBh
 nRI/aGFhUkoPn4hMALZanetw/RwDSngToHjwFpqPCujnSOAxmkiyj6G/8adAECNCDw8E
 q8w1NVeD/wH3ifi2WPvz6qL7utV0dSr2gvuV48lPi2cAL5ZY6jegHjElhMBSsNleheVB
 +gOjMLxEUqWPZ9ZNmQX7fffkC2dMnRioNxTEI2iZx3NP+9XvKBxojtF3/fKZ7IZYPh4g
 8v0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=o4wfwFzslWSogfShuzT1GXszAi31gOgslMZWdjvKfVo=;
 b=qdyODdbKv7QKn1dihe4iMTk9LIplbSfbmlP8fxtzTLIw2fGcy58tFIGvAokF3bRSR0
 Zul8yz3ac5YegthKm0dkQIixgjGEBY41hUZDqD9TdmQX/artliW3Q/vx0oMiI3UWsIf7
 Lg6aGMZP8XuzhbC2+oWRH+ssY82C+vyOaak6SJI6xYr7e4nnfioYTuYo662PUWBi28zM
 G0dJ+MXVFgB3L4IrZ5OoZZF5BqW1cvMIy5lMFS8Tz7m8zpW1918MQFLesDqzd38jDZfP
 C43F7XFQUVAr4mNQdzQNpbP9Ud2wgA3fU6y2zq3wvXkGeT97tf01J3klA4XBvtDoI5OI
 0BMg==
X-Gm-Message-State: ANhLgQ2/nILpx5MKua5BcDu2TILzj7w9P2gsFI32KUSmZJhOh0YHI3JX
 sNMzcSHxp4fWT4m0aJce+Xcct9+v70s=
X-Google-Smtp-Source: ADFU+vt+E4lrioPh1o0AmDdDMyHFD+dBDBxBKjY6ZhFem7kPpgR30rCCSCoB7F1MEwVLdmqsXmPQ8A==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr7155516wrr.396.1583973270323; 
 Wed, 11 Mar 2020 17:34:30 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-139-146-66.range86-139.btcentralplus.com. [86.139.146.66])
 by smtp.gmail.com with ESMTPSA id o5sm10909988wmb.8.2020.03.11.17.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 17:34:29 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Thu, 12 Mar 2020 00:33:59 +0000
Message-Id: <20200312003401.29017-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
  target/arm: kvm: Inject events at the last stage of sync
  target/arm: kvm: Handle DABT with no valid ISS

 target/arm/cpu.h     |  3 ++
 target/arm/kvm.c     | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   | 41 ++++++++++++++++++++++----
 target/arm/kvm64.c   | 51 +++++++++++++++++++++++++++++----
 target/arm/kvm_arm.h | 22 ++++++++++++++
 5 files changed, 188 insertions(+), 10 deletions(-)

-- 
2.7.4


