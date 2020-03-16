Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFBBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A07E20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsI0I7FY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A07E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv6n-0007Vv-EF
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDup9-0007r7-Ib
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDup8-00027f-J5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDup8-00023E-E9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVXGSPxot8hczQz2J5IHTqJPn4YWY3H/+Nf8/tep/GA=;
 b=fsI0I7FYHxuNmYyj16gckFJebc/2pIqOyaWu1BglUyaKiCPt/wbomSwhS0P9eQfuQIbqML
 JJ/v0WdzH1QX3jkgRvDZk++ABzrpmHKSTlxURVnaATVbYiFfhxYn7AR3C7FRmkctzLen32
 f0ANEXBcm1QLzpjy0OT70EyIJRq2hVE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-NrWvU37BOH21cJSQmtDrxQ-1; Mon, 16 Mar 2020 14:50:46 -0400
X-MC-Unique: NrWvU37BOH21cJSQmtDrxQ-1
Received: by mail-wr1-f71.google.com with SMTP id l16so8749408wrr.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n5kS6EiiI2CJmBCx9jFtPHKM4BcDVAnb98D+QFJyFl4=;
 b=PAhj9IHqkqKt/epC9CF2bes1e6TUjNkVfBDwgal0q0j8ptienCsYTaV7eB9gb6r0pe
 lJvmiQ3Vw0mMzq28jrfndT51bFApTaFG9Zhjfe3sRxqQ0yjIgf6gfCQ1eDhkq0mHwImi
 aQyqKXs0MGuefixwMnbkjFNCNHqEmWTGqE6R/UuGER8oNuroEA9/NZxMxdhlzzEjTO0A
 Yzo4knOzTeumWLWc0RdD55GGOZsOdAYaYRoxG5k9a22WnJDJPlpKTF3UgxVae1pNzIng
 rWGTXuYyT9Ix1cnNH3G/obzzp7cME6wj21JcBTINUnbUgIaMxjx9Gwgb8izOxkY9xtEh
 ncgg==
X-Gm-Message-State: ANhLgQ3WcQI0Y1HgGZvGqqBD/Kx0vbolUvpevUeQi7HTBJycOgE9lUBx
 yEyhXLMBGYtlvNYZ1A/WXiR5FSP35SFiJpYuRBOy6QGQh0FOtgPOfUdZLK+QOexeHlquv6jnWfC
 bqrvLrT7ULO04qF8=
X-Received: by 2002:adf:eed2:: with SMTP id a18mr761697wrp.59.1584384644868;
 Mon, 16 Mar 2020 11:50:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vujUgKKQsz8YH3FWEJO9HVduH1cIw0ZQ6bqlikQYm/FweiEVy96zoMzg8SD0wXEjW51QSWRSw==
X-Received: by 2002:adf:eed2:: with SMTP id a18mr761679wrp.59.1584384644664;
 Mon, 16 Mar 2020 11:50:44 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id f203sm722111wmf.18.2020.03.16.11.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 07/25] hw/m68k: Use memory_region_init_rom() with read-only
 regions
Date: Mon, 16 Mar 2020 19:49:48 +0100
Message-Id: <20200316185006.576-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/m68k/q800.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index c5699f6f3e..81749e7ec6 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -399,13 +399,12 @@ static void q800_init(MachineState *machine)
         uint8_t *ptr;
         /* allocate and load BIOS */
         rom =3D g_malloc(sizeof(*rom));
-        memory_region_init_ram(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
+        memory_region_init_rom(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
                                &error_abort);
         if (bios_name =3D=3D NULL) {
             bios_name =3D MACROM_FILENAME;
         }
         filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-        memory_region_set_readonly(rom, true);
         memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom)=
;
=20
         /* Load MacROM binary */
--=20
2.21.1


