Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A8C606D9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2925521743
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2925521743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkeg-00061w-6w
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hkkcV-0004IU-Es
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hkkcU-0001QH-Ei
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hkkcU-0001Pk-7X
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so2052809wmg.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 00:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MF042dK8SfNyK8ValhxsRumjMl4PNY5rE7vj3hfXNus=;
 b=ArzWq0VWJBDmWG7eE5hs6VVCMIpzwIdfZx8Wjl+PrHqKXZMwwzneYfye9RykYWQsAW
 LndSuvLtyEpRN23skNCj9P3ac37QXh1JUNGCkrFUKF/BM68on6VsgyO24Rp1rK/DSJ1V
 HA0ZHcu/mY9emAw0WRE8zbYq25xY8jsR3SY5QMCyMNtLccXg6lwjndl2C/4hnBNhIH66
 IA+mQ+S8bZ2bK5eiSDSC+z84+XrsyR+fDWs2Z9oClhTJH9liAAlFQ1UW/c5LpC6rzgk2
 qbbTSkILykJmFtQ6ednS4f83XNWsLEuKffwTuDmEkYkKSMdIPwEaK2WFFMhWn+Sdrv7Z
 VzKQ==
X-Gm-Message-State: APjAAAXocdOLQXlVs2NySM3LVnctaLoGzHowiAD2pmfGTSwctSTyNp6D
 +eiKl3TDCl2ln4oKrHmoqLNbOX0AX2U=
X-Google-Smtp-Source: APXvYqxX32uASOp0r9/SvUAmd+Xr3MR5+1C5IdEGI567O14dmuUJoxn6rYRXwvij7Tz8vYcGBo7KRA==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr20502157wmb.17.1562657577141; 
 Tue, 09 Jul 2019 00:32:57 -0700 (PDT)
Received: from thl530.multi.box (pD95752BD.dip0.t-ipconnect.de.
 [217.87.82.189])
 by smtp.gmail.com with ESMTPSA id l2sm1529208wmj.4.2019.07.09.00.32.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 00:32:56 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 09:32:22 +0200
Message-Id: <20190709073222.26370-7-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709073222.26370-1-huth@tuxfamily.org>
References: <20190709073222.26370-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: [Qemu-devel] [PATCH v4 6/6] m68k: Add an entry for the NeXTcube
 machine to the MAINTAINERS file
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't have much clue about the NeXT hardware, but at least I know now
the source files a little bit, so I volunteer to pick up patches and send
PULL requests for them until someone else with more knowledge steps up
to do this job instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc9636b43a..01c0f9dec2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -910,6 +910,13 @@ F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
 
+NeXTcube
+M: Thomas Huth <huth@tuxfamily.org>
+S: Odd Fixes
+F: hw/m68k/next-*.c
+F: hw/display/next-fb.c
+F: include/hw/m68k/next-cube.h
+
 MicroBlaze Machines
 -------------------
 petalogix_s3adsp1800
-- 
2.21.0


