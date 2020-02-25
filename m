Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3880FC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A152072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYRpWbc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A152072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dFj-0000PF-7R
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6dDf-0005sj-4K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6dDe-0004Lf-65
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:03 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6dDd-0004L0-8n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:02 -0500
Received: by mail-wr1-x42f.google.com with SMTP id w12so15532036wrt.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sD/qPlf4vUdHw1Xk0sS8bF0iY4OPu1u1kkvdhxNUD34=;
 b=mYRpWbc3u9pXI2/1GRaeXQkQPW+x+cBGklE95dLOH7EyW9/7DkkNOA3nXxs6KASt0+
 KA4LEeVR9kgBh8ZqGIKf72PB0YxYyrIUxzII1qgZOihHcTcLijGo5oBNunpzJb/L3C/i
 W8YM/qDX5NuDxPv02C42loEXPf8iKxn0wkksIIUs6XWzeqo/2fBHVk/wgb3pFyz91s4w
 15I/f5F5Eq2MB5RHDSb8ckpcP0vbdRSwF/AZMxXkGsOAYIDduTlS8HPIs2avFLrestB5
 igV6B5Ppc1nbzVaoP5vje6iIoGWzVDJ7WwGYuqSxVrAhYqyuMgErgA1cc1tDuYVvu8oa
 n1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sD/qPlf4vUdHw1Xk0sS8bF0iY4OPu1u1kkvdhxNUD34=;
 b=XGNqjz+9uF3fgCpL8BslFOV6IptBpCGIMwC/SVtwGjzEE2UxisnD5DLSp8f/SSc7oF
 l2GWqGoewWeet52qZeI0ELsY1K6/gcA0WPJlosQuZQUQFrzm3Ibr3GbQyioRGzwyfsRC
 ZmO95d4w/8GG6csHzDryU6ZIhPAglnkfRhivTCPeiengaqJzMo9+4RSlxfxm5ChFRQM3
 2rVYpxDnQlb9ZA14q+gIxSXNt72nNvZsmwmuoz0U1aa1r3NJ9P/+CXSgjLZv77CwvMSK
 CNjEQ9vWWnyroJpurSWqS7FCyiCUj5gvByh75ph93uaC1pHHB+u55s/WwfFx8R4f5s/p
 sKbA==
X-Gm-Message-State: APjAAAUXTQBgQuieC7QqWx03AKIYTpkZBeCbOwRQD0v99SIUxNMfbz/w
 jz1TRoI74zWPR4pgUS9WZsdJPuju
X-Google-Smtp-Source: APXvYqzIsEUvs2m3/X5y+m5LKn7WE6OFdG21ZTaESsWU5PhJWWbiRErHmwWrW9zgXASDlIl1iZXe9Q==
X-Received: by 2002:a05:6000:114f:: with SMTP id
 d15mr37454wrx.130.1582648679566; 
 Tue, 25 Feb 2020 08:37:59 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id q6sm18171398wrf.67.2020.02.25.08.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 08:37:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] qemu-doc reorganization
Date: Tue, 25 Feb 2020 17:37:54 +0100
Message-Id: <20200225163758.12996-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prior to rST conversion, reorganize qemu-doc so that PC is handled
like all other targets and there is a generic "system emulation"
chapter.

This conflicts with the docs/system/cpu-models.texi conversion to
rST, but I would like to have a review for the third and fourth
patch while that conversion is finalized.

Paolo

Paolo Bonzini (4):
  docs: system: remove target OS documentation
  docs: system: split CPU models doc between MIPS and x86 parts
  docs: split qemu-doc.texi in multiple files
  qemu-doc: extract common system emulator documentation from the PC
    section

 Makefile                                      |   11 +-
 docs/system/cpu-models-mips.texi              |  200 +++
 .../cpu-models-x86.texi}                      |  232 ---
 docs/system/gdb.texi                          |   71 +
 docs/system/images.texi                       |   88 +
 docs/system/invocation.texi                   |  240 +++
 docs/system/ivshmem.texi                      |   60 +
 docs/system/keys.texi                         |   53 +
 docs/system/linuxboot.texi                    |   27 +
 docs/system/monitor.texi                      |   35 +
 docs/system/mux-chardev.texi                  |   51 +
 docs/system/net.texi                          |   96 +
 docs/system/qemu-cpu-models.texi              |   28 +
 docs/system/quickstart.texi                   |   13 +
 docs/system/tls.texi                          |  329 ++++
 docs/system/usb.texi                          |  115 ++
 docs/system/vnc-security.texi                 |  196 ++
 qemu-doc.texi                                 | 1572 +----------------
 18 files changed, 1668 insertions(+), 1749 deletions(-)
 create mode 100644 docs/system/cpu-models-mips.texi
 rename docs/{qemu-cpu-models.texi => system/cpu-models-x86.texi} (71%)
 create mode 100644 docs/system/gdb.texi
 create mode 100644 docs/system/images.texi
 create mode 100644 docs/system/invocation.texi
 create mode 100644 docs/system/ivshmem.texi
 create mode 100644 docs/system/keys.texi
 create mode 100644 docs/system/linuxboot.texi
 create mode 100644 docs/system/monitor.texi
 create mode 100644 docs/system/mux-chardev.texi
 create mode 100644 docs/system/net.texi
 create mode 100644 docs/system/qemu-cpu-models.texi
 create mode 100644 docs/system/quickstart.texi
 create mode 100644 docs/system/tls.texi
 create mode 100644 docs/system/usb.texi
 create mode 100644 docs/system/vnc-security.texi

-- 
2.21.1


