Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C015C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B1F2082C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufr3j0Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B1F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjqD-0001sq-Ri
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbjhe-0007wX-7b
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbjhd-00075b-9G
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbjhc-00074N-Rk
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id 22so1828237wmg.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G4iI4xbE++btRAKqNuYcXwMPUFwpVIy3rzD2DOH8RuI=;
 b=ufr3j0GetZWdwGkwSW8r8oA2ZQxw6qaTnohIUoNWl2sVT8tbRL6l3zJ3rOPTDSr1CQ
 JBuz2HvEUj+bmLVVWSxJijMdBxldd629mMY/w+4hLT1c0Bz+7trW9QVShH3CGySf8lZs
 Rfbtem3Jv8n9o9zqWhQMlqO62yj7sQb52qf2PB9p9uVz5zSu3QTn6vaxz5OcZwCSymdJ
 ddgbC9ia6j97+wNGtWtN4yY2jCSkqwqP1QGpMdtPFxkQscnZ8rfFhKsRRzaOYfxanjpg
 UpIaTLesalFbF/vHD2mlQDxy9j6Iab5qQZCtiOnKExSZrspyMrCJOP2wgkIUcgaSJlj+
 Z9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G4iI4xbE++btRAKqNuYcXwMPUFwpVIy3rzD2DOH8RuI=;
 b=faxfZbAK20WlN62gjDRQ5XsJim9UPQYMYIISNqwfi+mTK9o0UfUD5PREUyI/dT4O1c
 O/+5rZjVigwjynk7mxXwFf/MRAqPkQAj6bh9NWwr2Mqic8mSLSpEWrUSsxTFJvyy63rj
 npeTLD8k1ZofFle2ws6bpJvBHDDA/6LLktAwnqgkj4Rd+FMIrYNGeUWyYiLxXwYOboAR
 xN4sX9caHOakoxI7lpMykW4Y397YOuM1/9v6PMrB3bhyk2UnyLkvMj7n77KKJUO+YaSP
 6IquTAnMQJ1efT6F5ql1PYGmI1v3NKuJ2dak92BMtw7bEc2OKVqFhuiQYyww5lrmgGcv
 hPsQ==
X-Gm-Message-State: APjAAAXk5jF1ScQkVh4nm0XaExwTcw93URx38e8OhNBpFAJqKnrRRNot
 5T7VpUwu1R0r508AIGNkLyq58A==
X-Google-Smtp-Source: APXvYqwoDVP0lyw5KxwZrlbVctjO8dnZbgIkcVhifknPd3UeiHddwith4nux6EMmnCmRM1F64/iQPw==
X-Received: by 2002:a1c:f512:: with SMTP id t18mr7301111wmh.47.1560509099255; 
 Fri, 14 Jun 2019 03:44:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y24sm2091238wmi.10.2019.06.14.03.44.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 03:44:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 11:44:55 +0100
Message-Id: <20190614104457.24703-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Support single-precision only
 FPUs
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Arm architecture permits FPUs which have only single-precision
support, not double-precision; Cortex-M4 and Cortex-M33 are
both like that. Now that we've refactored the VFP code to use
decodetree it's fairly easy to add the necessary checks on the
MVFR0 FPDP field so that we UNDEF any double-precision instructions
on CPUs like this.

The first patch fixes some no-visible-effect typos in the
names of struct arguments to some functions (caused by
cut-n-paste errors); not really related but I noticed them
while I was working on this.

thanks
-- PMM

Peter Maydell (2):
  target/arm: Fix typos in trans function prototypes
  target/arm: Only implement doubles if the FPU supports them

 target/arm/cpu.h               |   6 ++
 target/arm/translate-vfp.inc.c | 112 ++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 14 deletions(-)

-- 
2.20.1


