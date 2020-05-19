Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E46C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4495B206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDQwfi7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4495B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8BM-000372-AL
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb8Ac-0002Br-9q
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:44:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb8Aa-0002FA-UC
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:44:57 -0400
Received: by mail-pg1-x541.google.com with SMTP id s10so323088pgm.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RG3hI9oqiS8E92zFf8hbgJUm1VaZnqdP6j+3nmOYRfU=;
 b=YDQwfi7S7pysnK5IATP1Og2ieOJ3PjnUw6unbt4E14KqIbpl/VhtSNNXaytxGn7DJY
 2bWEU7/5MtslSqOnPUwj2YQUy5sh3m7Uceq2C/YwNgdM14tYWUKM3ip2mPdGydEfPZ6M
 AE4OXPXjJMEIZ/IQJ9N11/kPiROBHRVePySQgeQOQ/F8SY8VwVyX7TvsXwJ4zpWylEg6
 U9xeulFSNnEfkPIxqUuEBn89byJgCirBmsYOK4xpE7jcedMlibsDJ5MK65+qgp+/dUnF
 H5oZCm8ROmoLr00oEZcMwU8gtcmBVTQvdBFLgW1oWouAiwI63ASjgW34+2rsD5O0kbLO
 lUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RG3hI9oqiS8E92zFf8hbgJUm1VaZnqdP6j+3nmOYRfU=;
 b=oNDhCl8g/Zt1Ul14hJuXsegQ7DKueBCE3RwYgBXkl1V2+QCIujZonxv+up7cXc2MAP
 JreIzfbBQiICp26M/vdYOnC7Bg269nWnq1JAuQ4EoRPhFFuZc+iL4Gkyyzz2cuop1/fj
 qoTZPgEZoL6Mnu02xc+ol0TNrAT58u1bdSR7dq6OvKMFL38adLm0sF/yr7PYVqkZuY74
 sLOJSa0OXRKXye3L5JDO5pbKux+49pdfFpiCSNiGEORVN7hJYYmjGGLbJYI76DqjzGeq
 Us4g4au72FsCKITp5VOdCU6BC557SZndu0ULK4JOWhJ+40BsX2KHsHjtNj7FCdIbmhQC
 I/Pg==
X-Gm-Message-State: AOAM5332rrHOidKyKPYt1t1RPVen3Lh8L+ZbSl3aGIC+qOxrCpPh4XFm
 QfhCJIAcAvigB2825gHgjuLErPhXbVY=
X-Google-Smtp-Source: ABdhPJykMLrph6FairaPz7GDLk11/eEv5Qfp5P0qemTJRtIhl+eBgUVZ1mDUh2zIdGdokg+O9y8Riw==
X-Received: by 2002:a65:4487:: with SMTP id l7mr758935pgq.221.1589917494980;
 Tue, 19 May 2020 12:44:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm285744pjj.33.2020.05.19.12.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 12:44:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] linux-user: Load a vdso for x86_64
Date: Tue, 19 May 2020 12:44:50 -0700
Message-Id: <20200519194452.9009-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The subject of AT_SYSINFO came up on launchpad recently.

There is definite room for improvement in all of this:

(1) We could build the vdso binary into qemu instead of really
    loading it from the file system.  This would obviate the
    several problems of locating the .so file.  It would also
    mean that --static builds continue to create a standalone
    qemu binary.

(2) We could use our cross-build system to build the vdso.
    Though we'd still likely want to keep the image in git
    along side the other rom images for when cross-build is
    not available.

(3) There are some ??? comments where some decisions could be made,
    and other ??? that are merely commenting on weirdness.

(4) It shouldn't take too much effort to create vdsos for the
    other architectures.  But we should get this one as clean
    as we can first.

Amusingly, this patch set has just turned 10 years old.
First posted April 4, 2010.  I don't recall ever seeing
any review on the several postings over the years.


r~


Richard Henderson (2):
  linux-user: Build vdso for x64.
  linux-user: Load a VDSO for x86-64.

 Makefile                  |   4 +-
 linux-user/elfload.c      | 203 +++++++++++++++++++++++++++++++++++++-
 pc-bios/Makefile          |   5 +
 pc-bios/vdso-linux-x64.S  | 115 +++++++++++++++++++++
 pc-bios/vdso-linux-x64.ld |  81 +++++++++++++++
 pc-bios/vdso-linux-x64.so | Bin 0 -> 7500 bytes
 6 files changed, 401 insertions(+), 7 deletions(-)
 create mode 100644 pc-bios/vdso-linux-x64.S
 create mode 100644 pc-bios/vdso-linux-x64.ld
 create mode 100755 pc-bios/vdso-linux-x64.so

-- 
2.20.1


