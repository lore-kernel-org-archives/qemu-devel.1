Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50F3C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 21:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E242215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 21:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwDIZMEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E242215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLEJ0-0003TI-O7
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 17:59:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLEIB-00036M-TV
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 17:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLEIA-0005y7-Sn
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 17:58:31 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:36619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLEIA-0005xj-N6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 17:58:30 -0400
Received: by mail-pg1-x530.google.com with SMTP id 85so5818517pgc.3
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=BSejnZmTBgmRIVkic80VSsvAmUgxgYcicE1r6mcOOmk=;
	b=rwDIZMEsuJzUpVp9oy0inWEmFqosWhuQpvwRYwFL4xWwewGgxEjb+gWYyPiBpTnKmY
	O5F6RU27wD/0+qLJpdF36DPlfnh4Qr/YJaJ1QwzlpCfNvrD7i6aFN4LJ6SkOch68S/Qu
	JqabxWE9PXFfPsNfpZqV7GsErKS2l4O3kuqKjp+dr3+ftGHzMnDh51sXyB/X55i6kFQR
	yxSqEy86j0MXBzgtYthFd2apO8yGZ13JR/Rv0en9jIjGGjpDV12c/kdYUVDyq54/vWcD
	CiKpcHp+ANhzH2Ina9caC1ckHiF2d3vtyUKNFvGClx5IMLCt6si0xPVMRl+7wNCIfl5T
	dKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=BSejnZmTBgmRIVkic80VSsvAmUgxgYcicE1r6mcOOmk=;
	b=W5olZiXgo8OOw0zANjfCiHuiuFGpW6MKtv/nK5yPyRafH2I06H0OnU9dRAm+S+j8Vz
	sQ7JuZyQcektXzSXt7eqzf+wJLemx+d5iKAwh6d8w+o8AF1SLQiBrAxnQGb+flz51YTv
	4KD4XzkDSPl81JeaxxWpxaS0IshB7LjyXziWsOwtGu2spePEwN+zfp8HYCpcsOAtlGqc
	AAET2IOhvbBqjvTVcf+UIuEX640FQy99637dO9b4s1LGZkZk81+wloGMiCIEArebJonk
	PrdhCIFtc3KlkIUZpt0kgYaE+dsF5ZrSqvR8npqzTG4skoJZXiQMts7slXznXUIQzlTa
	hHfQ==
X-Gm-Message-State: APjAAAVXAJoMveHWKwnPGAPAQZWSaMiE70ZPHjIFayYSX4YoaSxG/klU
	uf9mzvR3prb293XeAOCJCqXCwYcw+q8=
X-Google-Smtp-Source: APXvYqxFrDySx/LIzO24dMYO4Xt4Vp3NlVHdgnwbM0R7hF09QZ6HcAyJRvkctwtM6c1PBcUKUXKOjA==
X-Received: by 2002:aa7:9148:: with SMTP id 8mr35242545pfi.176.1556575108763; 
	Mon, 29 Apr 2019 14:58:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-18-231.tukw.qwest.net.
	[97.113.18.231]) by smtp.gmail.com with ESMTPSA id
	v1sm60686010pff.81.2019.04.29.14.58.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 14:58:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 14:58:21 -0700
Message-Id: <20190429215821.10079-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::530
Subject: [Qemu-devel] [PULL v2 0/2] target/hppa patch queue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429215821.pRHoGg9naECoL5JE-nboqAZj7YpxijDsX1TB8MxLu7I@z>

Rebased for v2.

The following changes since commit 82b2865e0d0ea4c1001e9e7ed7920bcc0458f6de:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190429' into staging (2019-04-29 18:05:56 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190429

for you to fetch changes up to affdb7e6ba23f8160cb88e11f83db54a35f03d6b:

  target/hppa: Always return EXCP_DMAR for protection id trap (2019-04-29 14:43:39 -0700)

----------------------------------------------------------------
Implement fast tlb insert insns.
Fix data tlb exception for pa 1.1.

----------------------------------------------------------------
Nick Hudson (2):
      target/hppa: Implement Fast TLB Insert instructions
      target/hppa: Always return EXCP_DMAR for protection id trap

 target/hppa/mem_helper.c |  3 +--
 target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/hppa/insns.decode |  3 +++
 3 files changed, 58 insertions(+), 2 deletions(-)

