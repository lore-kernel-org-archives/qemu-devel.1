Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB49C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC510221E9
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8TBnRTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC510221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPpqz-00085i-35
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPppx-0006wI-CZ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPppw-0002gS-2I
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:57 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPppv-0002fR-OU
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:56 -0400
Received: by mail-pj1-x1043.google.com with SMTP id np9so2522068pjb.4
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lj6lSrPVM5tWkCU7F3bE232plkF3rYU2Va87V8fTIjA=;
 b=d8TBnRTGilmRgq2dtoYGdAw2K7bwQEG6YP0gFA9lHi3isKEPd0KP0Mk4I+S1C5mv3Z
 ZmH3M+P/N+Vu271Kl+x2uOemiT1mxR66lt7iP06f6oomzpI0UiAtHbHW1ZSzAsy3LWs2
 vHMhViUUHyZrV9qqsgNIUcsUzuVjvXsJUAuBfVK8EwJQt2rybFRsqT8ZicuHOjPwmQz5
 PHbrain04i2i1WnK+EmheuOalGyqSMYlsVRaGCh9lSvT/CVcyQJxfEbEP0rt/BsD/0Mj
 jGuE2vMBRR0xKYWIedGqDjnEDXgW58/h74YDpgzrvyg8LzIYB4E2ZNBDOweR7iWhZeRb
 d4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lj6lSrPVM5tWkCU7F3bE232plkF3rYU2Va87V8fTIjA=;
 b=WYb0jiuyEEGIp1DhMAj1dseVCJlLeBVt3oVWmgCdZmwPB+kgRJa4w2WpV/1qQ4S+Y2
 5IQN1rxeZxYbsZbQ405XczXHjGJfK3iYi0/KP5tvQh06htL1oomS7EYqiqdPnku3KgaF
 eM0jmkmHaz4jJx6XzehM/Caz3POOK403dqbnFgk28XlIXXjpO4uQKe9iDogQETfm8ugj
 IFD9snVNvTEbqWulTC+8tk4LPyX7LWAWyDt4ATlB4VjDUEfvo3nOfuQc3cE/qpmpIDpD
 /iXMz8ao6ZuLZhCKOvAx5JvHlm6bePz5Qk6hT/+TzIBlYcPOSUcddQVhtBmNWpAxCLAp
 rsZQ==
X-Gm-Message-State: AGi0PuZVgJgYu0/DlYUd/sx1QLL070Qm6HO5O3FIY54/rB9klRTyhaNO
 cXPQfG0YPS+cbksDY0Ey3MqB9Ij9FVw=
X-Google-Smtp-Source: APiQypLa6AlFdlQcjZk1UlTqk13RvLcrRboorDsSWl0xdKmSHfnftgLDW/TVpajAdLIyk2cr5HxUSA==
X-Received: by 2002:a17:90a:9b17:: with SMTP id
 f23mr10972815pjp.118.1587225414334; 
 Sat, 18 Apr 2020 08:56:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m189sm13928532pfm.60.2020.04.18.08.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:56:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] tcg: Improve vector tail clearing
Date: Sat, 18 Apr 2020 08:56:48 -0700
Message-Id: <20200418155651.3901-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

Something I noticed while looking at AdvSIMD dumps, while
testing changes common with SVE2.

If we're going to load a zero into a vector register for
clearing the high bits of the SVE register, we might as
well use that zero to store the 8 bytes at the top of the
AdvSIMD register as well.

Output assembly goes from e.g.

  00:   48 c7 85 08 10 00 00 00   movq   $0x0,0x1008(%rbp)
        00 00 00
  0b:   c5 f9 ef c0               vpxor  %xmm0,%xmm0,%xmm0
  0f:   c5 fe 7f 85 10 10 00 00   vmovdqu %ymm0,0x1010(%rbp)
  17:   c5 fa 7f 85 30 10 00 00   vmovdqu %xmm0,0x1030(%rbp)

to

  00:   c5 f9 ef c0               vpxor  %xmm0,%xmm0,%xmm0
  04:   c5 f9 d6 85 08 10 00 00   vmovq  %xmm0,0x1008(%rbp)
  0c:   c5 fe 7f 85 10 10 00 00   vmovdqu %ymm0,0x1010(%rbp)
  14:   c5 fa 7f 85 30 10 00 00   vmovdqu %xmm0,0x1030(%rbp)

Saves a few bytes now, and more when we can do better with
loading constants into registers, where we can share the
vpxor between instructions.

The target/arm patches are not aided by the tcg patch, but
are not dependent on it.


r~


Richard Henderson (3):
  tcg: Improve vector tail clearing
  target/arm: Use tcg_gen_gvec_mov for clear_vec_high
  target/arm: Use clear_vec_high more effectively

 target/arm/translate-a64.c | 69 ++++++++++++++++++--------------
 tcg/tcg-op-gvec.c          | 82 +++++++++++++++++++++++++++++---------
 2 files changed, 101 insertions(+), 50 deletions(-)

-- 
2.20.1


