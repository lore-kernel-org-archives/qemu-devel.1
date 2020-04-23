Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF69C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4835A2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0Ndjrct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4835A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRl96-0002zb-95
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 19:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5T-0007EE-SY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5Q-0006m4-V1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5Q-0006hr-Di
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id v4so8619282wme.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QqFmL+6vdmx3ikkSn1UPbShh4FBtsVBnq85SLDvukMk=;
 b=N0Ndjrcte/v7qdQCBfP5LkQ8uR3QbS/wNMljE0hfH+W9BVxeabWhDZMnHDvK8PwTqW
 UIql89qVW9dFvfmTqROeIxkgyAr4tOrH8+Yn5/SPqxMcLlOeYq3hquiUdRJkYsXGhHh2
 4z6/HpEysA38/BLspl0iZyjKrshVs5VTiPXPoXIz0oYDwY3cZjHeI76FXeT4HORDhYTs
 2auBmp/w7JsbEDeifAeINqbwaj1KpH6+cQL3fcW6vo1kjgrYNY8nZc5WPfuL5VrlgHle
 EL7pwxV36R9W0TSpTtwTE4KLHeqJBIG0zFoR4DJIBz7x0Sd0Yw8sCE1Qd9LH1cvWacFi
 tdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QqFmL+6vdmx3ikkSn1UPbShh4FBtsVBnq85SLDvukMk=;
 b=jm19uGkJCnmi9wmiePa7yqNDXSo+jGKLJpczDTcRrfNS5qoKjQ8p72Cfvdd3UDiMT5
 3FK2KxeUPb6wclG2we3N3atg5NRSsKMI7iQn1UQHi096Lov8xbBFhrEfIxyDJkT6nH7f
 htBQPWwfQQ86AsmrWSxG2dkzlWdn6lndmPKaawVTEO9hiGA/e7LeUUf8WsCwvS5Mu3vX
 f41h4d9pV4FVFhwnhKeSsE6fruXuZGyXmD7eAkI8WjcDzQjdNurHizAcUkk8P/FPDsrq
 0HfekP45BE9K6o5upVVTgln6SDcLNiTtWy/xgEUbia/OTHlkO614brsW7oAWZQ1lmrdj
 4NiA==
X-Gm-Message-State: AGi0PuYYjknJBWh0JHu5pYsjIQx1/NXB4U3hOT3xRpKkFIDEuB1EzFP8
 kcfVfujGxgHbS1J4eabSQQuC+EUo
X-Google-Smtp-Source: APiQypJdFwEQP0fcuCpfJ75w3QPfWghMaevN+a/j+ZJ3n0CK+S65261E4H2Ice5ehcxWaXrDIx6vfw==
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr6497385wme.71.1587683807312; 
 Thu, 23 Apr 2020 16:16:47 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h13sm5498122wrs.22.2020.04.23.16.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 16:16:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] hw/net/tulip: Fix LP#1874539
Date: Fri, 24 Apr 2020 01:16:41 +0200
Message-Id: <20200423231644.15786-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attempt to fix the launchpad bug filled by Helge:

  In a qemu-system-hppa system, qemu release v5.0.0-rc,
  the tulip nic driver is broken.  The tulip nic is detected,
  even getting DHCP info does work.  But when trying to
  download bigger files via network, the tulip driver gets
  stuck.

Philippe Mathieu-Daudé (3):
  hw/net/tulip: Fix 'Descriptor Error' definition
  hw/net/tulip: Log descriptor overflows
  hw/net/tulip: Set descriptor error bit when lenght is incorrect

 hw/net/tulip.h |  2 +-
 hw/net/tulip.c | 32 ++++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.21.1


