Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EFDC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767B8208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjTJJ7Ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767B8208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAeLZ-0004AD-71
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeI4-0001x4-QS
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeI3-0000Q7-Fv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:56 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAeI3-0000PD-9j
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:55 -0400
Received: by mail-pl1-x644.google.com with SMTP id 4so307981pld.10
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=F0Wia2jROmE5C4iTuiunWjrpETRbCBBXCQqEWgtA9Tk=;
 b=fjTJJ7EeFA6oP1ilpFPq1+qr075q8lqMKWWSwVRU5gXxfFj7Fpa8jVnZy5XwpgUqTa
 7H0JkeVKQ7ewwUsmdqPaX4prMBYHsAarBs1ijdz3qtExql2OPI8asqfcuaKKmhuy58Ya
 kszpOgXyYCs8xg6Qttfm846djVuCo0ujskKB3bIXwUNIAJ9H70kGDj/kIciJEDwASUFe
 nxYnHtmTHLnNu/FkVKNfopfgEqN5yy1btxReBsm0P7QO0KBJYYNAuSmTcfuwaxzDbrrU
 bHOYYd0E2sfYROO8GPViHZg7oAScTwkVYq6ddXxN7fnETrEowgUTMpG45WoVm3Ej08Fh
 tc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=F0Wia2jROmE5C4iTuiunWjrpETRbCBBXCQqEWgtA9Tk=;
 b=jqXtMd2PRb57NiOY4qNsF2hFBHoygne6w+i4XHfI7UjahOvPWoSZvitasM4WOn7Zd+
 3I9Pye7CVr3HxedEKyzW93xIxOJ5GkVp8Mmg2XkulWQ7PZKFj1gbG/JE7iM1Ku2wY3Uc
 ekY1/E6BS2RGNIy9lwlwmq57J6DCYMKq+ijLKiphnTpGBZOp7gGzdugSM5OnVp8oME0I
 FbIyRRVoN4/VgRdy8EkFcpKWKOAPDWasx05nbXZk1HoVcIfCKWi0Q2qC2X3osfj67+Yy
 rWq4y9Ms7RrXcVI8L+8Yy0glYLLT5Y0P31zQ3kSlalim0Iiygqgvm22uNN//MB0p6dju
 V3HA==
X-Gm-Message-State: APjAAAVqh46XQ/ogarZQiiixAs45yVNm3EBZsMT9VEhqvLeHmK9CfSOW
 NTtBm23W2auYOBhJoQnWmzH3GE57HJs=
X-Google-Smtp-Source: APXvYqxgv53dlU+odOgGdW4/5rUSJpGTWmGLU3lgMKJF/o+Se529uAxtmjDUnQIiaoh4nOGEFhA1Ng==
X-Received: by 2002:a17:902:b20a:: with SMTP id
 t10mr5521579plr.277.1568829772960; 
 Wed, 18 Sep 2019 11:02:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b16sm13319518pfb.54.2019.09.18.11.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 11:02:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 11:02:46 -0700
Message-Id: <20190918180251.32003-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [RFC v2 0/5] Move notdirty handling to cputlb
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RFC because it *still* doesn't work, just like v1.

However this time the changes are extremely minimal, and now
I really *really* don't understand why they don't work, because
as far as I can tell the new locking is *identical* with the
current i/o path.

In particular, the actual access happens between _prepare
and _complete, just like before.  Indeed, since this doesn't
work as-is, then I can't believe the atomic path works either.

I have included the TLB_BSWAP stuff just so that the
patch set is self-contained.

I did experiment with qemu_ram_addr_from_host_nofail(), but
an assertion for equality with addr + iotlbentry->addr does
not trigger.  As expected, really, since that's what the i/o
path uses.  One more cleanup for the atomics path...

Ideas?


r~


Richard Henderson (5):
  cputlb: Disable __always_inline__ without optimization
  cputlb: Replace switches in load/store_helper with callback
  cputlb: Introduce TLB_BSWAP
  exec: Adjust notdirty tracing
  cputlb: Move NOTDIRTY handling from I/O path to TLB path

 include/exec/cpu-all.h    |   2 +
 include/exec/cpu-common.h |   1 -
 include/qemu/compiler.h   |  11 ++
 accel/tcg/cputlb.c        | 243 +++++++++++++++++++++-----------------
 exec.c                    |  57 +--------
 memory.c                  |  20 ----
 trace-events              |   4 +-
 7 files changed, 157 insertions(+), 181 deletions(-)

-- 
2.17.1


