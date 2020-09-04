Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A19C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124462074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcAflwNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124462074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDro-0006b7-5n
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEDqk-0005I5-CS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:42:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEDqi-0006vl-MI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:42:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id u18so6470689wmc.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ijN8C9uYRScuOtrUptbu5atVjFcf+AwMoQAbhDGOgh4=;
 b=jcAflwNmVZ5Z45l/259WzmZ4HAmPVLnoGp3Gh9y06vAkWAkeX37goO6UkyWF6Fz3qk
 du+ycr++JLmX5UWxi0xwHZALYnGZBXTDFn0F/imhevaRMWijlSV76IJHb/L5Fa3mf6DS
 9RHnfYcc4OxBS7OPaTPbeCZs4FV4NFF6BNLFbMRa96v4Hr8e+0xv+/04y6rOWvOLpaSb
 Alw7QJlixYS3kQt+s8pKbiIuKW6hcu4UOtNPDHinesEg//cjOx2lzYDJ31GX+jzYUTG/
 uv08Q15+/PeP2QUJMaKBuW987kbT+hN3n/S/AJ7ziVRq7YkhsXwevAUvQkzI4CfH3ffe
 6U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ijN8C9uYRScuOtrUptbu5atVjFcf+AwMoQAbhDGOgh4=;
 b=jKvTaGO4pzZE8vmQKFHx0G+A6srz0wW2iyVVV3YXkoAAquqNHPk3fDWq4RlnlEiPeh
 gbeHpkewU+7Yw9IBbDXTMzwmDRXYaN573kWsv1cLLiAdb/G7Ohg7Evoor2hYf8fpBphQ
 M69sn8VG9IqhXJjTzfKTJQbqJttlYUpiKOKNfykDlEc9vqbnBDjNwkOOjdxD+vtCiGvk
 nAUh3szNAbTWztrwg7fzTCkIRoYmRys/FUCi4AZJyiezX/fKgt5g4i8J8y9X+/hg0hCu
 AkTibwfekGICvnWLwTu5cJe8KFM79FCeRXVd3+82LGSMYl+jfRWU0tRfx7b1bdUKzm0D
 PW/g==
X-Gm-Message-State: AOAM530p46RVtMEf/baZifqjxVBg5GUouYkqoG2OiWxpUZ/atFeS/L+X
 4K3c1RVqMKMhREWFGTaC5SOIpVYca1ymKq8i
X-Google-Smtp-Source: ABdhPJxeGk1ofLImKOO3yJPNHln5xxWZ+c9M/HPZiH0SkKUCPsfXk1WV5z8YaRZtqisBdA0ik9/8mQ==
X-Received: by 2002:a1c:105:: with SMTP id 5mr8676359wmb.83.1599234118890;
 Fri, 04 Sep 2020 08:41:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f14sm12723743wrv.72.2020.09.04.08.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:41:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] Remove KVM support for 32-bit Arm hosts
Date: Fri,  4 Sep 2020 16:41:54 +0100
Message-Id: <20200904154156.31943-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset drops the support for KVM on 32-bit Arm hosts,
which we deprecated for the 5.0 release.

To repeat the rationale from the deprecation note: the Linux
kernel dropped support for 32-bit Arm KVM hosts in 5.7.
    
Running 32-bit guests on a 64-bit Arm host remains supported.

I split this into two patches, one which does the
fundamental removal of the kvm32.c code, and one which
tidies up some now-unreachable bits of code or #ifdeffery.

thanks
-- PMM

Peter Maydell (2):
  target/arm: Remove KVM support for 32-bit Arm hosts
  target/arm: Remove no-longer-reachable 32-bit KVM code

 docs/system/deprecated.rst |  16 +-
 configure                  |   2 +-
 target/arm/kvm-consts.h    |   7 -
 target/arm/kvm_arm.h       |   6 -
 target/arm/cpu.c           | 100 +++----
 target/arm/kvm.c           |   7 -
 target/arm/kvm32.c         | 595 -------------------------------------
 target/arm/meson.build     |   5 +-
 8 files changed, 56 insertions(+), 682 deletions(-)
 delete mode 100644 target/arm/kvm32.c

-- 
2.20.1


