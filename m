Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF4C7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84A120857
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHkAvS4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84A120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Wem-0004QY-VZ
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 22:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Wdf-00035Q-2n
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Wdd-0003Mc-DO
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:02 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:40388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3Wdd-0003LQ-5a
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:01 -0500
Received: by mail-pl1-x636.google.com with SMTP id y1so6115870plp.7
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 19:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lfZ/gSeSSwO+iUrhXjDeYzuRwSvkE5pc/x6+ENqbncI=;
 b=KHkAvS4YHLTytdeAX1l5JU/D4BGW2/n6DS3hRxGn+0SD51n7FogMTQhL4tRdLbVPcv
 FCEeoBLTYNT7anmh2oEzN2+pJiSRT80ziWr+YvqyjedUJkM6F9APVa0bks7TbBSy9rQU
 2CvQPdfbUr1c9/LB1algsUyAwwFLG9MyQzk8EMdgYgUzgaznNcJjBvmGIl3uWzb55GgV
 +BYuwG190rLOF6trzUuhKTrqViInxG/K0lBR3X4XgNt/bwTFBcUzedUYMHPMo8abGLEa
 adpZQ3Hl+T+RXeFKN5QQm6IXmW3ci6PEKzZltG36NxNvt+TcBEcqNk1WlKPeHQ/SdUY4
 pNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lfZ/gSeSSwO+iUrhXjDeYzuRwSvkE5pc/x6+ENqbncI=;
 b=ILat4dW4+yN+sTjUm+Gm/uQ0YLWcPpUCQye9Fc6uzUcm4T5ze7CGJQcjFzydTYekUA
 EaQL2n1l/0okhWKp+dAOueBmZ63tlkzLdQIPcYfVW67EKVAKug1jhqKrEKRKJtPYOVaM
 jJ9MowkxxWQNPbRT+ZQritgIDKoTaTofaZQPGTNe5zK8CHYoQA4KIFrOqoqYSXmpjP95
 ko2ZSHAQwfTSTo02ZTyD4n9kH9TjOPCz0vIhwxi5h3XU+JPOyz8nhKJDz+lHlmvFZrvq
 RhFMzv5E1aJMk4mJos46/+rxaZAiHtLMmOw5OovVnoJV80bsfkbvqO5kM2Jm1gdWhGRN
 KKLw==
X-Gm-Message-State: APjAAAUe0BdO8nnHFp4H34XSrQCJfRfh37Oih73LFZUun2W+1SkruOUs
 TYKO6rH6TjGP+AuD3llKRHiK+UARfDk=
X-Google-Smtp-Source: APXvYqwYnJIZ0yKyBIJOWOEC7Lr2UGGcDSeMcSclEq5jCQ1MazirNlyXvybKn+OtZKcluof58dbr+Q==
X-Received: by 2002:a17:90b:97:: with SMTP id
 bb23mr16545483pjb.53.1581908399037; 
 Sun, 16 Feb 2020 18:59:59 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id u2sm14741060pgj.7.2020.02.16.18.59.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 18:59:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] tcg: Fix for Bug 1863508
Date: Sun, 16 Feb 2020 18:59:53 -0800
Message-Id: <20200217025957.12031-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The comment in tcg-runtime-gvec.c about CONFIG_VECTOR16 says that
tcg-op-gvec.c has eliminated size 8 vectors, and only passes on
multiples of 16.  This may have been true of the first few operations,
but is not true of all operations.
    
In particular, multiply, shift by scalar, and compare of 8- and 16-bit
elements are not expanded inline if host vector operations are not
supported.
    
For an x86_64 host that does not support AVX, this means that we will
fall back to the helper, which will attempt to use SSE instructions,
which will SEGV on an invalid 8-byte aligned memory operation.
    
The first patch removes the CONFIG_VECTOR16 code and configuration;
the subsequent patches tidy up tcg-runtime-gvec.c.


r~


Richard Henderson (4):
  tcg: Remove CONFIG_VECTOR16
  tcg: Tidy tcg-runtime-gvec.c types
  tcg: Tidy tcg-runtime-gvec.c DUP*
  tcg: Remove tcg-runtime-gvec.c DO_CMP0

 configure                    |  56 -------
 accel/tcg/tcg-runtime-gvec.c | 298 ++++++++++++++---------------------
 2 files changed, 116 insertions(+), 238 deletions(-)

-- 
2.20.1


