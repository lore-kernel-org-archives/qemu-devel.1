Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF4BC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248C720678
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJ/YqrK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248C720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlPg-0005VT-9d
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDp-00069U-1b
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDo-0002fq-0e
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDn-0002fI-Qo; Sun, 12 Apr 2020 18:36:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id u13so8049446wrp.3;
 Sun, 12 Apr 2020 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s0AvIH4tmhY8dJIWOooS3DYC6YTsxY1MNRofHTiR85M=;
 b=sJ/YqrK5TugYkQl5sc0s15+oijPE5rmDui2mmm426O3nS20g7Iqp2ltIuK0f0PBihj
 zN6rI0IbarDeMJvzhgzN9dAl5a89IN8iFLiBum11DWPxCw34nwRQPRZzxNHaNfKXKlW2
 3taNV/vYtbmHh/XkeiuNMqVZjraJ3zIsdVqLGCmZTcQyZKjdTiOL9h1wbUaVF+0ZIM/L
 DGJBtNsbKlG1iR82A/FsRGmUt7tk4ZuyMSaghR9c+hSJ9RlLPWMs8rR5eKpmHlnr17Qc
 Ivmo5Ie0zkDMFGMzDIuZpSKSnvsu/cAiaozPT7HkKGLTxUzqrHA8VBE9EqiE6ToGqcz2
 mB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=s0AvIH4tmhY8dJIWOooS3DYC6YTsxY1MNRofHTiR85M=;
 b=ikRldUAQPJNeIMPDLYBR9S+CYksDluwOWCm0HWTT9e+OTuxe7vxJAOixuElaU61a+i
 tgAd0Zk3YVWbxV7Q7qkWdgTmQmgQtuk3X1NZ/yQRPSpoSH+h9bajhxCkGPnv5q8QRddU
 H5KUNFjGwxTNCxsRCekD4caVqRAsbGMiUc3PUUkcDYfNz0ruXTn2i/ZiqjYKZJTEDJSz
 ypfOGPSjTPOZ4ZxEW67pJxu7xGhNHeOi9kDEGJVC7W/T8Yyt9Rp92jcsxjECszzo1mJS
 tKAMkrhN8Z2CbFeg/wTle6MuL3/NPIQKj+U2GZK9i3JJmjgfWsw5om5DJj9hfiibEftM
 Nw6w==
X-Gm-Message-State: AGi0PuZAcdWTnR6YwJ5TYAlekcq7UeW6/dzqkm01oSkm3WFMB1kLJNci
 OTtOIxHOs3DY26EKrsBkweKVyfYGmTZNTA==
X-Google-Smtp-Source: APiQypLXH/6sQRIVIVNKxcaxLPq1HWiNj+xu9u69ExZwdmp1hQGbfDARpX36GS/jz/BXjj5w6OycLg==
X-Received: by 2002:adf:ee12:: with SMTP id y18mr15131900wrn.289.1586731018704; 
 Sun, 12 Apr 2020 15:36:58 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:36:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 10/24] hw/arm/fsl-imx31: Move some code from
 realize() to init()
Date: Mon, 13 Apr 2020 00:36:05 +0200
Message-Id: <20200412223619.11284-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
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

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: hw/arm/fsl-imx31.c
  >>> possible moves from fsl_imx31_init() to fsl_imx31_realize() in hw/arm/fsl-imx31.c:68

Move the calls using &error_abort which don't depend on input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Typo 'depend of' -> 'depend on' (eblake)
---
 hw/arm/fsl-imx31.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 8472d2e911..61287e24f6 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -62,6 +62,8 @@ static void fsl_imx31_init(Object *obj)
     for (i = 0; i < FSL_IMX31_NUM_GPIOS; i++) {
         sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
                               TYPE_IMX_GPIO);
+        object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
+                                 &error_abort);
     }
 }
 
@@ -191,8 +193,6 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
             { FSL_IMX31_GPIO3_ADDR, FSL_IMX31_GPIO3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
-                                 &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.21.1


