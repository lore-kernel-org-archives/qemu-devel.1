Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E119C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C0821A4C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opmrWUwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C0821A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7pXe-0005qp-65
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 19:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7pWk-00052Q-9d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7pWj-00050J-7h
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:26 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:40070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i7pWj-0004zd-26
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:25 -0400
Received: by mail-qt1-x842.google.com with SMTP id g4so22976284qtq.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=umw90SX6/0hl/jRPXA5jQ4v+5K4DOeoQiu6PCv5G0w8=;
 b=opmrWUwegx2vQMGxOUA3Le0I/5GLZQ6aQYqih9YxR/uP2IDjNn28srWUQ33E9g8+rA
 fhS4EFzIRxeu7PAruAgGWZwztmfIUZx1ms/iZawqraCIBdMUSlueuLNi0G4RKs5Pk8tL
 IkKXJKLM7BYajfFsS9NB70xUpxGWfFqc6rjOysdELV1tNCt9qC3XYWJt6zwEY7f/Fh75
 /0Y6ZWnQ2zSAo9X+9I6B4+ccueOIHCvT2J8C7tUfAQKWrK9n79kN19txwx+WbtDYd2fw
 yRdAC49O6676/OTjlp5LZqmZumeQeKEJcjX/fkj9H6xuGSilXhpkCzkxSNjaZE6K+1f0
 t1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=umw90SX6/0hl/jRPXA5jQ4v+5K4DOeoQiu6PCv5G0w8=;
 b=O6htYhSuHWoOEJVQZpU2ADsWixgvqUxQrhYJgBALuHHZJJga7Ynpl85uQ1guVa2pSu
 KwNWbj76Zx/WhGjd7Pkx12Zt6m/qtjKmTjmFEYZj3UwE1Rz+TZHv87TzJoD/686XYRXU
 sdPTvzUhg04apYfSjj94WwQx+Z2m7dywBRhwAtKkr9VvdV+NG6lcZUT4UePEIE+ZgP20
 6aniXJxGv3xfCyJX9AnEHpO6DJ+UyIoHqK6VvvYS4SBYkxM4qQ0Z0vgIu834+XSuaUx/
 FngiNz70HWgXWy7WPyBr0gunBBM0PoJjIEkK8mWc+KliKzHLaP2ZjHRLhO4I5x196WUS
 TppA==
X-Gm-Message-State: APjAAAXFNs7M7W4vWVO/5KhI1PzOzZo2n3qZeGmuuP4WxHN5kNap3att
 5BSRRDezKksBrf8xQX2+FACnJL5M
X-Google-Smtp-Source: APXvYqzjLSP90qR5tfm8a7hddEfNo4qaRvseGGrujAxaS9mRoQiP9e0zGaHXJOxS6Af8+Q699n4mlQ==
X-Received: by 2002:ac8:7558:: with SMTP id b24mr31906989qtr.260.1568157983868; 
 Tue, 10 Sep 2019 16:26:23 -0700 (PDT)
Received: from decltype.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:6ea8:1::d3])
 by smtp.gmail.com with ESMTPSA id z5sm8804535qki.55.2019.09.10.16.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 16:26:23 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 01:26:17 +0200
Message-Id: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH 0/3] Audio: misc fixes for "Audio 20190821
 patches", part two
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series contains some random fixes for the "Audio 20190821 patches":
a coverity bugfix and pulseaudio connection/stream names fix.

Since there wasn't a clear consensus about naming the pa streams, I've
split it into two commits: the first time just uses the audiodev id
unconditionally, while the last commit adds a new option to qapi to
override it.  This way we can easily drop the last commit if it turns
out to be unnecessary.

Regards,
Zoltan


Kővágó, Zoltán (3):
  audio: fix parameter dereference before NULL check
  audio: paaudio: fix connection and stream name
  audio: paaudio: ability to specify stream name

 audio/audio_template.h | 7 +++++--
 audio/paaudio.c        | 9 ++++++---
 qapi/audio.json        | 6 ++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.23.0


