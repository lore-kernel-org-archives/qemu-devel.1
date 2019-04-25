Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D803C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F891206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZnvBWEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F891206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJiA8-0007PW-4C
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 13:27:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8w-0006e1-5V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8v-00039k-5Y
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJi8u-00038v-Uk
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so257317pfd.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=e50h0rv9rWiIypCYIm4Lk5gtLy8wge417FHJ3filWHs=;
	b=OZnvBWEtXPmqlaeIoWutj/GFEofMNxBkLQm42hGokgQj/Vfje5supEuUrinkyQhkWE
	slcW+lFhiIvtodpB8X4yuzFlqAasbma7mcW6KWG7R4nENxzcIm43PyI/dyDVQnolZ3AM
	bMMUmgPXIoppzPzU/cFg4FIrTZOsQ/iFU1agVY2yahwaE3uuTN8PFno2wxRolTu/Yblm
	ktEdBXNh27edKmoGDW1Xy1RW3y2KOssMTPYc8gWSgb5nGJc5b7cXHiwQKu3shadj8QXy
	6lht0Vx87pMyYx4/vdqb5hlIca7KKRFXtB0YPunX28QOVxrNpvl9DhdfQbAuTnrFui4o
	6Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=e50h0rv9rWiIypCYIm4Lk5gtLy8wge417FHJ3filWHs=;
	b=bxFCwc4TKyYkxT/yuuw8cIOftuD2giziVoaV6ai0fED2eLe6xdGnMtnTzqB/sk3oCV
	5yn1ixhbSvuOK0v2Jqm6a0PXX6jS6zYVrpv8j+iRtRQlpSCBbNtLAqVksK1JypnhYghi
	RhiIo1CJXaFtNQ0xlgBOn28jwlPJayBucN3IMIP85keMpyo485XpkjoOV7Q3a+yfbr0+
	a4ly2HJEq1VmDqRW79bBCb9OMKCXTRLUHfYk/jGI7zvDEoFJD/vjAlN/rXykiKmKbACq
	dOrefQv4sRL4NbnmHBNoZ97EecM3+MHO0q8pJvohQmGsAoEZvbgKfAlz+ddxhQUDM4wv
	EXCw==
X-Gm-Message-State: APjAAAXk0F7ITRwDSRBDad0Q7my9bSluTF6kn0+EjdVuUQQzAeaWSNon
	4asO45tgtczq/7Dug3lx3LjK6AKHk30=
X-Google-Smtp-Source: APXvYqxzqus8ip4JabfRT9z+BQLlq4glHKV7biqgNZ0B4LXLdYoC6Tb/midXquWSywKSYooqk3Fw7g==
X-Received: by 2002:a63:6844:: with SMTP id d65mr38929244pgc.393.1556213197963;
	Thu, 25 Apr 2019 10:26:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	128sm26439908pgb.47.2019.04.25.10.26.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 10:26:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 10:26:34 -0700
Message-Id: <20190425172636.11128-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 0/2] target/riscv fixup and reserved argument
 checks
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
Cc: palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425172634.K0QlljTxnJ_Uv5ygbbozgcAtWQEtkgTcIjxaOerTsik@z>

Based-on: https://github.com/palmer-dabbelt/qemu/tree/for-master

The first patch is my (interim) solution for compilation with clang.
I'm still open to Thomas' suggestion to add -Wno-typedef-redefinition
in the configure script.  I had intended to squash this into the
indicated patch when I got around to re-sending the patch set, but
Palmer has started queueing patches already.

The second patch handles the C.LWSP reserved operand case that Palmer
pointed out during review, and 4 others that I found while double
checking against the RVC instruction set listings.


r~


Richard Henderson (2):
  fixup! target/riscv: Name the argument sets for all of insn32 formats
  target/riscv: Add checks for several RVC reserved operands

 target/riscv/translate.c      | 13 ++++++++++---
 target/riscv/insn16-64.decode | 10 ++++++++--
 target/riscv/insn16.decode    |  7 ++++++-
 3 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.17.1

