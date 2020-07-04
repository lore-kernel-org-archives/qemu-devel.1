Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE00C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A766206B7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIhGHE4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A766206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjgx-0007i8-8p
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjV7-0002tg-A5; Sat, 04 Jul 2020 10:50:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjV5-0003xI-Pb; Sat, 04 Jul 2020 10:50:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so35784575wrn.3;
 Sat, 04 Jul 2020 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uE7YqG+qACaG8Uud6yeGxAsfWVnV3rkTeBq37HQj1qo=;
 b=sIhGHE4QN5ORR+3/Mgnoaxt2dRH9Duka3DMpiaQTVgS1lpSJEJ8KEB4VjCSKQqSlfc
 HwpmkE15woH+abTAT5VLKiyhb0Zq+u1XvalFXiALNHpXyYLuDGhlcjr3PJjaoEf3+FY7
 4UjhgJzhzYvcqHRKWwR/aqKYvEyqZ1yrs8FGt1f9ohuKcUlxQe/dtogbIP9H2gOPTdM+
 X1mnhOjui1Vk5B+Xa4Ju6b+X93HolCAPQsIP0PCVa5noiOK0+NH5/fSK60TLZZ4znABy
 cKKta1I+QCL7DFqQUZxr5qs5kGd/t289lAxS+UdQKR8b+NnivhadaJIHkJJVNpWJ4AOo
 xV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uE7YqG+qACaG8Uud6yeGxAsfWVnV3rkTeBq37HQj1qo=;
 b=iEilyWCOzbCQ+yGmY4aIeEvnwcGhx4VVL9JGJSuRJMfU9GZO8p5m41Z/lyQIFdIrU1
 SFS3DwwCpTFnxFxe5f2VL5XxNslSdMJNJms8xUK06HwaUUNuH3HOEfoZMcnwqKQ3lSID
 AdAmpOqf5L3ZVSpSdnbNuTAsYeSVlVoqBdIQCWFGW719Sw5/gkvrls8M9jUIAfcfE5tv
 J767Ldd+hmd9pji9fEnjSnyNIoirFTlZZ8aTrsIrfXHJUzXRH8ul6sNLJHgTVcGUw2dt
 YoEiQ5/07IjwlUnTZxvfcz4XlKaUrFhe7J76jmgrzWS8y8TSKA/qpolghPo6H9KUZkeA
 +NLg==
X-Gm-Message-State: AOAM532SGS6delwp1vh9wnsCESGPi+1A56rVv5ecEJIPXacnjjRkt5s8
 V7A+a98sRuv4+MuhJy6nA3/NaZ6AXL4=
X-Google-Smtp-Source: ABdhPJw68YNz9StYiIER/Bcj0m+eoPkR5IWJU/SRvblSzDy3zWSMVqWNGeAGRScY2s+A4+/iXWgZVA==
X-Received: by 2002:adf:9561:: with SMTP id 88mr11043924wrs.240.1593874241665; 
 Sat, 04 Jul 2020 07:50:41 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 26/26] MAINTAINERS: Cover dwc-hsotg (dwc2) USB host controller
 emulation
Date: Sat,  4 Jul 2020 16:49:43 +0200
Message-Id: <20200704144943.18292-27-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an section for the dwc2 host controller emulation
introduced in commit 153ef1662c.

Cc: Paul Zimmerman <pauldzim@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2566566d72..e3f895bc6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,6 +1651,12 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
 F: hw/usb/dev-serial.c
 
+USB dwc-hsotg (dwc2)
+M: Gerd Hoffmann <kraxel@redhat.com>
+R: Paul Zimmerman <pauldzim@gmail.com>
+S: Maintained
+F: hw/usb/*dwc2*
+
 VFIO
 M: Alex Williamson <alex.williamson@redhat.com>
 S: Supported
-- 
2.21.3


