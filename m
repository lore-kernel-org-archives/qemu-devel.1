Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C7820885
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1tK0UvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C7820885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLTv-0004X4-8t
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLT2-0003jE-Gz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:21:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLT1-0005qi-NH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:21:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id t18so18286353wru.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=utM+BoCjhmOMVexx0YBNeGuPgRXyfVF14tqXVwC/jek=;
 b=P1tK0UvDFVeB+keminTuP9JO2P0k0UlAXddZ5t/VtjAftIAcuvf2R8fNBjA3PboMPi
 Dq7dW3dntqPuLdr3qasJAlV/H81eQl0YndyB95Sp28JYsklnqnJ/HPW/GFM8l0fj5+Z4
 ydGIopXAKXjz4Q/jzUDggyJFtsASZQhoMM6pgKR1kTVMNm8hoHJKx91Our2/RBL0cTAV
 mSwXYU1Qvpj+5d/yKoyhZ57Fahtzpw8wR3koX1A2KzxBEMElN7c253DpXmGbDl2Am0vt
 w+X9DP8p0NID+g6DFPJ13hs7XDrIOAUd1NrVlaFXHy+iO233TMjGxHJgRTgC0+NnxKj6
 Uwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=utM+BoCjhmOMVexx0YBNeGuPgRXyfVF14tqXVwC/jek=;
 b=UT4QmHqEI5FZssa+M+cW9hXO0DnRzplXSXZ0zp2YgLoJ0NO5Q7u7ffj3wYH+Yetxrr
 AHXahfROH0ekQNxc6NmNZd1/5jdReNUn90yeU1m5evC+SQ+iRMDQY93cyeQ1JVQaq6n/
 MSY+w/EvjAPeOC1GjlD2ow7eKxROWpDqyHS1aHjxIZ9FfgVRmsaS23fVlQ8XAXE13pLx
 HFrQZJpDc4uWU2bQy7kXmWmcgr6n7rODiAR6//XMDH8IeS8P1ojRXB6o91L+dh1kM7wH
 ZqH2mDXF/oIUITq1xIeNSAVcjIru8UkFBbTQFcfjADEQKa1IxHZOAZ7GV4BkW66sL7TY
 4qvg==
X-Gm-Message-State: AOAM533kTmXpMX35OQ5kn8E0RZn+rjk7G6MI0KdpRP18kAMyop1z2Nqh
 bWJM5EKHvfvNY+yybS+lKSa+EU71
X-Google-Smtp-Source: ABdhPJxPyxQxTmUA7sf6Cij1gsKSEf08kYw60IqpnUvnCqWvxYDTpgTG/UcYbzNVXYNBMtqhfszdzA==
X-Received: by 2002:adf:ed01:: with SMTP id a1mr26423503wro.271.1591636905987; 
 Mon, 08 Jun 2020 10:21:45 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n23sm223618wmc.0.2020.06.08.10.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 10:21:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/sparc: Map the UART devices unconditionally
Date: Mon,  8 Jun 2020 19:21:41 +0200
Message-Id: <20200608172144.20461-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few more SPARC patches.

Mark/Artyom/Frederic if you Ack them I'll simply add them
to the current trivial SPARC patch queue I prepared.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  hw/sparc/leon3: Map the UART device unconditionally
  hw/sparc64/niagara: Remove duplicated NIAGARA_UART_BASE definition
  hw/sparc64/niagara: Map the UART device unconditionally

 hw/sparc/leon3.c     | 18 ++++++++----------
 hw/sparc64/niagara.c |  7 ++-----
 2 files changed, 10 insertions(+), 15 deletions(-)

-- 
2.21.3


