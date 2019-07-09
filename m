Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE54FC73C56
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D0421537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+RSbrIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D0421537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktA2-00048K-6g
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 12:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37897)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7I-000393-4u
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7G-0006Wz-84
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:19 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkt7D-0006QP-I4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id u17so9237624pgi.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JVOyp/SQtLtkdq8BjHn2mlzsOWIS2SvfgbnRIW9MzD8=;
 b=f+RSbrIZuaswgLSXeBK5hU/c/5bgbr2AuerajJMVw+GRyWgrOOX05ai/0S8/LHZisD
 EqUwPB5qTVJpGHvpB7dWyY85DD7P76o6wmXpsK1g9gZtvQ1OmReqhnp/SchCC5EqPHLo
 6XBunsMwINll0qnCPRDONQUzR1jiXNeOvzpzs/oNEMFgpwzBj02pytvAtTLLIMjmhrMa
 Y5Xqbin+DaNGYnWjp4GETzlvk7mIgE6zjaKdtWXT9LsxFCMXj825rya+Pl2OMKzxlSbm
 qulQqDeXsjfJmHhMVcRZM3wHfCwUkMpLqgOabnuPZ4oqk4zs+aRU8ld7YZgm8KBbpNqR
 /UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JVOyp/SQtLtkdq8BjHn2mlzsOWIS2SvfgbnRIW9MzD8=;
 b=oCcBtzEEImgvhw9L8So1vi3mWWkTqh2BS6Hvb3aK9R90Ec4bkqGMssaRZTt/XgmaDT
 FBgLWYLhR1UQbscJLI0N5vBVU1qKicJeItpJZNnUBywjnLx8ejTz81/tcOehSA3FMsvL
 QEEnREa2LZqQTH5nKg7zTkFSFHMSx4ENhhiVcWsC8aq3erPc8bvZbb8Fhuwj5BAvkZDR
 aiHIPUscLsMFylFKPaGvO6DNFefYmj32h2e9x72BaOHjHRVN8n+mutGPBqo5wTJ9pZQ/
 WprtcbxHUcUSg8JLICnw493lqmZf4zvVo0mOmh1HHYjmIXRR7HuvEoeHgQlemkiH6wQh
 25JQ==
X-Gm-Message-State: APjAAAWc1yUFoCfqS5OSBhi5NkS17slX90zSRqqC85gnN0NsCgzDocsj
 CRe7gMXK04B2MaoCWDSdrwrZYlmj0Ps=
X-Google-Smtp-Source: APXvYqzKwffXyji522+N677RI0Bi575GgRKjLe2y2urf1nUzWjpo0w0UGXfCSU5+J3ZAv+Eo9CRvSA==
X-Received: by 2002:a63:fb4b:: with SMTP id w11mr31690318pgj.415.1562690227163; 
 Tue, 09 Jul 2019 09:37:07 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id v8sm19225231pgs.82.2019.07.09.09.37.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 09:37:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 18:36:51 +0200
Message-Id: <20190709163656.3100-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 0/5] tcg: Fix mmap_lock assertion failure,
 take 2
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes from v1:
  * Fix whitespace error
  * Fix cpu_lds*_code(), where cut-and-paste failed to extend the data.
    Noticable with check-tcg with docker cross-compiler for cris-linux-user.

Blurb from v1:

While I could not replicate the failure Peter reported, the apparent
root cause -- the old magic fixed page -- should affect other guests
as well.  In particular, the old arm32 magic fixed page at 0xffff0f00,
and the hppa magic fixed page at 0.

In the arm32 and hppa cases that I just mentioned -- but notably not
the x86_64 case that Peter reported -- there is special-case code in
target/*/translate.c to handle those addresses without actually doing
the read from the unmapped address.

Therefore, until we fix these sort of address space representational
errors, we cannot even rely on page_check_range() to validate the
execute access.

Instead, modify the host signal handler to intercept this at SIGSEGV.
At this point we're sure that there is no guest special case that we
have overlooked, because we did attempt the read for execute.

Also, I noticed that we really ought to have some barriers around this
code to make sure that the modifications to helper_retaddr are in fact
visible to the host signal handler.

Also, some minor cleanups to the set of read functions that we expose
for use during translation.

Also, a trivial duplicated condition.


r~


Richard Henderson (5):
  include/qemu/atomic.h: Add signal_barrier
  tcg: Introduce set/clear_helper_retaddr
  tcg: Remove cpu_ld*_code_ra
  tcg: Remove duplicate #if !defined(CODE_ACCESS)
  tcg: Release mmap_lock on translation fault

 include/exec/cpu_ldst.h                   | 20 ++++++
 include/exec/cpu_ldst_useronly_template.h | 40 ++++++++----
 include/qemu/atomic.h                     | 11 ++++
 accel/tcg/user-exec.c                     | 77 ++++++++++++++++-------
 target/arm/helper-a64.c                   |  8 +--
 target/arm/sve_helper.c                   | 43 +++++++------
 6 files changed, 136 insertions(+), 63 deletions(-)

-- 
2.17.1


