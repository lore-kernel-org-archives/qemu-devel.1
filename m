Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE8C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4073721734
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl0IYolS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4073721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1bRU-0003vV-CC
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 14:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1bQX-00037z-Aj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1bQW-00020c-4e
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:32 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:40137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1bQV-0001xY-Tp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:32 -0500
Received: by mail-pg1-x52b.google.com with SMTP id z7so6275148pgk.7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dpiRuFdZAcSfOLy2kSM7vIZSMffwMp//61n2Ddo2hc8=;
 b=Gl0IYolSDsXld8IgJKst+segxK1t+ubBlHhmgKA2oGwcnyKwwyZHURyKhLQqfz0yqu
 p/8f0nC0FEWsmTLlZbdCB9/vwC6n/F5jv/KgoMZBB1VpjOtRlCBrcfRL+gayoUhf6wgN
 lIE8hQyckZjQulKB7QEzLE5KUiFEXa7OH33FsgE+yWLfz5r9NgwkjX5deISdbAH/wgS3
 G2HGj8LTMjiQATa7Lx+x1ITt2Z6zcTaiPiYuF4TBGNGQHyhm4qyomLlltKebyClsMsHK
 EYSmpWTdo543uc5mp/PxLqoravpgIOG32pCdb4H7yPHX2MkNnRMJ3UWij4J9mbCZEmoR
 Mv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dpiRuFdZAcSfOLy2kSM7vIZSMffwMp//61n2Ddo2hc8=;
 b=iJMHBWjnGrXaHB7J394qwe8K+nari+qEzNmvIopjOBNTlszX8JkwtzK+8mfsNl3UuO
 lSg9gTtaI/g9GvqqEl/KeQHzKmRlWl4rDna3vUYd/fnF8N/OEuj/PMZ7j6g33nSWIg6K
 Fj69nz1B6CMvN6ktYr7DSkwkovZCohbQfC5CHa6DE7otvMBfqXJ8CjMOsDSWFc1V/I2z
 dxMl0Q2OOeK1r+iJ5F+sYqKiTgMy/adyL7/V3ps9z1FKxRP2Q6XlWbcDDuvSVXA6T/1x
 f8WQQHM48F1aVZqMU5DICRx9VnUIRXFb6r9ZuI8BrRaLi0owgAJWJ5vLoJqY29E54SH6
 /dMQ==
X-Gm-Message-State: APjAAAWN3rVxI7cj6NVDWb5aEOujGXD4a9sP1AoeBtj7OnR0CA1Wz/Ds
 BIWJDIlGG7IvE/xMrxqYN2//ACJSSAE=
X-Google-Smtp-Source: APXvYqyFdNtxEOvUF2udo08C3+N9CZs76ygI0I6rC4EdvrV3ALuX1lWusfSPGyMwpvpN+grA9OsxFQ==
X-Received: by 2002:a63:5220:: with SMTP id g32mr8399385pgb.116.1581450149764; 
 Tue, 11 Feb 2020 11:42:29 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id b18sm5306281pfd.63.2020.02.11.11.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 11:42:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] target/arm: Reduce aa64_va_parameter overhead
Date: Tue, 11 Feb 2020 11:42:26 -0800
Message-Id: <20200211194228.16907-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52b
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Something I noticed while developing and testing VHE.
For v2, fix select as a separate patch.


r~


Richard Henderson (2):
  target/arm: Fix select for aa64_va_parameters_both
  target/arm: Split out aa64_va_parameter_tbi, aa64_va_parameter_tbid

 target/arm/internals.h |   3 -
 target/arm/helper.c    | 138 ++++++++++++++++++++++-------------------
 2 files changed, 73 insertions(+), 68 deletions(-)

-- 
2.20.1


