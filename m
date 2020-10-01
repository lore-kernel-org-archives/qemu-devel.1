Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F4EC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3A52085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwZ6rZbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3A52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2AC-0001py-Fb
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO23k-00021q-5z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:08:00 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO23i-0001cI-FI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:07:59 -0400
Received: by mail-ot1-x344.google.com with SMTP id u25so6166811otq.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n007JuMxNaM+43IWW/tiTfqPZrJc3uDGY1zoJY2D5Cs=;
 b=jwZ6rZbh3YU3FxfqN7WkrUJQRC8KExfaJTj2AaooCvudCJWDYf3DJE7MOZaF0oWz1e
 8twKi5zr3QYsYUyXoeXSdi11CXkdrMzfIJOewzWCWEGraUR7sGxLWsn5oW+4drCX/yv5
 A43bFAzlqV0mXfViUgR2UqEOR3Uu034LRHWFi4w7mBt8+YyJVGGOltmv4eWCdd2eRRws
 0nktHOAS1R+3MBTRkED6KjMlN8b5dKML8Sf2xbYWVnCIPZxOwDqoOn7JoXFLaYJ4gMEO
 QOBQTHk448luV5g/HF4TeTyrOUMbCiYhAxUmAhTX+5vwmLdULy/iDlhcAY+Llc+INz+o
 JvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n007JuMxNaM+43IWW/tiTfqPZrJc3uDGY1zoJY2D5Cs=;
 b=TAOVj46GfOO7TySkeZOS0/RTu8VdUUqJV+6MThrOl7dgrU/5w7ceFH3KlikqN2fi2x
 rTUGrToJwJDMuqFBA+OEPA6yfbqAsGX0SJ2JYI2ajH/pk78uaOUd+3B4+GD7XBNoOybA
 lVly2+9rg70W00jo1ooOwVb8IcjvH/iM/wwDeJGwT/kqKTVnOchoXyR2r66bE+dVyXqN
 FO369xENJSidsj7lhX1GMoP9mqzg52MSZtAsdCnqhhCvn7Ai+yU9Y5Y9nYswsfLD03lw
 qDMisfBgPOBef1yhR1fbFnZpc41ZkbQcWAouZjGtV9b/f5MDdGvC+8k6Nywc3CdeI0Ug
 S35Q==
X-Gm-Message-State: AOAM533sQpLnPpqGMLOQwWf5URT15xDhr8+6E/+C0kmhHxCcagsyvk3Y
 7fJGvQS+vr7T2Ep8u2t/mQmxN/+qXyggehnl
X-Google-Smtp-Source: ABdhPJy9wrtbaatHfoA1xNQ0JE483ZrvYYTJD1d2MbgZ0shS+2W1KWGC2EMGyRT7+rJkfaSfjG+Iww==
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr5827596otp.206.1601572076536; 
 Thu, 01 Oct 2020 10:07:56 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id w25sm1334350oth.22.2020.10.01.10.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:07:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/2] target/arm: Fix tlb flush page vs tbi
Date: Thu,  1 Oct 2020 12:07:50 -0500
Message-Id: <20201001170752.82063-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Jordan Frank <jordanfrank@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the FAR_ELx fix at 38d931687fa1, it is reported that
page granularity flushing is broken.

This makes sense, since TCG will record the entire virtual
address in its TLB, not simply the 56 significant bits.
With no other TCG support, the ARM backend should require
256 different page flushes to clear the virtual address of
any possible tag.

So I added a new tcg interface that allows passing the size
of the virtual address.  I thought a simple bit-count was a 
cleaner interface than passing in a mask, since it means that
we couldn't be passed nonsensical masks like 0xdeadbeef.  It
also makes it easy to re-direct special cases.

I don't have a test case that triggers the bug.  All I can say
is that (1) this still boots a normal kernel and (2) the code
paths are triggered since the kernel enables tbi for EL0.

Jordan, can you test this please?


r~


Richard Henderson (2):
  accel/tcg: Add tlb_flush_page_bits_by_mmuidx*
  target/arm: Use tlb_flush_page_bits_by_mmuidx*

 include/exec/exec-all.h |  36 ++++++
 accel/tcg/cputlb.c      | 259 ++++++++++++++++++++++++++++++++++++++--
 target/arm/helper.c     |  46 +++++--
 3 files changed, 325 insertions(+), 16 deletions(-)

-- 
2.25.1


