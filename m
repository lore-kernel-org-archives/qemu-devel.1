Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 16:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722E023ECF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB58rHbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722E023ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmgNP-0007D8-I7
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 12:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmgLw-0005ZO-Ku; Sat, 20 Jun 2020 12:28:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmgLv-0004me-43; Sat, 20 Jun 2020 12:28:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id g75so2963986wme.5;
 Sat, 20 Jun 2020 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LD86i6ePSe4PN5iFnsRMbNNgXe4bEQc0BX5nmcZuiH8=;
 b=VB58rHbilN8iHXRO6p4547/ir7TCrlzj8csaPS0NPlvowOC+m/HvYRnIclV4o6E0bZ
 ikSBXQL58RCM1FQdJpSYR28TBIDHO+QOETXBkvn+cekR1xLKjPjorF2Df24ODs0jPsDb
 IaZ1tyzrBSahVEWeWi/nJsDcVm0QVlVvNcELg3Epg9AOxSBu3Ei3vCougI1GGcjS6D7v
 qhEU7W39qUv542FzpudfIkN876lVGV2D0gEW3v/SHGNHraFXhPJlDe+1uDLcRuRFDvCX
 BHl7u9dgU0ufriNvNYM2b/ncaJf0vbax3S64mt2rXJNmOGcSUcT7lzKO8rN9iZeOicqv
 AxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=LD86i6ePSe4PN5iFnsRMbNNgXe4bEQc0BX5nmcZuiH8=;
 b=tICJ+qALMqISS5G2HEHvQ2hh6Hh7rXo1I6ma/fUdxjBcwwDHt7do4B7ZfTt/LEEcE9
 a5fvNiRKhYoY7a0xbWJFNJsV596R7RK70c9/c2iTMXj7ileDTW0d+4GJab/dpMdNQbbI
 V31HxpcgvtV7ueHZ5IyFKd+KKHyvZvRXdX193O+ViAc/s/0AbC6kt9Km39OqE8nVMJO5
 hiHHoaM/lfjez/SrsEuFyrlSFdlaFN7iPV8EAQJ/afHy3PV20Y/WSgWiH6koOFa8JBl1
 0IaAZ7NToolt4aCbOoAiIu1CBiTZ0hXeMKUMaIseFDAvy+NZkg6SAznx7VEnbW9K/Mpm
 +J4w==
X-Gm-Message-State: AOAM532GUXpEkILSw+MMOHvbH1lMmlpzF3YdEvslhvog9j4xs6OyA9q7
 Cm6sOaVvWb12cVHvb43/i0UjSdps
X-Google-Smtp-Source: ABdhPJy1QhJrwYlASr5yz2XmkyzgJkYGkkDJrYMe6m1Qy6K27J8yxzbdnq6pTMHSAs1Zadb3+zcRVg==
X-Received: by 2002:a1c:ab04:: with SMTP id u4mr9945063wme.52.1592670501164;
 Sat, 20 Jun 2020 09:28:21 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id e8sm9240006wrv.24.2020.06.20.09.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 09:28:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/arm/aspeed: Improve QOM usage
Date: Sat, 20 Jun 2020 18:28:16 +0200
Message-Id: <20200620162818.22340-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yet another cleanup.
Simplify aspeed machine QOM usage.

Philippe Mathieu-Daudé (2):
  hw/arm/aspeed: Remove extraneous MemoryRegion object owner
  hw/arm/aspeed: QOM'ify AspeedBoardState

 include/hw/arm/aspeed.h |  8 +-------
 hw/arm/aspeed.c         | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 14 deletions(-)

-- 
2.21.3


