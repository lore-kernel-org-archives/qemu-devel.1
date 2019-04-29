Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99480C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB4B2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJ/EDS1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB4B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9yt-0005Mj-Jt
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:22:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ew-0004yH-8r
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0006oJ-J0
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9et-0006Sz-9G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id h11so154063wmb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=gOSZFXq2rEJgzYuKCOmuQOc1oajgGdbAZM9qUX5r8OI=;
	b=IJ/EDS1EmZ3ZPBupqIIoYvleiQ7hgYvA7cd4FaNtqH0OWRUgdkKCw2eWb56SjiqkVI
	2lOcRTCYkJ1k/bFDO1fZMhjnBtzdztB7hvlBD/7UlGlan/sJ/Ul09YpvzPiSzEPKpzCQ
	oRlQWde5sx++hoC60sO3a8UJoq7SjpjonoejNnFaxVDHTFVOfa1PvbpZwRtXzQ04jBC3
	T4VCzAgWQRKCWUKVKpKu2HVF2bQ94392WnP0C1jTLaSQMUqTs/EHwpsABXbWYaBnIlvy
	5fYhrkmxKm2c7qn+/RatM6A/Tu1o9tv+q8UoF9y1sTbazNGKCkkXWrIDoYXd8cXOAutL
	yr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gOSZFXq2rEJgzYuKCOmuQOc1oajgGdbAZM9qUX5r8OI=;
	b=tT0ldFT/XBQadN95j61L6xHoV355SS4hDHqNyRe2qaQ0Bl8QqIbATAG96VwbnjPHEy
	HG6IVZgi7e9lZvgozcVEQJI/65R0Vl6MAfgmhKDKj0UPDCr0iSgzfeKLNLCnrEBjxTwu
	4s5o8rTSL0CIoGOqbtfBPoASlNkZYmvBv3lLAXDGr00knr/kyuT4mSzbt+ayguToicnR
	dAR9JvAJZk4qkEjEywvjPo9W6zQNh6U+1wTmwCuP2/xDNwt04DGGls2DSFySXUnS7bGs
	cvZxMScrGJKf0v4dqEjLNJRetDDQhdYwKKDrReRci9Zzvu8k/5FHDtWRcykietYkhtym
	KeWw==
X-Gm-Message-State: APjAAAW7cc/ME/BQ0H7LFCj1whh86PlXWgmhyN7ElTYF0KeVRSH/3Qdp
	9zpSHh5oH92L8Mm1VEoSVBpXNnMTwQ4=
X-Google-Smtp-Source: APXvYqzALKASsVWLxbqd6P/UjfN3Ck3OXAiwH5El1G7Xq6IYI6rWwpHl6i9O3e+PxlAsjTxCt8wHlg==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr40998wmh.13.1556557256508;
	Mon, 29 Apr 2019 10:00:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.55
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:07 +0100
Message-Id: <20190429170030.11323-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 19/42] target/arm: Move NS TBFLAG from bit 19 to
 bit 6
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429170007.D1Qc-e0F6PUUJNnILrXJjOckiuOB0ytnbzoMJ_FYlEE@z>

Move the NS TBFLAG down from bit 19 to bit 6, which has not
been used since commit c1e3781090b9d36c60 in 2015, when we
started passing the entire MMU index in the TB flags rather
than just a 'privilege level' bit.

This rearrangement is not strictly necessary, but means that
we can put M-profile-only bits next to each other rather
than scattered across the flag word.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-17-peter.maydell@linaro.org
---
 target/arm/cpu.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index eb989d773af..0ea448034b3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3138,6 +3138,12 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
 FIELD(TBFLAG_A32, THUMB, 0, 1)
 FIELD(TBFLAG_A32, VECLEN, 1, 3)
 FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)
+/*
+ * Indicates whether cp register reads and writes by guest code should access
+ * the secure or nonsecure bank of banked registers; note that this is not
+ * the same thing as the current security state of the processor!
+ */
+FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
@@ -3145,11 +3151,6 @@ FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
  * checks on the other bits at runtime
  */
 FIELD(TBFLAG_A32, XSCALE_CPAR, 17, 2)
-/* Indicates whether cp register reads and writes by guest code should access
- * the secure or nonsecure bank of banked registers; note that this is not
- * the same thing as the current security state of the processor!
- */
-FIELD(TBFLAG_A32, NS, 19, 1)
 /* For M profile only, Handler (ie not Thread) mode */
 FIELD(TBFLAG_A32, HANDLER, 21, 1)
 /* For M profile only, whether we should generate stack-limit checks */
-- 
2.20.1


