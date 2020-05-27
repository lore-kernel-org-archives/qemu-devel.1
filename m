Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B290BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C0C20890
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fs1iPgcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C0C20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsxZ-0004ar-NL
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdswa-0003P9-1G
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:05:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdswZ-0005BW-2V
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:05:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so23456246wru.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B3rPEoB6RauZKehNk3gMFSktGnuLNDT1B/nk8E7cQyg=;
 b=Fs1iPgcY6pPLzn1zW2eMBAH88sNN+hYetqkgMAHUKCRMvY1QV30AkWwsBGTV4845Uy
 FTHzIG3fTrCjrzoxXY/dZlUuPZ95M8htUKACgMfjP/37YS8fykasclJONkDmPRqBduB+
 fE0h/R+c7Eeky8dKQj9+j1zHpnQlN1FGH1zLTLlrWSMdsFlsczt5lJeQzsa/KbzlTVIB
 6oI5Dh1Yo/vMHvrP7ozurq2aqMokJM3R8WDWqe6HYDqEL2wq21poV69sCN+gkG4bwEFl
 lOJS6PvLEg/R6Sljr4xyVQndmM8zHEOQYnU/2+lHHQqMX4iNDWSwf+/H1HPtzBuinAdi
 OanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B3rPEoB6RauZKehNk3gMFSktGnuLNDT1B/nk8E7cQyg=;
 b=rI65g4AHNIBNCaFxAGNvT9eK5vI1tZh9RjAQxjvNDTwQJJdTwEX0ntUiFmv9ESc6k7
 8GI1AEoJ10qRZ9s7hwP+lFZz99WBlLCR2+T/IMab2gfVEet5cKEX58BSJdf9Czb7WVMf
 Nuh+XX605Ti1Nhg6M1YtSs1ulpHYyA08zF1vMRZGZjgA4dnbn5AcLnDmjYH8VTJkxET9
 0XlerHuxqGAj1rz7+jfEFe0TJ8c6AGzUU7SpQkM+HFmj6d56d/h8SjuOR83sQ9JrNIOP
 jHexcVN9RwvVhePjJF9o1nDluw+72+kZHChYZkA7XufhrhAR4YzYC4FrPGXiM05OTtwv
 vNew==
X-Gm-Message-State: AOAM531p9FX058R7gUEt2TUdzxFLskEDf/Y3dkBmxFvI4p5ZH8bMZkBu
 54+7dsAgTbltzX57UOsUqOB0Ww==
X-Google-Smtp-Source: ABdhPJxyq+vyEcm+JAF9FOeoe5e9OJifYgwcM8muRkb/YYrTwUb0yKpAmNi+sf9FCW6e1mAoJxUzGQ==
X-Received: by 2002:adf:eb47:: with SMTP id u7mr23972224wrn.14.1590573949080; 
 Wed, 27 May 2020 03:05:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm2331662wmi.16.2020.05.27.03.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 03:05:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B47851FF7E;
 Wed, 27 May 2020 11:05:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/3] some linux-user guest_base fixes
Date: Wed, 27 May 2020 11:05:43 +0100
Message-Id: <20200527100546.29297-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Here are a couple of patches to clean-up guest_base handling for
linux-user guests. There are two cases we hadn't accounted for/tested
enough in the original clean-up:

  - chroots without /proc access
  - 32 bit hosts and the 32 bit ARM COMMPAGE

The solution to the first problem is a simple fall-back to mmap
probing but without the ugliness of the first approach.

The second is a bit of a hack but works. Given we only ever expose one
value from the COMMPAGE it does make me wonder if we could rip out the
special casing and come up with a cleaner ARM only approach by hooking
exceptions? Anyway I've included a test case for the COMMPAGE as well.

Please review

Alex Bennée (3):
  linux-user: provide fallback pgd_find_hole for bare chroots
  linux-user: deal with address wrap for ARM_COMMPAGE on 32 bit
  tests/tcg: add simple commpage test case

 linux-user/elfload.c          | 66 ++++++++++++++++++++++++++++++-----
 tests/tcg/arm/commpage.c      | 61 ++++++++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.target |  2 ++
 3 files changed, 121 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/arm/commpage.c

-- 
2.20.1


