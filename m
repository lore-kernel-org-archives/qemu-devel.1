Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE92C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786EE24813
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyK2m8sX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786EE24813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXr0F-00009p-BQ
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 15:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXqwo-0004ie-HT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:17:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXqwi-0007Zp-0u
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:17:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so248246wrp.10
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CZIUq9jQBpb3euLRL7uB1HYxmM0OdzjlpOHQCueZOfM=;
 b=tyK2m8sXn9JRs7zLK/8YRPBnjxLON30jDxiol1pF76p0nA23kQNgEYIPk+gTZv8vZH
 kMZTXHBmzIMgzckzHcSjeD+m9f3XPww6LsimpTYV30ZTGrDekEJjneHJvd1m1GimNXL9
 XQ+UrmfctqOj6C7eENsPw/4tnVHIuCnStsxVAHBgrNjzMbITUdh6Y8BuYsQeq+N2tZCM
 vJDC1fsagK/UhM4Xrc4x5D4384nzQw1eBJV1iaBj955yuTbDeuxUIcNNygx9Ip6mWiKi
 9XPE7nfj3Ks4E6n7hFwvOeMRxNf+TfGWAHAvXKTUeFas4ph6kqMg9YIiBLCA/OH9RkW6
 IraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CZIUq9jQBpb3euLRL7uB1HYxmM0OdzjlpOHQCueZOfM=;
 b=M+pkYYOi2CF30miUDqYEKxpnAp3ygul2djq6IYDz3T/UkkTk9XfZYmXfA8eunBnZxd
 NqElLsxShuWt8DYKkCj3ClcxPM9hjk4UqGupXcrU9RUr6dnDOUr/VnDfkfGgQ4PtNNTn
 K5gZqxJoh9G3QFREEec9G3vW/A1kwgSF3eWVvI73BZV5Mm7DSalIiTxe240G9UwQE/pv
 gqJghgVZVwOE108UOQM2A7myr+X4BwSilAkqrqiz+cIDDcOaLRUNzWthJcAr/3uJC6ho
 b31fgJQgwnWOL7OBfFAYZ0sAVClC3g20CMwLas+CzFa0BHDdVNEpkg4zHb0zEcZWEma5
 eCvg==
X-Gm-Message-State: AOAM531WpsPF/2f+T+8y0Jih3gJnAVm9ccHq8lMd1F5rk7jmp3FQ/p1p
 EX+OrZvDRWOTZEM2GJFivN7zuQ==
X-Google-Smtp-Source: ABdhPJxCmwv76YpXlMNnZgFVVArlyZYMuwF8ZdL6j25SVK7+gWMkjitnkFFaoCwiPKVStSr2UzMg/g==
X-Received: by 2002:a5d:458c:: with SMTP id p12mr900665wrq.329.1603912635174; 
 Wed, 28 Oct 2020 12:17:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l16sm743953wrx.5.2020.10.28.12.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 12:17:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix some Neon insns on big-endian hosts
Date: Wed, 28 Oct 2020 19:17:10 +0000
Message-Id: <20201028191712.4910-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchseries fixes a couple of places where the vector
helpers we use for Neon insns were missing uses of the
address-swizzling macros H1(), H2() or H4(). This is harmless
on little-endian hosts but causes the wrong results to be
generated on big-endian hosts. The affected insns are
VUDOT(scalar), VSDOT(scalar), VPADD, VPMAX and VPMIN.

This series is independent of Richard's recent "target/arm:
Fix neon reg offsets"; it fixes the handful of remaining
risu test failures I see.

thanks
-- PMM

Peter Maydell (2):
  target/arm: Fix float16 pairwise Neon ops on big-endian hosts
  target/arm: Fix VUDOT/VSDOT (scalar) on big-endian hosts

 target/arm/vec_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1


