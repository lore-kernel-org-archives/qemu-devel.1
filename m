Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D25C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C362072E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKE1a0ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C362072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1bq-00029F-FJ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1QX-0005j8-0G; Thu, 01 Oct 2020 12:27:29 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:33404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1QV-0003DY-1h; Thu, 01 Oct 2020 12:27:28 -0400
Received: by mail-pg1-x530.google.com with SMTP id o25so4447028pgm.0;
 Thu, 01 Oct 2020 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OxTuJZi4yOFQzwAVxPQMOtb1M7Vd0gQ3V5Fr2XqNTNg=;
 b=hKE1a0dsPW1Nppv3z+t3JlysETzzJJQpK3dj6hiWfV8VEILCubk4bFpGOUgHyhIYqP
 V0oAQE8wkx4Gw4DiXFNotPqAM1I/Sr9KjCd4ZCxUqIUoYZpz/2Y4QSMskw0j/MpuiLsS
 naREpQU+A2xQK2YWTDhkKRPrmluT/llteUbPfpbyIPl/jpTzSSOrd7w3zyICiq6aJIXs
 5kZtyzfS7Eu9fxhhOYROuAOxj9I9Ywi+a9XP5ekcKdBSYpurlolL50VA93dN7lMLyzX+
 ImHA8HSLSAVeTJzcAORXYn1jubPLNF8+YwH6FfcN/aY7CG5SPjoHTmd1pCCwz75q1Gzo
 Kzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OxTuJZi4yOFQzwAVxPQMOtb1M7Vd0gQ3V5Fr2XqNTNg=;
 b=jzQXcTh0sFxGcDkteZpBETZ9zTIHPZWwWNV9tk4ObgxtaL9dRRd4r4jw9Zf/Bo17gD
 wHoCEPHed4JtOVpsT5eBSrfkn6TMrPwcr/Vuc79EvbiJvgWRMrHSpmPEnoFQ09Zl7W1Q
 ilrnkCMc6p3t45I9UHkIsX6ErqAG2UpXGEOuthT1siHmePlZqxJ0ljD/pckQjccKg1fC
 hAHaL2h0VtOfoNFqJNKlgTrfTxpvSRb0ym5KcOJciiqasWaodc5y+u5oZwJPuRfkugYL
 iz511cfwaMitq28UFMJcaG5XzyMeMPn61tjo3fag8j4n+2G/3BKWqsiAHPbdT0YiIp9L
 F1QA==
X-Gm-Message-State: AOAM531R4Gqdle6muO/QPp/nV1WDX5/IHdjs9zfCQVnMHZBOTl9Si0QI
 QoV//8rFnlPWrr6De/Z2/JhlPF4DQajsbw==
X-Google-Smtp-Source: ABdhPJx/N8YnbC/PokkUjn9uTYLqCjTnCCIA+oMgYRE2W1Q6ubAyB++OEHzz0dPr86kysAO274Wvsg==
X-Received: by 2002:a62:3802:0:b029:142:2501:397e with SMTP id
 f2-20020a6238020000b02901422501397emr3400650pfa.67.1601569644634; 
 Thu, 01 Oct 2020 09:27:24 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id e8sm3810174pgj.8.2020.10.01.09.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:27:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Texi cleanup
Date: Fri,  2 Oct 2020 00:27:03 +0800
Message-Id: <20201001162705.219-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Texi cleanup=0D
=0D
Yonggang Luo (2):=0D
  doc: more texi cleanup=0D
  doc: remove hxtool-conv.pl=0D
=0D
 qemu-img-cmds.hx       |   2 +-=0D
 scripts/hxtool-conv.pl | 137 -----------------------------------------=0D
 target/i386/cpu.c      |   2 +-=0D
 3 files changed, 2 insertions(+), 139 deletions(-)=0D
 delete mode 100755 scripts/hxtool-conv.pl=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

