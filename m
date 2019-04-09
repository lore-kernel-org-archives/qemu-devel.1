Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A17C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA762084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+jEs8YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA762084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtcB-000186-Q5
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:28:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWg-0004Uz-TI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWf-0003Qx-P3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtWf-0003QN-Ap
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id w1so21739597wrp.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=y/8PrclKnxmolPq5eYA0ddDNjqLNHWB3s8whob5ULbo=;
	b=P+jEs8YYrrRa0sZctEVW2OE/83hl2kSROgcoPbpXvHiKvzx8Dy/251LhKwZQaQ3WCb
	cF29/vyoDBuh1LR/o5dBs1W3zNhtEbW1D0I7OcvRSOZdoRtm/Ve6H+otp0pAOmXQ4kiJ
	bJoiWWpGdubeQo5WqpY5pGch1q0hdvdO8OCYPacbpKpTRkPWesySsZ7mbGgTDHUbi+Rn
	fHiKhGyWqi7F8mIJu4BQztqAc89Nq8Iv+7WvYKTiS1dRxkuGiIBu6l4Xffvv9hRNlSPR
	N/myb+2Mzg5tSLHInEMRw2BWdESPrO2cUV3FBJTBnksHCKRCzUOxKUyiNhCLO/LY4vIZ
	ViHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=y/8PrclKnxmolPq5eYA0ddDNjqLNHWB3s8whob5ULbo=;
	b=psT6faeRYkI2R+LAi5iE8hlxPwf88+VowA+g38d9jMAG3ELBM03ZS+ivhPvzGrMEbp
	SQ5CXfgCqWdF64vQS8Ert6sZe+W2hO+G3FRBHKhvXzKkhFuK4d+ar38Rw+w4n+DvEFwr
	j5xbs5jowqQKoJtbwp8knRSNsG3FJqYHsN27TURkchEjwvV5D36bgle562xzGKSyPvw+
	49C3lZ3+96+j09GLVnB2gOYT4mtdqv3Dmhg1v5tFMgEmI1O5daikRF1qLGDO7aC7pEL6
	nDgaQwspXq3UYPrRhPrD5PAf1anrcYa8j0SvkO6G0NvONQiEL/KEkAxGqCBN+WAM24D0
	96jA==
X-Gm-Message-State: APjAAAXdDK/56nyHAnnJkaUeEMukBM3w1q+tgTqEL3z0HNA0uPcGyejw
	vZxFUhBqqMuxhZ1Jup4e1BDWhgzD
X-Google-Smtp-Source: APXvYqx2ovMJ4BeuffVzjHIGevDv3HkrJuPdayqg2cTi4L+wOhZdsfLnxYc1LrGp2UFYc39D/3LbXA==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr23130251wrj.179.1554826987939; 
	Tue, 09 Apr 2019 09:23:07 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e1sm59579736wrw.66.2019.04.09.09.23.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:23:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:23:01 +0200
Message-Id: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL v2 0/5] Misc patches for QEMU 4.0-rc3
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
Message-ID: <20190409162301.DUKvd5aEcB70QatsYJfQ1rf0Zfcox5kvAaN0sKeNAHw@z>

The following changes since commit 248987f92cfda8305d6d44ced23e173e62a8bc0e:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-04-09 10:02:30 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 73a2f20946d387e971f2e18fe9503f4ea3a3c201:

  tests: Make check-block a phony target (2019-04-09 18:21:59 +0200)

----------------------------------------------------------------
* fixes for Alpine and SuSE
* fix crash when hot-plugging nvdimm on older machine types

----------------------------------------------------------------
Markus Armbruster (1):
      tests: Make check-block a phony target

Peter Maydell (1):
      include/qemu/bswap.h: Use __builtin_memcpy() in accessor functions

Philippe Mathieu-Daudé (2):
      roms: Rename the EFIROM variable to avoid clashing with iPXE
      roms: Allow passing configure options to the EDK2 build tools

Thomas Huth (1):
      hw/i386/pc: Fix crash when hot-plugging nvdimm on older machine types

 hw/i386/pc.c           |  9 +++++++--
 include/qemu/bswap.h   | 26 ++++++++++++++++----------
 roms/Makefile          | 23 ++++++++++++++++++-----
 tests/Makefile.include |  2 +-
 4 files changed, 42 insertions(+), 18 deletions(-)
-- 
1.8.3.1


