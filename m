Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243DC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B41724658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMLMKixn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B41724658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irTS3-0002eC-8V
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 16:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irTRJ-00022R-DB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irTRI-0001Oc-5c
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:29 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irTRH-0001Na-VJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:28 -0500
Received: by mail-pf1-x441.google.com with SMTP id x184so7189096pfb.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 13:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SG9JeoFxep43iAJNgSRqAaEY4yiEwPdJOA63l9QRp0w=;
 b=AMLMKixnH9LeoCc6IifK57Nbi3GzHgdNvYZfClyIeYUkU1H5IBP59TqNB4GWoxox+2
 3mN/02EZRPGH8yxWv+UdEQkiky5mypIewF/JJeqaYq8WytAmXYYtRpR3xNZKpBHDevx9
 GPtQCSQiEpLM/6f2JdYGZpupkFAG3vtQem6fhf6zerOUn33P35UYH7H/LCR1Ylt9hqZd
 WAIUbMvohAkRKB7pbf1cfkpWrTA6LllauvyIXTcJXePndt8fFBvXLGQmDvzKib2JlNhP
 rAesem84NmmueEmVuWr4cW01C4Y2iFRO9iVsAON+wf4po/+hB8LrIHjNsfI8ylfj+xiM
 HMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SG9JeoFxep43iAJNgSRqAaEY4yiEwPdJOA63l9QRp0w=;
 b=owgG0ivyjYRo0GZ987N/1XhhD2I27MrdC8kOF2MdiZFYyNQnMBB2MlpYxhrJ+nUT9k
 itXiLQ5ZaEMCMphUxBkdMrHUvIplR6HeenVMHOsI1k0xER8Y/5QtGVXzn3fuLf/2NUJ+
 kt4QpfF0K9YK9PllwmPwmZWTuNurrtqVIFgx5YrZoh7o48h2NPAaTBtRwTnFZATvo/wc
 M4C8HUtSAS5Hc6j7NoIMLnHdSMwe77M4JO1qlmCi0xupSlFtQAUQpQXkPZm8aFzav9Ya
 POgFPMLyxLht7tFVqMaspXlgsyUR2wCOwGHTKS+FYoVxRk+z1KaMNS5EwrUJ276mkhZI
 kW1Q==
X-Gm-Message-State: APjAAAX507WIIouq29N6Lf0i/cnLTFVmO6dL4L/yrJgvnCoLU50YK5yz
 xTjmC9ySWhiU4iUC5O0mIfT2FDqRVD4=
X-Google-Smtp-Source: APXvYqzljqQOzlxmM/f67sV9Tt5VjjAnFlT2+0+6aBZA/1MvupV3A4HoPx28J410BElzx4WTivXF6g==
X-Received: by 2002:a63:5924:: with SMTP id n36mr29216564pgb.43.1579036166080; 
 Tue, 14 Jan 2020 13:09:26 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id d26sm17881020pgv.66.2020.01.14.13.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 13:09:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] linux-user: Implement x86_64 vsyscalls
Date: Tue, 14 Jan 2020 11:09:18 -1000
Message-Id: <20200114210921.11216-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: pbonzini@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The x86_64 abi has a legacy vsyscall page.  The kernel folk
have been trying to deprecate this since at least v3.1, but

(1) We don't implement the vdso that replaces vsyscalls,
(2) As of v5.5, the vsyscall page is still enabled by default.

This lack is affecting Peter's linux-user testing.

The dependency is not obvious because Peter is running the tests
on x86_64, so the host is providing a vsyscall page to qemu.

Because of how user-only memory operations are handled, with no
validation of guest vs host pages, so long as qemu chooses to
run with guest_base == 0, the guest may Just So Happen to read
the host's vsyscall page.

Complicating this, new OS releases may use a kernel configured
with CONFIG_LEGACY_VSYSCALL_XONLY=y, which means the the vsyscall
page cannot be read, only executed.  Which means that the guest
then cannot read the host vsyscall page during translation and
will SIGSEGV.

Exactly which of these many variables is affecting Peter's testing
with Ubuntu 18.04 of my TCG merge, I'm not exactly sure.  I suspect
that it is the change to drop the textseg_addr adjustment to user-only
static binaries.  IIRC bionic does not support -static-pie, which is
the preferred replacement.  This could mean that the host and guest
binaries overlap, which leads to guest_base != 0.

I vaguely remember someone (Paolo?) implementing something like
this many years ago, but clearly it never got merged.

In any case, this emulation has been missing for too long.


r~


Richard Henderson (3):
  target/i386: Renumber EXCP_SYSCALL
  linux-user/i386: Split out gen_signal
  linux-user/i386: Emulate x86_64 vsyscalls

 target/i386/cpu.h          |   6 +-
 linux-user/i386/cpu_loop.c | 197 ++++++++++++++++++++++++++-----------
 target/i386/translate.c    |  16 ++-
 3 files changed, 155 insertions(+), 64 deletions(-)

-- 
2.20.1


