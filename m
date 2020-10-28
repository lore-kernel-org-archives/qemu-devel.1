Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48518C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858BA2242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFgiaCSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858BA2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXc8O-0006tJ-FT
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7E-0005j2-0K
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:12 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:39608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7B-0005lk-8X
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:11 -0400
Received: by mail-pf1-x431.google.com with SMTP id e15so2112860pfh.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Apclru9edkda74kh1AR4rRs5y1vYr8Lk7zFfDsb8O0=;
 b=zFgiaCSlTg0FYmSpuzt2dwO1fYuZ5ZSuiVIubDwA06mxkLLTFaxn6w/LiDVmWY7Lp3
 z7pVtW8h4s0BEpMs9PVmfmam3S7HWX/C9MBMSditc7E3D/yRdfj/VX1F+59KR9cySXDy
 fCWg9TgFGog67cxyI9TQcw6gSuUajY0ps8QBlcXpW+g+4Jiz5ZmWGpy6A++Pql0X6pqS
 YCoxhP3Mzj0dM+tD1qkHSE1HMQvImOyVcRbD6eoL6knQFuarDK5anTauJUiBw4wlQcPJ
 I3liXO3gAmCumExD2gSSlwHzBoEzIGa49cL8kOf8mY/2yBfXGtyUTrhji5nfHdPYy2RA
 1thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Apclru9edkda74kh1AR4rRs5y1vYr8Lk7zFfDsb8O0=;
 b=WQNg6w3ujMOzdQNmMIVmcTbv9uFfRLxcEAjyN1IPNt7U60+FaOUU/rIFSWLQvra8ZV
 Bt6oasfEsoN0nQ214WiatufQPriTWhs4L5UPxk1F0G2RS5r7Gu92CY18avICWn9uieT+
 FRFbXoic/5U6Qn7NAZRRcp6AKiiGB+HjZdZnIkhsZZPxy+6jKk7DwTdclZg/HxDEReEZ
 kipOcHSTdtWCtE54xf0DsQ55e1GDIJsD1skwp3U40spODz9RDo/VTgixvHo8wqCBtgMP
 W8+i8ByMwHPniHx0Np3Kv6o1t2INUYuW39MqhbC31XROotiVVBOj5vqKB2z0flT8hAY4
 q7BA==
X-Gm-Message-State: AOAM531CAnAeQHOF3PBU2C7vaQGxPGIcVnGFTHYq9SiuntYVY50wbh9d
 q01m/t9pltJxVKRdkPqtxfcw0Eem+CtYlg==
X-Google-Smtp-Source: ABdhPJzSTBeovWngHW6CmK2Sb+DbeZjIODqQz6Q7C4e/67vDgWoggewKpOwywG4tn281rvwyt22F0Q==
X-Received: by 2002:a63:2d41:: with SMTP id t62mr2234217pgt.292.1603855626337; 
 Tue, 27 Oct 2020 20:27:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d26sm3764413pfo.82.2020.10.27.20.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:27:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] target/arm: Fix neon reg offsets
Date: Tue, 27 Oct 2020 20:26:52 -0700
Message-Id: <20201028032703.201526-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Much of the existing usage of neon_reg_offset is broken for
big-endian hosts, as it computes the offset of the first
32-bit unit, not the offset of the entire vector register.

Fix this by separating out the different usages.  Make the
whole thing look a bit more like the aarch64 code.


r~


Richard Henderson (11):
  target/arm: Introduce neon_full_reg_offset
  target/arm: Move neon_element_offset to translate.c
  target/arm: Use neon_element_offset in neon_load/store_reg
  target/arm: Use neon_element_offset in vfp_reg_offset
  target/arm: Add read/write_neon_element32
  target/arm: Expand read/write_neon_element32 to all MemOp
  target/arm: Rename neon_load_reg32 to vfp_load_reg32
  target/arm: Add read/write_neon_element64
  target/arm: Rename neon_load_reg64 to vfp_load_reg64
  target/arm: Simplify do_long_3d and do_2scalar_long
  target/arm: Improve do_prewiden_3d

 target/arm/translate.c          | 153 ++++++++---
 target/arm/translate-neon.c.inc | 464 +++++++++++++++++---------------
 target/arm/translate-vfp.c.inc  | 341 ++++++++++-------------
 3 files changed, 510 insertions(+), 448 deletions(-)

-- 
2.25.1


