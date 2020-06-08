Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A86BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311DE206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clLVhiux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311DE206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKqo-0006zw-Bi
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnC-0002AX-LY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnA-0005tg-TB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591634311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TSMddJzpjn6Vllp7XpbKx/dlCGcBtr406MPEN8/b55E=;
 b=clLVhiux32C1dhe8pVn0qtV1oME5qwfm1g1Z4UVxvaxLnZ4KBglQanaJdUvi9kevqJxEGJ
 D3OhHpIGEdLMWVoY6ELZe7xsxPOWmlHFgwp30PmX20rE00jD+SOJvMirMZiKc9AlGMqcMM
 LaannkjdsoFUFf7ylUstcRF7EUej8Fg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-_sPaISNhOQyCGgiyu5_s0g-1; Mon, 08 Jun 2020 12:38:27 -0400
X-MC-Unique: _sPaISNhOQyCGgiyu5_s0g-1
Received: by mail-wr1-f70.google.com with SMTP id h6so7436222wrx.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TSMddJzpjn6Vllp7XpbKx/dlCGcBtr406MPEN8/b55E=;
 b=XmehsWcluEmJfVomqa3p1JINfzW41IMa4nYsaHKIDy8QExLBZWYi4OCekhCWpYJjjH
 RkyOwcFPeNLHtJ3noNdxDSbEB5BiT5o5LCq9edbRPAShs6JDIhfLHnAy2oaOMipzIAkr
 /fWuWf44HsP6CJYJ70y50Y9CxMJmUL2rPTnN2ZrYH2GOUKxOZu29EVbFRzc4L1NI3ZPB
 FWNEPxlWt5g92CYu+wfiR/xDAQDJxt/TRjiphlHZ7hVzormk12DAVFp23q5N9ns5mIJ9
 bpK33cGpwEuDqMnpAB6/6EpvbeXZmSKlpgc3fS6thrT6kfH2q4pUOd58RrU838u1IeTB
 yvRw==
X-Gm-Message-State: AOAM530OLRGnW8tR/uQkYVkY5YNOn3yxm2mppTqpcoFg4AQgDEi9aCEI
 AkisKOQwm9RaAshoS1nyPiwyN5Tf8Mt13p9BUK6HlliEITny1cp2KD+51w6d/O+ova4IIUAsYlZ
 8GdJau+47XKgRh/4=
X-Received: by 2002:a5d:4490:: with SMTP id j16mr26508058wrq.276.1591634305814; 
 Mon, 08 Jun 2020 09:38:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxmnVlkiGKupRNLBgU4otljYooVEn6Z9gAzyFNFP7HHHgpNnb9IhcuZMbf9VC88JHVRO6vtA==
X-Received: by 2002:a5d:4490:: with SMTP id j16mr26508041wrq.276.1591634305570; 
 Mon, 08 Jun 2020 09:38:25 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b14sm79707wmj.47.2020.06.08.09.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:38:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/10] accel: Allow targets to use Kconfig
Date: Mon,  8 Jun 2020 18:38:13 +0200
Message-Id: <20200608163823.8890-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


