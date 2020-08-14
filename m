Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22953C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C7F204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFE7E2xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C7F204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ckv-0005OW-5V
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjq-0004C6-CQ
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjp-0002KA-1T
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:30 -0400
Received: by mail-wr1-x442.google.com with SMTP id f1so8906485wro.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n2CEbtdu6uAjduGqvuOKlfbi80BnaDbte2CK5FnPb84=;
 b=DFE7E2xkv8Br3ZAK4S832X2EM4wk+/qKcXsveoV3LWIQM1z3ME2eN3R/P2mN3XknwT
 427ioIb0wD/PDwReFp2+26MfoUJwA6QrIYFU8oVNtaA+uswe6Yq7qeTrv4FAMy97vrQt
 9NlbgqRDsrJX6NLs5d0pD5hxJeohe5DzyDEm8kilFFGtb/kEZ6AKMfXjFssO2DSQ2ocT
 j53rfN36dW/pQ8zmlp4ZOmGjLnPPcvHXWdciq2oZxxa1vT+EudzgojyVW0Oy0v+9WeBj
 V60d8hFBpdf+Su1dYtsn3e8NFV8+q7jovsmQCrSDD7gvu0pbvknMRvVtyCxuYtME4gc8
 N32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=n2CEbtdu6uAjduGqvuOKlfbi80BnaDbte2CK5FnPb84=;
 b=l6+bZl/U9margRPou96O4LaXXy3W8x7DQagh6JBgJvvBBlU9lgAu/wT31gPZNUyDxH
 5qVXMTpGerjpBU5szhQS2EBuN6MSEUj1Ses5HAwqyqWyieBEyOv/T6X5ptferpVjjCmD
 spd4Hdt3jA4r1z/SFacPzRHb7Ce+J0Cxox+HA1Sr1FEUEhHuyXgr9S9mSrxxN432BlnN
 97kb7RWcEQgdwDw2ANcaebu1aLhvsIGkVxQYMuPTkBZH36jhL6oe48DXiz5UJtNlJlSt
 1yjfVelg+35pLjIAbPK98FTjUG9q7yU632GSfR7wWoJbt7GJO72KP2apbyOPjNNvMZGm
 EdGg==
X-Gm-Message-State: AOAM5311c1BCojpsy44WALEVduUaLOeXOWnv5/uflBguEzIlGy4tD77H
 vtA0v641pim186CSpa7IYNCIkA1K9mQ=
X-Google-Smtp-Source: ABdhPJzvllGTg/+YEh0wu2H1kvwpiaryjuSOUAqcpImcUD0sSPHeIqViZ315opf2lW+CUc433p2E4w==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr3336359wrq.353.1597423167318; 
 Fri, 14 Aug 2020 09:39:27 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p14sm18417178wrg.96.2020.08.14.09.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 09:39:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/avr: Start using the Clock API
Date: Fri, 14 Aug 2020 18:39:19 +0200
Message-Id: <20200814163924.11662-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In this series we slowly start to use the recently added
Clock API in the AVR ATmega MCU.

As the Clock Control Unit is not yet modelled, we simply
connect the XTAL sink to the UART and Timer sources.

Philippe Mathieu-Daudé (5):
  hw/avr/atmega: Introduce the I/O clock
  hw/timer/avr_timer16: Use the Clock API
  hw/char/avr_usart: Restrict register definitions to source
  hw/char/avr_usart: Use the Clock API
  hw/char/avr_usart: Trace baudrate changes

 hw/avr/atmega.h                |  2 ++
 include/hw/char/avr_usart.h    | 32 ++---------------------
 include/hw/timer/avr_timer16.h |  3 ++-
 hw/avr/atmega.c                |  8 ++++--
 hw/char/avr_usart.c            | 46 ++++++++++++++++++++++++++++++++++
 hw/timer/avr_timer16.c         | 12 +++------
 hw/char/trace-events           |  3 +++
 7 files changed, 65 insertions(+), 41 deletions(-)

-- 
2.21.3


