Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C5C54FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 16:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D1A20724
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 16:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="LI7bVyKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D1A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG3CI-0003vW-5k
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 12:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jG1wR-0001Qu-Ta
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 10:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jG1wQ-00019l-R6
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 10:51:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jG1wQ-00019f-KW
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 10:51:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id z18so2737162wmk.2
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Y1e3vEeZseg8+tffx8tXcU2nLzJtVJ2tC5obRSC3QGo=;
 b=LI7bVyKe5czWJsGV+uRQF9JWbJDmo5KgN5iLT/+y/8AoTgRHfgkMW2Gh7Tf8VFGTmb
 czY0O6NKhslwx+ydK16GwBvdBnVwZxUolPlh8Nvy6G69SkeTPy6w+JF3qVEGAr8CUJLL
 zjuY4C3kWbYoXS6kcvXa3+jBij94eo4g0WKFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Y1e3vEeZseg8+tffx8tXcU2nLzJtVJ2tC5obRSC3QGo=;
 b=JyeJxzMaxm1m5ZN7KzqQTAl7Xs73N7+1iqVBNFKOnjmuG4G+QxUPJGcN8TStaowgw2
 HTFa1noy4r9lYLqJ1IXf0feK1y+FqFZL2QdE0mPMQSKmj1p8drvtmDG7dSKy2AGunJiy
 5H0eJGLyW5eTHhQnJdaaysfLsjZQu7sbuQ7AvV91EJZbQihCgqfAFtKC9GfYV7mScubf
 LtfHqpLN8cFMGnIUUzunMVcbWE1w1Y3Wfs85NNgfOS496YsC1hchCUwM7pBh0a/qzzRq
 PkGosjLfu6xdQwATr4isCkH+rWP4eOIZTQJPTh7gUmJ68VZ72r63WIQtFogoOeFoOQYz
 3Vlw==
X-Gm-Message-State: ANhLgQ2CbXd7vmWWKuUPZlsGEFPSwHgrQ3yFKo3uvAI5gSLgPepxmpmP
 BK3G31fRbiwuAehU8Q5pUmfpi3+72J1+a7lAXTDR5BaKmg91EQ==
X-Google-Smtp-Source: ADFU+vty1ni2gML7F3qqZEYl0RIGp5SKsdo4foVPyDZdlZdKRNSjcKZzBPZi7KyZ7TOwMIrEnQIA3oKaU0FPZn1Fqv4=
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr22370775wme.66.1584888664940; 
 Sun, 22 Mar 2020 07:51:04 -0700 (PDT)
MIME-Version: 1.0
From: Derek Su <dereksu@qnap.com>
Date: Sun, 22 Mar 2020 22:50:53 +0800
Message-ID: <CAKEOLWV5DknQdp4QzR4c1P-Qp+_h6j9MdvamxUP=c=G2CFsm1A@mail.gmail.com>
Subject: [PATCH 1/1] COLO: Fix memory leak in packet_enqueue()
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e1f42f05a172a56a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-Mailman-Approved-At: Sun, 22 Mar 2020 12:10:47 -0400
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
Cc: chen.zhang@intel.com, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e1f42f05a172a56a
Content-Type: text/plain; charset="UTF-8"

The patch is to fix the "pkt" memory leak in packet_enqueue().
The allocated "pkt" needs to be freed if the colo compare
primary or secondary queue is too big.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7ee17f2cf8..cdd87b2aa8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -120,6 +120,10 @@ enum {
     SECONDARY_IN,
 };

+static const char *colo_mode[] = {
+    [PRIMARY_IN] = "primary",
+    [SECONDARY_IN] = "secondary",
+};

 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
@@ -215,6 +219,7 @@ static int packet_enqueue(CompareState *s, int mode,
Connection **con)
     ConnectionKey key;
     Packet *pkt = NULL;
     Connection *conn;
+    int ret;

     if (mode == PRIMARY_IN) {
         pkt = packet_new(s->pri_rs.buf,
@@ -243,16 +248,18 @@ static int packet_enqueue(CompareState *s, int mode,
Connection **con)
     }

     if (mode == PRIMARY_IN) {
-        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
-            error_report("colo compare primary queue size too big,"
-                         "drop packet");
-        }
+        ret = colo_insert_packet(&conn->primary_list, pkt, &conn->pack);
     } else {
-        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)) {
-            error_report("colo compare secondary queue size too big,"
-                         "drop packet");
-        }
+        ret = colo_insert_packet(&conn->secondary_list, pkt, &conn->sack);
     }
+
+    if (!ret) {
+        error_report("colo compare %s queue size too big,"
+                     "drop packet", colo_mode[mode]);
+        packet_destroy(pkt, NULL);
+        pkt = NULL;
+    }
+
     *con = conn;

     return 0;
-- 
2.17.1

--000000000000e1f42f05a172a56a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The patch is to fix the &quot;pkt&quot; memory leak in pac=
ket_enqueue().<br>The allocated &quot;pkt&quot; needs to be freed if the co=
lo compare<br>primary or secondary queue is too big.<br><br>Signed-off-by: =
Derek Su &lt;<a href=3D"mailto:dereksu@qnap.com">dereksu@qnap.com</a>&gt;<b=
r>---<br>=C2=A0net/colo-compare.c | 23 +++++++++++++++--------<br>=C2=A01 f=
ile changed, 15 insertions(+), 8 deletions(-)<br><br>diff --git a/net/colo-=
compare.c b/net/colo-compare.c<br>index 7ee17f2cf8..cdd87b2aa8 100644<br>--=
- a/net/colo-compare.c<br>+++ b/net/colo-compare.c<br>@@ -120,6 +120,10 @@ =
enum {<br>=C2=A0 =C2=A0 =C2=A0SECONDARY_IN,<br>=C2=A0};<br><br>+static cons=
t char *colo_mode[] =3D {<br>+ =C2=A0 =C2=A0[PRIMARY_IN] =3D &quot;primary&=
quot;,<br>+ =C2=A0 =C2=A0[SECONDARY_IN] =3D &quot;secondary&quot;,<br>+};<b=
r><br>=C2=A0static int compare_chr_send(CompareState *s,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const uint8_t *buf,<br>@@ -215,6 +219,7 @@ static int pack=
et_enqueue(CompareState *s, int mode, Connection **con)<br>=C2=A0 =C2=A0 =
=C2=A0ConnectionKey key;<br>=C2=A0 =C2=A0 =C2=A0Packet *pkt =3D NULL;<br>=
=C2=A0 =C2=A0 =C2=A0Connection *conn;<br>+ =C2=A0 =C2=A0int ret;<br><br>=C2=
=A0 =C2=A0 =C2=A0if (mode =3D=3D PRIMARY_IN) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pkt =3D packet_new(s-&gt;pri_rs.buf,<br>@@ -243,16 +248,18 @@ sta=
tic int packet_enqueue(CompareState *s, int mode, Connection **con)<br>=C2=
=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0if (mode =3D=3D PRIMARY_IN) {=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!colo_insert_packet(&amp;conn-&gt;prim=
ary_list, pkt, &amp;conn-&gt;pack)) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0error_report(&quot;colo compare primary queue size too big,&quot;=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;drop packet&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D colo_insert_packet(&amp;conn-&gt;pr=
imary_list, pkt, &amp;conn-&gt;pack);<br>=C2=A0 =C2=A0 =C2=A0} else {<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!colo_insert_packet(&amp;conn-&gt;secondary_=
list, pkt, &amp;conn-&gt;sack)) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0error_report(&quot;colo compare secondary queue size too big,&quot;<b=
r>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;drop packet&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D colo_insert_packet(&amp;conn-&gt;sec=
ondary_list, pkt, &amp;conn-&gt;sack);<br>=C2=A0 =C2=A0 =C2=A0}<br>+<br>+ =
=C2=A0 =C2=A0if (!ret) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot=
;colo compare %s queue size too big,&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;drop packet&quot;, colo_mo=
de[mode]);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0packet_destroy(pkt, NULL);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pkt =3D NULL;<br>+ =C2=A0 =C2=A0}<br>+<br>=C2=A0=
 =C2=A0 =C2=A0*con =3D conn;<br><br>=C2=A0 =C2=A0 =C2=A0return 0;<br>-- <br=
>2.17.1<br><br></div>

--000000000000e1f42f05a172a56a--

