Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FD5C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9755D20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiICOJxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9755D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuHC-0007Xo-SG
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4w-0000RE-3q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hct4u-0007Mz-9n
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hct4t-0007HA-Ov
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:57:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id n4so2237949wrs.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OfRlriUcegMGyJMXyPC8qiO/SzfKh5oij1yWMrA7S44=;
 b=uiICOJxljTipTrT91dOiG7kabgZW3AgINocFDmuFbZXFUuqA4wTZs+Qc4AqnyS/AWS
 ucXsmblFTQ6bZDLFxkCn4XrDWE8v5w2V84rIzsOULYa0hP84uZKQOAnIwtFwBp0hpvLc
 zDAiKyjiVjS+K4rm5vLej6r2MPlSxMeoLoE965IW/W4I59sZili8v6rtq4nxKK2xY+2y
 clQo+ml9xH4TzwAowU6o6ch39Dchk6Vfs8J81Zd4vEEguGNQiL47vFZSCqjeP+whgM/I
 5eokE1136FuUhcIT7gFKrENHkUcvmOc7jPGOmFsC9GjpxCsPIml6qMO35r7jRTy59zl7
 Me3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OfRlriUcegMGyJMXyPC8qiO/SzfKh5oij1yWMrA7S44=;
 b=PYQfmgIvaBC4EJRmm56abl1n2UsfrWQlw/bdRLHx14U7fmYKv/yQyAOYvg7nm0yRjK
 SX3ENMjNwdSDkaI22aWjgiZVoxpUF2SEouGvjS+e+B1/5rZuuF4nosInidqanLfqUPaR
 FFppK+hvDQ5HENMwwOTNRUMhprr815HxHTcQxMwp420wyEr1fV5buLgGdiM9TyBijNAO
 06FmGLO/D+Mn+xCCZq1xVxdxfIAe3pNXdENa4aaWDZFxIqHRCRJz7naA3JcABaAqy26n
 876R3OFpfRRc7VsR2yYCEF2AAKVEEfyodnAh/zmJivIjnXV8vbjX2/lpr/T1GPcIJYrK
 rbUA==
X-Gm-Message-State: APjAAAXLnN8r1gSgx4jxYzLbubrH57EfDrDLIN+8gY+9NoKlDHRwpvD3
 oHInnMITJ6Hr2VlPzuDSeXNJeZJDLar3AA==
X-Google-Smtp-Source: APXvYqw0es24UilT+UELDgiW0QLNWzTo8gO9Pwuz8ZLKZKD/LkFmmtY49N+kmktRCOuB8ae8/2mAOA==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr60925723wrm.218.1560783462448; 
 Mon, 17 Jun 2019 07:57:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14690750wmf.8.2019.06.17.07.57.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:57:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:57:36 +0100
Message-Id: <20190617145740.9881-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 0/4] docs queue
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

I thought I'd put together a pullreq with some of the sphinx docs
patches I've sent out recently, since they don't really have an
obvious more sensible route to go through.

thanks
-- PMM

The following changes since commit 5d0e5694470d2952b4f257bc985cac8c89b4fd92:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-06-17 11:55:14 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-docs-20190617

for you to fetch changes up to 0783a732f9ee2de28dc722d6cd87f04b2f264a48:

  docs: Build and install specs manual (2019-06-17 15:35:31 +0100)

----------------------------------------------------------------
docs infrastructure queue:
 * fix some minor syntax issues in docs/specs/index.rst
 * build and install the 'specs' manual, since it now has some content
 * delete the "QEMU compared to other emulators" section of the docs
 * Convert "translator internals" docs to RST, move to devel manual

----------------------------------------------------------------
Peter Maydell (4):
      Convert "translator internals" docs to RST, move to devel manual
      qemu-tech.texi: Remove "QEMU compared to other emulators" section
      docs/specs/index.rst: Fix minor syntax issues
      docs: Build and install specs manual

 Makefile             |   7 +-
 docs/devel/index.rst |   1 +
 docs/devel/tcg.rst   | 111 +++++++++++++++++++++++++++
 docs/specs/conf.py   |  16 ++++
 docs/specs/index.rst |   9 ++-
 qemu-tech.texi       | 210 ---------------------------------------------------
 6 files changed, 139 insertions(+), 215 deletions(-)
 create mode 100644 docs/devel/tcg.rst
 create mode 100644 docs/specs/conf.py

