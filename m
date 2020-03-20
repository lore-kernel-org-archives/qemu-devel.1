Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB6C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2001520739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDXroowW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2001520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKCi-0005r7-7l
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jFKAJ-00021b-3a
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jFKAE-0001ZZ-8C
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:30 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jFKAD-0001Yz-PQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:26 -0400
Received: by mail-pj1-x1043.google.com with SMTP id np9so2665911pjb.4
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2qwsnnZRpJ70PFD94LRZPv0e2iao9t6qg05HQ61q8lY=;
 b=dDXroowWhGQLETvjZrBc6u3bap48GxzC51fp3jfrj4ni74n88qYIfxuBiOJeZdQ30o
 eO2YyqyxY41CTuNeYxCNct4WDopcQh3rFBnfeih/rAOjzl6IesUYiJ5uNOqI6CbuM2uR
 5hRjQpfOVqZe9+ShHX65evIfxTZU+yneEnT2SAB9d5w88q1ZkLIvqYvFd7y1Kamci9Gg
 4+EXR+K044pOxlEjFsoxdoAOKkgtJx4Fo4bbpV0waYWhcybdgV6yJS1mp6uY885Knkmw
 J22/tUo/cw983UIqzT99HtmUs+BMW++SNEdgbKqodPrXScY+czq+hcf08tjsC7fQRVgQ
 LcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2qwsnnZRpJ70PFD94LRZPv0e2iao9t6qg05HQ61q8lY=;
 b=LlhHJ+G7EFOfeRG8Cz5/qD5pKNSREDOVADEqGRhxWTkPxZltsfPGcl48ztQuD2dzY3
 5w/xzRm8Z0GUkVzYlfbVknG0LJkC6hn0omx9L3imxGA2HnLnEmnHJNZjppqAhuq43Q2m
 Q/iZYmF7vMtHf02u61ZPT3C7kNgeigqpbBf6Ca/7rmt3B060eWJfxwuthU7fUfwkg/lo
 2/h33HMkdrEKDKVRutIwA1xpCxSXLcI+c9wnEvEIZ41aGg7pXsDzb4tQ4LHk9on4k5fp
 bS/ckbZZMTQWeQtRB5QcXLj1LCSWG+eSTJvj3quXm+K73sAb7RvwaNOmqp5q7KxUd4BV
 kvWw==
X-Gm-Message-State: ANhLgQ11TwVktjl6Hi7VwnqVZX0KTj8jIzt0fLkNEneRslaj+vSYU531
 745tfWCjh8fyy+npNV+U9Vzwg6fB8Hk=
X-Google-Smtp-Source: ADFU+vuxRvr+XVlQPN2CCYBroj4o9wy36SDjEt82r6C38J7pi2WFQjTcnwLEu5Wji8idUPU2fXYQyQ==
X-Received: by 2002:a17:90b:370e:: with SMTP id
 mg14mr8778881pjb.16.1584720384226; 
 Fri, 20 Mar 2020 09:06:24 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id nu13sm5272745pjb.22.2020.03.20.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 09:06:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Coverity tweaks
Date: Fri, 20 Mar 2020 09:06:19 -0700
Message-Id: <20200320160622.8040-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only the first of these appears to be a real bug.
The other two are adjustments to help satisfy Coverity.


r~


Richard Henderson (3):
  target/arm: Rearrange disabled check for watchpoints
  target/arm: Assert immh != 0 in disas_simd_shift_imm
  target/arm: Move computation of index in handle_simd_dupe

 target/arm/helper.c        | 11 ++++++-----
 target/arm/translate-a64.c |  6 +++++-
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.20.1


