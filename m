Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50885C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 15:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5E02082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 15:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVCNzkT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5E02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2zgl-0004Xu-94
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 10:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2zf2-00021O-T0
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2zf1-0001wb-Ay
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2zf1-0001uW-0b
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581781633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tYltBhqeLQxUZGR54w7qQJk4/DruklmbGosv+U0bRqA=;
 b=PVCNzkT4fBTSksUNMHQ11nn8tq+3mqnZ+HdDanFwBm0mlcx6iH2ynThZhpfshPr4hH122V
 OkSEU4SDMOVgG/pv9HwVks+ab3MMF0vuzc34u+Py10GVo1lEpZaGDD34jVYQGqB5HvL3H3
 DVfgafgxc9Yn6hlf57KNbe7SsnVrVo0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-ytT85LooOwSFZ5R3xbfgdQ-1; Sat, 15 Feb 2020 10:47:10 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so5894450wrb.21
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 07:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0wxRUNRl7KOON5G37/w7XMRZyrfBR7Zs/f868HWcC2c=;
 b=CHBvZ1NqME3PmsJrXaus+idPkadXLyGIPssUGVd28xZBMakNo8RXCPxUvxDxDOllCy
 ae4uJH2wHylMqsrA2k9oWitniNTvTJO9Vn9iD707EjgTrg8XlpdirVdQAvmmOTSQ8ghh
 73pSS91Cswq26TJ108ttwMsWXsPBHgU8E66tv45duCx2pKvbHBmzxd4mr7j5naXXS57+
 bjHHkzI3RiWnBfuiPz/up1I5AxAumYBQu91P/NJ78YuiamB1aQ+HpACsXDTXp11Fi4ir
 V7V7DcLFiRao/VGht825OsLwlZRSuDUmUWrjB3XVwctWFUIa5VXkee2FqjeeCJbGBs+g
 XsWw==
X-Gm-Message-State: APjAAAXZRObY6vLK9EcTYDe9InO+jfBgVtstCLbgEZVGx4A1orhF0Q6z
 3WvrVV1TJAAkHO9KYI9JHQyN1XgT5oMFlM/zoscI/ZbbU4KaABP8nkpGu37H1IrUFuBEvDKWp4k
 o+YABRZuc2K/dBOk=
X-Received: by 2002:adf:df8f:: with SMTP id z15mr10346288wrl.282.1581781629509; 
 Sat, 15 Feb 2020 07:47:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjXpSZDNpAJ43JenBouT2jCMUI/AjDNk1/MbphCJr39U2Efno7atbzqmiHXT1PRUVA/Qe9UA==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr10346277wrl.282.1581781629315; 
 Sat, 15 Feb 2020 07:47:09 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w26sm11766519wmi.8.2020.02.15.07.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 07:47:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw: Delay timer_new() from init to realize to avoid
 memleaks
Date: Sat, 15 Feb 2020 16:47:04 +0100
Message-Id: <20200215154706.19837-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: ytT85LooOwSFZ5R3xbfgdQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After reviewing various patches from Pan Nengyuan fixing errors
reported Huawei's Euler Robot, I wrote this tiny coccinelle script
to find all occurences of this pattern:

    @ match @
    identifier instance_init;
    typedef Object;
    identifier obj;
    expression val, scale;
    identifier clock_type, callback, opaque;
    position pos;
    @@
    static void instance_init(Object *obj)
    {
      <...
    (
      val =3D timer_new@pos(clock_type, scale, callback, opaque);
    |
      val =3D timer_new_ns@pos(clock_type, callback, opaque);
    |
      val =3D timer_new_us@pos(clock_type, callback, opaque);
    |
      val =3D timer_new_ms@pos(clock_type, callback, opaque);
    )
      ...>
    }

    @ script:python @
    f << match.instance_init;
    p << match.pos;
    @@
    print "check %s:%s:%s in %s()" % (p[0].file, p[0].line, p[0].column, f)

The script produces:

  $ docker run --rm -v $PWD:$PWD -w $PWD philmd/coccinelle \
     --macro-file scripts/cocci-macro-file.h \
     --sp-file scripts/coccinelle/init_timer_new.cocci
  init_defs_builtins: /usr/lib/coccinelle/standard.h
  init_defs: scripts/cocci-macro-file.h
  check hw/ipmi/ipmi_bmc_extern.c:505:24 in ipmi_bmc_extern_init()
  check hw/misc/mos6522.c:489:25 in mos6522_init()
  check hw/rtc/pl031.c:194:15 in pl031_init()
  check hw/arm/pxa2xx.c:1137:19 in pxa2xx_rtc_init()
  check target/s390x/cpu.c:283:8 in s390_cpu_initfn()
  check hw/sd/sd.c:2061:26 in sd_instance_init()
  check hw/arm/spitz.c:527:18 in spitz_keyboard_init()
  check hw/arm/strongarm.c:402:19 in strongarm_rtc_init()
  check hw/arm/strongarm.c:1244:26 in strongarm_uart_init()

Pan fixed most of the occurences. This series fixes the last two.

Philippe Mathieu-Daud=C3=A9 (2):
  hw/ipmi/bmc: Delay timer_new_ns() from init to realize to avoid
    memleaks
  hw/sd/sd: Delay timer_new_ns() from init to realize to avoid memleaks

 hw/ipmi/ipmi_bmc_extern.c | 12 ++++++++++--
 hw/sd/sd.c                | 12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

--=20
2.21.1


