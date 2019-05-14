Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FFBC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 04:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE2E20843
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 04:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaT6VvYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE2E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQP3x-0001gc-Me
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 00:29:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQP3B-0001Ma-NI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 00:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQP3A-0008Fk-V9
	for qemu-devel@nongnu.org; Tue, 14 May 2019 00:28:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:34829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQLzX-0005Ot-Ti
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:12:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id g5so7345579plt.2
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 18:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=808gD/RWuW8ph7gRO3e1PjmafMp7jgBxuh7bwpr9apE=;
	b=AaT6VvYmgnWz0SfRQbsGmI4jk8u8tC6Cb6tCHx/gCktlANa9Y1oiccsSs6BI4GwT0v
	5JGzc2p27I7EStV1L4v9MT3rg75ur3+55DPTG0+oBJbpSI41CRt8v8l6RwgpJLwpf2ux
	0Yaxyi2PU3L4w2d6zAnITwlAWASK4eFCPqSyf2ZAyJyTCmG9SJm/zQvYaWDl/upzcmf8
	EusA9UEyQM9Pbdcr5J+pYNooz1W80NPNZhKENrAfUAMlHv4dSxuEG5DhPea1U1T8Svm+
	0ACiQSU8/E2pRGlT9MhsVqzNlC7Hc3ADdhgFcQfzjsmsh+mXc7FpbI63E/8AziGhUJI5
	HFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=808gD/RWuW8ph7gRO3e1PjmafMp7jgBxuh7bwpr9apE=;
	b=VRUIYFhxMY6RA3iwUOup23lh7IrLBogfqW0qR/0PsygBVgRPVsg80d2gclaYMXg9aM
	XT3EjolrufqFSX3dPDzDNI/4LRiKwFoxzQLMKoKsNzb/Nkd8cYKmMs8LKW+VOoTwq21i
	mVAlXp/xX96dCNNM6zqUIUbrHQ8+tO247l+UFDVB5OPB0YoeWbRMu5xfVpxJkQEIELtf
	TRcmq0PSO4r+xx2ue/JoNcufmuI/ojwenpeV73VBvySiMPVOaIhb2PpjdqdKDlFdUYLG
	SDPMK98XCBCeeFKcrQMK/qfIMl0bu7BASNqR1Y5RJwXo+BMvCPHDmxIsG7ckv+kLzB03
	eLlQ==
X-Gm-Message-State: APjAAAVovymfUSDURcSuur+OUTEni6yvGnxzYxbZKsby/If+VA3Ql+mc
	XrYeg8ApJuyp41PSCg6p+4TwJi6YjRo=
X-Google-Smtp-Source: APXvYqzB+MKSuURnWLfyG3RFOAwqwjrJGsjRlJuIaNpjYHFjtzxFLiCRS9x7nMMbTBJMtb/GsfHXXQ==
X-Received: by 2002:a17:902:294a:: with SMTP id
	g68mr8962233plb.169.1557796291917; 
	Mon, 13 May 2019 18:11:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	b67sm20029147pfb.150.2019.05.13.18.11.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 18:11:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 18:11:27 -0700
Message-Id: <20190514011129.11330-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62e
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Minor bit field improvements
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

The tcg extract2 patch on which this depended is now in master.


r~


Richard Henderson (2):
  target/arm: Use extract2 for EXTR
  target/arm: Simplify BFXIL expansion

 target/arm/translate-a64.c | 44 ++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.17.1


