Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A20A233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcmziD7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A20A233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0sLI-0006kT-5v
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 15:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0sJ6-0005Pr-2P
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0sJ4-0004PT-BB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:35 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0sJ3-0004OP-T4
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:34 -0400
Received: by mail-pg1-x543.google.com with SMTP id k3so4180651pgb.10
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Hgo7S5UIiUNt0ZBTjD+X0/y9Qgvm9bETayEs4h3pBGk=;
 b=kcmziD7lKB8oSctR/ifjuCLkJfpatpB6iRjIwBZ5UJcVoOaORjhEnOfdIGvANoXCXG
 lvVrKvUzgUehZGYHoqoJzsHNYxgwHv8SWl/1AD+m5aVTLBP3Z1zKFBYezdEpu8103T98
 xxydak3SNHlm34ipabsLFqQjrgsWHfO42tjviTX/SQRi4/DyiatghItILpGCeqxX/3X2
 nPd7psiph6M7Uoab7OA46zDgeMVNxUXeRd/gO1B5ZsPOBWMrhnMvN7eb2s+ra57BARmn
 CmIHKbTVY7b0OJUtovBItxcz1Us6NZdLxtAPUeL7uVKHvOgOA3SndC37i8S6cOeO9o2h
 yhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Hgo7S5UIiUNt0ZBTjD+X0/y9Qgvm9bETayEs4h3pBGk=;
 b=NgdH22UahHbWTpjiNsdywkbZRju3krxSFfcItJU12WaXgtJMChvC3pt6pxwRPjs9S3
 WW5XKKZ0eZ/b+edGy1Cuj6tB+3D5foHOa/VFVAigmuyi4p0BtcSoejcsXDR1SsiaZByV
 2XtVtXIKUXk/1/DPwzqJYoBEze0a3DN7k0nFZ/Gz+N1Ck8yTyhCXyDPC/ocFDvH2imrL
 iRBtb3HTOMJQn3NX1TmS7HwaSkS5eUZwkDk1jl2bR6rkiqN4c1sbR75y1SfWV3yIq8tm
 wuJg8vuUjnGkrKmFxWSEOSiicIZXGsoUtIz4jTAXclexQYyT7NfBNVX0eMn4sxMmtQ+o
 Db/w==
X-Gm-Message-State: APjAAAWzcO7dz3SFvybWUsd5kVkL9tO1fUcstZX2iuuTw8PiIGvuzVoD
 tjUjDzEBwTgq3VZnABB2i1j7pUZlq7Q=
X-Google-Smtp-Source: APXvYqz4DkdxhcPyMG6bRpAMczViSX8CCmjBtOzH3EoLA0VVVFwmPU4pJmYXSNsqv/5qwr6dYhvp/A==
X-Received: by 2002:a17:90a:2c9:: with SMTP id
 d9mr1197473pjd.134.1566500371651; 
 Thu, 22 Aug 2019 11:59:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z14sm287172pjr.23.2019.08.22.11.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 11:59:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 11:59:27 -0700
Message-Id: <20190822185929.16891-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 0/2] linux-user/arm: Adjust MAX_RESERVED_VA for
 M-profile
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is inspired by the discussion in

   https://bugs.launchpad.net/qemu/+bug/1840922

Previously I suggested a new CPUClass hook, but when I went
to implement that seemed like overkill.


r~


Richard Henderson (2):
  linux-user: Pass CPUState to MAX_RESERVED_VA
  linux-user/arm: Adjust MAX_RESERVED_VA for M-profile

 linux-user/arm/target_cpu.h | 24 ++++++++++++++++++---
 linux-user/main.c           | 43 +++++++++++++++++++++----------------
 2 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.17.1


