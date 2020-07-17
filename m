Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC56C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABFE20717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS0x9zFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABFE20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwTXk-0000uk-AL
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 12:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jwTWu-00084h-JB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:48:12 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31]:46172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jwTWs-0007Dd-D2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:48:12 -0400
Received: by mail-oo1-xc31.google.com with SMTP id s190so1958162ooa.13
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
 :content-disposition:content-transfer-encoding:user-agent;
 bh=SUOl+hV+T1L7z95z1yhwj+ZR/UUqnnwnoYcJTskgr24=;
 b=FS0x9zFOBpZ4kSRA8pFiwzGtt5bAxSNVR2pp5nUTw33RkNs0FtlTYiRga9bvUL0K6t
 LIuXVKRO9HbnJlttaE6rI9Gg3oNwySuI04GFrW0g30snRz2vhoD8j+HDhJAUyxJdsIxR
 hbGug1eSPyaSg/8d7LOwPHUosZX4jPFjrfc0BAeHN4ZTV7lb5zjvwFQZqU8yk3SrmOlM
 gtWU+Yn/QFQs9N9+WYXFQ1tB7JgZRUNcBEg4ip5YdBkHEJeJFKn9aurSxweSRBLmC1Mq
 MsMbBHUYWN+wsIm3eh0FnRsZEnepxN+NLpWuDMCRnRuPxTXPDF+7V1InORHnAJj+wPzO
 exOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:mime-version:content-disposition:content-transfer-encoding
 :user-agent;
 bh=SUOl+hV+T1L7z95z1yhwj+ZR/UUqnnwnoYcJTskgr24=;
 b=tfQqOf4iYXuyzGOfg0+LTCFLwIIxkCPtuuCIZ3FBjgbt0UCQFucZKB4osOlsHHfcaF
 iz4X6vkFvaz/E1nGbTnuRHk7KbfmjgsC/CrZkXcfwGfsX+7+l4QPwcdAjeuiOnIe1bux
 KvjdaMWzyLSVsMyv53OEwh+UZ3T44+i8d6xMY8ff8T2QH3UeWpIlBmx8dKASrroHtyfO
 nHRklfo69/BdBVu407wgq+enVU7r7v2/h5ft3OjyzT93aB3Ef7Bg4dcl5qo4daEw2z7O
 lqHGrpX6STPU4ItqJPwW/1fh/LVkZKKsT55adJ90Dwuq2Qy063LK5FTwOJlz7tI1uEZ7
 zHyg==
X-Gm-Message-State: AOAM532zagBoxn70ynO5bJtUCEVsk6X5J13wfII0fSIHm2tIUbRKmofx
 3wXNOvt/lgiZP3lR2sOWAA==
X-Google-Smtp-Source: ABdhPJxg3tJ8s4LiNgG/5UuVPjTRzoBzmBtjwCbpYy6PsREQChR1sEuaMF+HtNXq33MCxtEZNoRodQ==
X-Received: by 2002:a4a:57c1:: with SMTP id u184mr5567053ooa.41.1595004488171; 
 Fri, 17 Jul 2020 09:48:08 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id k16sm2021032otl.63.2020.07.17.09.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 09:48:07 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:899b:e727:2fc3:fa54])
 by serve.minyard.net (Postfix) with ESMTPSA id 11CA918055F;
 Fri, 17 Jul 2020 16:48:06 +0000 (UTC)
Date: Fri, 17 Jul 2020 11:48:03 -0500
From: Corey Minyard <minyard@acm.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [GIT PULL] IPMI updates
Message-ID: <20200717164803.GJ29192@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc31.google.com
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
Reply-To: minyard@acm.org
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 95d1fbabae0cd44156ac4b96d512d143ca7dfd5e:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200716-pull-request' into staging (2020-07-16 18:50:51 +0100)

are available in the Git repository at:

  https://github.com/cminyard/qemu.git tags/for-qemu-ipmi-5

for you to fetch changes up to e3f7320caa1cc08a9b752e555b79abd6218c7c7a:

  ipmi: add SET_SENSOR_READING command (2020-07-17 11:39:46 -0500)

----------------------------------------------------------------
Man page update and new set sensor command

Some minor man page updates for fairly obvious things.

The set sensor command addition has been in the Power group's tree for a
long time and I have neglected to submit it.

-corey

----------------------------------------------------------------
Corey Minyard (2):
      ipmi: Add man page pieces for the IPMI PCI devices
      ipmi: Fix a man page entry

Cédric Le Goater (1):
      ipmi: add SET_SENSOR_READING command

 hw/ipmi/ipmi_bmc_sim.c | 223 +++++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx        |  11 ++-
 2 files changed, 233 insertions(+), 1 deletion(-)


