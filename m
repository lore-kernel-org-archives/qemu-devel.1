Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EF2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B13620707
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYttLoMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B13620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVgiK-00033d-JP
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 15:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVggx-0001V5-6A
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:23:51 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:53550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVggv-0005xw-B2
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:23:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id hi11so356443pjb.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VYkjbZ34Yrs2AgktNHIysUVrNg3YJZ9pMM1DxFr47Vg=;
 b=vYttLoMrP3ushjMoegQ02oyIWyr1GAaokw8Y/mIGU1l7i9DeRtmx6lQSp84QEVAc+5
 69LqaQFrmnynqxz9h9/ePOzKxcbTjewt+yort4/8CjEfb/dSKC8O0WLlylmTbCTgOcqG
 T0Tk13C/3sTkKEbpzAH872a7Iwr2JgRuTPBC7j78+xp+X6LHYoSqwI4KUE8BPVtPnCXI
 SZLOFWj1stlaBPuRJ+rcH/E4Kmj5J06TMG/eBT0lzTn52Tjh2m/8SBgx63oLV6EvPFVg
 CAYi7UIAhhyhu27d9lReEl79oKSi+Ti1y1l/F6aGWu6hHjZb+cjRvyev6k32FVdUL7hq
 ATPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VYkjbZ34Yrs2AgktNHIysUVrNg3YJZ9pMM1DxFr47Vg=;
 b=kMBPUaZpWFiaTxq+DUZB4j9atTfLn06Lc/dBCnU6YgQ0n/9Wy8keQak4gwDWXeeemM
 6J2O5duKz0xZ7Y1mu01C3+NVxVmKUfAdCPricBVTDHuMbCac6AVFq0DtkfuUvYTHtLDQ
 Sgngadun2ZwO6u2eLQY7Zhv28mIPwf07lIKbTr1K2kYbjZ3yNT78V9v0eTqcaYcODlgV
 iv1VOHWRbCRz+U722YISR9F/r320iAf/eS2fw/YGtNHx935hlKVA43twE/QjK8nW6ifo
 GDnXQUoQ0BxSkBTvVXeX/jtvnphOt/P0BoyCEK/zX7dVS8an1Ys/LZzad2aSFw5jOevW
 fl+Q==
X-Gm-Message-State: AGi0PubuHLdREcYuNlzUbu4xzZr5zHe3zyK0jxkZywGz7eX2wfRJfL4J
 qkeJpnFjs3JcpyTciiG+XIlcQjreK4A=
X-Google-Smtp-Source: APiQypKeYqGjyXR61Ii4ne/Q939nmwRrssb8g0EYnmPn1Bc45b0B3Ikf5jYsdo4Ossgm+65+zb2kuw==
X-Received: by 2002:a17:90b:155:: with SMTP id
 em21mr566017pjb.59.1588620226271; 
 Mon, 04 May 2020 12:23:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b9sm9407364pfp.12.2020.05.04.12.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 12:23:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] target/arm: misc cleanups
Date: Mon,  4 May 2020 12:23:41 -0700
Message-Id: <20200504192344.13404-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard Henderson (3):
  target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
  target/arm: Use tcg_gen_gvec_mov for clear_vec_high
  target/arm: Use clear_vec_high more effectively

 target/arm/helper-sve.h    |  45 +++++++----
 target/arm/sve_helper.c    | 157 ++++++++++++++-----------------------
 target/arm/translate-a64.c |  69 ++++++++--------
 target/arm/translate-sve.c |  70 ++++++-----------
 4 files changed, 152 insertions(+), 189 deletions(-)

-- 
2.20.1


