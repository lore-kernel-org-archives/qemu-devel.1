Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D40DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A3720675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK5tnRQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A3720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshOe-0007Sh-4t
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 02:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshNU-0005w5-AF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:46:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:36067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshNS-0000c5-R1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:46:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 17so45206705wmo.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VtqJ+RTuDLdDRaK4nxJtdOEtXoIq17N7HCPQbMA1KKk=;
 b=KK5tnRQA34KWcEzPq1fD8KGupihz8g0xD1EzSegXaQhtTgqM+AIB06EkdV0BQ8Q9Xd
 CQz+kJ199l/3OwSLcme3xd/Nfon1JHvbBGctZq9+RtwU/brwmRRQXkLkI6zyLnOXgA3H
 KWzikTpGX2a2YbG/sl7nupkrPUE1ryiwfA3BHMepRVZD7XiAJGHGHKist0zP4w7EbEGW
 +vkGO2uR3TVs28NY1VqOXwvZFHoIQhS9lY9MqvXSOh78kMNTqYSagVdiW5OYSqUOXl6R
 5N6mEcVQJqnG7I60WxZGWW+xL6Jc0P2cS909TJ+72CssAt2mHlquF3zAfhoheM8aJeUg
 8c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=VtqJ+RTuDLdDRaK4nxJtdOEtXoIq17N7HCPQbMA1KKk=;
 b=T5sBG0e7h+9z34vD2ArRbCKP7sxbZ1zdjJ/zFMm6gV5S19Zf7e4X/54TiL2Z2aUULf
 hr+rEumz1C1BFlnYdKVUOc9+flutcxcpoecVqO8a4xLpXCqyF4vhqsjkpTBY4D42MpiY
 e3NKF5kDOKila6+36AhmHXeX7nvZWzJq8w5SIiGEABdTgYpA8TctkqMRLt1HqL0BRQV/
 QK81/DTifgw82+WbGYV3Y1u+u89E3BjyhfqhI0DmXzPPdx5eUYoayKf5QrW4JN5KuiVK
 1F/gMHyoLhUVHcuqotM27jzOcmVF93Ft40QlrxEaShOEKVGIsD3TH+L7nb2VaLDnrgYB
 5xGg==
X-Gm-Message-State: AOAM5304i4kJajJZm07Rn+2381Xjs1Te2vf2+vJAlJzsHMLJi0SLlzKM
 JdvbxquJxsvcI2y5MQXCgcN/1pDZ
X-Google-Smtp-Source: ABdhPJzhAGr6Op/TeWDb0VvadHmb4gSpgEwNbReyd7sl7P83jP+K7QUhGRHqdlvuf4O/kMN+B2qGSg==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr2544992wmf.4.1594104408454;
 Mon, 06 Jul 2020 23:46:48 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 5sm2172545wmk.9.2020.07.06.23.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 23:46:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/avr: Few fixes
Date: Tue,  7 Jul 2020 08:46:43 +0200
Message-Id: <20200707064646.7603-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few fixes on top of the AVR merger series Thomas sent yesterday:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg720089.html
Based-on: <20200705140315.260514-1-huth@tuxfamily.org>

Philippe Mathieu-Daudé (3):
  target/avr: Drop tlb_flush() in avr_cpu_reset()
  target/avr: Fix $PC displayed address
  target/avr: Fix SBRC/SBRS instructions

 target/avr/cpu.c       | 4 +---
 target/avr/translate.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.21.3


