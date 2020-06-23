Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA4DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9722072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq5S938J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9722072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndGL-00016O-Sl
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndFS-0007Vx-1k; Tue, 23 Jun 2020 03:21:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:32822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndFQ-0003Di-FO; Tue, 23 Jun 2020 03:21:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id l11so19369537wru.0;
 Tue, 23 Jun 2020 00:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PC262lDbsM+izIS4gIzIDS7tjH2mSBnNq8vbqL9Ixqk=;
 b=sq5S938JWBN4musCRKNxKfdYUuGua+ni9IENCVr5LybQAO5ZgDwqIU/cvZCpNfp7zp
 k8jDZNRmrinRak/Q7Y/sRhchZbZ5gtyUmz/TLAR4xgrT90Tj15anWZKUdLoR8IcuMgqp
 NCJZT9MHKptyvGv3GbfsE0TBN3r1vxRxenyLGp8is1jmFR5pPjEs6W3amUHogkv559YC
 Ch2PB+i1lpExV2Rq6W8VhZg+r5ormpCUAVPRJfMSMbMq0kR+Yzuu+e5cCDlkcT0EKmGK
 SZ1QBy3ooqlFYAgh9cHvC6tpg6Qu3WMKrWdVvCO2+ugBOHhWIPbl/lWw/XnsC54jD/BL
 wxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PC262lDbsM+izIS4gIzIDS7tjH2mSBnNq8vbqL9Ixqk=;
 b=RrbmvjyrfU6mmspBzA9QUIOCXRT5UJpCRAs+1Cqi990+mwc2hcokppEfZ4z8soDXPy
 eS7DZ9TEq47upqsaSyuE1F6ax+zTY7so/yHboX7dk5YsRqpQ5qydji4awEjPdfgurWb6
 oQtL0bneSlrzCGYdchC6S7NpCCplu2yL925n13PojjhWjiYkpMIto+51kauU7YBPxE2O
 CVj74LXPIHbqTdNLRKIgzFwVhf0FFcyrp7ib72aIKFdJaXe2qTUzSs61B2yQo8AJK7bU
 RArZHemAPWpBLK6gQz0BskfoSaBKb7DbvouqgCrfNbphW4J36F0aGieroCuO1MNXeylg
 jA8w==
X-Gm-Message-State: AOAM532mH0Xm1QhWT4FMwjA1ulvqo5ASFMMC2s22wUhvlHtZVaf5d8+Y
 ctnPssNYRNir6CbQcsKCyjIwB1PM
X-Google-Smtp-Source: ABdhPJxJjvz547J8pMNk8OvFgePqqqeVO2OC6DOmgFfMF7wiW03IJZ4GmQ8eRgzR0GIe5xyVupIPjA==
X-Received: by 2002:adf:f707:: with SMTP id r7mr11331412wrp.70.1592896893875; 
 Tue, 23 Jun 2020 00:21:33 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x13sm21877236wre.83.2020.06.23.00.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 00:21:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] hw/arm/aspeed: Improve QOM usage
Date: Tue, 23 Jun 2020 09:21:29 +0200
Message-Id: <20200623072132.2868-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yet another cleanup.
Simplify aspeed machine QOM usage.

Since v1, addressed Cédric review comments:
- Rename AspeedBoardState -> AspeedMachineState

Philippe Mathieu-Daudé (3):
  hw/arm/aspeed: Remove extraneous MemoryRegion object owner
  hw/arm/aspeed: Rename AspeedBoardState as AspeedMachineState
  hw/arm/aspeed: QOM'ify AspeedMachineState

 include/hw/arm/aspeed.h | 12 +++---------
 hw/arm/aspeed.c         | 33 ++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 24 deletions(-)

-- 
2.21.3


