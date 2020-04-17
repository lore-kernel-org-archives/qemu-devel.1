Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D97C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FDD20780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WACCFHof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FDD20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWOq-0003Yx-Kd
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNf-0002f5-Ss
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNd-0005Ek-T1
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:26 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPWNd-0005Dj-KB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:25 -0400
Received: by mail-lf1-x141.google.com with SMTP id f8so2666675lfe.12
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zVohzvPzOmTz7Q0+p82EyXL4+9LToc+S6zBNjmWyd7s=;
 b=WACCFHofD3lSl3G2Vw9BgPWtyFwa3GBsmeaS3xnmr7pVXEb7UC3hNFRRn9au1pqBuL
 AMRBi0x5O6DeG/+c2BnLgAsWXwt9Jrd/FCHW3Ki2SEYadNfDIy4KC3CZ5KN348aGvmGy
 wzayjbu8lF4OAIkKq+Yn0u9I0DbfvrTKDNoQIkrB/CcaJY3D2monTbmJRg32WPFlAQiG
 fYlXszStPESJBXloah1uSTkAyf9MdhqTMMzdPItyKWVPh/H7Ohfa45MdidBAR0kSlyka
 Rtj+CuLR2g9s8cin4+x3L061tk5jTaOdtC2vF+vGXtO16Ou1ytnxEjvyIxNhp16mV+gi
 j5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zVohzvPzOmTz7Q0+p82EyXL4+9LToc+S6zBNjmWyd7s=;
 b=bD/AD5jejAnBp1dOqVtv7OtCzPrMKRPt0xPj5fGPIcj9LwXVjTy1JSOG0g8AK4PZRE
 EG50gwJ8+97I1egZkWuEvKi57lGIEu55Mj7ETEL/DbzhIKP+OxFCup/fL7H8aAVAffU2
 vKPir5X8Ds6H5mW6oL+snhttEQM0U+RauOu1HmaUeZDOdWimT7S22fIoD0GfO2VWdM8t
 Iyr0UNoSTM1sPCdBGszEndxfBWlmEpoQ5kr2HQfw0bwbXHsT9kjLiDk4yvJGq03jSnk4
 pxwd0uTJ+DeOCMmOiw76zf4h3Qj48sVTJO3+pHlwTwS9llhrR3RRgdoZGyWgGLDF0Sjj
 Asjg==
X-Gm-Message-State: AGi0PuaQh+X0l7GSUFLUlBZ8n7GRPIm1b+krIhGhpWR+6EqlumVSlPBF
 rjNQPl4z5QoMYbYiuejgohUtex9yfx6U5A==
X-Google-Smtp-Source: APiQypL2syRZeJnuVTmcUOGUT+Qe833VI/duVvzlXXGGgAUtvg5Kdjhy7SxQ3oqmr2EGdgnCkKktnw==
X-Received: by 2002:a19:2d1d:: with SMTP id k29mr3004369lfj.46.1587150623949; 
 Fri, 17 Apr 2020 12:10:23 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id y25sm18219571lfy.59.2020.04.17.12.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 12:10:23 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/6] target-microblaze: Misc configurability #2
Date: Fri, 17 Apr 2020 21:10:16 +0200
Message-Id: <20200417191022.5247-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This is another round of conversion from hardcoded regs to
cpu properties.
The property names are taken from the device-tree bindings.

Cheers,
Edgar

Edgar E. Iglesias (6):
  target/microblaze: Add the opcode-0x0-illegal CPU property
  target/microblaze: Add the ill-opcode-exception property
  target/microblaze: Add the div-zero-exception property
  target/microblaze: Add the unaligned-exceptions property
  target/microblaze: Add the pvr-user1 property
  target/microblaze: Add the pvr-user2 property

 target/microblaze/cpu.c       | 22 ++++++++++++++++++++--
 target/microblaze/cpu.h       |  6 ++++++
 target/microblaze/op_helper.c |  5 +++--
 target/microblaze/translate.c |  8 ++++----
 4 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.20.1


