Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE5C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133502075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXM10/4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133502075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3GX-0003ey-AK
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FQ-0001wQ-MX; Mon, 13 Jul 2020 14:32:16 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FP-0004FB-5f; Mon, 13 Jul 2020 14:32:16 -0400
Received: by mail-ed1-x543.google.com with SMTP id z17so14578049edr.9;
 Mon, 13 Jul 2020 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CfEDbVfF7kj/yGhqKmfevoqL1P6U47hn56zU8XjW1QI=;
 b=dXM10/4nPGnWiypzrPjXOAc3vegBlO2sa76aTCpJnpxtMQvbMLOcqkuI7x27jrvg+A
 yGdXfib+one6Ipu/i47ziQg9iEhKSvGYeKfh1A0IE3B5zTFOksh6htFf+1qWTXhCGemU
 B4uo5diiwVUEJtEybKCyIhh9dYZe+n5FLaZ+vPIThjHJ+Qxjah2mCQ31woDOtQrOCGnT
 NCu0/Whlu+Y2BzmbRflF41tkZg4ubWO1qDDjj40L55BICXefcMXsQWUpVlhJ0pzqodsN
 E4JVXDhSx2qA2eeAL7kp/wRlvCYmzkhiq3GmuU/e0XxYRABfXwq6v3W1PFzO+tkZPVEO
 lfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CfEDbVfF7kj/yGhqKmfevoqL1P6U47hn56zU8XjW1QI=;
 b=V4loOVhtqQ+NOXcI9lW0VRuhOXlPw8pTzyRga7bht5DKMydtD/sOH7Ny8SE5PxfPGI
 RBHUOrgYAT4TAUr7yqtuAo744eFeCo5lurBYggUs/CyFkRc+OohnHnGt2BhJS+a51UwB
 MZcjJEmhrcvckAED++OzqUKjtcC5Xcr5Zn8XFk79pXTaC4YXbCzTvkCOquac2KbvO5Pm
 SfVWQH2gThMYfTgUqIoxAcM4YjnLtJspfGZac2LGCoyM7NVZhWL5LoEGvWmMvZ/qhm8/
 6Fg5k82Xy+5qJmJLzM5+VWPUTwOCpA/uHZw0Ueiu9vOYBD4hPJBvW7bg8iuLwRw736Pm
 dBdg==
X-Gm-Message-State: AOAM531wjLxFBg3D7Sp8UUPcY2HDgaXIDUNavu3t/srn8Lpb4scnzFVA
 ekJshplek4oPZa9l+jClwxP/D7Qctts=
X-Google-Smtp-Source: ABdhPJwSfMDH2o9uAjFduzeSbJ6NmFtBBP7BNEucfDswEp4P/0ad0zv5VDuhFVMp2QWCQ+ajEBUdRQ==
X-Received: by 2002:a05:6402:947:: with SMTP id
 h7mr692719edz.213.1594665132944; 
 Mon, 13 Jul 2020 11:32:12 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id ce12sm4353148edb.4.2020.07.13.11.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 11:32:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] MAINTAINERS: Cc qemu-block mailing list
Date: Mon, 13 Jul 2020 20:32:01 +0200
Message-Id: <20200713183209.26308-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200713183209.26308-1-f4bug@amsat.org>
References: <20200713183209.26308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We forgot to include the qemu-block mailing list while adding
this section in commit 076a0fc32a7. Fix this.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200630133912.9428-2-f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe8139f367..d9c71d0bb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1674,6 +1674,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
 F: hw/sd/core.c
-- 
2.21.3


