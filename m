Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B92C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED61206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tnf1IWH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED61206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgrT-0002Ku-BP
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgpy-0000my-RN
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgpx-0007Wg-Ed
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgpx-0007WR-8X; Mon, 20 Jan 2020 18:52:05 -0500
Received: by mail-wr1-x443.google.com with SMTP id j42so1262906wrj.12;
 Mon, 20 Jan 2020 15:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s1igqKfCso4sFnyZZ3LURygk4ICU58gQAal/3CWVEAU=;
 b=Tnf1IWH0vEnqN+foKGOhpWul2mMrZGPXm+xrATws3uESCw3hBk8aUaSkAwrF1/DE3/
 ofOm6Q9QhSjkobenwWkGO5ZY2zF8u+a+lVsVv08fWWhgiaM38XSDzoNTm+EQHv9lBJVG
 HNKbmCZ/8OX94sBHY/tF0G1gy0mRgjjKgUJnPh8VCRULTpIkPUIvsFYXKtBERwjbwT01
 Qj0WJoi9ZZXXhrCK7VP0+dThzOtPjtEm769LKJmWY7R1UtaTIY6Ys47ONBexVsiwVXPr
 IxQ3zRiCbOiWpiwdJZ38nEyvET6QEycbvpyoR2UdyI0O08Xd/oKhBRM/4K9yMVCXRr9k
 wvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=s1igqKfCso4sFnyZZ3LURygk4ICU58gQAal/3CWVEAU=;
 b=kS9Qv6PihO2oTkLx9K8knItip6SLupU+lP6GzYJec7pPxyVI5zvFxZwkwl+Y9Ro+cZ
 +SpkM487f3I37jcr54wWWWtvHZ9bdzcT8Ej+gpUQrpuKmdQI7JChghXrjf09bwnhR7W/
 Ri8IYayZzFZOgglI1hTUWMgd9sCKX4hC7tCH8zkgWDRk4P4DMSy2ZPTMiuVAgZYZGSOI
 piCOIbMBIJzmGkRNiP2BTaSzpHnhoZa+gFrklcLG6nr6geBMlcrrB3f/7kXUW/6tSzls
 l6DfXHvBKSClqXZceQbC/g6xujm/rtGq2tPevWXA4pr76rHUtNrcoz425oHXiZoqeq9d
 uLoQ==
X-Gm-Message-State: APjAAAUDr+Cgnk7AfQW8JI9Wt5BSgSYYDSgAXwKkGn2r0pnQeqH1L19X
 nupDK1ZgUIf7U+GkUAX3yp3fRgmk
X-Google-Smtp-Source: APXvYqw9JyDJc4GbeC6oCGMjB22taeNI2Xms40fwXS0CF5oAoXKRO8RpAOFjeNgk9HIICMLC2/VOUw==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr1806117wrp.355.1579564323829; 
 Mon, 20 Jan 2020 15:52:03 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm48655269wrx.71.2020.01.20.15.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 15:52:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/7] hw/arm/raspi: Remove obsolete use of -smp to set the
 soc 'enabled-cpus'
Date: Tue, 21 Jan 2020 00:51:53 +0100
Message-Id: <20200120235159.18510-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120235159.18510-1-f4bug@amsat.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 "Emilio G . Cota" <cota@braap.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we enabled parallel TCG code generation for softmmu (see
commit 3468b59 "tcg: enable multiple TCG contexts in softmmu")
and its subsequent fix (commit 72649619 "add .min_cpus and
.default_cpus fields to machine_class"), the raspi machines are
restricted to always use their 4 cores:

See in hw/arm/raspi2 (with BCM283X_NCPUS set to 4):

  222 static void raspi2_machine_init(MachineClass *mc)
  223 {
  224     mc->desc = "Raspberry Pi 2";
  230     mc->max_cpus = BCM283X_NCPUS;
  231     mc->min_cpus = BCM283X_NCPUS;
  232     mc->default_cpus = BCM283X_NCPUS;
  235 };
  236 DEFINE_MACHINE("raspi2", raspi2_machine_init)

We can no longer use the -smp option, as we get:

  $ qemu-system-arm -M raspi2 -smp 1
  qemu-system-arm: Invalid SMP CPUs 1. The min CPUs supported by machine 'raspi2' is 4

Since we can not set the TYPE_BCM283x SOC "enabled-cpus" with -smp,
remove the unuseful code.

We can achieve the same by using the '-global bcm2836.enabled-cpus=1'
option.

Reported-by: Laurent Bonnans <laurent.bonnans@here.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Emilio G. Cota <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/raspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 6a510aafc1..3996f6c63a 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -192,8 +192,6 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    object_property_set_int(OBJECT(&s->soc), machine->smp.cpus, "enabled-cpus",
-                            &error_abort);
     int board_rev = version == 3 ? 0xa02082 : 0xa21041;
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
-- 
2.21.1


