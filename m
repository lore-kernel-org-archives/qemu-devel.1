Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2510C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 20:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8812065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 20:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rW+MyXSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8812065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgDAE-00018S-Vw
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 16:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jgA50-0006YZ-Hp; Tue, 02 Jun 2020 12:47:58 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jgA4z-0005GU-HZ; Tue, 02 Jun 2020 12:47:58 -0400
Received: by mail-ot1-x343.google.com with SMTP id 69so11451830otv.2;
 Tue, 02 Jun 2020 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=0sRZuUdo7NhJjpmZ+QsJQg75Tos1es5ONp8As8ZlHQw=;
 b=rW+MyXShdOfwkGOVtpsFUC9U0UcKAGwKrPZb6ff5G5ELomvSxI3PUSDi57cgc1MI0f
 vAtoxt4EXXqI6sHoJRyD4UnveZRfZoe9fChuZJ9YFyh47hTy/9PcsuZVVQcnuvtWCHPm
 tPATFQtwbdHQbmrgqhqzCTITTk6yolk4N2qOCTEq8LIbNK0Icx9X2WkJZZgIcfp3s1sf
 Zzgdv01eUzpCm416TOB74K8J0+fZ8TyBKNmFUCmZMO/0sfDbV+W9IF366XAlxTcI3Vb4
 WzFcy9t7z+d95yClD7BhFI1zB2hx/sf+OlBH3UzZnj7N4dDzqA2RIgCd+ePOjNE+8txs
 D9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0sRZuUdo7NhJjpmZ+QsJQg75Tos1es5ONp8As8ZlHQw=;
 b=YAf4aBcJpp11kn7wAPH6WngrYFXk9NecRqgHLonDMd7ut/7N5xSuh0NxmQjd8MVbES
 OHdB1cTpcXXQULp6vn4+OSSmKJkH1FqaiaqXaRJK4T1/BEoFfSj9OD29L6A2vZXCdkAQ
 gbQOFdj5QdEGmvE28aVihYnZc5znoS3nvP4ZOvtaw0443nRMNZ5gJfFyd1NRnOeJbfvl
 eSUa6xVZWU4zAR7VL0gNabm6FrDgr5ysV5/38HAjpy2t+YZWx32oN+zLk5pbMhuMX1NQ
 d6UGtR01lWD5Rfdu8n029RhzOLEYt56ib0k8hXU60n5VnTv4Ma55Sy823wsRYrEEmwWz
 6wtw==
X-Gm-Message-State: AOAM531lTO4azqIaTOEsDtnbOouLrP814QngpbNlQUUbKVlW+MCW3z9S
 SGrritKiigk2qQXF4W2fsBL8rPxJSBO8p9aTnno=
X-Google-Smtp-Source: ABdhPJzZ8mBb3yS6rmt/wHeElq0j5g0TRPlWJFjn6SJWRVJogeCBHsMNcIqJ1SufmhOZnRtHlw21Nzx8kkMvVA0uG2A=
X-Received: by 2002:a9d:3f35:: with SMTP id m50mr179709otc.120.1591116475385; 
 Tue, 02 Jun 2020 09:47:55 -0700 (PDT)
MIME-Version: 1.0
From: Erik Smit <erik.lucas.smit@gmail.com>
Date: Tue, 2 Jun 2020 18:47:44 +0200
Message-ID: <CA+MHfov0TVbwjy8g_cHVa6Y-bMowCbsGLdt8uUhmcns0v_eVLw@mail.gmail.com>
Subject: [PATCH] ftgmac100: Implement variable descriptor size
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 Joel Stanley <joel@jms.id.au>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004fcaa405a71cac44"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2020 16:04:31 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004fcaa405a71cac44
Content-Type: text/plain; charset="UTF-8"

The hardware supports variable descriptor sizes, configured with the DBLAC
register.

Most drivers use the default 2*8, which is currently hardcoded in qemu, but
the implementation of the driver in Supermicro BMC SMT_X11_158 uses 4*8.

--
The implementation of the driver in Supermicro BMC SMT_X11_158 adds 4 extra
4-bytes entries:
https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.h#L387-L391

And sets DBLAC to 0x44f97:
https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.c#L449

There's not a lot of public documentation on this hardware, but the
current linux driver shows the meaning of these registers:

https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/faraday/ftgmac100.c#L280-L281

        iowrite32(FTGMAC100_DBLAC_RXDES_SIZE(2) |   /* 2*8 bytes RX descs */
                  FTGMAC100_DBLAC_TXDES_SIZE(2) |   /* 2*8 bytes TX descs */

Without this patch, networking in SMT_X11_158 does not pass data.

Signed-off-by: Erik Smit <erik.lucas.smit@gmail.com>
---
 hw/net/ftgmac100.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 25ebee7ec2..1640b24b23 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -79,6 +79,19 @@
 #define FTGMAC100_APTC_TXPOLL_CNT(x)        (((x) >> 8) & 0xf)
 #define FTGMAC100_APTC_TXPOLL_TIME_SEL      (1 << 12)

+/*
+ * DMA burst length and arbitration control register
+ */
+#define FTGMAC100_DBLAC_RXFIFO_LTHR(x)      (((x) >> 0) & 0x7)
+#define FTGMAC100_DBLAC_RXFIFO_HTHR(x)      (((x) >> 3) & 0x7)
+#define FTGMAC100_DBLAC_RX_THR_EN           (1 << 6)
+#define FTGMAC100_DBLAC_RXBURST_SIZE(x)     (((x) >> 8) & 0x3)
+#define FTGMAC100_DBLAC_TXBURST_SIZE(x)     (((x) >> 10) & 0x3)
+#define FTGMAC100_DBLAC_RXDES_SIZE(x)       (((x) >> 12) & 0xf)
+#define FTGMAC100_DBLAC_TXDES_SIZE(x)       (((x) >> 16) & 0xf)
+#define FTGMAC100_DBLAC_IFG_CNT(x)          (((x) >> 20) & 0x7)
+#define FTGMAC100_DBLAC_IFG_INC             (1 << 23)
+
 /*
  * PHY control register
  */
@@ -553,7 +566,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t
tx_ring,
         if (bd.des0 & s->txdes0_edotr) {
             addr = tx_ring;
         } else {
-            addr += sizeof(FTGMAC100Desc);
+            addr += (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac)) * 8;
         }
     }

@@ -982,7 +995,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc,
const uint8_t *buf,
         if (bd.des0 & s->rxdes0_edorr) {
             addr = s->rx_ring;
         } else {
-            addr += sizeof(FTGMAC100Desc);
+            addr += (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac)) * 8;
         }
     }
     s->rx_descriptor = addr;
--
2.25.1

--0000000000004fcaa405a71cac44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The hardware supports variable descriptor sizes, conf=
igured with the DBLAC<br>register.<br><br>Most drivers use the default 2*8,=
 which is currently hardcoded in qemu, but<br>the implementation of the dri=
ver in Supermicro BMC SMT_X11_158 uses 4*8.<br><br>--<br>The implementation=
 of the driver in Supermicro BMC SMT_X11_158 adds 4 extra<br>4-bytes entrie=
s:<br><a href=3D"https://github.com/ya-mouse/openwrt-linux-aspeed/blob/mast=
er/drivers/net/ftgmac100_26.h#L387-L391">https://github.com/ya-mouse/openwr=
t-linux-aspeed/blob/master/drivers/net/ftgmac100_26.h#L387-L391</a><br><br>=
And sets DBLAC to 0x44f97:<br><a href=3D"https://github.com/ya-mouse/openwr=
t-linux-aspeed/blob/master/drivers/net/ftgmac100_26.c#L449">https://github.=
com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.c#L4=
49</a><br><br>There&#39;s not a lot of public documentation on this hardwar=
e, but the<br>current linux driver shows the meaning of these registers:<br=
><br><a href=3D"https://github.com/torvalds/linux/blob/master/drivers/net/e=
thernet/faraday/ftgmac100.c#L280-L281">https://github.com/torvalds/linux/bl=
ob/master/drivers/net/ethernet/faraday/ftgmac100.c#L280-L281</a><br><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 iowrite32(FTGMAC100_DBLAC_RXDES_SIZE(2) | =C2=A0 /=
* 2*8 bytes RX descs */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 FTGMAC100_DBLAC_TXDES_SIZE(2) | =C2=A0 /* 2*8 bytes TX descs=
 */<br><br>Without this patch, networking in SMT_X11_158 does not pass data=
.<br><br>Signed-off-by: Erik Smit &lt;<a href=3D"mailto:erik.lucas.smit@gma=
il.com">erik.lucas.smit@gmail.com</a>&gt;<br>---<br>=C2=A0hw/net/ftgmac100.=
c | 17 +++++++++++++++--<br>=C2=A01 file changed, 15 insertions(+), 2 delet=
ions(-)<br><br>diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c<br>inde=
x 25ebee7ec2..1640b24b23 100644<br>--- a/hw/net/ftgmac100.c<br>+++ b/hw/net=
/ftgmac100.c<br>@@ -79,6 +79,19 @@<br>=C2=A0#define FTGMAC100_APTC_TXPOLL_C=
NT(x) =C2=A0 =C2=A0 =C2=A0 =C2=A0(((x) &gt;&gt; 8) &amp; 0xf)<br>=C2=A0#def=
ine FTGMAC100_APTC_TXPOLL_TIME_SEL =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 12)<br><=
br>+/*<br>+ * DMA burst length and arbitration control register<br>+ */<br>=
+#define FTGMAC100_DBLAC_RXFIFO_LTHR(x) =C2=A0 =C2=A0 =C2=A0(((x) &gt;&gt; =
0) &amp; 0x7)<br>+#define FTGMAC100_DBLAC_RXFIFO_HTHR(x) =C2=A0 =C2=A0 =C2=
=A0(((x) &gt;&gt; 3) &amp; 0x7)<br>+#define FTGMAC100_DBLAC_RX_THR_EN =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 6)<br>+#define FTGMAC100_DBLAC_=
RXBURST_SIZE(x) =C2=A0 =C2=A0 (((x) &gt;&gt; 8) &amp; 0x3)<br>+#define FTGM=
AC100_DBLAC_TXBURST_SIZE(x) =C2=A0 =C2=A0 (((x) &gt;&gt; 10) &amp; 0x3)<br>=
+#define FTGMAC100_DBLAC_RXDES_SIZE(x) =C2=A0 =C2=A0 =C2=A0 (((x) &gt;&gt; =
12) &amp; 0xf)<br>+#define FTGMAC100_DBLAC_TXDES_SIZE(x) =C2=A0 =C2=A0 =C2=
=A0 (((x) &gt;&gt; 16) &amp; 0xf)<br>+#define FTGMAC100_DBLAC_IFG_CNT(x) =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((x) &gt;&gt; 20) &amp; 0x7)<br>+#define=
 FTGMAC100_DBLAC_IFG_INC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&=
lt; 23)<br>+<br>=C2=A0/*<br>=C2=A0 * PHY control register<br>=C2=A0 */<br>@=
@ -553,7 +566,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t =
tx_ring,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bd.des0 &amp; s-&gt;txdes=
0_edotr) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D tx_r=
ing;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D sizeof(FTGMAC100Desc);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D (FTGMAC100_DBLAC_TXDES_SIZE(s-&gt;dbl=
ac)) * 8;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<b=
r><br>@@ -982,7 +995,7 @@ static ssize_t ftgmac100_receive(NetClientState *=
nc, const uint8_t *buf,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bd.des0 &a=
mp; s-&gt;rxdes0_edorr) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0addr =3D s-&gt;rx_ring;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br=
>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D sizeof(FTGMAC100Desc)=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D (FTGMAC100_DBLAC_=
RXDES_SIZE(s-&gt;dblac)) * 8;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0s-&gt;rx_descriptor =3D addr;<br>=
--<br>2.25.1<br></div></div>

--0000000000004fcaa405a71cac44--

