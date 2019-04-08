Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D9C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD0720830
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFRFYj6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD0720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57105 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZ1f-0008Qu-0T
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:29:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0K-0007Zj-Ng
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0J-0007Aj-KU
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:24 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0J-000795-CW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:23 -0400
Received: by mail-ot1-x342.google.com with SMTP id f10so6987339otb.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=HdALe2m97uBiJXmSq9FGIPnU+ECzlTvNcJCVAqg8xFg=;
	b=pFRFYj6/iwiCFC0ubW+wiNAXII/kVtOiXwjrk+b5FScRv+ObCzs7IEhsuvzBrlXpT8
	v5m0LnRiJL5HFaz6oTrW4rI9W3q8al11Uh3nY1c0ZOffPjAJOndp5G/cmSUn6Ea8nKmr
	F8RWR0LCbnCXJP1D8i9kqaA9KEY0vw5totz0PNo0Z1Z3W+s9o8aMLJ92N9O/41WI7PDv
	4pvmrPuVpxajpt7MtYCqcfQYxhDouXH8mr1KqA5BpPwuHdNcnQAhg7t9v9+p1IUJNWD1
	vzfjAmC51vDFLoD2xm05mM7b23om0lZWyglNmTwvRMc6BByz/dUJYIi3rHCzfLeIkQbX
	tDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=HdALe2m97uBiJXmSq9FGIPnU+ECzlTvNcJCVAqg8xFg=;
	b=ZU5V5DaEfd91DCEqZbItStR3KHLJn0HUZprzzmt5ySRFoK01vR+Dl7zOJ/8TEvGnPu
	kjVdtcuHRhV4y3wT4TYWi1Dmg1MwNT3n9sdU2rBT2JVNvmNmXZt8sIfa6H5W+LRi71XB
	fzRwJjzY3o+5h6fQREfuZ00615WQinWDATvsgGnnvesMLwTHStfvRs1KYjjwTzckM8PX
	Brh+yUaZObaQJz2qxkaVoJOD6HyL4cs8NMHqI7a5IegJ/vXcfYReio/DpWOLdMvGSIBx
	UitAIrN+wq6WjV86PZOoA968c3xZxs91CUvK3NDg8O63Y/ZWeroNjEh+3Fduuap4Hg3n
	cEsw==
X-Gm-Message-State: APjAAAXoEkk6yWgQZd6m0mCsBb0JfDR47zm8jtxY6EFYtCsv7MHwlFn8
	nviD1ydnY7L7xm2B3OrLPksRTsNeL+Q=
X-Google-Smtp-Source: APXvYqwsaWInWCoQNwUlT4EE3szK+wGcnS1kq9ZS1ZKZw7GX3cg9LORssKnx5p7yHPcSkrly0ZN6fA==
X-Received: by 2002:a9d:6b9a:: with SMTP id b26mr20841594otq.46.1554748101240; 
	Mon, 08 Apr 2019 11:28:21 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	r133sm9940295oib.21.2019.04.08.11.28.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 11:28:20 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:27:43 -0400
Message-Id: <20190408182748.1238-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [RISU PATCH 0/5] Fix RISU build for i386
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Jan Bobek <jan.bobek@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408182743.9a0nKFsZlH2XTAujd11kXL-IkH2aq8SluaoW7kEzOx4@z>

Hi all,

here's a patch series that tries to fix the (currently broken) build
of RISU for i386. With the patches applied, I am able to successfully
cross-compile and run RISU for i386 on my x86_64 laptop running Debian
10 with:

$ CC='cc -m32 -std=c99' LD='ld -m32' AS='nasm -f elf32' ARCH=i386 ./configure
$ make
$ ./risu --master --trace test_i386.trace test_i386.bin
$ ./risu --trace test_i386.trace test_i386.bin

There's a couple of points that I'd like to mention/highlight:

1. Most of it is just moving stuff around, however I've implemented
   reginfo_dump_mismatch (based on reginfo_dump and code in other
   architectures) and defined EAX as the param register. There is no
   support for more registers yet, that will need to be added later.

2. Note the '-std=c99' switch in the command-line above; without it,
   GCC defines the symbol 'i386' to 1 and the preprocessor magic for
   including arch-specific headers in risu.h breaks. Does anyone have
   an idea how to fix this in a more robust way?

3. gas (the GNU assembler) chokes on the syntax of test_i386.s; that's
   why I'm using nasm as the assembler above. Is that intentional? I
   haven't found the nasm dependency mentioned anywhere.

   Also, nasm will happily emit the UD1 opcode (0F B9) with no
   operands (see test_i386.s). That's a bit surprising to me, since
   Intel's Software Developer's Manual says UD1 has two operands; I'd
   expect at least a follow-up ModR/M byte. gas refuses to assemble
   UD1 with no operands, and gdb's disassembler gets confused when I
   load up the nasm's binary into risu. Is there something obvious
   that I'm missing?

Thanks,
-Jan Bobek

P.S. This is my first time using git send-email, so please bear with
     me if something goes wrong and/or let me know how I can improve
     my future submissions. Thank you!

Jan Bobek (5):
  risu_i386: move reginfo_t and related defines to risu_reginfo_i386.h
  risu_i386: move reginfo-related code to risu_reginfo_i386.c
  risu_reginfo_i386: implement arch-specific reginfo interface
  risu_i386: implement missing CPU-specific functions
  risu_i386: remove old unused code

 risu_i386.c         | 140 ++++++--------------------------------------
 risu_reginfo_i386.c | 104 ++++++++++++++++++++++++++++++++
 risu_reginfo_i386.h |  38 ++++++++++++
 3 files changed, 160 insertions(+), 122 deletions(-)
 create mode 100644 risu_reginfo_i386.c
 create mode 100644 risu_reginfo_i386.h

-- 
2.20.1


