Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F70520714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVzxmaMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F70520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ1bG-00089z-Om
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 17:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJ1Zm-0006Xc-Dm
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJ1Zk-0002dA-DY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJ1Zk-0002b8-36
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id u10so23401411wro.7
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 14:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GOZtPYlJYkzukGwNx4Y9x7WEX4ppgFY4ZIR1eVR/7yU=;
 b=QVzxmaMKMve3RG9zta7/gXvwyTcZxoq8Gk6nC8mZ2Yw2yyCXMGy6+nYN0cIAcAwwrp
 K6qc38osB+k0mHsc20jVfPpYR3vaG3Rs2I/H1ZDPzBo+tDpWF07StARg27Pfjmk328+4
 S70fRZ9HkHuZkpwHWm+6G4onzArSi2J26Jz2lP9b3w2S24tNTb/NaMobhcHlLbY8AewF
 wZiUsmDChgzpjmj4M3PS/47hhEWd9u9OnYwBpCnRjseBekIGbCw4xnrx6EwtYSPRDo3J
 n3U7ZGKE+xymKWuEUOk8G6SxKcRZ1pZOB/2VXnfgUfKPSfykqc4eqlDgZWsOJHsauuNY
 PvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GOZtPYlJYkzukGwNx4Y9x7WEX4ppgFY4ZIR1eVR/7yU=;
 b=kHSSnOJeK0pSgopkRg/JXluasYzo/NUtnDr0z55+hIw/echWls9V+WT9pyNS6zD+d3
 /VQrm4B7PME69Uh0B8iw4g8aKXz2K5oxbOUhvYLGA7rw3FoCEO5a+3prDHYxgm/8r+I1
 vL5ErTRvuTwhqKheEMjamFve3J0EmlaOjVfQq9ig4+UikEBfgkGFD5t8H4J6s+fz1jbl
 Pw6C8keb8dx6UlmO9zen5E5HDTadqN9HCd7yHZrCe/H4SVkbfXnkHP+r/1jdrGzx2eWn
 9yTBAq3yoB4sBZyeecSYuQzoB1kn5M7IuCmo/OwFvSDT3QwNV/0tnl6fUZt8rZz2AsEc
 dahw==
X-Gm-Message-State: ANhLgQ0lWHLTByzV5nly1uMM0bDAP9cHI4DGJM1jg6daXpP1jBkzIId9
 eXUlTkp/W+GDynnf+K5lGK5KPQ==
X-Google-Smtp-Source: ADFU+vuhPl0wDzOr6EN7TDDPLKQoS0/KTk+2scncbjk9rSW8d+G3rSIDn8c2OrbwJ0mt3y/Q22OtPA==
X-Received: by 2002:adf:ab5d:: with SMTP id r29mr18258373wrc.158.1585602242416; 
 Mon, 30 Mar 2020 14:04:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p21sm1012700wma.0.2020.03.30.14.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 14:04:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] arm: Implement ARMv8.2-TTS2UXN
Date: Mon, 30 Mar 2020 22:03:56 +0100
Message-Id: <20200330210400.11724-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is obviously not 5.0 material, but I figured it would be better
to push it out for review now rather than hang on to it and forget...

TTS2UXN is an ARMv8.2 extension which changes the 'XN' field in stage
2 translation table descriptors from just bit [54] to bits [54:53],
allowing stage 2 to control execution permissions separately for EL0
and EL1.

For QEMU this had the potential to be awkward, because it means that
the stage 2 translation now depends on whether it's being used
for an EL0 or an EL1 stage 1 access (the address doesn't change
but the access permissions do). Fortunately, although we allocated
a QEMU TLB/MMU index for Stage 2, we never actually look anything
up in the TLB. So patch 1 turns ARMMMUIdx_Stage2 into a 'NOTLB'
index (ie one without a QEMU TLB), thus avoiding the complication
of splitting it into separate Stage2-for-EL0 and Stage2-for-EL1
indexes. Once we've done that the actual implementation is pretty
trivial -- we just need to plumb an extra 's1_is_el0' argument
into get_phys_addr_lpae(), and then use it to decide what to do.

Peter Maydell (4):
  target/arm: Don't use a TLB for ARMMMUIdx_Stage2
  target/arm: Use enum constant in get_phys_addr_lpae() call
  target/arm: Add new 's1_is_el0' argument to get_phys_addr_lpae()
  target/arm: Implement ARMv8.2-TTS2UXN

 target/arm/cpu-param.h |   2 +-
 target/arm/cpu.h       |  36 ++++++--
 target/arm/cpu.c       |   1 +
 target/arm/cpu64.c     |   2 +
 target/arm/helper.c    | 183 ++++++++++++++++-------------------------
 5 files changed, 107 insertions(+), 117 deletions(-)

-- 
2.20.1


