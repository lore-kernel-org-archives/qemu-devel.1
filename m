Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A03BC34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC9D22B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKs8HqUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC9D22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48k1-0005GS-93
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iU-0003YO-OF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iT-0004Az-9u
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:34 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:37478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48iT-000491-3u
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:33 -0500
Received: by mail-pg1-x532.google.com with SMTP id z12so11460928pgl.4
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DeOS0f0SMHOm6wYCvXYWoiG04IokuiueGEm3UZ/zxi4=;
 b=UKs8HqUrEG6OVS3YEEijmFaARMrc8GMvkgEEGFKF9QQx7u7JOfekj3ZkqmfrpzV8fQ
 wCZoFppdAA4zJXL1IA8Fttxxhzzf4BRPXZpitht3pkgVcPHSryHmhJ7L1dp16Nmez5IA
 vmffdNssFEjQecMiVk3f7umjE/8FKeLX0SgOlHmsn/lHINMfz6AJsy+XYBSnkgdZxiQG
 p1+V/Lm49XEAvgcWTDPIgkQIOpoasNBBdIWtkFBvmnDsSB1/DMI9RUdnGxBXdPvzErMV
 p7wMZPLtNSaCr79nmwXJ91qz6GoDNndXsS2ClSolPt9f32LjS2FDolrSmN3Xwc+rFUBF
 8Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DeOS0f0SMHOm6wYCvXYWoiG04IokuiueGEm3UZ/zxi4=;
 b=nCoVGGyPN6936P6nHS0kZsb76s6qQUugImJRLpR35FqgHklW6O+gD3a8XAnrHh7QRg
 gzhdWco8vMZmLr0dBz1nxPpH5els0IcAz3WyFn/NsIB0WjWKYfc5FGw3ZZPy9SkLFNi/
 cofYjdPZsqgl6SNo/ClBDMVSceUvqq5YIX7p/ae8xvvFRuVOF8g8PKAlIGVx9HFa597N
 P1t+l5OunIgg2HSOp3HE1YWJ3BkHqBMJbJDIu4TtLHCpE2CFZxST8jDC7kcLiQ+u1xpF
 pHiGpwce8sK2m/1NoOhN7oZ3EnHzF+46DE22LCr8tTmCvhhJk3T7I2iAs221I1/MX4Je
 w8Bg==
X-Gm-Message-State: APjAAAUbYw2zkxkuIHR3Fx6ykO3S91jUKVWBMi8RwQ94A+zX3+8ZVAy1
 qy45i6hTP1r+POTfcHkdbUePH2ekRB0=
X-Google-Smtp-Source: APXvYqze6K/tyJbT2UTDV1ivj0+4TcvaIUoEr/i2HuyD244MaxOVKh5l1EFdAhLBEwSzo8pqFhht2Q==
X-Received: by 2002:a63:de4c:: with SMTP id y12mr23997815pgi.107.1582054771273; 
 Tue, 18 Feb 2020 11:39:31 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y15sm424395pgj.78.2020.02.18.11.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:39:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target/hppa patch queue
Date: Tue, 18 Feb 2020 11:39:20 -0800
Message-Id: <20200218193929.11404-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::532
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

The following changes since commit 6c599282f8ab382fe59f03a6cae755b89561a7b3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-02-15-v2' into staging (2020-02-17 13:32:25 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-pa-20200218

for you to fetch changes up to 90e94c0591687f7f788fc40ac86b5583f30d9513:

  hw/hppa/dino: Do not accept accesses to registers 0x818 and 0x82c (2020-02-18 11:22:10 -0800)

----------------------------------------------------------------
Fixes for Dino and Artist.

----------------------------------------------------------------
Philippe Mathieu-Daudé (9):
      hw/display/artist: Move trace event to draw_line()
      hw/display/artist: Remove pointless initialization
      hw/display/artist: Delay some variables initialization
      hw/display/artist: Avoid drawing line when nothing to display
      hw/display/artist: Remove dead code (CID 1419388 & 1419389)
      hw/hppa/dino: Add comments with register name
      hw/hppa/dino: Fix reg800_keep_bits overrun (CID 1419387 1419393 1419394)
      hw/hppa/dino: Fix bitmask for the PCIROR register
      hw/hppa/dino: Do not accept accesses to registers 0x818 and 0x82c

 hw/display/artist.c | 29 +++++++++--------------------
 hw/hppa/dino.c      | 31 +++++++++++++++++--------------
 2 files changed, 26 insertions(+), 34 deletions(-)

