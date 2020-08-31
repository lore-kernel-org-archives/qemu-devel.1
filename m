Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9493C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CC9207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkOFhQMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CC9207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCsKK-0004op-MX
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 18:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCsJE-0003up-2g
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:29:52 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:38444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCsJB-00014k-Rp
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:29:51 -0400
Received: by mail-pj1-x102b.google.com with SMTP id ls14so655372pjb.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9h0A0onaN4Z0vGQoeZvZX7Cn2t3jal9crq28joeYs04=;
 b=QkOFhQMojWZ5ANWI2PXnKE8L8Ln0rOxP4l+BwiWpahZfwT6fnR08rRc4m7LkQgCmmM
 7myjZjsAXu40FmEe2jFmkTP0gFsFQlaCWWGrlPHjrmLRjy5GBtSDqq40OmhrvJ+mU2yi
 Hu8MFpJYhwlyNCS7Y/FBlZUm2tkFBnpn6TgBv+cxmb6w6pxId/q5U/EuchKSpRPGTIcU
 GD8YWWDNN30kfrX6zapEBIOM9VHu7Pk+cyM+ejGO4L1cKeykv4fkWuvob5UYkXqfbr4U
 xHBOWi4L8IyOXwJJkXSuNU1wVY10Ao2BXu56D/5LnIqC3cxsuPMVJzOZKm+gu+yMqCXt
 dSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9h0A0onaN4Z0vGQoeZvZX7Cn2t3jal9crq28joeYs04=;
 b=Jb97nHv2rQMyq0/8wqi/28aBxBfUGSOMoEjGOPV8vcDDVyQobiKP/Hhe8cwozm6DyZ
 3lDIRzi1ZB882rsO1CdRrbaZYiS09639Q/hzeuqqgcrSOL9UAtEUDxnlqz8sX0v39mpy
 jT2ANM9wVO2cbH1kyBbXHzrkTeTwrAxa068/WKiUp++PaQhOWK97fafoec4JeJEE7/aI
 vFZdQXhbH3ETqE5WtbKGPMjLLcFlxvn7Uf3Ccs+RawYt5Cc+PnpVHpKFHve4ebT6NX2h
 t6wg2oDFoX68DqHnwl0aVLLfc+egdaVLafsCBYQne0tO4Ruxv5pUiTt5vgf5W+9BCc55
 /bGg==
X-Gm-Message-State: AOAM531+R97FRHpRsWyZhtgzb++nKIVHN7e1oGx68ZM1dMtDf3ct1Kcu
 bdgVsMN7vF6YcQVyVqpXw5u45A4Db9DIGw==
X-Google-Smtp-Source: ABdhPJw7hL8IEKLqIPVeALTAfa33Sg1Bh9b3mjOqKGlJSwGX5mbYxeBMp2ZPNOtE4mt6yNbRyhIf5Q==
X-Received: by 2002:a17:90b:2383:: with SMTP id
 mr3mr1317370pjb.29.1598912987681; 
 Mon, 31 Aug 2020 15:29:47 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z126sm9391708pfc.94.2020.08.31.15.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 15:29:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] tcg: Adjust simd_desc size encoding
Date: Mon, 31 Aug 2020 15:29:44 -0700
Message-Id: <20200831222945.875453-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
Cc: frank.chang@sifive.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Frank, this is intended to address the vector size limitation
that you encountered with the risc-v rvv patch set, as per

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07924.html

although not exactly like that email says.

This will allow vectors up to 2k bytes in length.
Please test, if you can.


r~


Richard Henderson (1):
  tcg: Adjust simd_desc size encoding

 include/tcg/tcg-gvec-desc.h | 38 ++++++++++++++++++++++++-------------
 tcg/tcg-op-gvec.c           | 35 ++++++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 21 deletions(-)

-- 
2.25.1


