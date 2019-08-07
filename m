Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4719C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA8C21743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZ19ZpGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA8C21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvDxy-0002TB-Hd
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40535)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxL-00012S-AW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxK-0004iH-95
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:40472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxJ-0004gz-Qc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id p184so42759421pfp.7
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=PJ7zkpB+6Cwx8kF4V3bvovNm+nwQsltuqm4c6vQnd5k=;
 b=UZ19ZpGDrBudoEcAvtcKIJIr9z/nqqcWcZHSk2hwLQhioxsidWMMwBF5LEToPbjkRB
 SzNX1ol4cKWFvz6rytNMa6328UdDExzXI1B/trhI7IoPioxTz27zll4HGTg/8/iwUYKc
 D4MKto2gGQH+hZngYe1UKB1fjMebp6qYQ/Uibzlm0eMfy+M03mbtcrcT6gOmCdxSSgKa
 wksK+tRNIfmLc1qPSHWDFJRDC8v5fhWi+AmcNbpWB11/vDEBXbxpSUwqQCznG9IqxgJO
 ItoIKTqZshlTA4Kpkx9rT1wTgbjRrwskWEkTTv0T6hPfWtQ0HCAkXFzHv1YeMVYmXd9N
 4i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=PJ7zkpB+6Cwx8kF4V3bvovNm+nwQsltuqm4c6vQnd5k=;
 b=i/vK/wMM2juFiLbMzC0mtu4Zv9RvUNWRVgrRacqZFhPRnG4W6AeKI7hXcbRlSMPHZN
 3Gq/BP27BWqqLOFHYK8NqUjIgSdFOjgtXINTaU4BTmhVzHEomZ0qmdT5+cgaIv1aa6G/
 j3mYNNhwrFo01c5GVy4YUKBdy96nKD6WxlD3+qQZZzN1Lkf/7TN2hAAHm27kfWdSryAF
 FhKCuoXyGz7jZAtdpN6G+SrT9LyGhrZAr51bpb7Rn1Br8JEtjv2t0iC8lF6vc/njhRVg
 feZvNjMgrrXhHoTUDn74NoKCUkgRFS01zBtXnppaQDnNm5Gqy0UIwLBPP2t1vGHcdvcg
 5qvg==
X-Gm-Message-State: APjAAAVhzQ1XV5pLAVr8Hwzzx9W3EuqLfMxLhEm/wnHqgCLKoLxmmrKF
 5seVKwtaQZu5aXfvPjDQF3XLFi6msDA=
X-Google-Smtp-Source: APXvYqwpA6Dsby7tl2Yt/1UCdfk1xKEbLfhlkThyaTcoTDBRiKwlHQSSkTKHRSbQEByI1DX6HVJ0jg==
X-Received: by 2002:a17:90a:20a2:: with SMTP id
 f31mr6504650pjg.90.1565153623738; 
 Tue, 06 Aug 2019 21:53:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:24 -0700
Message-Id: <20190807045335.1361-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
Subject: [Qemu-devel] [PATCH 00/11] target/arm: decodetree prep patches
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are split out of my decodetree conversion of the
aarch32 general instructions.  With one exception, these
are all related to cleaning up how we refer to "PC".


r~


Richard Henderson (11):
  target/arm: Pass in pc to thumb_insn_is_16bit
  target/arm: Introduce pc_curr
  target/arm: Introduce read_pc
  target/arm: Introduce add_reg_for_lit
  target/arm: Remove redundant s->pc & ~1
  target/arm: Replace s->pc with s->base.pc_next
  target/arm: Replace offset with pc in gen_exception_insn
  target/arm: Replace offset with pc in gen_exception_internal_insn
  target/arm: Remove offset argument to gen_exception_bkpt_insn
  target/arm: Use unallocated_encoding for aarch32
  target/arm: Remove helper_double_saturate

 target/arm/helper.h            |   1 -
 target/arm/translate-a64.h     |   4 +-
 target/arm/translate.h         |   5 +-
 target/arm/op_helper.c         |  15 --
 target/arm/translate-a64.c     | 109 +++++----
 target/arm/translate-vfp.inc.c |  45 +---
 target/arm/translate.c         | 397 +++++++++++++++------------------
 7 files changed, 249 insertions(+), 327 deletions(-)

-- 
2.17.1


