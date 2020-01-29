Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E51CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A8A20702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPBw6Phm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A8A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwtvf-0008Uz-5V
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 15:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iwttg-0005Av-Ny
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iwttf-00011R-Lh
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:12 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iwttf-0000v0-EZ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:11 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so1091354wru.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 12:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=5PiI2JpLPXOD+rhRs9PjT8IxzU7v7C1XqbI6jKm2tH8=;
 b=iPBw6PhmDE72adZ8akd4XeUE8dJvenckql6hJ+U+FpzRpIw0sYb0RBMJe3Ea/dUkoX
 oV2abATZvmbcgmr8k/CJf+d3bn+9UvQik1a4oUu/QxQlZUrpmswocbQrt1yGdgQSwhQ3
 GMdxhiP66sQ2/uHRYyDYcilnRYlUBHdHZtVOCPwsO66wXE+ofbThdUG2ycH61acP87WJ
 AHEZPHL6ZJKi485xpU+YLrJz+T1xMS14TCBntcMs67ZQ9ySsWDb4TRc5FYlGoatscVrG
 VR4uik1p8XcWMQr9h9SLQepvSVOfKi90BsLJIgZNKKBwvygaLKE9CS6HotvVL7YXa9Ry
 Y7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5PiI2JpLPXOD+rhRs9PjT8IxzU7v7C1XqbI6jKm2tH8=;
 b=Z0n8eXzkZSYgBKXT/LoaoC34v1jzbtT8c8bOplQgdSupEHKOOvLUJ2pu+qIuH2cgzQ
 wv8FF0BNFt2griqyPbGZ1g9zCUgmFex4Yp3yXkp6hepapZWmzszGVNdGy7lxq/dLP5dC
 mzoXkpWfMknq4cbTljt1riKdtwJCccKytLTX1l52G8qdoiToftNt0YcXf6SRBVEeuIpl
 enZKJrh0u/pz0MFmDyiw06xKrQoqHOlF2ht7J/qTO2pRjjD0YMEAi+lr0NO4ir3Qwh9T
 exlQ2Qm/63mDAXrbkChC+2rtUBBLdpzjpoqtfyTSak/pZeY5HAE4xJDdu0QF7+w00FdG
 Xy6A==
X-Gm-Message-State: APjAAAUcpw0qtKpCv2bpfwHxGmNlFYHlpBUiXRcYIYCPH85bWXas9G3t
 a2QiSTpkvztDzsDhp0gX7E1sVUKZLCg=
X-Google-Smtp-Source: APXvYqzHPzyBe0Bphrsvbb0c0NUyVZ5k7zDuDZ3BqSnCCZVfmTQUu16+tksblF9fEaldbHZwvLhNOQ==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr604190wro.51.1580329510061;
 Wed, 29 Jan 2020 12:25:10 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-131-78-194.range86-131.btcentralplus.com. [86.131.78.194])
 by smtp.gmail.com with ESMTPSA id h2sm4377518wrt.45.2020.01.29.12.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 12:25:09 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] target/arm: kvm: Support for KVM DABT without valid ISS
Date: Wed, 29 Jan 2020 20:24:39 +0000
Message-Id: <20200129202441.12745-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, kvmarm@lists.cs.columbia.edu,
 Christoffer.Dall@arm.com, pbonzini@redhat.com
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

ARM KVM introduced support for notifying guest of an attempt to execute
an instruction that resulted in dabt with no valid ISS decoding info.
This still leaves QEMU to handle the case, but at least now, it can enable
further debugging of the encountered issue by being more verbose
in a (hopefully) useful way.

v2:
- Improving/re-phrasing messaging
- Dropping messing around with forced sync (@see [PATCH v2 1/2])
  and PC alignment


Beata Michalska (2):
  target/arm: kvm: Inject events at the last stage of sync
  target/arm: kvm: Handle DABT with no valid ISS

 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   | 23 +++++++------
 target/arm/kvm64.c   | 23 +++++++------
 target/arm/kvm_arm.h | 19 +++++++++++
 5 files changed, 143 insertions(+), 20 deletions(-)

-- 
2.7.4


