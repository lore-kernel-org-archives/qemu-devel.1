Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56418C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBAC20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEd/AmeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBAC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2OcM-0005m6-Ag
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObU-0004Wd-OX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObT-0006vw-Pb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:08 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObT-0006u3-I8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:07 -0500
Received: by mail-wr1-x434.google.com with SMTP id n10so6978580wrm.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fI+qq8NyYxD5I2H7/AMaNoXcPIiuDuJa3jDC2/HwYUk=;
 b=GEd/AmeDbNlm79G9JsBNlhnDhjC749ozeOrlIeCiUmF7XLKRLH1bMiJPilhDCpg5Pg
 2aP93S41qNlMoxPAvNnGN2nHqjLLD2LvWv9zy/Of2rAGv8txjV5DbZKbZFMS/Z4Jzj/n
 /Dqr4qlTWcJCwNhKSAoYGk8vvYt6wiOfT/DTBc/RtJuSdJu9JW1tV9ucMjTVABu+oDAr
 sz0lmD1W7lxRDVekZKR3OfhomXH5hWSp+oYxDYPZTB9KQ4WjP9vyCjgHISDL/dgL0Jkq
 +FRW1NOohCKTXOE29vmBfh+KyMPtyDXfofnq84m9eC1vko/7a4EoZTyvL0KPOLVhBSZD
 +IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fI+qq8NyYxD5I2H7/AMaNoXcPIiuDuJa3jDC2/HwYUk=;
 b=MpZjaTMWsYy7lERjQVokKps1uJNUnSJcxm5UIHK/G4Tc5HEhjbrD8m/cZUSjLtTFTz
 lrVqGIdcatlqovhInmEJNwNjVngG9H0LSJ6t4vr2rmmeag+0FPiRW6CS1jRrluxT6eEK
 O/2O0Spq/lyD7oJHYY3v8cWUD0XdGICxHM8KDN9RrSr2v7J/BKkPNaF5Kp2Kf7rCz+Mp
 etD2LqWX+M5lZQQJuSL4hpgJP339qhpfDSWw/QMbAqpvxOz+JrZutkXFRiTxE3ww4XDn
 OzVOSktigiDtwF/WOSwB332Wpc/zCIfFoL5dog+GxonCt56Po1draMrviYg11OlHHds4
 Bexg==
X-Gm-Message-State: APjAAAXxKQ0NMQ4jBsqp5Qi/4HGMUMugsYsdmhZrV0R9KrbxqeRXqOj3
 AxcOrEhLssO4nCWBV8k7WL8=
X-Google-Smtp-Source: APXvYqxKo6dXEzGr/1jO1h/DUF9M0qOf1KM9QBjZXk5HWByCZDqUyRHxB2Svv5EBZrvcTTZXAa2oLg==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr113588wrp.2.1581639185823;
 Thu, 13 Feb 2020 16:13:05 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a16sm4679230wrx.87.2020.02.13.16.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 16:13:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/5] hw/display/artist: Fix Coverity 1419388 & 1419389
Date: Fri, 14 Feb 2020 01:12:57 +0100
Message-Id: <20200214001303.12873-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Another easy Coverity fix.

Philippe Mathieu-Daudé (5):
  hw/display/artist: Move trace event to draw_line()
  hw/display/artist: Remove pointless initialization
  hw/display/artist: Delay some variables initialization
  hw/display/artist: Avoid drawing line when nothing to display
  hw/display/artist: Remove dead code (CID 1419388 & 1419389)

 hw/display/artist.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

-- 
2.21.1


