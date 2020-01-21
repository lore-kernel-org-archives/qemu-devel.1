Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCDCC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 19:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BE6217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 19:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OgA7B9U0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BE6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ityws-0004Bi-8R
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 14:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ityv9-0002Ic-Ma
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ityv8-0004Od-Bp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:10:39 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ityv8-0004OL-67
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:10:38 -0500
Received: by mail-wr1-x42c.google.com with SMTP id w15so4590724wru.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H4OFsg26gJaJunl/BhON2bBtKMiFVVfKgZ3mGizQWN4=;
 b=OgA7B9U0WIor5e5Yr1U1llchQQC9seckt0osd1QL7BzZxlWER66TY6K/57rCC2Eq1b
 DerHYnOcUyVZ16nfdO70fPOAesZnnb691E1GKZchidZHWysj0HAi25nYP92F+cSaSmhy
 uluDfKVImyk7StFau12GWe9au9p0mclEoj+nhR6cxTXk59aFMefOogqA80/Q4n5ciwwF
 znym9zmYBSqrY1SAtRH7MbzHho06uQeNDNRY2tEPVlpM4fleRqtjPpeWo0jM1SynPk1u
 SzJkVwcpngQtDtP2NlUv4sDp+FanCn9DFRsALAFcakp2tH1S3zMIwcE11fjIR3gAn2XZ
 XnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H4OFsg26gJaJunl/BhON2bBtKMiFVVfKgZ3mGizQWN4=;
 b=SksOPdaaPulhRz2ZL/vrOJTYsxhIw/0IPPVohxJwduFtKOSeLZ8nU/xiHvMgID4LFj
 ad3hDhzq8+7lFSTfBOy4siG8Dq6kYLwNhksf88uKRA77ql5n3aFa1rOS+SVN37+6QMmz
 NkKM59sm2HJ1UnAUf9NIec0BOug1PndFOXmXYLd9DEUC8Tg7UurFBCMz25yG061XUJA9
 JJhe5hn5lrwjNpIHjkCMx+eZKTLmFVDI0bZrePMWMafxNdFm25kEoSd4Z5+qT2GoKg7U
 DkGZW0hWtJkcLl+fxStGxOMmcdn4n+idWEVX0GtjloZEX+0ZLFlqd9AdjhiTEBXFvoZT
 ZVpQ==
X-Gm-Message-State: APjAAAU2ZRdhSVa1GiRHkmYFlw3ATIizzGatQo5MpvLQtdUkXO/vQlH3
 F10PwJ5Ma8mI7mNB7v/2TnTvN8sJIMA/mA==
X-Google-Smtp-Source: APXvYqwh/pzdFYEzmSqmRafqKqXxgDB7lW1XXC5zIlQIVgu1uQsByzOAdMkxX31s/Rkhs6VUYNnSTw==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr6759366wrn.356.1579633836884; 
 Tue, 21 Jan 2020 11:10:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l3sm49533271wrt.29.2020.01.21.11.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 11:10:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] qemu-img: convert to rST
Date: Tue, 21 Jan 2020 19:10:28 +0000
Message-Id: <20200121191033.28195-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the qemu-img documentation to rST format.
It includes a new Sphinx extension which handles parsing the .hx
files which provide documentation fragments for this manual.

The general approach follows the outline in the email I
sent the other day:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03786.html

The new Sphinx extension implements the hxtool-doc::
directive, which indicates where the assembled rST
document fragments should be inserted into the manual.
qemu-img-cmds.hx doesn't use the DEFHEADING or ARCHHEADING
directives, but the extension implements them (tested
with some local modifications to the .hx file to check
that they do the right thing).

As noted in the commit message for the qemu-img.texi conversion,
I have not attempted to tackle any of the muddle in the
current documentation structure or the repetition between
the manual document, the fragments in the .hx file and
the C code; this is a "simplest thing that works"
like-for-like conversion.

Another deliberate omission is that I have not attempted
to get links between our various Sphinx manuals (system,
interop, etc) working yet, as this is not totally trivial
and the odd minor missed hyperlink doesn't seem to me
to be a deal-breaker.

Sorry about the size of the main 'convert qemu-img'
patch, but it's unavoidable when converting a big
document between formats.

thanks
-- PMM

Based-on: 20200116141511.16849-1-peter.maydell@linaro.org
("convert qemu-nbd, qemu-block-drivers to rST";
dependencies are mostly textual and in a few bits of
the makefile machinery)

Peter Maydell (5):
  hxtool: Support SRST/ERST directives
  docs/sphinx: Add new hxtool Sphinx extension
  qemu-img-cmds.hx: Add rST documentation fragments
  qemu-img: Convert invocation documentation to rST
  qemu-img-cmds.hx: Remove texinfo document fragments

 Makefile                  |  19 +-
 MAINTAINERS               |   1 +
 docs/conf.py              |   3 +-
 docs/interop/conf.py      |   2 +
 docs/interop/index.rst    |   1 +
 docs/interop/qemu-img.rst | 822 ++++++++++++++++++++++++++++++++++++++
 docs/sphinx/hxtool.py     | 210 ++++++++++
 qemu-doc.texi             |  10 +-
 qemu-img-cmds.hx          |  99 +++--
 qemu-img.texi             | 795 ------------------------------------
 scripts/hxtool            |  33 +-
 11 files changed, 1128 insertions(+), 867 deletions(-)
 create mode 100644 docs/interop/qemu-img.rst
 create mode 100644 docs/sphinx/hxtool.py
 delete mode 100644 qemu-img.texi

-- 
2.20.1

