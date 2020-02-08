Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D86C35254
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EDE21741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4RzJkeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EDE21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Shz-00074Y-0d
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 11:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh3-0005G4-Ta
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh2-00083q-R5
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh2-00081i-LP
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:52 -0500
Received: by mail-wr1-x431.google.com with SMTP id w12so2428933wrt.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 08:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KNRX11p/24OmqP+QT494o3fZUvsDK9PhMGr8QwsMje8=;
 b=F4RzJkeFvlGYsP5voY5GZzpNQrtd/9GdxClru2a13f58XSae3Gt7NVSMV/Ywt82Xen
 wcI4dg/b9/nrzoqdLRGnU8fL+Hs/hSgqZ9DP/u95+KIunvbbVPjruHxVIlW2euNo4+Gn
 /UzNB+QKVKBuBsdsoowhQD2/8TNbKlqOTXb+xUk+gAABpMoCNtf9GVOVSy3+BRv1PGE+
 P1UKxEqXEoiJzc81EIPavaOrNmUMDXD/L6YUtRedkNlfcwMbL6Vd4VXwChdpCHtKJHo3
 xKLTYLgI/IzkMZvr/HWzSej3ygnnXo5bYr0zcWEBVXRe2PkFwgRPhSAG7uuABb9dE6jw
 1qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KNRX11p/24OmqP+QT494o3fZUvsDK9PhMGr8QwsMje8=;
 b=ObcTbLuvNyx7Lms6kbse+xJUnf3e4Q7YTfbwEb3K+SXEWfOR8K+L9AUBh+/77pFj9Y
 1pZLFlj+x4FSTGEtpk4RgiqRFk8oTvdl/iXv7/u/04cEyckHUtPac/oSxHHjCBnQhEFh
 wBwYZAYyMdUzwZPjDo2GV3sPzTzXItLmsrX8870zlk+YzrOIohxF6y5TFRj6clyOzfbY
 eKHe5FpNKs5s12pUAKZKxRsZGMaccHJwPNXf1jBp+8cigI7zAEaaIOXCjT6ILnsLiP+w
 kJ7B5ERmu3IY5cE/BQCrkL/YlWpRN7qoLzKjXd08OXajLVEn4EHtc5XNLCQIt3eCG00M
 BWgw==
X-Gm-Message-State: APjAAAWuLNY+2dFCzgYG3adAbS401/rcoh0KvIqrQUkJKqAkllLKT+27
 nk0gfXavP37RtTwl5ubnJxDxilR1
X-Google-Smtp-Source: APXvYqz/RoPHAR1X9emuFxthkfxf5V0pE5KFXLoEz7FHM+kblpmbLGZTSsGl5YpYg3TTYDOalmim6Q==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr6269605wru.40.1581178250826; 
 Sat, 08 Feb 2020 08:10:50 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l8sm7931669wmj.2.2020.02.08.08.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:10:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH v2 0/2] ui/gtk: Fix gd_refresh_rate_millihz() when widget
 window is not realized
Date: Sat,  8 Feb 2020 17:10:46 +0100
Message-Id: <20200208161048.11311-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix bug report from Jan Kiszka:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg678130.html
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02260.html

Supersedes: <20200208143008.6157-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (2):
  ui/gtk: Update gd_refresh_rate_millihz() to handle VirtualConsole
  ui/gtk: Fix gd_refresh_rate_millihz() when widget window is not
    realized

 ui/gtk.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.21.1


