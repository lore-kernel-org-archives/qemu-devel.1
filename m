Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2B4C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BAE20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHEu0COV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BAE20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutV7-0004w6-0B
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jutUS-0004Pi-TZ; Mon, 13 Jul 2020 04:07:08 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jutUR-00041b-CT; Mon, 13 Jul 2020 04:07:08 -0400
Received: by mail-oi1-x242.google.com with SMTP id x83so10257399oif.10;
 Mon, 13 Jul 2020 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u3c6nzETiRerzsAAkRnLd14naRzeIdzULOJdcj7F5N0=;
 b=MHEu0COV9uxYHK8bkFedzbidnkUddVP/86HvKo/C6lYUfiKE12knI5HKt/FymvcAKF
 1T0Chc7MQe0QPWlpea/RKitpJCGcrnuHPyy50gVlgGUE8yOBLF2VenyjGZaU1M+fk7xG
 BVtBT8ICD/xG4dqLFJaq0R5wSDK3EX8F1RHG92Mvgt6m7egQakPBJyJQo0RC0Tyk1Yz1
 7NhIF8aBOLNxrroNx6hVj+iFSWNLLRteZYZ3gk/W03oVh5ROSholtUkfESt/I1WHsdgg
 nDkmjvXwUCTHQx7pqFtlN1DIBbI/19s68pcwG1zOcdDO2o1VMBk4LX3zDs8YGJqcpIia
 Vomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u3c6nzETiRerzsAAkRnLd14naRzeIdzULOJdcj7F5N0=;
 b=aelvZkG1pCc61UviFn20I0aHvTqFHnPqGVLKinsOvup4enkZStC45sJLtTQBLvO/tj
 cJhjyP84WoQl9F50dBlVRhRNVDZEiDI+mmb5p3HQeRTht+WVpul6nUlT4Zn1OuMST2je
 jmyVGdzaLuHeGFoI4IwjYv5a+HdxawKnCjaWDBIfZ5tJtU396rNf2+PUKOo4d2PjuIIa
 LmpRO57eSufzAvCSxLovjs47hMs2G0n9GjTBGC1pbtGqAGMSlDI0Kk2RhK6xzQk+0SCK
 vo9kYBVlWo3Dof5Iu+pEWiL3VjBMnt9Q7Todcvkn4zGA+DgUOjzUpnYs39feE9XmfzzM
 SoLw==
X-Gm-Message-State: AOAM532IuXTEof4qirbPG3LibWKtT1u5OmQgLg6klkqKSPsUla0LP3G+
 +fO6L+IpawDvt4cc2K0ck42pAypMZ/mVJueY2HGpvj23IvI=
X-Google-Smtp-Source: ABdhPJzh/W93gz7J/EmB6nGLh1haIZXkd81Lkr4ql3wOEsTBBpyr6AJtVEbp34JRvbSoGBT61znCzGLbTKui17LXelo=
X-Received: by 2002:a05:6808:a19:: with SMTP id
 n25mr12349271oij.84.1594627625317; 
 Mon, 13 Jul 2020 01:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+MHfoubt1g2FzcjTw3a0vNr7X2T8Jb+nYoc4_x=Z2TP51afKg@mail.gmail.com>
 <a7acba46-5a9a-5dd2-71c6-7e4586485823@amsat.org>
 <CA+MHfot6FdS2yT0mEsCW36bCfwy-WY-1KPQ-KDfYBKzTy=Gd7w@mail.gmail.com>
 <CACPK8Xdqr+EufMgooCY=D+Vt98qu11YTHE5Fzi5+xqX=wKReeQ@mail.gmail.com>
 <CA+MHfouin6Zmz+GrjWRCc_WzPF=ff-z_5V7BLv0HkL+SW9bRoQ@mail.gmail.com>
 <8879bfee-752b-c4e2-7646-c42dec84a440@kaod.org>
In-Reply-To: <8879bfee-752b-c4e2-7646-c42dec84a440@kaod.org>
From: Erik Smit <erik.lucas.smit@gmail.com>
Date: Mon, 13 Jul 2020 10:06:54 +0200
Message-ID: <CA+MHfou6ijtwjzWye6CKaqTa4sKxF1WmgH9juaSdO344uP2UZA@mail.gmail.com>
Subject: Re: hw/misc/aspeed_scu: 5d971f9e breaks Supermicro AST2400
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi C=C3=A9dric,

On Mon, 13 Jul 2020 at 09:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> With this patch, the supermicro firmware boots further but there is still
> an issue. It might be the flash definition I used. The machine is detecte=
d
> as an AST2300 SoC which is weird.

> BMC flash ID:0x19ba20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
000

The firmware is expecting the flash ID to repeat. The following makes it bo=
ot.
Not sure if this is the right way to go.

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 8227088441..5000930800 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1041,7 +1041,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
             s->data[i] =3D s->pi->id[i];
         }
         for (; i < SPI_NOR_MAX_ID_LEN; i++) {
-            s->data[i] =3D 0;
+            s->data[i] =3D s->pi->id[i % s->pi->id_len];
         }

         s->len =3D SPI_NOR_MAX_ID_LEN;

--=20
Best Regards,

Erik Smit

