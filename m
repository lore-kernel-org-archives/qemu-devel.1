Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF8AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FF720748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKu9c7uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FF720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrQw-0006iJ-RJ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrLo-0004Ks-2l
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrLh-0008IU-58
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=guRcykgqBUf/uuxJ52t2kwsJO8KdY5hMp8f0NDASSU0=;
 b=cKu9c7ucQZ+W9ocV19E5dxzSpGxg/BJqOrcZIZv+Tm094d1Xsqd6RPw57LmyIqogiyT2oz
 0E5zitOgN5mx06XZpRbDIcJqMSKzCVqlDGfmg48Xplvy+q2BfUCtLDxKXBOQOh04OLLpTO
 PHa+y5nypRkIOEz9Bi4XiKJ9CKM2V2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-2_64jg77NI6Vjlp7bTzYXQ-1; Thu, 21 May 2020 15:59:16 -0400
X-MC-Unique: 2_64jg77NI6Vjlp7bTzYXQ-1
Received: by mail-wm1-f70.google.com with SMTP id l2so3087201wmi.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=guRcykgqBUf/uuxJ52t2kwsJO8KdY5hMp8f0NDASSU0=;
 b=t74EDhQp7sCQzJUE5JZIFNoJeERNh82ArtmRwRTWmfWZjMy/aR+gB/eg4a7HT1xMjc
 +xdijLCXwXtQA8qJYBMK2xMQhKRfYC0jleOiGJNxz6DkfanSJJcX1sJqwRVlkwOCMI6/
 0lyGTzRvN5etI1LlN9vj5d5Kxo7YqaRlOrTjEZWMEAv1bG2nvcUXwM1uEFHAkuorJfNq
 L59NUp0hAB5Jhsln8jDpQCac4V+Vw/Aih+B4f//1TKmQ6yl8po/sLNZacgI9RTKgUfSc
 NssoOq93MhjO6eA8H+FYeiZNQP6jLClzrWt9c1BzBSbFvjukipf4QGFWugm7KYaJBIz9
 3Rfg==
X-Gm-Message-State: AOAM533Jk/bJ4cwJUqiRAfG1ZhhTvrlW3Mi098VE2VMdLnrntZOMN7gq
 59D6Dul6GLJGQzkdFuOFbTdMD+HmrHvQ8ob+SB/dJwosWWEzvQeF2gD1yW4LijDMm8DQW6p1eBA
 ps10nfXCc2WlEU8c=
X-Received: by 2002:adf:8041:: with SMTP id 59mr215565wrk.278.1590091155007;
 Thu, 21 May 2020 12:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc3hVTKc/Qtox4biKZbXuH5ZWECFJX98tmcBQ+e5NAjkjfbKYU2ze4WONqRKcqmiBIpmU7lA==
X-Received: by 2002:adf:8041:: with SMTP id 59mr215534wrk.278.1590091154541;
 Thu, 21 May 2020 12:59:14 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id e21sm7338181wme.34.2020.05.21.12.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:59:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/11] accel: Allow targets to use Kconfig,
 disable semihosting by default
Date: Thu, 21 May 2020 21:59:00 +0200
Message-Id: <20200521195911.19685-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missing review: patch #9 'rules.mak: Add base-arch rule'
and patch #11 'semihosting: Make the feature depend of TCG'

This series include generic patches I took of the KVM/ARM
specific series which will follow.

- List orphan accelerators in MAINTAINERS
- Add accel/Kconfig
- Allow targets to use their how Kconfig
- Enforce semihosting on architecture where required,
  disable it elsewhere

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

$ git backport-diff -u v2 -r v3
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/11:[----] [--] 'MAINTAINERS: Fix KVM path expansion glob'
002/11:[0002] [FC] 'MAINTAINERS: Add an 'overall' entry for accelerators'
003/11:[----] [-C] 'MAINTAINERS: Add an entry for the HAX accelerator'
004/11:[----] [--] 'accel/tcg: Add stub for probe_access()'
005/11:[----] [--] 'Makefile: Remove dangerous EOL trailing backslash'
006/11:[----] [--] 'Makefile: Write MINIKCONF variables as one entry per line'
007/11:[----] [--] 'accel/Kconfig: Extract accel selectors into their own config'
008/11:[----] [--] 'accel/Kconfig: Add the TCG selector'
009/11:[down] 'rules.mak: Add base-arch() rule'
010/11:[0002] [FC] 'Makefile: Allow target-specific optional Kconfig'
011/11:[0014] [FC] 'hw/semihosting: Make the feature depend of TCG, and allow to disable it'

Philippe Mathieu-Daudé (11):
  MAINTAINERS: Fix KVM path expansion glob
  MAINTAINERS: Add an 'overall' entry for accelerators
  MAINTAINERS: Add an entry for the HAX accelerator
  accel/tcg: Add stub for probe_access()
  Makefile: Remove dangerous EOL trailing backslash
  Makefile: Write MINIKCONF variables as one entry per line
  accel/Kconfig: Extract accel selectors into their own config
  accel/Kconfig: Add the TCG selector
  rules.mak: Add base-arch() rule
  Makefile: Allow target-specific optional Kconfig
  hw/semihosting: Make the feature depend of TCG, and allow to disable
    it

 Makefile                                | 15 +++++++++++----
 default-configs/arm-softmmu.mak         |  1 -
 default-configs/lm32-softmmu.mak        |  2 --
 default-configs/m68k-softmmu.mak        |  2 --
 default-configs/mips-softmmu-common.mak |  3 ---
 default-configs/nios2-softmmu.mak       |  2 --
 default-configs/xtensa-softmmu.mak      |  2 --
 rules.mak                               | 16 ++++++++++++++++
 accel/stubs/tcg-stub.c                  |  7 +++++++
 Kconfig.host                            |  7 -------
 MAINTAINERS                             | 19 ++++++++++++++++++-
 accel/Kconfig                           |  9 +++++++++
 hw/semihosting/Kconfig                  |  4 +++-
 target/arm/Kconfig                      |  2 ++
 target/lm32/Kconfig                     |  2 ++
 target/m68k/Kconfig                     |  2 ++
 target/mips/Kconfig                     |  2 ++
 target/nios2/Kconfig                    |  2 ++
 target/riscv/Kconfig                    |  2 ++
 target/xtensa/Kconfig                   |  2 ++
 20 files changed, 78 insertions(+), 25 deletions(-)
 create mode 100644 accel/Kconfig
 create mode 100644 target/arm/Kconfig
 create mode 100644 target/lm32/Kconfig
 create mode 100644 target/m68k/Kconfig
 create mode 100644 target/mips/Kconfig
 create mode 100644 target/nios2/Kconfig
 create mode 100644 target/riscv/Kconfig
 create mode 100644 target/xtensa/Kconfig

-- 
2.21.3


