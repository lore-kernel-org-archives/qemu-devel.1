Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3069CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC8020645
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg5dmIIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC8020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTubG-00075F-0a
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:46:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZe-0005vt-7Y
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZd-0002pM-4p
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:26 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29]:41658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZd-0002ov-0d
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:25 -0400
Received: by mail-yb1-xb29.google.com with SMTP id d2so2783146ybh.8
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=F0xnbzlBERJ64y5UAizwcpCP7wLLEhXZKCUWGgIUI08=;
	b=Bg5dmIIreRz59VKscPzkPxClkPxasq7J3upYwRkslX9uYq64s5VM7ksYPg2gAO5ypq
	4JmUyrLRurC9esi2dePxp3uno4xyzo7oCRBGXh/fhdkILqIKDXzNqxWBGXD7tUyRdue8
	f0J9AzxaLDXdRJlzZfzQQO3an3xO/Fl6eyWrYmNvha5fIAZaomntcNUiYQKdQCHXM+x7
	/bf4tmNHA5ogfEvOj/9CGNWxo4q7ubt93yon9Y/4ZJ+0TtR2nAEzZirwQSRVbPQk96Tz
	a4is5muEoaFb/9SE5tVC/Rxuyh4y4+Q856OleTGiD1eoeic+6Yv1AMeP+mSkRA4+msgV
	Ir1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=F0xnbzlBERJ64y5UAizwcpCP7wLLEhXZKCUWGgIUI08=;
	b=gjHbvY78X78BfkGBDdMb2dlHPeuNdb4YNOehr4ROQozSrgA0r+GYncNXB9yrVUrIjC
	8WN3yEVkvAEcknQa/sIe2uOcSP8rEGUolLXucEY270+dUcW7c2SWggk9oYpbOHhYeBYU
	8aOcWAQDxN6VhY3gAskiSnM634s1MCQomGT4ivrxDy7rssrDtUlQXmjYeyY9JV+S5fZ6
	bsTEYVOOsKIoajA5bYeLYOewYn6XGrVkHpNX2B8TlmEsQkgFADxVcgo3l/lnpNFUxcmp
	HUkqvY+LXATr+XdS306aIDSzxFJU+nBVZOCFqdaJhKI5/EE3TaX6pO++wk6apKYcOZxE
	Z08g==
X-Gm-Message-State: APjAAAV+KfNVxuNjmjtX4Za+dQgazPQfCKA5ipQMVg2jNoXNKpFiL73L
	kcYLoYO9FTGMqbVeA62N+SdWd3xw
X-Google-Smtp-Source: APXvYqxplpbjHmYIwXAE1S6Llvly3kgI7PgrQgDUTwN+9UWKCIwrdrvDXTjZu4e9yO/ZxmCaI2FtaA==
X-Received: by 2002:a25:3248:: with SMTP id y69mr19972773yby.415.1558644263833;
	Thu, 23 May 2019 13:44:23 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:22 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:58 -0400
Message-Id: <20190523204409.21068-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b29
Subject: [Qemu-devel] [RISU v3 00/11] Support for i386/x86_64 with vector
 extensions
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds support for i386 and x86_64 architectures to
RISU. Notably, vector registers (SSE, AVX, AVX-512) are supported for
verification of the apprentice. This is V3 of the series posted in [1]
and [2].

Changes is V3:
  - fix a matching bug caused by misplaced index multiplication [3]
  - print an error and exit when parse of the --xfeatures option fails [4]

References:
  1. https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg01294.html
  2. https://lists.nongnu.org/archive/html/qemu-devel/2019-05/msg04089.html
  3. https://lists.nongnu.org/archive/html/qemu-devel/2019-05/msg04922.html
  4. https://lists.nongnu.org/archive/html/qemu-devel/2019-05/msg04903.html

Jan Bobek (10):
  Makefile: undefine the arch name symbol
  risu_i386: move reginfo_t and related defines to risu_reginfo_i386.h
  risu_i386: move reginfo-related code to risu_reginfo_i386.c
  risu_reginfo_i386: implement arch-specific reginfo interface
  risu_i386: implement missing CPU-specific functions
  risu_i386: remove old unused code
  test_i386: change syntax from nasm to gas
  configure: add i386/x86_64 architectures
  risu_reginfo_i386: replace xfeature constants with symbolic names
  risu_reginfo_i386: rework --xfeatures value parsing

Richard Henderson (1):
  i386: Add avx512 state to reginfo_t

 configure           |  10 +-
 Makefile            |   5 +-
 risu_reginfo_i386.h |  49 ++++++
 risu_i386.c         | 142 ++--------------
 risu_reginfo_i386.c | 400 ++++++++++++++++++++++++++++++++++++++++++++
 test_i386.S         |  80 +++++++++
 test_i386.s         |  27 ---
 7 files changed, 556 insertions(+), 157 deletions(-)
 create mode 100644 risu_reginfo_i386.h
 create mode 100644 risu_reginfo_i386.c
 create mode 100644 test_i386.S
 delete mode 100644 test_i386.s

-- 
2.20.1


