Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBC9C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6F720776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oic/7g82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6F720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Wy-0007if-L6
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS0Jw-0006Q5-NF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:05:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS0Jv-0002Sy-51
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:05:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id d81so17596007wmc.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5RjKW9cZZrgD/YoK0SgXEa7vWbpGc042rPJwJZwUOzg=;
 b=Oic/7g82tUQ8imuaw+kkvmCFebcH8gP/+RZW97SYxOs6mQkDHcZu7KCzAATpFPoFJX
 y/XcMLQnxeYonitI8nefa8nYocVB8kktBDQTpdJgpvKS+e0sXo/kuOf2Fl699KSjfL38
 al6hqtrHfWgbOzJqjo64mRgc0kDwFM/y+61TEF1dNIxcLhkQ1W+g3ca6IRU3iaPPXPda
 6v8Hm5bX3h5OwH4YcowDYXifCjzW5o3KEYRdZp9GeL+veG027nYNHkM2w5ADAkyVjj45
 nDhPXLNs9Yvmv2N8b2LyCqozezfG3gBekVnYAdgPga4lmrsO0iSlI78lo5HZsb6Uh1Hj
 qjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5RjKW9cZZrgD/YoK0SgXEa7vWbpGc042rPJwJZwUOzg=;
 b=H+avo42s5K0P+hcEMK75eFA+jfLl0bfMFQzp20Inf+Rf5i0idQSi6haLhWerK3Ch7S
 pJ/iCQGgpscJLZhTM4P+WU2vQjIjoG+z/xZ6FEppks1zkxMUCrX/9CaKjV7f3xbk8gCo
 XXbo4QtfbzsI1eUHWSYTbWzrYOpX/HAXu6cyqaK5TR/RkWZwExd1dJ69rrUGtK08mV9L
 U9TUjlSwWpyem4twNh8GJPi3eEEc+siYj3TaxOuwAzFIf2hkEcU5i3H4wnD38Yt7oIx0
 krblljjZgD/baC9Ctaop2Ra+AfWAoxQsjdrFljeSq623cT5z02oaAZ4ghNSH9Z0tyQuy
 K45w==
X-Gm-Message-State: AOAM533310tX9o0OGJ/qB/c2oHnUlc02UNr1m4koFHaXRAlzPSPshPX/
 WHbWKeno1sFJZBfqqH2JykT1xn9ypuY=
X-Google-Smtp-Source: ABdhPJwR2WW/3OoC150ygBGqvfo2UDZICmgK3Uioe6GNVsLsTSTy+yTCmF0zbHf8J4T8z94q9YJb8g==
X-Received: by 2002:a1c:2186:: with SMTP id
 h128mr11191648wmh.113.1602518705452; 
 Mon, 12 Oct 2020 09:05:05 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c9sm16096576wrs.66.2020.10.12.09.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 09:05:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/mips/malta: Minor housekeeping in mips_malta_init()
Date: Mon, 12 Oct 2020 18:05:01 +0200
Message-Id: <20201012160503.3472140-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move some code around to make this big function=0D
easier to review.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (2):=0D
  hw/mips/malta: Move gt64120 related code together=0D
  hw/mips/malta: Use clearer qdev style=0D
=0D
 hw/mips/malta.c | 21 ++++++++++-----------=0D
 1 file changed, 10 insertions(+), 11 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

