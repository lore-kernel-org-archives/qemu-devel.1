Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A2DC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89282173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUImm+wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89282173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvp08-0008Ps-U9
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozN-0006wy-CB
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozM-0001Bb-Am
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:21 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvozM-0001B8-3n
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:20 -0400
Received: by mail-pg1-x544.google.com with SMTP id n4so2906239pgv.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=E+V3l19qjvp2GyZbaaWVRKF84AAkyJUqeZHB29ZNbdg=;
 b=qUImm+wUxZ95+zy18eOUgcv8UXleYjqPVYyWbw0/i+/wIfanF+uklwODhr1GlgWD2K
 ZVaTaBpBFkgdEjDBgKHCg7crZDiQIjwaxZI9c1scLQhJWFitV76rxOo8pN03GDQhmBeA
 Dc/nQiMt9qFd5cyFZNkQ45HO6B1t6shw2VsArymKYWiLX97kVZQ6ztKwDOJFVgFL8ePz
 LEqxERc+3hJ3n+U7UG//0rIuQuU5N6r7qIwrOBqg1Fd0Xx3rRETU0SfN7gzAX2cEu3YN
 3lhFOLPZ5W7PQsobiGUTBuY8oISE8IBtOKvDKuFK72t10N0+orSSU0JYyCLvhtmDz12y
 J+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=E+V3l19qjvp2GyZbaaWVRKF84AAkyJUqeZHB29ZNbdg=;
 b=co0OAefwKvzs+CZGn27PK3ixRIQIHH8Y+VIiAWgsj9GSqLil5O+5xxMkPgc6PLxRxH
 BDPR48XKAxPdcZ158BmRzrwMZkpvzEo87FZwa/gywL4emrNpSUmsiniv8MVvaBLWce6Q
 2Q9am7s877jlOhHPG8iGvDh7AM3XHfV8vC6Kwfohns17PtDqDpoH2iYGQN5Dsm5mV0ab
 ps0u9i6zFPXpgsnfrmuwiaZGunysdH/tSeZGYqCADDFCrxtbFgp1JAL5W6GMnf1Fa8qH
 iGLac5gU7dJ6dLEtr7bkW1qKJXH/O1tqsaRibOTMgMB/tm0dp9yJJ3LIeD1iawGx/pVs
 qW1Q==
X-Gm-Message-State: APjAAAV+LcdIeINU9kfwyE3saDHfXC4XrWZKcjNvLQbFXAtT404G/mMc
 Edf+mYbZOGGI8csiBSK4NGEv+NdxMAo=
X-Google-Smtp-Source: APXvYqzdLwvCNMu5PJghlswX8/orru3tDiNG6ocn3glCfkasumLUPqwFArpMbQ94j+PBIBh1RhueFA==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id
 h1mr5870423pjs.101.1565295978688; 
 Thu, 08 Aug 2019 13:26:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm2850146pjk.13.2019.08.08.13.26.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 13:26:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 13:26:09 -0700
Message-Id: <20190808202616.13782-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 0/7] target/arm: Misc cleanups
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

Some of these were cleanups that I was making simultaneous
with the decodetree split.  Let's do those beforehand to
make the split easier to read.

Some of these are new, noticed while I was in the area.


r~


Richard Henderson (7):
  target/arm: Use tcg_gen_extract_i32 for shifter_out_im
  target/arm: Use tcg_gen_deposit_i32 for PKHBT, PKHTB
  target/arm: Remove redundant shift tests
  target/arm: Use ror32 instead of open-coding the operation
  target/arm: Use tcg_gen_rotri_i32 for gen_swap_half
  target/arm: Simplify SMMLA, SMMLAR, SMMLS, SMMLSR
  target/arm: Use tcg_gen_extrh_i64_i32 to extract the high word

 target/arm/translate.c | 157 ++++++++++++++---------------------------
 1 file changed, 53 insertions(+), 104 deletions(-)

-- 
2.17.1


