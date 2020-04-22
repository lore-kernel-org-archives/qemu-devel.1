Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5706BC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C322076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gf+80bbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C322076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFcT-0002T0-6x
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUV-0006iL-IM
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUU-0003Xq-JD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFUU-0003Rz-4n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C4mjVc4GupZqidy/jN6Lg6n+I2oMBFVaLfmcbIurl0=;
 b=Gf+80bbnZkPvcbufQhEQdBJ7zYPNmK/5fYf3Q7jUJcZLcBFvMddxjpTChD7oB9mr+MHks6
 5cGvi4L+rCfpErz2IRuYZfqEOpis9SlrgAxn7WC+JQtDUDs1QcqJfB+MXWzj7g64AaIhaG
 AnTIKPIlrn3izv6ZbGLP8XPdhYot2fg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-sdVPOeqfP7C_xI7wKdjXDQ-1; Wed, 22 Apr 2020 09:32:36 -0400
X-MC-Unique: sdVPOeqfP7C_xI7wKdjXDQ-1
Received: by mail-wm1-f70.google.com with SMTP id f81so809007wmf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dq75PFzgynrFGY6/YI8kQB8GRBvNE4I9mXbmGtzIHFo=;
 b=s1bFYSh9wx2A+KtLN0ftoImqgv7AJ3fGslDbH5jnhIXdXChWELr3MDXFSxWkGYoMLD
 jViSNzJ71GRaGAGq0YpeKQKET1GmHCdJ87CFnvS9b8IYu8C9ja7YZMZjxrXdcOphhQI2
 6JVIVoY2Doq2hmRcAy2BPScGQxqo0POsW7gz4gHvK4XAmmWOAwOL2MIpyUvaWNkR7Kee
 PJVW5g+Ft/LIl0pk3Nvj+fAFpKC8LAMzB7TZqV/TfrTlySARQDaZQO3dOm4bzthl3k/L
 9tMH5jC7X2oC8MfEZ7AOG4a9Me1j8sumCuzWnmLK40leXOeL8N2snMgHUktlsGcTUhwr
 qkDg==
X-Gm-Message-State: AGi0PuYwWGr/P1GvedoyAm71+OiKi/GaBjvc/LKp7vatFmwWhTAkAN8R
 iAFKpZm8Zx3lR4EY2j7chta17mFc+J49shztUGAgIadRTvy2zalLLb876RTN3Ylho1Yu16WwEyG
 i3n1Egg2J88EjncU=
X-Received: by 2002:a05:6000:1001:: with SMTP id
 a1mr31239578wrx.9.1587562354687; 
 Wed, 22 Apr 2020 06:32:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypL5S5fiw1pjeVHXAqixPkISK1j3A4uJRvzr0tgSExLtCfCpYkFUbSeWRoEQ0hralI1T6KA8dA==
X-Received: by 2002:a05:6000:1001:: with SMTP id
 a1mr31239557wrx.9.1587562354470; 
 Wed, 22 Apr 2020 06:32:34 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h5sm8860641wrp.97.2020.04.22.06.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:32:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] hw/timer/stm32f2xx_timer: Remove dead assignment
Date: Wed, 22 Apr 2020 15:31:51 +0200
Message-Id: <20200422133152.16770-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
References: <20200422133152.16770-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/timer/stm32f2xx_timer.o
  hw/timer/stm32f2xx_timer.c:225:9: warning: Value stored to 'value' is nev=
er read
          value =3D timer_val;
          ^       ~~~~~~~~~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/stm32f2xx_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 06ec8a02c2..ba8694dcd3 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -222,7 +222,6 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr =
offset,
     case TIM_PSC:
         timer_val =3D stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
         s->tim_psc =3D value & 0xFFFF;
-        value =3D timer_val;
         break;
     case TIM_CNT:
         timer_val =3D value;
--=20
2.21.1


