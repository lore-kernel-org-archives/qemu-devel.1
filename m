Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9282FC33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E37120684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uK7wf2xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E37120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isFvP-0001RV-FS
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isFuQ-0000YG-EY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isFuP-0001dh-6F
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:54:46 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:35464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isFuP-0001cw-0U
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:54:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id g6so9128824plt.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ScxTDDdqSEa/S9oADYkmdnEKwxGmeN0PAZysNN1FfpU=;
 b=uK7wf2xsdJt+Fqs3VdQAkd3C/Q17z6WRm8psOUYJx19x9uivjYhDyJjKGkCsOpCYLd
 Yz9yaX1E860QmtfC6U/ucffCPvyGbN6nQvnnoMkW9It1NCUmxP5VN+RV/ZbvViJJScom
 z9sNog+lUrp3wSESHJ+f3Mqc7/wCx+zYwuY3ZMZPNmq413ziNpGdXzGQSUTVb9t00rCV
 EwkWco2uz/LEbgC8l11pM4YTrH3LTO+Up7OjLR/+90h75Rro/IMOIBxPWTL0fmnwjTTL
 cvex0JRYXpJdkRNC93s2QkpXFklBBvFbzDFYs4dFR+l4RDYhINNYrQLcxx9SFbo+TeaO
 0aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ScxTDDdqSEa/S9oADYkmdnEKwxGmeN0PAZysNN1FfpU=;
 b=Lpk2V0XXdDwLO2iVESICdYog0uH+JLRYKBxMRryx16FF5VcpkvlhJNRVy/n9geMOu9
 lkUOx+QBqYczwtRnU3edap78brqgX3krtcrBg/LD0yYt2BXkvI7Q0xLtCXKeDSG1dn1T
 7qTESXPXmYr58pnmV2JbeBAankxcZIsQBIttNl76YZclMPG2Sb8mpfT/aedtfk1NTEmg
 qAPE39kb8bnCjTCeeYk/ImbmLd1TnV2c6xBq6tIcjSeyb5l5Z42yBVJOpVmS7j/jmQlM
 hzGp6eBocA6Vo7z0Et+u9svdSsDLJVXrSKo5gaGxoDyQrpyVgzI4N0vrBRgvI8r4T/2a
 HIjQ==
X-Gm-Message-State: APjAAAUQjIWZ2BwN8Mvj5eMUbSs28uK+/Ct2B8g6jAz+PVjXYHiH+oKO
 pPWD3DzvsqOAu/arBrooGIgTb6HzQEU=
X-Google-Smtp-Source: APXvYqw4PexBIs6ME8z98CHGyByQNVjoZzikS6qygYVYc1SU4iTn1KJS5J/1hXF25J8Zq8ZwFx5sUw==
X-Received: by 2002:a17:90a:ec0f:: with SMTP id
 l15mr2430786pjy.39.1579222483356; 
 Thu, 16 Jan 2020 16:54:43 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id l14sm23848628pgt.42.2020.01.16.16.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 16:54:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] target/openrisc patch queue
Date: Thu, 16 Jan 2020 14:54:39 -1000
Message-Id: <20200117005440.3524-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::632
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

The following changes since commit 28b58f19d269633b3d14b6aebf1e92b3cd3ab56e:

  ui/gtk: Get display refresh rate with GDK version 3.22 or later (2020-01-16 14:03:45 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-or1k-20200116

for you to fetch changes up to 97a254b3f03a184136e381c6d9fd80475e1795ac:

  target/openrisc: Fix FPCSR mask to allow setting DZF (2020-01-16 14:50:43 -1000)

----------------------------------------------------------------
Fix FPSCR masking

----------------------------------------------------------------
Stafford Horne (1):
      target/openrisc: Fix FPCSR mask to allow setting DZF

 target/openrisc/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

