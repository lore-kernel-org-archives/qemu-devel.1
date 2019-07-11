Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E40C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278A920872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV9bX/RA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278A920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhez-0000Np-Re
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40548)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdQ-0002I2-8S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0004AS-Gm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:52 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0003cd-9F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:50 -0400
Received: by mail-yb1-xb44.google.com with SMTP id s41so470677ybe.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6c3V8YA8eUAhhzuDHmNYoKZSJuKAzGeAVZYrIxT1hLc=;
 b=WV9bX/RAoKCvsXw5Gvph3K7jHZ+bQbB8ZvjA7+q6FBae8OvLRU0dYYHw4pQBZM2QII
 6UUF9CReJZ5LsRIQWv/B9UR+5L48jWgYTRLlarK/8o9UMCNi/GvHD1AaQJI59qapuuJY
 7dmEfupGkR5IwzUQzKPTWr4Uz5vuFIa5OjBmEFwTuXgfdrMmus+kd0TSKdz4gP/xKqfu
 PlCutl1HgR49aedTwELbWUlLWD2+q21gzebj9GtqBiqBPO9IgkpiBtcbTR4f0Ung5Iew
 WfyzSUcouDp9Vha5JvaMFsoo8cml00jXlAxZUw7yUOwyGi1lpwrPqv2z9mX8t1nhkwf4
 ALPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6c3V8YA8eUAhhzuDHmNYoKZSJuKAzGeAVZYrIxT1hLc=;
 b=hOzu0U+Blu0aXhaISzRQlyl7j3JvP2NVGEAPKHRfI2WCR5f8RsUfRZMl1phd8SETTv
 qeYLKPKuwTJklfCpSVJx6HmfVMrc0RUlfLUJCwpID5uzE97Hc1AZQ7XXKUziz04dPT19
 U7W2XZfkBxnSHL+MViJAmEmvUSDWRz+lULzjN4xYCOOryT4LnqFPoXrgjVpNtaCYEqZZ
 ymEpNBqNqdbDoWaaA48YKo+Ohgzy5sc6qECGMVU6fNpoxFRmspb2bY55ryKuw/NmqDrr
 PGoVoncXiTS+YAMJKA1Q7e5SB6JU1ZDapKQTIM7lfDwlPU/qRlHMFgwVVC2IpbeIQ5pr
 S/Ng==
X-Gm-Message-State: APjAAAWGWiyM9YznrG/xTgWx6wshKVfQb3rwhgr6QIiM4OXkf5Z/khFr
 sqs2RQI61p9FxIxcKRTDWePtWFmY
X-Google-Smtp-Source: APXvYqz8q8ZDmG6woor5QhqW/BuXFCDLbjDQF+5QKS/6cZRMQMm8WgA7jTO5Whx34q2+0rPYzNxQkQ==
X-Received: by 2002:a25:1b45:: with SMTP id b66mr341953ybb.365.1562884392938; 
 Thu, 11 Jul 2019 15:33:12 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:12 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:42 -0400
Message-Id: <20190711223300.6061-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU PATCH v3 00/18] Support for generating x86 SIMD
 test images
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v3 of the patch series posted in [1] and [2]. Note that this
is the first fully-featured patch series implementing all desired
functionality, including (V)LDMXCSR and VSIB-based instructions like
VGATHER*.

While implementing the last bits required in order to support VGATHERx
instructions, I ran into problems which required a larger redesign;
namely, there are no more !emit blocks as their functionality is now
implemented in regular !constraints blocks. Also, memory constraints
are specified in !memory blocks, similarly to other architectures.

I tested these changes on my machine; both master and slave modes work
in both 32-bit and 64-bit modes.

Cheers,
 -Jan

Changes since v2:
  Too many to be listed individually; this patch series might be
  better reviewed on its own.

References:
  1. https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg04123.html
  2. https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg00001.html

Jan Bobek (18):
  risugen_common: add helper functions insnv, randint
  risugen_common: split eval_with_fields into extract_fields and
    eval_block
  risugen_x86_asm: add module
  risugen_x86_constraints: add module
  risugen_x86_memory: add module
  risugen_x86: add module
  risugen: allow all byte-aligned instructions
  risugen: add command-line flag --x86_64
  risugen: add --xfeatures option for x86
  x86.risu: add MMX instructions
  x86.risu: add SSE instructions
  x86.risu: add SSE2 instructions
  x86.risu: add SSE3 instructions
  x86.risu: add SSSE3 instructions
  x86.risu: add SSE4.1 and SSE4.2 instructions
  x86.risu: add AES and PCLMULQDQ instructions
  x86.risu: add AVX instructions
  x86.risu: add AVX2 instructions

 risugen                    |   27 +-
 risugen_arm.pm             |    6 +-
 risugen_common.pm          |  117 +-
 risugen_m68k.pm            |    3 +-
 risugen_ppc64.pm           |    6 +-
 risugen_x86.pm             |  518 +++++
 risugen_x86_asm.pm         |  918 ++++++++
 risugen_x86_constraints.pm |  154 ++
 risugen_x86_memory.pm      |   87 +
 x86.risu                   | 4499 ++++++++++++++++++++++++++++++++++++
 10 files changed, 6293 insertions(+), 42 deletions(-)
 create mode 100644 risugen_x86.pm
 create mode 100644 risugen_x86_asm.pm
 create mode 100644 risugen_x86_constraints.pm
 create mode 100644 risugen_x86_memory.pm
 create mode 100644 x86.risu

-- 
2.20.1


