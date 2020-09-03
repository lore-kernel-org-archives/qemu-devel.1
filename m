Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDF0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729CC2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqlRJZlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729CC2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpMO-0008VZ-Da
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDpLc-0007HH-4j
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:32:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDpLa-0007up-98
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:32:15 -0400
Received: by mail-wr1-x42c.google.com with SMTP id g4so3263522wrs.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IS2FHzcfT+ool6leykwthfQBd2V3RQBhWX+2lK4kgQI=;
 b=bqlRJZlqNn/GTIJmJrTh5zrBPGPKEnn1llMYtjSitorBlIHMCVxqvLy7zCrjdwjFpz
 /KTRQQAyD9wfmDogOlQ9ttZ7kJ5Qp01Kg7MMAzOBHmjpXTqpMq/i/0exwINk0cnfDdhy
 eyG2oh8gnChxqKdGPostdg1y57vKdF2HSGCu4+m8AqD5NhKcOE00FNLfJUWC/SM2kr+x
 hl+IUzd0yGz9gQpvvRpjxcMVLpdRhsoCm/WeZaYZdkhX0R+3uCqqqzupYLgDOaNZPV2c
 R1YaqJo+Pe+QRkXAyQYdyghAcSaPyZPh/K2hiXHo3t6MR4IZECSZKIoF9ZlBYFjmM+Kh
 2+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IS2FHzcfT+ool6leykwthfQBd2V3RQBhWX+2lK4kgQI=;
 b=GU960iRU0WEwGvkicMKuH54HlfmDdlgtWtyCj3VCF8aYBvxDFnglL57SQNrXgkPhec
 49wcz5F84LS8jwHToR9jlGhHN/kEP6ZMxHEIbkeHrlb5QsPq2ZCqIQufxMfgU02W2C8b
 7Xx42E7s9nKNNlaJQBrvhKcY4IGoR4Qv4b998L/yDUxi/jLnjfc24PNinE+tyr/K6iYH
 oIjlICybLGV/rmYKbgng7eYqi+zbBAJNwAEYVg+YOQ3SiLq6XPB7CTBsOlPtTqENJxkJ
 DalEj6+FruHkhzK2u6g9G9Q0StnzE9yn0NJIByu44aZdFLxeRjzxuNCVFA82PpWYiVgr
 HQqw==
X-Gm-Message-State: AOAM530naX/FzHe0yaU/MIaxjHe/VxBVMpeoTcfuZt3OQw8NVdDARvEX
 r60cHofczhwmeDUMrt4gdpSOeg==
X-Google-Smtp-Source: ABdhPJzg+ZuDr+RB0S/GbP7z1E/qXXpoH/JvlR0Dbk07Tyok3gkqTvUqdoulD8ZReWJJABd3o9kHWw==
X-Received: by 2002:adf:f808:: with SMTP id s8mr2476180wrp.268.1599139932186; 
 Thu, 03 Sep 2020 06:32:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id k24sm4301988wmj.19.2020.09.03.06.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 06:32:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Decode Neon fp sizes in decodetree
Date: Thu,  3 Sep 2020 14:32:06 +0100
Message-Id: <20200903133209.5141-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patchset fixes something that Richard pointed out during
review of my fp16 patchset.

In the Neon instruction set, integer operations always have a 2-bit
size field with an encoding corresponding to QEMU's MO_{8,16,32,64}
constants: 0 for 8 bit, 1 for 16 bit, 2 for 32 bit and 3 for 64-bit.
However for the floating point instructions, since only 16-bit
and 32-bit floats are supported some instructions use one of the
size bits as part of decode, leaving only a 1-bit size field,
which might be encoded either as 0 for 16-bit float and 1 for
32-bit float, or the other way around as 0 for 32-bit float and
1 for 16-bit float.

Currently we simply pass the raw size field values through from
decodetree to the trans_ functions, which means that when reading
or writing the code for a trans_ function you need to know the
encoding of the size field for that insn. This patchset moves
the handling of the different possible encodings into the decodetree
file, so that the trans_ function is always passed a MO_* value
for the size.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Convert Neon 3-same-fp size field to MO_* in decode
  target/arm: Convert Neon VCVT fp size field to MO_* in decode
  target/arm: Convert VCMLA, VCADD size field to MO_* in decode

 target/arm/neon-dp.decode       | 18 ++++++++------
 target/arm/neon-shared.decode   | 18 +++++++++-----
 target/arm/translate-neon.c.inc | 42 ++++++++++++++++++++-------------
 3 files changed, 48 insertions(+), 30 deletions(-)

-- 
2.20.1


