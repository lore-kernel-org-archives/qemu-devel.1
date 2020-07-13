Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C1220738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+0FuobU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C1220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2j9-0003PK-JS
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv2i8-00026Q-Ah
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:57:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv2i6-00084Q-Ox
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:57:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so513432wmi.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Vbg5izYI34iu471XO9N3fvyaBGXDvlDeLjxYI4mvRCM=;
 b=u+0FuobU1Y3BTd3hEBc1kkmy2svengzkeVkGXZ8NMqG8lD+muXu76tpV/Ct9VQxUjr
 Q+snIzeXADa44BKIqam3k1gUzFcYgjtXANiruLPgpI2X03ZDUe13f9LKUlbIUnCsaf5M
 jmwnbriQudARFzocY4uGQapNgcbXllouJiMUIrKev0DTOQszf4CyQEp+35lF/gMYHIdu
 ewNpf9NXguuTH50gj4Uxt/EqF5o3J4XW0ikyn+cgGfEbEgDmgYXdLTZbC5JF1yvs9zVw
 M1nIIx6IXn2EMUL3sIXxwmyKplR1lnU7YI8/hsjbO899b2m+oqmP54zCO8XrSPRC13JO
 helA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Vbg5izYI34iu471XO9N3fvyaBGXDvlDeLjxYI4mvRCM=;
 b=h6iJjXxOQu9mAtl74gc7C401kV3Ctwz/tAKjyX7a3MHww/FvQRudacJmHhZiLAEAPy
 2oqZKjgk5jrPPvEG8fOnz77d96drTZ7mzeSR6PrH/SLivKl7VfcuXeap2ACczV/shAWo
 7fX+khNRYgNp02kC2zHn+0pGiLc2CSKjhSOsEKH5vUvssEtc45Gdn9PcyTCViMkG47yK
 Zar4HtW8D6jUcrA6Je4e6gS3leFTqOa5eSC5bBFSTpQr0+hQPW2ZnDhMtnd4KcROiFB5
 IGkqIhcgSQSiXyCyf6HBrgPWWK0xFyHD4QK1Bbgg86Tv/av7Y0dFnk2lWZD7IF3381Q0
 64+g==
X-Gm-Message-State: AOAM531FQJWOURf8DMBtYSJVqAN9C+Lk6xeovl8pgpKxzmJ9yuSJlZAT
 0GAe2jHDwB0digJiVq0Exy/o0x6J+H+1AQ==
X-Google-Smtp-Source: ABdhPJxagE2NiaWUMK8FKOY0It+glK4voBtoa9gsIvkqXQH5a9n4K8zKgkA6cuSKeIZYotc4kyaXxA==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr606953wmf.0.1594663068575;
 Mon, 13 Jul 2020 10:57:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j4sm25723721wrp.51.2020.07.13.10.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 10:57:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1 0/4] Document virt and a few other Arm boards
Date: Mon, 13 Jul 2020 18:57:42 +0100
Message-Id: <20200713175746.5936-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series adds some documentation to the system manual for
previously undocumented Arm board types.

The first 3 patches are very minimalist documentation of the
canon-a1000, collie and gumstix board families.  The info was
obtained by looking at source code comments, a brief scan of what
kinds of devices the code was creating, and sometimes the cover
letter for the patch series that added the board. The level
of documentation here doesn't seem fantastically useful but
on the other hand it's no worse than that we have for some
existing boards (eg cheetah) and it would be nice to eventually
get to complete coverage of all the arm board types. But
I figured some feedback on whether this level of documentation
was worth doing was worthwhile before I tried to add it for
any of the other board types.

Finally, patch 4 is more meaty: it documents the "virt" board
(which was a pretty embarrassing omission from the docs given
that it is the standard board type that we recommend for
Arm guests these days). I have attempted to fold in the info
on the board from https://wiki.qemu.org/Documentation/Platforms/ARM
where appropriate.

Peter Maydell (4):
  docs/system: Briefly document canon-a1100 board
  docs/system: Briefly document collie board
  docs/system: Briefly document gumstix boards
  docs/system: Document the arm virt board

 docs/system/arm/collie.rst  |  16 ++++
 docs/system/arm/digic.rst   |  11 +++
 docs/system/arm/gumstix.rst |  21 +++++
 docs/system/arm/virt.rst    | 157 ++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst  |   4 +
 MAINTAINERS                 |   4 +
 6 files changed, 213 insertions(+)
 create mode 100644 docs/system/arm/collie.rst
 create mode 100644 docs/system/arm/digic.rst
 create mode 100644 docs/system/arm/gumstix.rst
 create mode 100644 docs/system/arm/virt.rst

-- 
2.20.1


