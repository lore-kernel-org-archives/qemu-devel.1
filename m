Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCC0C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FA72133D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVaS2Zuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FA72133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRldD-00035u-NL
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:47:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbC-0001By-8A
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbA-0005Dz-Pn
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:10 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35]:36668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbA-0005BE-LS
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:08 -0400
Received: by mail-yb1-xb35.google.com with SMTP id m10so3242923ybk.3
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=nxUBugLnk/cYYTKEq+Sl+nYkafMoGc/C3hGXaIEoeoQ=;
	b=qVaS2Zuu2hBJKm/WviUFjTYlj906QG/jGLIyX1RN3IKwNkgk7+l1LoZPAjm480uIqM
	mqBR6hadNhMQ/6eOwAV9Szev8K6mcptNtgNogSm+VB7e4y2CiIVFf6xUId7TOOzFo8Cb
	2Bkiaknjbvvw3+wvToyuGpfeUPzyAxxjAR3K9hgrkoc0pmlfTpckVIoyctd/69awuHbc
	ZxOoab/n0I9A0o2KNEL292reEbWQrFFDvW8ASX2jauzAePXlZx2LOxY32fPyQDVV8YI9
	RZvHzYdJJq/FuoOCnf+hrwSTwenCpfkJH0IfjqO5bkJLhCGb7jrcFEiAKL+YUSMmgObU
	y4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=nxUBugLnk/cYYTKEq+Sl+nYkafMoGc/C3hGXaIEoeoQ=;
	b=uazO9jpiKfBWQA6Wy3gpeXnXtjwQw0f1uNG3+aglG3+WmXMXGRx0WXjMPoQVFViz6r
	0s0smdmFoXDIdlJl6+4/wAlh2iouyWj/1Mczrd9m6ANA3IDZv3fE97MReBtcHUQT4/RW
	DTwwhPUz1ob7oOYonPYEE7OHuAkUmV8gCI1+/R/WtFNQ8ArBYOjJZhEaluC/YIlPNyom
	7wkUpPbDvMBUVRf/9/zNGtotDArhaOGvsQ+/VtvayukcH1yPDgGRnWjAhdCidHbpB8qs
	6ufHrwf7b0cmtNEfX2j41te65OsVB2mt7zffWZ12wv5+6Ns0utlaajfiweZd9eqoMwCV
	++3g==
X-Gm-Message-State: APjAAAX1Xalo9z85zLSrQsjK0mnd6+/MCqvIyHS+FwLk0IGp8X+u7T5n
	uVOyXtjmDXpWV9nq6jnyKIh3qU9F1h6OGQ==
X-Google-Smtp-Source: APXvYqwV0y8ua2dshAIbjHTTwuMTduYBtXKiGI4XxE8MuyEb0UyXX2WmklIV2z8vRSDUlqFLb48/3A==
X-Received: by 2002:a05:6902:4d3:: with SMTP id
	v19mr2125338ybs.322.1558133107237; 
	Fri, 17 May 2019 15:45:07 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:06 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:39 -0400
Message-Id: <20190517224450.15566-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b35
Subject: [Qemu-devel] [RISU v2 00/11] Support for i386/x86_64 with vector
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
RISU.  Notably, vector registers (SSE, AVX, AVX-512) are supported for
verification of the apprentice. This is V2 of the series posted in
[1].

I decided not to drop the register definitions from the second patch
as suggested by Alex Bennée [4], but replaced them in the fourth patch
instead. This keeps the second and third patches code-motion only.

I wasn't 100% sure how to acknowledge Richard's contributions in some
of the patches, and eventually decided to include a Suggested-by:
line. Let me know if that's (not) acceptable.

 -Jan

Changes in V2:
  - included Richard Henderson's fix-ups [2] and vector register
    support [3]
  - replaced the magic numbers for XSAVE feature sets with symbolic
    constants
  - symbolic names ("sse", "avx", "avx512") as well as numbers are
    accepted for the parameter --xfeatures

References:
  1. https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg01294.html
  2. https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg01338.html
  3. https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg01371.html
  4. https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg04307.html

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
  risu_reginfo_i386: accept named feature sets for --xfeature

Richard Henderson (1):
  i386: Add avx512 state to reginfo_t

 configure           |  10 +-
 Makefile            |   5 +-
 risu_reginfo_i386.h |  49 ++++++
 risu_i386.c         | 142 ++--------------
 risu_reginfo_i386.c | 392 ++++++++++++++++++++++++++++++++++++++++++++
 test_i386.S         |  80 +++++++++
 test_i386.s         |  27 ---
 7 files changed, 548 insertions(+), 157 deletions(-)
 create mode 100644 risu_reginfo_i386.h
 create mode 100644 risu_reginfo_i386.c
 create mode 100644 test_i386.S
 delete mode 100644 test_i386.s

-- 
2.20.1


