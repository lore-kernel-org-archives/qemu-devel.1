Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C7C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B03B206F0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlNVyIAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B03B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNPw-00010f-H0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNNz-0007FT-Rv
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNNw-00084V-9N
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:23 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNNu-00080Q-5b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:18 -0500
Received: by mail-pf1-x444.google.com with SMTP id 4so2561472pfz.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uY7Lt5g9YurdfmHwmcMrcFnNWqbcQeorv2ToloQVRY8=;
 b=wlNVyIAgumKS1Us9ZsgKoRUE+syA1Kd9TJaVwALoxoWAAkE2qaRqjs9iUcQNbU+kGI
 GOX9KH419cztuRCBp4d+r7Hpvt8SBCbFIsMfph6dLEuXGfs2noG73UEZGYdsms4LY5IP
 E4lAmSRH+o1Lz28ruRtCLIfAb4dhZmeQqlohgEwQkQw2OyzPy4KL7gPvMuQyd3U1BXc6
 5gt1w0NjNSS6Mw8pDolPK13m9ZnVmD0OlH71tj/Y8tFiUKtDd5VpWwdPr1vP5/Q2JQcT
 cbKLQuQOZkcyAkeMWfkSWpVfwkZhkeCFvCgeAET0iDWf/lf2zJlMhrp47v3k2SwFMIue
 7wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uY7Lt5g9YurdfmHwmcMrcFnNWqbcQeorv2ToloQVRY8=;
 b=gSW/cKVeBoRBb3Ytaph0ugmgVZpcXRC0g5eA/izBMRZaQvntcj4ADj7btYLuAcPg5p
 xWXPjskHZvw52CEFt8gee6zvBOh8CnsoqY7o0YNMM7o1Q51D+ovNQd57v3SMdX56pfuz
 jhaPCqtnL+MM8cM4QTkl96lblJ6Jv7siP3DNn3PxB+hvydC4EFoTeaiKK5KKHPhYFe58
 NIcQ6OGPtJd2WVDgGIWG3gTqhwrHfIyIyLRBS8gWmehNsbxShSaaAdLsrB/qMmEgtJ0m
 QPenTUCkoKfByaF7kJPF/9iYVPlBt1DnwdIRddvVgTYv8l+bDsrabjljdqrqLFmBYq04
 xH8g==
X-Gm-Message-State: APjAAAUNwI9DXJr2VZ64dEkgcxwzk8F1DQS7CN0PebHh4/wBmcys1Ytz
 KLasVbjnKHY81J1UoOdg++MYYC9G+fBxQg==
X-Google-Smtp-Source: APXvYqyqIXB747w6wO4D1nc6GAgKHg8jjx/k8b2bK5obwsVY5qPku8z3Q9eU8g+iy1RCqhA66k2Nag==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr8676875pfn.62.1578536236088; 
 Wed, 08 Jan 2020 18:17:16 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id n26sm5166715pgd.46.2020.01.08.18.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:17:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] vl: Fixes for cleanups to -accel
Date: Thu,  9 Jan 2020 13:17:06 +1100
Message-Id: <20200109021710.1219-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running qemu-system-foo with no options should not generate
a warning for "invalid accelerator bar".

Also, fix some mistakes made while moving the code from accel/accel.c.


r~


Richard Henderson (4):
  vl: Remove unused variable in configure_accelerators
  vl: Free accel_list in configure_accelerators
  vl: Remove useless test in configure_accelerators
  vl: Only choose enabled accelerators in configure_accelerators

 vl.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.20.1


