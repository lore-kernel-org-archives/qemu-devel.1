Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7338BC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CDB21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm3hEphK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CDB21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwvr-0006SW-QK
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuE-00051D-3X; Thu, 15 Oct 2020 02:38:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuC-0006p9-Gs; Thu, 15 Oct 2020 02:38:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id f21so1904890wml.3;
 Wed, 14 Oct 2020 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yn409OoAXAvtjvGSJ+WlHlOrgCSHZsY7uZz+Opq6+fM=;
 b=lm3hEphKO6UmQRTPco6x8OQYJrsbxtR/EsgvWjB0v8p1xJ2E635S/raGOF7KOBpWIf
 gIWm6FZ4mAf32uyOt2p2iNkBUYJE7Fw35O/prRt7/vHxrqUy23DvXhOTUCiUDXS5jc/c
 Fhxh7+qYzQ0Rv6fbafRMABjYClk+5zSMTjmN2p6nsQfRNbbbPBUMV2Rj6Oon2mAFefPe
 D+EdbwiICVj2aVhcX2AN5cU3vYEMZgeDUHY1pMSmFP3DB9b0HBLslf2cYVgBoKvypBtq
 kNPWHAOkynuTjBMcTFWfpZ1rNfiwmAwbEijXYI4IJYmVaAHAC/I6InFsuF2VQqb7WsUf
 eiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=yn409OoAXAvtjvGSJ+WlHlOrgCSHZsY7uZz+Opq6+fM=;
 b=QFgftsNFimhIDmw4zy4pNjyL97Crc0HOeWLe3Y7IECei5m4d6hdQguukyfc7haiQcd
 KeY/7y91yiP8Z1Vjz2Css3ibws41oQJlQIh3bBPJU/2fQKheVcjdijk08JHlmtDaHUCY
 slcYpHRxHqFIRbZVSlG07+acPlqjW7WsmyMO2xlSIme5BqDY30magmAlvDI/Vsn5nEKQ
 sTsrK8LODz5B2LKa7Gyv/Z1DHGnjSj/gYkJJyuKKZf/QNrMBXvDd7mIzVS/QZS3YMVpr
 zCl4+AleTSjh1Z2qzvAUL+TemT1HFsHf68SvM0eAj/LswwzqAMYhX/12sbB3B26P3nHw
 DAaQ==
X-Gm-Message-State: AOAM530sGHLSg5P4G3qedRMHDJ+WV0sI0fJb48WOTqWKFhZrUBAosMru
 fTTDDY7UOiq/w24+Y8tvCfJI0dQNbRk=
X-Google-Smtp-Source: ABdhPJyYWY7WYV+kducPUmH7797Pup+kfb3y1NXg6mwix3LtS8S25eKfOwcKRd5yy8P3O64h02XF3A==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr2320132wmb.32.1602743906515; 
 Wed, 14 Oct 2020 23:38:26 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j101sm3154244wrj.9.2020.10.14.23.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 23:38:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] hw/sd/sdcard: Do not attempt to erase out of range
 addresses
Date: Thu, 15 Oct 2020 08:38:18 +0200
Message-Id: <20201015063824.212980-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yet another bug in the sdcard model found by libfuzzer:=0D
https://bugs.launchpad.net/bugs/1895310=0D
=0D
Since RFC: Settled migration issue=0D
=0D
Philippe Mathieu-Daud=C3=A9 (6):=0D
  hw/sd/sdcard: Add trace event for ERASE command (CMD38)=0D
  hw/sd/sdcard: Introduce the INVALID_ADDRESS definition=0D
  hw/sd/sdcard: Do not use legal address '0' for INVALID_ADDRESS=0D
  hw/sd/sdcard: Reset both start/end addresses on error=0D
  hw/sd/sdcard: Do not attempt to erase out of range addresses=0D
  hw/sd/sdcard: Assert if accessing an illegal group=0D
=0D
 hw/sd/sd.c         | 30 ++++++++++++++++++++++--------=0D
 hw/sd/trace-events |  2 +-=0D
 2 files changed, 23 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

