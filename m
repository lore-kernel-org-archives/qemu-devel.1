Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F1EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88262074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="kGYvFTnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88262074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGAV-0001g7-Di
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiG8o-000879-GC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiG8m-0003cX-IF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so3827139wmj.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j5UtYOhp6/GoKwnx2MtNQCzJMyI+rDSpVdvwADTk754=;
 b=kGYvFTndVUoixHaTQNiGWVM2XXFajezAKBT6qIS5cdyzyvuWXrGfLTaQCjavbfWcSi
 2gc2W7p/4twtfTuHe8v/E1REX3wWbLb1n/y0KnndLvZ/m+JnPk5WYowKvtwZ252FBoT/
 w/O5cqVuI7Pr+JuPkgrUZ7J1STszaPzHS2sxmBkRn/3fW8odmWsaOtDlzChI8fp67s4e
 mW4hy2fccC3idspT71qt3VoW26V2e1avwKtaTbmRD8uzTYgb9bZI2rVvfLyQZLJmXP26
 Hs/z4q7/NqBpM7UybZHUpVt+kA+fHPv7iAu4I1FFjX2yFWpvevVWJSASIUB92W4tf0Qw
 FyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j5UtYOhp6/GoKwnx2MtNQCzJMyI+rDSpVdvwADTk754=;
 b=Az0XnAKAYsaDTxqo/pY5PLEZ7XrCWdLi7HWt4aIA5cddye8/5zg3QjV/sKJxVI/qnT
 ymXy9pzUql6Z4hJ/Bwjcq+NyGgPqQUVn9SZsgvevIVwgR2RwjlcGdWj5+r0Dy3WDMxfH
 1QOENdT6KL0mtsUfVqb0lSv+eDiDrE0KH9y/IbKybuyr9FT11Dk5s9qhN+FQiIqTA9Rh
 iBjptFOl81ThCoTjzNTOWNq7fErHBmDQo7valqlkx00ZlCy0XWmjyYYoGtt800pV3V31
 oANaevUBnG3Iubju/FFbgaRW1MUsk3vkvTzUMInG4M5Gw6JqzBNXn2ofCBeGk0qSpSlg
 /tCA==
X-Gm-Message-State: AOAM532vcyxHNkECoXRBUuGJ+eg2M3nnUz46QESUI1eKW61F8kw4wTN5
 X8qm9BrAOYwzDc63xQoNo7mQj7xEOsGtPUFcXdojxEPnCTFHYXqDXx105FCEjHISMUzm/Q51T3Y
 YgyVwpbwU6w2kAhiBYeMJN2VjSJ+7B/Qm/3ClN8kINN69JWvjHiSQFCXss28hXiM3
X-Google-Smtp-Source: ABdhPJwdkiTUlIF8cTjGl0wamqSK8h8+iqWIRdpZS4jrHQXLR5yua+sbipFBHlfxlBQ3w/sQoOnTFQ==
X-Received: by 2002:a1c:2b01:: with SMTP id r1mr6905735wmr.26.1591616430263;
 Mon, 08 Jun 2020 04:40:30 -0700 (PDT)
Received: from vanye.hemma.eciton.net
 (cpc92302-cmbg19-2-0-cust304.5-4.cable.virginm.net. [82.1.209.49])
 by smtp.gmail.com with ESMTPSA id y5sm24225932wrs.63.2020.06.08.04.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 04:40:29 -0700 (PDT)
From: Leif Lindholm <leif@nuviainc.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [RFC PATCH 0/3] target/arm: move common aarch64 init to helpers and
 make cpu max standalone
Date: Mon,  8 Jun 2020 12:40:25 +0100
Message-Id: <20200608114028.25345-1-leif@nuviainc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=leif@nuviainc.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a follow-up to the thread that started with
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg01018.html

Most of the a57/a53/a72 init functions is currently identical lines,
with some individual options set up differently.

Some of that duplication can be considered to be likely to apply to
any (or at least the majoroty of) aarch64 processors to be added in
the future.

And finally, the "max" cpu init function currently calls the a57 one,
with some non-obvious side effects including:
- cpu dtb_compatible string set to "arm,cortex-a57"
- kvm_target set (to A57 value) in tcg mode
- id_mmfr0 containing a value present in real A57 cpus of the revision
  qemu emulates, but banned by the architecture specification
- emulating implementation-defined cortex cp registers

This series:
- Creates a common initialization function for all aarch64 cpus, which
  also sets up the MIDR.
- Creates a common initialization function for the cortex cpus defined
  in cpu64.h.
- Detaches the "max" cpu from the A57 init, making use of both of the
  above helper functions.
- Can definitely be split up into additional patches (especially 3/3).

Leif Lindholm (3):
  target/arm: commonalize aarch64 cpu init
  target/arm: move cpu64 cortex processor common init settings to
    function
  target/arm: use cortex...common_init for cpu64 max

 target/arm/cpu-qom.h |   3 +
 target/arm/cpu64.c   | 155 ++++++++++++++++++-------------------------
 2 files changed, 66 insertions(+), 92 deletions(-)

-- 
2.20.1


