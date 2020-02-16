Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0BEC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF60820726
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5W/HF0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF60820726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3PsC-00072a-2S
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpT-0003b1-Mr
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpS-0005TE-GZ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:47 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:40819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3PpS-0005S0-Bj
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:46 -0500
Received: by mail-pg1-x529.google.com with SMTP id z7so7889842pgk.7
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2Ox+v/I0pqLjSZRLVIm2ELpIo1rl7PcWPrh50XcU3n0=;
 b=C5W/HF0QbLRqYmpwkA9ZL+VCbhMUDiMRfYlviLRrwXyJrFZ0KsPpNPbG8Z3jM8QSUo
 p9TEA/eFRJnBFCaUG0wGRBSrMDYc6dYRj/KfUUBhfZcSfaIDFju4SvBDnPJHdJf9JHak
 V9+GPZ79MAO+gExD2wqDYdH5TFeqpWtNp8dW4ZbYyhMq8PtDt7oe9z6FsETH7WUn93N7
 bxz37VE0m/dAFWTkB0obNDFOLPd7l4TcpC1gr/W3Gr8ELnQzwKZM9qcvHBwJ3eMS9kS6
 Xiw9+FByobRoLbag23Xf3oYPbhq2Z5no/LIZVm1wViQ7LqmMFBHpZB1kEyXa6tcSBuvL
 Ut/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2Ox+v/I0pqLjSZRLVIm2ELpIo1rl7PcWPrh50XcU3n0=;
 b=VisMEK4TKnSHn9GmvBu8YXN+Z3ddzx3POUaECDy1bVQ5BHzG0i4uT1PWhHKjmF/xLS
 O4a12+kO2R6M3VU2oscPZ1WfZhFub9OAIpWCJOj7KgN9jHPkFg8c/qAOqWyxt/gMHKbW
 dswuq9ezlwW7CxUDFeSllrm/LTc/WFZF+ywokQySH9W4U9rBeuzet13SKiidMIbY2RkJ
 i3CRy14jmbVzuLwhWo2pFrfNIl5LWkB8WnsWBUh2YB7A6M7vXYYUxZEfCkKJlZ8sSdGt
 9V6pklRg+wsBeY4VqQ++x4cz4VTkmR0exKpSCFE77AHtC2a9XdCQaMPpMaaGhmjheT4E
 gyxA==
X-Gm-Message-State: APjAAAWvi/LoKTwEvPcwp7p/w1kbBpQEeNTSd8fbtixcAzL9CJqaq+P4
 bM0avrE85OPFAHR5r2vcpDWbbLuzLfY=
X-Google-Smtp-Source: APXvYqxUxk/szE0N4deZwVRnDTVPSCgGqMd5zQUTJJEqQ/9NyOLzVw6d5QxL/OK5+iFiGfCiFGznrg==
X-Received: by 2002:a63:f54c:: with SMTP id e12mr13873617pgk.181.1581882225018; 
 Sun, 16 Feb 2020 11:43:45 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y127sm13945188pfg.22.2020.02.16.11.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 11:43:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] target/arm: Reduce aa64_va_parameter overhead
Date: Sun, 16 Feb 2020 11:43:39 -0800
Message-Id: <20200216194343.21331-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Something I noticed while developing and testing VHE.

For v2, fix select as a separate patch.
For v3, adjust pauth to use bit 55 explicitly, and remove a
now duplicate test within get_phys_addr_lpae.


r~


Richard Henderson (4):
  target/arm: Use bit 55 explicitly for pauth
  target/arm: Fix select for aa64_va_parameters_both
  target/arm: Remove ttbr1_valid check from get_phys_addr_lpae
  target/arm: Split out aa64_va_parameter_tbi, aa64_va_parameter_tbid

 target/arm/internals.h    |   3 -
 target/arm/helper.c       | 144 ++++++++++++++++++++------------------
 target/arm/pauth_helper.c |   3 +-
 3 files changed, 76 insertions(+), 74 deletions(-)

-- 
2.20.1


