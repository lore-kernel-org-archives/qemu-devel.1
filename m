Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC56A20724
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4DedgHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC56A20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQtr-0001it-75
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQt4-0000Wz-Oc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:58:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQt3-0001To-8v
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:58:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id w3so22615993wmi.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B93WOFgqX36UhvJ4vEyF01rHmdjp3ebCmiX6P/HuZtQ=;
 b=l4DedgHut2kH7jrsVW9S9mLBchlDn/wAcKJr3XEtvsHdVnK5cN/6mZ6HJdpBrb/J3R
 vDVc/5bBnNcUM1q8SAlRUDexoD+SLiL8n9ucCjgaZFup51yZcjad4Eq0RU0PSek3qyru
 CciV0RvgQ/WUQtwahZOMmUAwcptEkGp/oreaTXvXTIkrIeX0+3kWFyOz5M2fevGzwPxp
 7heSt95z1Z2NQ4Mt3oy7wvkNMvL7DqvqXL6MGBPPvGq4K/5oMTGvvli6yb6vwcEBNWVd
 G5M7e0V7NbmUkuU6WN1s8sidCLat+au/MIzYY1SzeseI04e4MiNDJXBRaKb2DYruBlUf
 7gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=B93WOFgqX36UhvJ4vEyF01rHmdjp3ebCmiX6P/HuZtQ=;
 b=N0r1Wtx0Z3XdE1wxhc+Yn0eCNUawP5xOJj9bSXoL127mZ/FUsGhI11Vs5l1tmzyghG
 NslUUgVmPoz4qd29uurzACHIOQ+qEZeG2kOVNJqWQDB639x9bBWUe4AOXN3LFyX21FWG
 AOjKOMjunmptDmfRSRiLmSENRcwAsP8IrYHpn0FqyEsYqFBG5s+5KXI46Eqyszv/rZGZ
 BBAhLZrLCkObjUwU2GWBA+tFOjlxeQvhhYtQMdSiTBwRT5Z5o17t79zbfJSz9G2kRpo3
 coBLaQpVeqBTx6QGCiCrWtFLEGXOf+h2Uk2KCXbRULHJ+mxvzXvZqcTVUUWsM6fxlmHZ
 TLsw==
X-Gm-Message-State: AOAM531f7VcDGvm6Uu9qAzLJoUOZLDSLvxxNz0hZ8Cb24KyLKqvN7VNv
 z2r4bphMR8xKN3e2fcbnu9YGAi5MGbM=
X-Google-Smtp-Source: ABdhPJyL9Z1um6dnmOjPcgSzOcO5t9ik07NsCiKVmASUjU16cEQXDN7/CeSDXOurUSbS1hOR/FYcxw==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr36133526wmc.23.1593802691545; 
 Fri, 03 Jul 2020 11:58:11 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id t16sm16060929wru.9.2020.07.03.11.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 11:58:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/char/serial: Migrate I/O serial device
Date: Fri,  3 Jul 2020 20:58:07 +0200
Message-Id: <20200703185809.5896-1-f4bug@amsat.org>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We migrate the memory mapped device, but not the I/O one.
No particular reason, so let it be migratable.

Philippe Mathieu-Daudé (2):
  hw/char/serial: Separate and document static properties
  hw/char/serial: Allow migration of the I/O serial device

 include/hw/char/serial.h |  7 +++++--
 hw/char/serial.c         | 12 +++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.21.3


