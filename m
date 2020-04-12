Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2525C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5B120678
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eziZT5VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5B120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlP8-0004Am-MW
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEM-0007Yt-Jn
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEL-00035N-Jh
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlEL-00034z-Dw; Sun, 12 Apr 2020 18:37:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id 65so8551368wrl.1;
 Sun, 12 Apr 2020 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f8mojAlRUdlR/2NknA9ZDyMqw2xlNW4cv+f7vBTxHaE=;
 b=eziZT5VRpWIAND8SYyKHzijX/5xYTrfYTlPUcRQYAPxRa668XdW0jOPhlDojMaEV7p
 2SP40m65aD/PN6dmSemcJ7snSHqvPG9wmFxqxY8hyI5zgQ4k72U2AeornVZbDxNouSXv
 9xdN8ssu/gHRojGMjx8NOoCJBpooHyRNeJqiteQGn/Eod7g0lVyZPIM4yHq+JuX7OBfQ
 UV/PEndKzXUXZ7dV+b3VbzDM3h4pkRHPES4yayiu+nHUXwXP8Az/e7+dvpQtYLNc4W+H
 Xj3j1Bk9tLBdrhBoI7fUtJ1OAw9khMjV+azIuUu+HM+x4Pby7/hWOLjdLX5iVE0RkN90
 JtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f8mojAlRUdlR/2NknA9ZDyMqw2xlNW4cv+f7vBTxHaE=;
 b=UikYRy83umpNf4liS/lKHGa8vzkg1YjHPm0UkqGSbUDSWsigDlOSu2JQEogmZvKA9d
 DsAHwEahXPNZ+yrSeJa3Pi+n8lYPkHSU0McD2NyyrF8MRldN1IdFCX+3ovBiL1LecFXU
 PlGZEgA9+MX/kFr76efk+vLf7UGMysOP8C6rjObmS6x3kpa8qBxQVSUsvqsg07+JU2J2
 bTSUdVObLoNPWKISkrHJ7kP5WxO9NEHBAWUZdEti7BvhnwY3KtvQiUWu/03APQpHDiDe
 aTwz/7GA71F/rIYuy0t2uqHidFI4eemM8dvvdD5XY1dYB8Ct49dXFw5tKGGo2ppDKuoP
 6kYA==
X-Gm-Message-State: AGi0Pua33YqZbxZi/gsZIW/j31h4sAdL/uGHXg84Wx91HE9clL8GFvNJ
 xGEtdJVnnTX/2U1tfCirnzF8I8O3Vm0tig==
X-Google-Smtp-Source: APiQypKhADx8IsEhdzPX+miCokTZ08hDMUeYWbAJvUHG+uHvi03tXxbe6BnsWTdx9nq8xzvRWtrlww==
X-Received: by 2002:adf:a345:: with SMTP id d5mr12993154wrb.23.1586731052287; 
 Sun, 12 Apr 2020 15:37:32 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:37:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 20/24] hw/riscv/sifive_u: Use single type_init()
Date: Mon, 13 Apr 2020 00:36:15 +0200
Message-Id: <20200412223619.11284-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can use a single type_init() to call multiple type_register*().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/sifive_u.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 998666c91f..9c90c94c33 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -601,13 +601,6 @@ static const TypeInfo riscv_sifive_u_soc_type_info = {
     .class_init = riscv_sifive_u_soc_class_init,
 };
 
-static void riscv_sifive_u_soc_register_types(void)
-{
-    type_register_static(&riscv_sifive_u_soc_type_info);
-}
-
-type_init(riscv_sifive_u_soc_register_types)
-
 static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -627,9 +620,10 @@ static const TypeInfo riscv_sifive_u_machine_typeinfo = {
     .instance_size = sizeof(SiFiveUState),
 };
 
-static void riscv_sifive_u_machine_init_register_types(void)
+static void riscv_sifive_u_register_types(void)
 {
+    type_register_static(&riscv_sifive_u_soc_type_info);
     type_register_static(&riscv_sifive_u_machine_typeinfo);
 }
 
-type_init(riscv_sifive_u_machine_init_register_types)
+type_init(riscv_sifive_u_register_types)
-- 
2.21.1


