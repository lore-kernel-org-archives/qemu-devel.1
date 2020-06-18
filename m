Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E84C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C5220707
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzPzMUDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C5220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltku-0005TP-Lp
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltjv-00048i-J9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:33:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltjt-0004k6-M4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ec3+6rIYnweISsqXobwB8UQ1YAERHYVXDDrU6cMnaY0=;
 b=EzPzMUDlDEUNxZ5Bf1vnnfg6/iOFQXAkM34+I6n7xQyusjPP7xm1x3eC/kjYDmD/7QnyAG
 Q8A8f4st5MUX0dE5gt/l0bQ5LnPhRELUiCbm7wQ9j3+nYmJX2LcIXVH0do9EC8m3fv0otr
 a01yDiTW+XxcQmzh2tg90CB3fQTnaTg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-DSEOySQEM0uUuooP3np2ZA-1; Thu, 18 Jun 2020 08:33:46 -0400
X-MC-Unique: DSEOySQEM0uUuooP3np2ZA-1
Received: by mail-wm1-f71.google.com with SMTP id u15so1742234wmm.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ec3+6rIYnweISsqXobwB8UQ1YAERHYVXDDrU6cMnaY0=;
 b=en4uKi5SVVym1mCy0GvCIKYSfxUMEz0gyFWAWsyz7W7rnUftCXt8PpsaWZUgouRroL
 +OT2yvjcFDwBVB/LV47mxfK3+12B42HOqqENlH09EXRFrHD6+j9+Mo/ceM9SMwYz5cCF
 gRc2ZMR28OZ67LlNt087GzkjbCDTw8lmGsee23M8i8e2gall6v7wxuRBAeycgLwcBRqm
 /3In8DFB3nG5EM5lwq/X/4I26J7LHdUym1w8uLA0p9JzkeMAWn/ybvSJSwFADqzshBVD
 esH61+0Wzohew1eQtqHZtqJrUdiSXT0JLURgj8ZCfgmVhZLd29XxPswxg/7DarJP6u3b
 TtSg==
X-Gm-Message-State: AOAM533+oUAITruKTd1dED4/fWPM9IUaIkY0P9L2VDGvCpioaJliIAeq
 wgZXKWxmiYNCDSTMTMZvgXDa/CWifPhhjc5HgzFvep6r+sbla9rpfUPT2E9JMxAvYaTteXRp7N6
 WKHfzb2MB/ClRHKE=
X-Received: by 2002:adf:e44c:: with SMTP id t12mr4209665wrm.181.1592483625282; 
 Thu, 18 Jun 2020 05:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg4JV2c3qlpEZj+xzkoaQYb7B1L4eVfD2Z+w/QXAOC6Aqj5B8x6mEJV2UlbdVK+Jg0N7gWvQ==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr4209649wrm.181.1592483625027; 
 Thu, 18 Jun 2020 05:33:45 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id a3sm3357148wmb.7.2020.06.18.05.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:33:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 00/10] accel: Allow targets to use Kconfig
Date: Thu, 18 Jun 2020 14:33:32 +0200
Message-Id: <20200618123342.10693-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missing review:
- 03/10 MAINTAINERS: Cover the HAX accelerator stub
- 04/10 configure: Generate rule to calculate base arch of target

This series include generic patches I took of the KVM/ARM
specific series which will follow.

- Update accelerators in MAINTAINERS
- Add accel/Kconfig
- Allow targets to use their how Kconfig

Since v8:
- Fixed typo in patch 10 (Stefan)

Since v7:
- Generate base-arch() (Alex)
- Do not deprecate HAXM

Since v6:
- Fixed typo 'startwith' -> 'startswith' (armbru)

Since v5:
- Fixed typo in patch #4 subject
- Added David R-b tag
- Stripped --- comments

Since v4:
- Addressed rth review comments in rules.mak

Since v3:
- Fixed base-arch() rule (rth)
- Dropped 'semihosting: Make the feature depend of TCG'

Since v2:
- Addressed Thomas review comments
- Fixed problem when including TARGET instead of BASE_TARGET

Since v1:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html
- Drop HVF MAINTAINERS patch (merged elsewhere)
- Kconfig-select SEMIHOSTING (bonzini)
- Drop user-mode selection patches
- consider m68k/nios2/xtensa/riscv (pm215)
- reword Kconfig SEMIHOSTING description (pm215)
- reset some of rth R-b tags

Previous RFC for semihosting posted earlier:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg631218.html

Alex Bennée (1):
  configure: Generate rule to calculate the base architecture of a
    target

Philippe Mathieu-Daudé (9):
  MAINTAINERS: Fix KVM path expansion glob
  MAINTAINERS: Add an 'overall' entry for accelerators
  MAINTAINERS: Cover the HAX accelerator stub
  Makefile: Remove dangerous EOL trailing backslash
  Makefile: Write MINIKCONF variables as one entry per line
  accel/Kconfig: Extract accel selectors into their own config
  accel/Kconfig: Add the TCG selector
  Makefile: Allow target-specific optional Kconfig
  accel/tcg: Add stub for probe_access()

 configure              | 19 +++++++++++++++++++
 Makefile               | 15 +++++++++++----
 accel/stubs/tcg-stub.c |  7 +++++++
 Kconfig.host           |  7 -------
 MAINTAINERS            | 14 +++++++++++++-
 accel/Kconfig          |  9 +++++++++
 6 files changed, 59 insertions(+), 12 deletions(-)
 create mode 100644 accel/Kconfig

-- 
2.21.3


