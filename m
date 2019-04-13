Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C28C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 20:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FBF20870
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 20:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+HiKKSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FBF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFPIG-00040n-Ki
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 16:30:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hFPGj-0003DH-Tl
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hFPGi-0000LU-0g
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:28:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hFPGg-0000HL-Av
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:28:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id r186so3009843wmf.1
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SEKRy7aHQXuSEfpbZ0pa8gjX4vlmHg5KV7kK/N9lB/0=;
	b=r+HiKKScyQXsy/vEoia3PBstuHxKIa6HXmWUT08EzINH+yunNh2f6Q+fphEqYRF5bL
	jRXEmaEMHZsFGIhJUzFkQ7A/E7Y2Tw0u3qQ/z6USHoJTlY7jGRsKy7cZx+KQZZj0n2fe
	z8VMVa3x9F037Xug0ye9VJmJKHIjiIVucM0dN5PnQGwTmg8SJhn1TUo1dcF/o6U8PTx5
	YS8V1jbiayKzwkxRMXICRdbRXM9nMSrRnKGhufj6qm4iHYCniLz/Wgkl7JncNIdmYusL
	EAnPlHWht8vSt63JWbeFn6cCEkwBgRtti90/Iil00y8DgnxfjJYqikw4nQiYYIE6Gi4C
	U6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=SEKRy7aHQXuSEfpbZ0pa8gjX4vlmHg5KV7kK/N9lB/0=;
	b=bqfNh2aHe+qmFrwyem+nHoY8swwziyLIYQ2y7SCsrRwTumGGzRfivYYPitvQEiBJKL
	rsbkL9s/vIXxusePdj0+eyECQjJF9dL48lYd66DKMpRbeqp/d89AElTJqYIN0sIXYpuO
	stScxsN+yypOg0pyr0x5q1+JNdRjWDcwstKGrUO2TKd8q3bJFPx63dN8DN6o5rLlOsho
	qewdGSAwbkkgpkUy+ubzGiLHPLGb73xQXJofxDfcJbHthUiemgY6ZQ2cMGYMJ3X1kiac
	AW14cmIPh6LMedmxYPgl6vs/3qEiY/8DA0J7lwdrPkNYSMpic78RSWag4nTtULGFHuBQ
	LaXQ==
X-Gm-Message-State: APjAAAXn+XJnDnYHPW4AQtcqFU/ledc07XJd/V9ZIDhsF3mVvzCbd3wz
	Zh2pJm9SpoOo2YfRsg2T8jo9vjj7/w==
X-Google-Smtp-Source: APXvYqzK5ctX0akepn0We4WxytzhJi9fxTC1no5BS8EKq3yya/4ly1tjW0EJqAkq28zOiiHa0vyO/w==
X-Received: by 2002:a1c:cf46:: with SMTP id f67mr15554768wmg.98.1555187331563; 
	Sat, 13 Apr 2019 13:28:51 -0700 (PDT)
Received: from ninjahub.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	7sm153212361wrc.81.2019.04.13.13.28.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Apr 2019 13:28:50 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Apr 2019 21:28:16 +0100
Message-Id: <20190413202818.13622-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v5 0/2] target/mips: Errors amd warnings
 cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, Jules Irenge <jbi.octave@gmail.com>,
	aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190413202816.fkEyNEJrxAC5m1Yjm3t5fGOLEuupelsUSAi30gG0IEM@z>

This v5 series combines patch v4 2/3 into patch v4 1/3 hence the number
of patches to two.

Jules Irenge (2):
  target/mips: add or remove space to fix checkpatch errors
  target/mips: realign comments to fix checkpatch warnings

 target/mips/cpu.h | 211 +++++++++++++++++++++++++---------------------
 1 file changed, 117 insertions(+), 94 deletions(-)

-- 
2.20.1


