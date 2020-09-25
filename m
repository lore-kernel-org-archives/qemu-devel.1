Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A7FC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC0C20878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JG/stvFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC0C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpZ7-0002gP-Ht
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWn-0000qg-8t
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:53 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:33230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWl-0005QK-IY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:52 -0400
Received: by mail-pf1-x42b.google.com with SMTP id z18so3526669pfg.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LN0rM9K+QBjq1swvuakMXRjdGRKzzcDIkzPvNIAaL4U=;
 b=JG/stvFnDHmWAQJIl/V/6PCcKAY2kXb1cO5YIAWJBQezYVyX18wfpHWeVKd1YDYTsI
 PTkDlTl+NzUPglLa4vo3bO2UKyNBkWL9A6Iq6bnWf7J83W9umzSs2dTTIjEaKpumbIbX
 woQ2IOVrHf7YkO647+oZXuFh6oHULGh9TqW7mOt9Yax3evGRmQ7w4nEO9pCXx4mW6Def
 hiWOnt1BwN6a0mBDP8WlKJox3OLyg2PskQBREaX42tQ6kHRJjj/JlAG3f5nkhiJDMMox
 uv0ed0Z7fEir9gLxq4vNzvav/Wjqwdo9b40U+0UsF6Ff+Wqvfd1x+1Gc16F8v5UlLiGk
 evsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LN0rM9K+QBjq1swvuakMXRjdGRKzzcDIkzPvNIAaL4U=;
 b=rsFGYodCBUfFr/Of646kiEf7qdKdJcgb/4z4i2kud6d50o9lRnyL/oeEGn51oEaPg9
 dKVl4DF0jSxrMWdewqIbg8l5z7aaVqMGvsZyvdVGAo1+Rh1lyXAW3Q5MrQLNsR+2OJ68
 JAgJNPxGH7sF9ETB4n9i0DkzEE3pK6qkjDfsRZPR2zXTGslL3kPkunxwAVEOGIzBhIV5
 LCr09IoyN+H8gMICu/hHKJZ2W/Tsn9p7WBmg/7L5kNicn7mtrYmzsLUFFLvZbpaY7i0N
 m9t38n8COnr7/7ZBjX1QtUAj56sfIWpiVaIORPiRR4RCky5v0mG26EXQzGvS5lLkdoGI
 2BsQ==
X-Gm-Message-State: AOAM531Nx8C8uw/6cRNS4CBfOSiOzFJdUd149y4zJuh+NTLP2eIAAUnW
 vIsO1LUvRlUkpSvTtkC5EK3rVOR557PS5w==
X-Google-Smtp-Source: ABdhPJxO8hw1ZtA7meLMNlpRsO4hSBd8Yoz6w4W8pcnqhzkZ4VGOQehRimny5LUoCPLkGaCqbQ7GnA==
X-Received: by 2002:a62:8607:0:b029:13c:1611:6593 with SMTP id
 x7-20020a6286070000b029013c16116593mr4467332pfd.16.1601047249334; 
 Fri, 25 Sep 2020 08:20:49 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:20:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] softfloat: Implement float128_muladd
Date: Fri, 25 Sep 2020 08:20:37 -0700
Message-Id: <20200925152047.709901-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Plus assorted cleanups, passes tests/fp/fp-test.

Changes in v2:
  * Add UInt256 type (david)
  * Rewrite and inline shift256RightJamming.  This keeps the whole
    UInt256 in registers, avoiding long sequences of loads and stores.
  * Add x86_64 assembly for double shifts.  I don't know why the
    compiler can't recognize this pattern, but swapping values in
    and out of %cl (the only register in the base isa that can
    hold a variable shift) is really ugly.
  * Add ppc64 assembly.


r~


Richard Henderson (10):
  softfloat: Use mulu64 for mul64To128
  softfloat: Use int128.h for some operations
  softfloat: Tidy a * b + inf return
  softfloat: Add float_cmask and constants
  softfloat: Inline pick_nan_muladd into its caller
  softfloat: Implement float128_muladd
  softfloat: Use x86_64 assembly for {add,sub}{192,256}
  softfloat: Use x86_64 assembly for sh[rl]_double
  softfloat: Use aarch64 assembly for {add,sub}{192,256}
  softfloat: Use ppc64 assembly for {add,sub}{192,256}

 include/fpu/softfloat-macros.h | 109 +++---
 include/fpu/softfloat.h        |   2 +
 fpu/softfloat.c                | 620 ++++++++++++++++++++++++++++++---
 tests/fp/fp-test.c             |   2 +-
 tests/fp/wrap.c.inc            |  12 +
 5 files changed, 652 insertions(+), 93 deletions(-)

-- 
2.25.1


