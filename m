Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8164C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F85D2171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAoBCUIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F85D2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw15X-0001ox-UM
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13o-0005x8-SB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13n-0007YF-QI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw13n-0007Wr-GT
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id z23so4968170wmf.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eh67ZN+wSqNIEm1UhPEvUSAm2SqaYFM25aW3NNCzhgg=;
 b=bAoBCUIN9HoMrBqO6yu6WcJKfRSyMJVYp8id7TP6ybU2pFyciaQ2NwZXDfiQ48mIKR
 1ZRwtGilXxSwTJ0l60dsMKGxGfLDme6DHSa8TvYJlW9LnoqLaKyQhowZQVe7KUzCmszX
 BzHJhZ9VHmSTVfpHCQsoX7v9FFQMiA+qVOQEvnAzeyeXGM8/fvXWZsVkCkCVHOVHdRNa
 Xo1cqwhS+Zmny6b9b0E9t6/uh5YwkNqNJj2SjzLGM2Wh3k7sSPIYKPSWaqXWfb8HWOcZ
 tbDYGgb6xMkiP4KHMHUbPMI22drFnScJ4KZRA2lePJZTUxu2ucFcAkmCSgJGnjRvxTpl
 QKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eh67ZN+wSqNIEm1UhPEvUSAm2SqaYFM25aW3NNCzhgg=;
 b=jgzWDeCccOnJDr5hGRmL/pgu7mCLfMQ++7FCC9nWaphmbwoAXIp1ps/klCxkB+FLGY
 toeF0xXlJSWqrehdvkBBVjon1v3K3NAVSTufLpK8oMolcYT0dzhyedmThSF9iHU1Raav
 LG63AXnck5GhR6okcQ385xGaLZIGh4emuLIBMw2BFbmSTZhQh5M89YbYSxSepeRnni9z
 nBXwyFWszkKctESUPdhpLVylMWeIpXh4V8tWOcgjKBv333LJ5gmz+rmKJBaCrVyt7OOv
 HaXiGSgTTVmhrhj5Al+c+/Dl4k2gOHHBZSEwjMTHhAqDTwyLItvtI0JKt1i0yUYkZeYV
 /jVQ==
X-Gm-Message-State: APjAAAWzT9nNofJ3hd8jWoJzarJ65TQgR3FRVZq1Qtw8oBry0/V3y1IL
 QuyVPB/IY1nqWumiKVuqPoctLw==
X-Google-Smtp-Source: APXvYqzPcjxZ6stdGd+cA3QMhGLNIdHioTUM3wmLN4+tr/vK+u9Kk3WZGdGeA6GYWrryEIg3+rY4Pg==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr9660599wmj.155.1565342381928; 
 Fri, 09 Aug 2019 02:19:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x8sm3771593wmc.5.2019.08.09.02.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:19:41 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E05981FF87;
 Fri,  9 Aug 2019 10:19:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 10:19:33 +0100
Message-Id: <20190809091940.1223-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH  v2 0/7] softfloat includes cleanup
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

Here is v2 of the softfloat headers cleanup which addresses Richards
comments from yesterday.

The following patches need review
   01 - fpu move LIT64 helper to softfloat types (1 ack)
   03 - fpu make softfloat macros self contained (1 ack)
   05 - target mips rationalise softfloat includes

Alex Bennée (7):
  fpu: move LIT64 helper to softfloat-types
  fpu: move inline helpers into a separate header
  fpu: make softfloat-macros "self-contained"
  fpu: rename softfloat-specialize.h -> .inc.c
  target/mips: rationalise softfloat includes
  target/riscv: rationalise softfloat includes
  targets (various): use softfloat-helpers.h where we can

 ...pecialize.h => softfloat-specialize.inc.c} |   0
 fpu/softfloat.c                               |   2 +-
 include/fpu/softfloat-helpers.h               | 132 ++++++++++++++++++
 include/fpu/softfloat-macros.h                |   2 +
 include/fpu/softfloat-types.h                 |   2 +
 include/fpu/softfloat.h                       |  65 +--------
 linux-user/mips/cpu_loop.c                    |   1 +
 target/alpha/helper.c                         |   2 +-
 target/microblaze/cpu.c                       |   2 +-
 target/mips/cpu.h                             |   8 +-
 target/mips/internal.h                        |   7 +
 target/mips/msa_helper.c                      |   1 +
 target/mips/op_helper.c                       |   1 +
 target/riscv/cpu.c                            |   1 +
 target/riscv/cpu.h                            |   2 +-
 target/riscv/fpu_helper.c                     |   1 +
 target/s390x/cpu.c                            |   2 +-
 target/sh4/cpu.c                              |   3 +-
 target/tricore/helper.c                       |   2 +-
 target/unicore32/cpu.c                        |   1 -
 20 files changed, 157 insertions(+), 80 deletions(-)
 rename fpu/{softfloat-specialize.h => softfloat-specialize.inc.c} (100%)
 create mode 100644 include/fpu/softfloat-helpers.h

-- 
2.20.1


