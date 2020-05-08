Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8971FC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512B3206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2t4xYJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512B3206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4fU-000430-Ef
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eS-0002Nt-DB
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:00 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:55674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eR-0003zG-IX
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:00 -0400
Received: by mail-pj1-x102b.google.com with SMTP id js4so397730pjb.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jr73WCqW28SbyhPRTb5aG+mTkxxF432ibNUtSueJpeo=;
 b=R2t4xYJkURLMGgKj6B/QFI80myKHro0EgAQDQiQExYJLm+rKRrEWWiLNxvsWkoxefu
 LkLJKwt3iR3hg9YSeL9IxwDjsLipYobznENFtu+0zdpASFUEFpH/e0Sorx5NHnnIsLhz
 Bq8ToR35otAu5lqqkTGsBxsdmVZXkvZiEhmtIkwjwZb8eFDBQW1KejYJiaSwmhnHtsZV
 6q7nJ+mNADEWEBbEok10wbjmYPOMSjmTTVo9t2Z7HEN00jur5DVPl4asz4P3qFjHfrHM
 r6eewubUOai4Ap7lpVQX8LauCTfoLyB/NsjOqbwxNUdTee7/vVfLLh9TJC5udTN0iDDo
 9vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jr73WCqW28SbyhPRTb5aG+mTkxxF432ibNUtSueJpeo=;
 b=pD9qF/zc9dkrvIxLfU4z59h0bGzNrBUvKW0DGHwNNFMxNuhlL94JjPcdLRXMpWrDTl
 0LQd9Ncjars13ImK45ivIvi8c9VpophpY4YDMX+jQBM1zKiOGRwiJmG+xFR8jBC/xBcQ
 Oo8PB1/elBpdJo5YP373/vnNLpWoWC5Wp4wZC6GJKkifeivJY55AXBxi19syTL8CsdKw
 Ij6jkl33KBdlX8rR1HIjTx2DhFywa+a+jy5yWqLwD0l4N3A175a2CNcXW79djpmRbRvr
 dpxRZH1n0+aigLkLiwAJjWawq6cRyrKeGb8oFiX6RxSuDAMXh3HKYmMFm6xcdrtbBYdj
 VuKw==
X-Gm-Message-State: AGi0PuZieikgvnqve51cSZbVgWUv5mNNuFvrvNXfnissjER0UbeNrJmP
 K5zlV8K5CcGy49XY1QIJBCfKc9HGY4A=
X-Google-Smtp-Source: APiQypIqU7U7shw4xSMgksKIQYyyjviq8YJseTk2RFucF3PvWQCosMiz8aDdSZ9nryMhe/4HSWetMA==
X-Received: by 2002:a17:902:347:: with SMTP id 65mr2949498pld.21.1588950657312; 
 Fri, 08 May 2020 08:10:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d13sm1557562pga.64.2020.05.08.08.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:10:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/10] tcg vector rotate operations
Date: Fri,  8 May 2020 08:10:45 -0700
Message-Id: <20200508151055.5832-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split out from the v2 omnibus patch from 21 Apr.
No real changes, just a rebase on master.


r~


Richard Henderson (10):
  tcg: Implement gvec support for rotate by immediate
  tcg: Implement gvec support for rotate by vector
  tcg: Remove expansion to shift by vector from do_shifts
  tcg: Implement gvec support for rotate by scalar
  tcg/i386: Implement INDEX_op_rotl{i,s,v}_vec
  tcg/aarch64: Implement INDEX_op_rotl{i,v}_vec
  tcg/ppc: Implement INDEX_op_rot[lr]v_vec
  target/ppc: Use tcg_gen_gvec_rotlv
  target/s390x: Use tcg_gen_gvec_rotl{i,s,v}
  tcg: Improve move ops in liveness_pass_2

 accel/tcg/tcg-runtime.h             |  15 ++
 include/tcg/tcg-op-gvec.h           |  12 ++
 include/tcg/tcg-op.h                |   5 +
 include/tcg/tcg-opc.h               |   4 +
 include/tcg/tcg.h                   |   3 +
 target/ppc/helper.h                 |   4 -
 target/s390x/helper.h               |   4 -
 tcg/aarch64/tcg-target.h            |   3 +
 tcg/aarch64/tcg-target.opc.h        |   1 +
 tcg/i386/tcg-target.h               |   3 +
 tcg/ppc/tcg-target.h                |   3 +
 tcg/ppc/tcg-target.opc.h            |   1 -
 accel/tcg/tcg-runtime-gvec.c        | 144 +++++++++++++++++++
 target/ppc/int_helper.c             |  17 ---
 target/ppc/translate/vmx-impl.inc.c |   8 +-
 target/s390x/translate_vx.inc.c     |  66 ++-------
 target/s390x/vec_int_helper.c       |  31 ----
 tcg/aarch64/tcg-target.inc.c        |  53 ++++++-
 tcg/i386/tcg-target.inc.c           | 116 ++++++++++++---
 tcg/ppc/tcg-target.inc.c            |  23 ++-
 tcg/tcg-op-gvec.c                   | 212 ++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c                    |  62 ++++----
 tcg/tcg.c                           |  85 ++++++++---
 target/s390x/insn-data.def          |   4 +-
 tcg/README                          |   7 +-
 25 files changed, 696 insertions(+), 190 deletions(-)

-- 
2.20.1


