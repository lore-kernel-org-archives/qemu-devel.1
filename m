Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D5AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60486208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLyfwrxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60486208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJFD-0007Wy-BH
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54300)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZH0O-0004JB-3m
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZGnD-0002l4-TX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:28:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZGnC-0002ai-N3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:28:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so2556605wrw.13
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T8Rvl6sz2FJi2XdphD/mU/UZJrz8C96J4P3ThrvXMF0=;
 b=tLyfwrxU5vqauGeB/TovemZS0vKcMY1Wza7ghA8z1NirINuyWs71B/gSlEoggjks//
 wXRNpiX2OyrCN/7LeHS2wZb/FI9jz1RwZ9PIxLk72HKwKEISKp+/L3oPEB4D9GLSNqVe
 khwS8azQ/3wShpFcYyHkssKOYBWUFKso6ptOd3uT/eJLyng+GmLdOLeDU+HnXhYyNIP+
 f6WA1uFYUtVVQMFMY0JjPyC5dkICJl11N6e+9Azs9Lcp5iLekseRWidsTNnw7uus+/hz
 05HnMqYhm2xUMKs7+xKwcxmrzIw7LXFiWQa1MsDGD6elO6cD2F+OHJy4h2GTeoJicfSk
 2waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T8Rvl6sz2FJi2XdphD/mU/UZJrz8C96J4P3ThrvXMF0=;
 b=nAo/JnnPD8qNKuNPlAZ+C1+CmjJlhJoADlXV0dRSDeyw/MVR7WahLYuI3j3Flte27B
 NGvhm5J5y2Ibs1qQ9fYfsKNqjhQ5V6HbtyuwPwNTZThXpk99gqJLfNYXxx0NYrfsHwGK
 iWn+8zOpVhxON/Ko5z/Q0f/igPIXb7g3qzPj/hToTIL8KJIPU4g9B10ok3hTjo+0t7a2
 FvWPmO9W19ttovvqCduHQbKlN4OFo5BcwaaTxYSeOevzmwHttvTbUESmBeXLoWQSSORK
 L8PCoLG93OW6JwPNaEBXQ0MtWgxz0Rn7N1yDzm1hHSz2LTWTe1m8VROx7sB/Ad+7Zjiq
 VhYw==
X-Gm-Message-State: APjAAAWUiBlO8ZW90EosctBPpiMNw2rcgNsvLeLyYM41pXp0IpEsM1W8
 46Mf61tITMQx7tf6qws9malGYY3YN4F82A==
X-Google-Smtp-Source: APXvYqxVdQzSPkfnw9bnP3ZggXlXnlfEATH+OZdIE0JQNYu0AvOauqrtqy2KnThOLwt71o40Qqd4hA==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr5047458wrn.258.1559921309969; 
 Fri, 07 Jun 2019 08:28:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b7sm580224wrx.83.2019.06.07.08.28.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 08:28:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 16:28:25 +0100
Message-Id: <20190607152827.18003-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 0/2] qemu-tech: move part to docs/devel,
 delete part
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

This patchset makes some of the cleanups to qemu-tech.texi which
I suggested in my Sphinx transition plan:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04932.html

(1) the "translator internals" docs move to the devel/ manual
(and are given a simple by-hand texi-to-rst conversion)
(2) the "compared to other emulators" section is simply deleted:
since we haven't updated it since 2015 we obviously don't
care enough about it to keep it useful for users, and the wiki
or website would be a better place for that kind of "you might
want to know this before you install" information if we did
have anybody interested in keeping it current.

I suspect the TCG docs may have some stale info in them too,
but the devel/ manual isn't user-facing so not a very big deal.
Followup patches correcting any inaccuracies welcome :-)

thanks
-- PMM

Peter Maydell (2):
  Convert "translator internals" docs to RST, move to devel manual
  qemu-tech.texi: Remove "QEMU compared to other emulators" section

 docs/devel/index.rst |   1 +
 docs/devel/tcg.rst   | 111 +++++++++++++++++++++++
 qemu-tech.texi       | 210 -------------------------------------------
 3 files changed, 112 insertions(+), 210 deletions(-)
 create mode 100644 docs/devel/tcg.rst

-- 
2.20.1


