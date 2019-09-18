Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E573C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EE621848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgMJWTmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EE621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iASaV-00060n-CQ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 01:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iASUK-0002L0-Bo
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iASUI-00070j-1e
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:47 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iASUH-00070I-RS
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id w10so2562958plq.5
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=M0oPGEaqH2K0JM4e4Q7AnuXfBw3BK1zS9WU3J+Hs32Q=;
 b=kgMJWTmmvgPkqbGOeJbvMfofApSU6yJvNsimM06Z1kaP1LCr2wfDHiLVALZHfvOXvl
 wmz55T1a7Srdfm4XXX7/fFlWkIeG0A5nG6jLBLtrroDH+oA4sGsrr28821ls30Xb0008
 /N7gEOvwmtARsLQPuydjCILcuNFjW08uKOpqjCVnb1iNIgf/q6NIs4hvnkXHqEWUu/h3
 PpUDKgh4oecjJqjcXFyXIUtSpnxZJEtcqHXDiQ5xAxZiTEQzZ/tfdjXunLKrp/lzLaNq
 jyJ/+czUPITJEtPJ+17afe+wMe3sCBsI6qKaitFIg0QhPGLyQ3IR2Ulxx+vY1JfUWw//
 FF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=M0oPGEaqH2K0JM4e4Q7AnuXfBw3BK1zS9WU3J+Hs32Q=;
 b=Cu9umt6zm+54gaApYOAN63GuJTY6RrOKonyCgaG9ac3zbUuxzmOmRRVkSuRJ/Xk3U3
 IrMPu8JtM7JByBwOptzK6dK4/3JcjSKzlreQUF33KVf5NjN71FOIF/ly2v5+6nmr2rkD
 set6j0l9gc4oyubuSYb4m7/R3uk+6Maf3BYz/X2MSy8mNnfX6q1OKRpODdvnLX/a2RNv
 wLNMEX6VqYE7Ubk7iYW6CMZXcgLbamYqESld5rj0halAKk12kGFxmsX7yOVPrAfeF1pZ
 EDZoWZrP8Z2BERGNk3mFQ25zNzi9a95rmV1zG2jgKPxR1O5U8P7gb7LoKHe2sjT7kisx
 EbQg==
X-Gm-Message-State: APjAAAUUdkjaFb5EKz0sq83m0K3x+IXkecPFgu+H1l1uigYH7oCZLAp5
 GHkywTFjHJw58KlBLFxkhcl0GDyXcTU=
X-Google-Smtp-Source: APXvYqzxjEKMXguDTmT38eKW13BpyDa4ic8BQUm2UdJoN+bIrTTuc8egN1bYucq7y5u5nFOweCBjqQ==
X-Received: by 2002:a17:902:b20a:: with SMTP id
 t10mr2357286plr.277.1568784404173; 
 Tue, 17 Sep 2019 22:26:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a1sm3457234pgd.74.2019.09.17.22.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 22:26:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 22:26:38 -0700
Message-Id: <20190918052641.21300-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [RFC 0/3] Move notdirty handling to cputlb
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RFC because this doesn't work, and I don't quite understand why.
The only failing test is {i386,x86_64} pxe-test -- the other
migration tests that use notdirty all pass.

Note that if you try to reproduce this on x86, you'll likely
have to --disable-kvm, as otherwise the pxe-test will skip tcg.

Anyone who knows how this works willing to have a look?


r~


Richard Henderson (3):
  exec: Adjust notdirty tracing
  cputlb: Move NOTDIRTY handling from I/O path to TLB path
  cputlb: Remove ATOMIC_MMU_DECLS

 accel/tcg/atomic_template.h    | 12 -----
 include/exec/cpu-common.h      |  1 -
 include/exec/memory-internal.h | 53 +++----------------
 accel/tcg/cputlb.c             | 65 +++++++++++++----------
 accel/tcg/user-exec.c          |  1 -
 exec.c                         | 97 +++++++---------------------------
 memory.c                       | 20 -------
 trace-events                   |  4 +-
 8 files changed, 63 insertions(+), 190 deletions(-)

-- 
2.17.1


