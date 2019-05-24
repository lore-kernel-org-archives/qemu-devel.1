Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADB6C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546A820851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lv+acOeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546A820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9YX-00085G-IQ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:44:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9XB-0007IC-IW
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9XA-0006Ky-MR
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU9XA-0006KH-Ft
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id f204so9257158wme.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Wpm2sQhYIfIk/OCN8Lhc9DkJO4UyQ5qxNO30ipqpQyo=;
	b=Lv+acOeYB2G5acMbaEj56suh5rss25PSFHiGKuFycUP4OxIiTUhTj5JJ1vIKO+Uyef
	wmaQgpNPs41mDcFQKh7Ydblf1lmiYsvcF5oRUFVqKpmM+1iR6O0ZTkH+2biGE8a0K2n+
	1z2mDn9IF9X77fTPy/kVuPZn+wcKnWeJISDnuDL8WajPgwHPhXuEFDTzD2dnqU+l2hMj
	Z9uedALieSl9FvZZd9j6LUwXjVsr9lAMu4HxUlsijTn+scWsqIO3VGrIvdloHbmKVw7t
	CwEOAMMp6fAriWDGbqRJ7NqNBkcfbSdZZvMkZRzbQOcgBm11x6NvIfh1vkX8uayMo3xo
	XGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Wpm2sQhYIfIk/OCN8Lhc9DkJO4UyQ5qxNO30ipqpQyo=;
	b=hUUCpWsF7A5Q8Ge8VyO4vgbAPLmHzBfmcMa/8+rPyEzNNRhKzReTMeFmHLTlS1zZ0R
	T+dnpjPZkhYh8oyM0KbbFYPd7gXzt4ATdQdvjeXBuxwzNr2/TfonDndP9DIBAgDvEja+
	GCIMh5dHT6ALWxdbP0fZMz/eoldjVQsuR5ALVuIzW13ST71qw+XPWG/ZQzqUNPvdbEAB
	1avHmcm8rtOMv0ukj/yFJBIwlbDkGXzqNEJ5/+mglA1JWWWo+1JNwu3RLfuaA8qARPFF
	5ptzRehRauPX58WorDwVLtMxiwWTP8YrarxtF63z2cip16atvC81s27I/T6Zzbi/PkBb
	CYGg==
X-Gm-Message-State: APjAAAU/Kbu4Wn/TfzRQQ9un/DbalkS3MaQhd+Sh4GbYalDuBmAUXhxq
	Ui6jApoSNVX8IlBezBKwFhOa7A==
X-Google-Smtp-Source: APXvYqwqcKKMTz7l3kgNErij7Uj997uz9+Av17AtL0ZN1gs4i97vecAVSr3V79A44WndxzE65r1JIQ==
X-Received: by 2002:a05:600c:21c1:: with SMTP id
	x1mr16146269wmj.5.1558701771017; 
	Fri, 24 May 2019 05:42:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id t12sm2969854wro.2.2019.05.24.05.42.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 05:42:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:42:46 +0100
Message-Id: <20190524124248.28394-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PATCH v2 0/2] hw/intc/arm_gicv3: Some simple bugfixes
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset fixes a couple of simple bugs in our GICv3
implementation.

Changes since v1:
 * patches 3 and 4 from the old patchset are now in master
 * patch 1 now covers both the read and write functions

I've also just noticed (via grep for IDREGS) that we made
the same decode mistake in the SMMUv3. I'll send that out
as a separate patch.

thanks
-- PMM


Peter Maydell (2):
  hw/intc/arm_gicv3: Fix decoding of ID register range
  hw/intc/arm_gicv3: GICD_TYPER.SecurityExtn is RAZ if GICD_CTLR.DS == 1

 hw/intc/arm_gicv3_dist.c   | 12 +++++++++---
 hw/intc/arm_gicv3_redist.c |  4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.20.1


