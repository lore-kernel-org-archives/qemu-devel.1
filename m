Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7135CC2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399C020857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtvGFGYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399C020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3GRi-00024P-Cs
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 04:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GQu-0000ru-Fo
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GQt-00023h-F7
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:48 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:34497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3GQt-00023X-8k
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:47 -0500
Received: by mail-pj1-x102b.google.com with SMTP id f2so1571281pjq.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 01:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=01a7VFoW61bNrbC3OHwoKYYtJfiLCMrQllc/DyNAeB0=;
 b=vtvGFGYIUy+te4kNNK4xI43Ybbc2WvedFR5NeD6JhphfRypQESPLIbjK2lBPWBjd76
 73/gnly6qJqOLpCo6AzB/21q8C77ouw8HlZGBs+EhgnvOPMKlmgyPYlcwVc3Qj2mKw8w
 9B9VHAYYecfjj1rM4ZVTMlRvymCDppRk1A7duM1o6h40TjZxP3A1r3L4RqWf4oYWp5io
 Eg41+UXIqmYs9GJ1ziZEcytuoBXJZ84usWXJq2J+hz7fyotlqNWxAawCAn12AEktpGTM
 MIFE2tyhFGoKdQ52TT6co780B4amVvsp2sO/FoUn53oklNSqXhPGPVJqM96E9SbQPKYf
 awqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=01a7VFoW61bNrbC3OHwoKYYtJfiLCMrQllc/DyNAeB0=;
 b=ldRMcikRwN/U1Mogu06BY5svgsm9GSyXXQmg4PoWVzX4bbC3/k9HBriLoDGHPUKh20
 /L29LZnR6JozCJtB5fU7v4QPKaQPk+wAXX4oJANwHHgneKbdeR8RNb8qIU4w0jXxMsLv
 r/CPbGfMJoDh66nklFQOzxRYGFMu3VRdseTR+3OSGiU3XYNzzudrhLpfnR7BP0xuh9BB
 L2foRz1Q1FymczyTOVpPFyn0BykLez8X3znZjq6PgvqJ/i7MHYwWvm4N78KDeSCFuOPD
 m2TbUpo7s7V/S1E/NO2E+f9g38Ovm9Q3/tytvEUdfpo9m7t4E8SZaq4qHxxls5/xsYtB
 mLtA==
X-Gm-Message-State: APjAAAUIpzRyJlPG62tYn+RpZaXV0atI9XH6oeXz6rI89wQL6IuLrSi6
 GCEJGFx61VqwZz1zUmFvY04esWYj7bw=
X-Google-Smtp-Source: APXvYqwCY8qezU5fqSpSrsZVM2XXuXdNv/LHt2Mb/ITe2zTp2nWb6GnebEy+JYmvrbtDpig+uX1W9A==
X-Received: by 2002:a17:902:a706:: with SMTP id
 w6mr11291705plq.79.1581846105602; 
 Sun, 16 Feb 2020 01:41:45 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm13023553pgi.31.2020.02.16.01.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 01:41:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] tcg/arm: Expand epilogue inline
Date: Sun, 16 Feb 2020 01:41:41 -0800
Message-Id: <20200216094143.14201-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102b
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
Cc: philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

v1: http://patchwork.ozlabs.org/patch/1176721/
v2 splits the patch in half, as requested by Phil.


r~


Richard Henderson (2):
  tcg/arm: Split out tcg_out_epilogue
  tcg/arm: Expand epilogue inline

 tcg/arm/tcg-target.inc.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

-- 
2.23.0


