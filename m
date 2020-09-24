Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CD3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A442145D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUjOoIfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A442145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG1T-0006QH-Bm
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0I-0004l1-JC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:24:58 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:32785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0G-0005gf-WF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:24:58 -0400
Received: by mail-pj1-x1032.google.com with SMTP id md22so3496578pjb.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HJGGeqLqq1Djj4zDsg787yOmF3r5rA+nf0wqwESfDmw=;
 b=kUjOoIfETEFB1KfZPNxsY1uHdU3/jYK2AbLSdp86xH7LkQmX1uBr7GtVDzljt8e4UF
 0b23ETFbCcuPTR+mefYejUr07c9HaabbSBjCkaqd4R4vtvTnq3AsKn3mntjSLFsML0t7
 6U32X09DbFmjyebEXW3+eWS0wVlVFLECVo96aYVqMLhynCMnACJoDdxskxynhGY6iNTk
 +fTh4YyjB/CCCaUZXuXwoHjk8UZRtMlxLY/s6GNFC8dYqH5cCRykOqi8VNOiRLYNMwC2
 PjlVTCYVHUxwZvz65DWqJB77/VdHe/rRKzcn9DMXaYehvYXtE62D5oMxqi1vHTM/f2EH
 P3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HJGGeqLqq1Djj4zDsg787yOmF3r5rA+nf0wqwESfDmw=;
 b=RKnPdx3n+bAaZikoAJh+MotF2njg2/b6Iu6mi/G0AqGsLhM5C80f9mPOKUnpjE7gMP
 bMwOmJrYfiHrw2VspUVLv3Dmz0g/tYEw0gErUH0/TxA8Xkfc8UmFYFRdnrPPp5OY7MSe
 /UuVU2ehYRokjJR7pBRd3db/RpNaWWMcTwLlgWlmKPVGaetY1C79EPSEhjRMD4Ke0ezi
 DZ34bo2NoFxK/7O604CWP4rYloX4Q+zk5P4JBuJrbv12BQ4yohX8xojM3EGvdZYEDucx
 seZkE4z33u6IpqzSwmqwie86fR0gOAyenp+kZjcKLHn49MxX5t6YrghlJptpwiSPQh0R
 GK+g==
X-Gm-Message-State: AOAM531XKhwV2ul/+XrN2YvjtHqn3m0ft0D38l2uCIWnw0H5jEJkJ7o8
 JI4Qj3GHAN76gIwQACG1lgaiO8oSvCJkbg==
X-Google-Smtp-Source: ABdhPJwAj0oLY/wZSq8GqZsia+4qKotMvnjOIjAWveNf3Dvch7io8izQ8fsNijPvmkVzPopdW5MzcA==
X-Received: by 2002:a17:90a:b118:: with SMTP id
 z24mr1705934pjq.220.1600910694790; 
 Wed, 23 Sep 2020 18:24:54 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:24:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] softfloat: Implement float128_muladd
Date: Wed, 23 Sep 2020 18:24:45 -0700
Message-Id: <20200924012453.659757-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
I will eventually fill in ppc and s390x assembly bits.


r~


Richard Henderson (8):
  softfloat: Use mulu64 for mul64To128
  softfloat: Use int128.h for some operations
  softfloat: Tidy a * b + inf return
  softfloat: Add float_cmask and constants
  softfloat: Inline pick_nan_muladd into its caller
  softfloat: Implement float128_muladd
  softfloat: Use x86_64 assembly for {add,sub}{192,256}
  softfloat: Use aarch64 assembly for {add,sub}{192,256}

 include/fpu/softfloat-macros.h |  95 +++---
 include/fpu/softfloat.h        |   2 +
 fpu/softfloat.c                | 520 +++++++++++++++++++++++++++++----
 tests/fp/fp-test.c             |   2 +-
 tests/fp/wrap.c.inc            |  12 +
 5 files changed, 538 insertions(+), 93 deletions(-)

-- 
2.25.1


