Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90C1ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B476D2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/gXzscf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B476D2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5vY-0004Ux-1j
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5kz-00008k-LE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5ky-0000vp-34
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:23:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45387)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5kx-0000vg-T7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:23:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so2317383wrm.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DhRE11UdLxath7raVb3JsISvnWGqrCeOZshNI/mC17A=;
 b=Z/gXzscf3NU2uqXCfryyqNgKXN3y/Kuv6Znv4szHo9zmC7kaGLXOi9AyGbYzEZkrVu
 Ht7rWr4LOnHjSnHrDE8LUPMG6hcGurkoyytxFVRau9UvekCsEbQjsWeOkT1jlmxM4NC1
 NQg3mbT08RgNo22XoNAytDAtgAy4wAEJGwacq1ejtfH+swuzVUYcwgwdz17ggALZgCF6
 XCipbSU4BEgYrUk19x3yjMTC4ntD3bHAQXBEhIuGhTeJ8hUJ4snJDl/8FBv8ytTVhPWr
 Saqhopz7d9cwUkEdpiGsXBoY0LkwzfRNyUV2jXoSTQ5fK+6TNOO0VDP29xyHIgBr6Pr7
 ixQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DhRE11UdLxath7raVb3JsISvnWGqrCeOZshNI/mC17A=;
 b=fJnH6PaNwbM6EoGgrHNGtR6crnPvoeX67PSuz5qM3wm4MXIQtKR5bPL8BQbGeG3zoP
 LR7CZKsIEkN/a85kBNhHhIXEc0cWg/gVGFP149OCBqlKYytVNBtaK3p6MVnKK5GsJ7XX
 1qe11XTh9dOMPgo+ENhxMoIwmN4hrAJ4MECNQJ7UA2U8upF2oZBL44TacUNQmaif5y6T
 pE6G3uzMjzF+7DnC9JtySCb12mOgpYcxx/g0Cnik3Lo9UryQKFJvfK+0SEK+OKs1vh2p
 Mo8+Lu0gR0FtPtFxjv7ZihY30lzrLAXrTEEFjOONck/eFz11Z55V707pwXuKD77JFAO8
 QzRw==
X-Gm-Message-State: APjAAAVb3Ah1845p60vf+iX5L0VJiFhxLELAA1iMt1JF2Naf6dkI03bE
 FpK5REFKbRmrYFxhn2hHuhnDATdfoJukpQ==
X-Google-Smtp-Source: APXvYqxuR3/P+MtYF5fa1ixHU32vrMW4Z5RmwFQKQIbeNb0g0SSgt7GUFWtvnEFTL6kk+cSBU+wFHA==
X-Received: by 2002:adf:828c:: with SMTP id 12mr3042041wrc.40.1571318634255;
 Thu, 17 Oct 2019 06:23:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2270302wrp.26.2019.10.17.06.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:23:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Convert sparc devices to new ptimer API
Date: Thu, 17 Oct 2019 14:23:49 +0100
Message-Id: <20191017132351.4762-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the devices used by sparc machines to the new
ptimer API.

Currently the ptimer design uses a QEMU bottom-half as its mechanism
for calling back into the device model using the ptimer when the
timer has expired.  Unfortunately this design is fatally flawed,
because it means that there is a lag between the ptimer updating its
own state and the device callback function updating device state, and
guest accesses to device registers between the two can return
inconsistent device state. This was reported as a bug in a specific
timer device but it's a problem with the generic ptimer code:
https://bugs.launchpad.net/qemu/+bug/1777777

The updates to the individual ptimer devices are straightforward:
we need to add begin/commit calls around the various places that
modify the ptimer state, and use the new ptimer_init() function
to create the timer.

Testing has been 'make check', and a quick smoke test of a sparc
linux boot image I had lying around, which obviously doesn't
exercise the devices very much, so more specific testing would
be appreciated. I'm happy for these patches to go in via the
sparc tree if you want, or I can collect them up with the other
ptimer-related changes I'm sending for other archs.

thanks
--PMM


Peter Maydell (2):
  hw/timer/grlib_gptimer.c: Switch to transaction-based ptimer API
  hw/timer/slavio_timer.c: Switch to transaction-based ptimer API

 hw/timer/grlib_gptimer.c | 28 ++++++++++++++++++++++++----
 hw/timer/slavio_timer.c  | 20 ++++++++++++++++----
 2 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.20.1


