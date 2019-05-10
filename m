Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE6DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A2F217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZnsmCd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A2F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPBjJ-0003JL-DN
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:02:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhj-0002S1-7b
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhd-0002Rz-S8
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hPBhc-0002NK-IO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id d12so9113875wrm.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DDiN+MMrpUN/LmlEEKX6L2Ablxv7aphx+aWfipYbLho=;
	b=xZnsmCd+GozDlS9njK54HLAR/wWNjeLjOCWq0eo21VkDS/Lwt2vwPxwrmLkfXmEd78
	V13jxMTICWAgiodWz7yHK3UzNfYxbAavn8HnZxbXC6WGx2TcM2xWE14ut+57/vaHgnzm
	gycbz7HUoIDdTd2zT3OyN4NT7fJtcwmGI1bSm2OuJ5Xal3dITd8KlrjDDVfXgLjla2pd
	UkVPB/6ry0GadQIQLa5VKIWCKG70nA3U4DQOnSmojnA8eH9ugWS8D/Th0lv1nss3hr+n
	sCUglpVS5H6SFn/11/arSnMH1EnWi3KGVL/ESUcs8dssRDXVaTiCfSlw8jon2ysTvHIA
	Jolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DDiN+MMrpUN/LmlEEKX6L2Ablxv7aphx+aWfipYbLho=;
	b=YM9oIQ0IMFiojo0ECa/3oij3i7MRAQEqyleLG3Jwphhh5VhqCVz6ezH+xaZPeOZbBs
	QsQmxKvDLXsT58pKctQnMSBuLIWLrutwI6AfLvHJjFnJJKMWj/LkN+CcaZ+f3JYnfUXL
	O2BNsMVvxDK3j7iLz4Le+VnDTaCZEcY5Rsj8zeqZApRCO2Nxvzd9b98QXSqRE14FiKtd
	WNhlfsgEGaWBMGaGNpmYYpZTxwPQsGOH1jn52hCmJsqsu0tIgvwox1S6Jun4UceKH/ng
	543g6UlArQ31DkOsB+/uByRPN08yT0qwg3j6N5bCQtQpDFANta26KhR939sO7NvXWg6T
	iM7w==
X-Gm-Message-State: APjAAAVJJiBLzq4Ts5+4sNVaxH5aLssQc7p+O9ds134/5GOri33jkoAB
	L3hHUM5UFeKDC7W7odLKnHhtvw==
X-Google-Smtp-Source: APXvYqz9yMGzPQ6I0hxfjZ5NYfZi9qkY+yqLOG+uQ0DMRs6mhmlrQtJg88cK2UJRPfUyzLT9Yz+zeQ==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr9247530wrv.303.1557518463270; 
	Fri, 10 May 2019 13:01:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id b8sm5518418wrr.64.2019.05.10.13.01.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 13:01:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C6C891FF87;
	Fri, 10 May 2019 21:01:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 10 May 2019 21:00:56 +0100
Message-Id: <20190510200101.31096-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 0/5] demacro SoftMMU
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-demacro-softmmu-100519-1

for you to fetch changes up to 4601f8d10d7628bcaf2a8179af36e04b42879e91:

  cputlb: Do unaligned store recursion to outermost function (2019-05-10 20:23:21 +0100)

----------------------------------------------------------------
Demacrofy the SoftMMU

  - the demacro itself
  - refactor TLB_RECHECK and fix bug
  - move unaligned handler out

----------------------------------------------------------------
Alex Bennée (1):
      accel/tcg: demacro cputlb

Richard Henderson (4):
      cputlb: Move TLB_RECHECK handling into load/store_helper
      cputlb: Drop attribute flatten
      cputlb: Do unaligned load recursion to outermost function
      cputlb: Do unaligned store recursion to outermost function

 accel/tcg/cputlb.c           | 626 +++++++++++++++++++++++++++++++++++++------
 accel/tcg/softmmu_template.h | 454 -------------------------------
 2 files changed, 546 insertions(+), 534 deletions(-)
 delete mode 100644 accel/tcg/softmmu_template.h

-- 
2.20.1


