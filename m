Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600CDC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 22:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C2C20726
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 22:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs59ge7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C2C20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2j8X-0000NV-BM
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 17:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <falhumai96@gmail.com>) id 1j2g3o-0004Vu-HF
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <falhumai96@gmail.com>) id 1j2g3n-0008Ob-69
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:51:32 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:34148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <falhumai96@gmail.com>)
 id 1j2g3m-0008No-PU
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:51:31 -0500
Received: by mail-ed1-x534.google.com with SMTP id r18so12355709edl.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ucgLg4iz3Zg5WHnxGSgAP9dYzN2ZSCHnBaW8OP5RV8A=;
 b=bs59ge7yX4RsVofIwEodO19w2Wks2YXKbCIRfXA7i2s9onaMQ67Oif19r+Ar0zKlME
 Ng5RDYY6s3aSYsrQ7MnOeh/ZkbsC2FMLixejFPFYD9IH52HFl6ns1/LwS+xBg/isysuS
 AShti9QhSnZAqUEaQXJaHCX0vETDninxZIeh8AigzWQOLeGT67jiIZQqebImFTEjpi7a
 3v4VhalCDfxgIGA3CHAZYE9HMKOChYMBAn/G4rcLxreSJ3CvfaZ4fkK+LwMB6XuGhW1R
 KVzlJTUM8/Pste8IERtfFFCS5vQNqtVRUcr4nAVY/wqf1f5BaiAS2k5/8199gjWr80sL
 b+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ucgLg4iz3Zg5WHnxGSgAP9dYzN2ZSCHnBaW8OP5RV8A=;
 b=sHk8M2ydMmBfL0/Es0jTqM1uK/5HnJMdRIQYat1le87fZwEGlTUVtdHRRspcD2iKXZ
 Xock3ZvRdAoAdEtfzhf6QDHMdq3G0rUpqCYtMWQ/Lk63RpowehyUOtSHySNU9nB6CqlL
 f5ih68SxvMi1rG4mWbbVU1HARsgwW5XKaS5syE936RbtJTbWhXtaVmeOWGlumwZAs6HJ
 ydTO9lbZPKX4waVEu4dM6Eug/ZDZTqbJSDAr3Rm1El2ByeJyR7r4koe+HAC4cqb7BLm1
 TSB2jszq/7OXDPkg7iWr/Fio0nPb73OzA6SEAh1Q+ubBwRpJ4oAHeYWHIvfPKLf+IDCA
 o4MA==
X-Gm-Message-State: APjAAAWPvAGAErpOTB+HIryn4ki9UCQofpM1kw+KOtz0dSUPR+ZHZV9l
 d6xfWdLmwFylX7QkDVJHeEWhICTtjCjTbkoFc7ntZ8WTlfk=
X-Google-Smtp-Source: APXvYqzBEhe0BkS7AWaH6HiiiW+9XHF/BIjdyhXfAFdocKLDKIg/wZOSCLZGhxfZbqmk+5pGbUw8e9EAgcazqrOWAGw=
X-Received: by 2002:aa7:d716:: with SMTP id t22mr4043338edq.77.1581706288559; 
 Fri, 14 Feb 2020 10:51:28 -0800 (PST)
MIME-Version: 1.0
From: Faisal Al-Humaimidi <falhumai96@gmail.com>
Date: Fri, 14 Feb 2020 10:51:17 -0800
Message-ID: <CAMx8kb2aJ2OOHx6GG9qmXOoSXdQrzQ9+fsK=JR7pM-bJA4QOzg@mail.gmail.com>
Subject: QEMU Sockets Networking Backend Multicast Networking Fix
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="0000000000007827ef059e8db1ca"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::534
X-Mailman-Approved-At: Fri, 14 Feb 2020 17:07:41 -0500
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

--0000000000007827ef059e8db1ca
Content-Type: multipart/alternative; boundary="0000000000007827ed059e8db1c8"

--0000000000007827ed059e8db1c8
Content-Type: text/plain; charset="UTF-8"

Hello QEMU developers,

I have noticed a bug in the `mcast` option of the `socket` networking
backend, where I simply cannot join a multicast group (tested in Windows 10
with QEMU 4.2.0 release). I have found a fix to the problem. The problem
was mainly due to the fact that QEMU was binding to the multicast address,
and not the local address or the default INADDR_ANY (0.0.0.0) if no local
address is used.

Here's the patch text (as well as attached with this email), that outlines
my fix:

```
diff -uarN qemu-4.2.0.original/net/socket.c qemu-4.2.0.modified/net/socket.c
--- qemu-4.2.0.original/net/socket.c 2019-12-12 10:20:48.000000000 -0800
+++ qemu-4.2.0.modified/net/socket.c 2020-02-14 10:30:16.395973453 -0800
@@ -253,6 +253,15 @@
         goto fail;
     }

+    /* Preserve the multicast address, and bind to a non-multicast group
(e.g. a
+     * local address).
+     */
+    struct in_addr group_addr = mcastaddr->sin_addr;
+    if (localaddr) {
+        mcastaddr->sin_addr = *localaddr;
+    } else {
+        mcastaddr->sin_addr.s_addr = htonl(INADDR_ANY);
+    }
     ret = bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
     if (ret < 0) {
         error_setg_errno(errp, errno, "can't bind ip=%s to socket",
@@ -260,7 +269,10 @@
         goto fail;
     }

-    /* Add host to multicast group */
+    /* Restore the multicast address. */
+    mcastaddr->sin_addr = group_addr;
+
+    /* Add host to multicast group. */
     imr.imr_multiaddr = mcastaddr->sin_addr;
     if (localaddr) {
         imr.imr_interface = *localaddr;
@@ -277,7 +289,7 @@
         goto fail;
     }

-    /* Force mcast msgs to loopback (eg. several QEMUs in same host */
+    /* Force mcast msgs to loopback (eg. several QEMUs in same host). */
     loop = 1;
     ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
                           &loop, sizeof(loop));
@@ -287,7 +299,7 @@
         goto fail;
     }

-    /* If a bind address is given, only send packets from that address */
+    /* If a bind address is given, only send packets from that address. */
     if (localaddr != NULL) {
         ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
                               localaddr, sizeof(*localaddr));
```

Regards,
Faisal Al-Humaimidi

--0000000000007827ed059e8db1c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello QEMU developers,<div><br></div><div>I have noticed a=
 bug in the `mcast` option of the `socket` networking backend, where I simp=
ly cannot join a multicast group (tested in Windows 10 with QEMU 4.2.0 rele=
ase). I have found a fix to the problem. The problem was mainly due to the =
fact that QEMU was binding to the multicast address, and not the local addr=
ess or the default=C2=A0INADDR_ANY (0.0.0.0) if no local address is used.</=
div><div><br></div><div>Here&#39;s the patch text (as well as attached with=
 this email), that outlines my fix:</div><div><br></div><div>```</div><div>=
diff -uarN qemu-4.2.0.original/net/socket.c qemu-4.2.0.modified/net/socket.=
c<br>--- qemu-4.2.0.original/net/socket.c	2019-12-12 10:20:48.000000000 -08=
00<br>+++ qemu-4.2.0.modified/net/socket.c	2020-02-14 10:30:16.395973453 -0=
800<br>@@ -253,6 +253,15 @@<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;=
<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>+ =C2=A0 =C2=A0/* Preserve the multi=
cast address, and bind to a non-multicast group (e.g. a <br>+ =C2=A0 =C2=A0=
 * local address).<br>+ =C2=A0 =C2=A0 */<br>+ =C2=A0 =C2=A0struct in_addr g=
roup_addr =3D mcastaddr-&gt;sin_addr;<br>+ =C2=A0 =C2=A0if (localaddr) {<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0mcastaddr-&gt;sin_addr =3D *localaddr;<br>+ =
=C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0mcastaddr-&gt;sin_add=
r.s_addr =3D htonl(INADDR_ANY);<br>+ =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0=
ret =3D bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));<br>=C2=
=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err=
or_setg_errno(errp, errno, &quot;can&#39;t bind ip=3D%s to socket&quot;,<br=
>@@ -260,7 +269,10 @@<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>=
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0/* Add host to multicast =
group */<br>+ =C2=A0 =C2=A0/* Restore the multicast address. */<br>+ =C2=A0=
 =C2=A0mcastaddr-&gt;sin_addr =3D group_addr;<br>+<br>+ =C2=A0 =C2=A0/* Add=
 host to multicast group. */<br>=C2=A0 =C2=A0 =C2=A0imr.imr_multiaddr =3D m=
castaddr-&gt;sin_addr;<br>=C2=A0 =C2=A0 =C2=A0if (localaddr) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0imr.imr_interface =3D *localaddr;<br>@@ -277,7 +=
289,7 @@<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0/* Force mcast msgs to loopback (eg. se=
veral QEMUs in same host */<br>+ =C2=A0 =C2=A0/* Force mcast msgs to loopba=
ck (eg. several QEMUs in same host). */<br>=C2=A0 =C2=A0 =C2=A0loop =3D 1;<=
br>=C2=A0 =C2=A0 =C2=A0ret =3D qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST=
_LOOP,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;loop, sizeof(loop));<br>@@ -287,7 +2=
99,7 @@<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0/* If a bind address is given, only sen=
d packets from that address */<br>+ =C2=A0 =C2=A0/* If a bind address is gi=
ven, only send packets from that address. */<br>=C2=A0 =C2=A0 =C2=A0if (loc=
aladdr !=3D NULL) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D qemu_setso=
ckopt(fd, IPPROTO_IP, IP_MULTICAST_IF,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0localaddr, sizeof(*localaddr));<br></div><div>```</div><div><br></div=
><div>Regards,</div><div>Faisal Al-Humaimidi</div></div>

--0000000000007827ed059e8db1c8--

--0000000000007827ef059e8db1ca
Content-Type: application/octet-stream; 
	name="qemu-4.2.0-fix_socket_mcast.patch"
Content-Disposition: attachment; 
	filename="qemu-4.2.0-fix_socket_mcast.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k6mj2gl90>
X-Attachment-Id: f_k6mj2gl90

ZGlmZiAtdWFyTiBxZW11LTQuMi4wLm9yaWdpbmFsL25ldC9zb2NrZXQuYyBxZW11LTQuMi4wLm1v
ZGlmaWVkL25ldC9zb2NrZXQuYwotLS0gcWVtdS00LjIuMC5vcmlnaW5hbC9uZXQvc29ja2V0LmMJ
MjAxOS0xMi0xMiAxMDoyMDo0OC4wMDAwMDAwMDAgLTA4MDAKKysrIHFlbXUtNC4yLjAubW9kaWZp
ZWQvbmV0L3NvY2tldC5jCTIwMjAtMDItMTQgMTA6MzA6MTYuMzk1OTczNDUzIC0wODAwCkBAIC0y
NTMsNiArMjUzLDE1IEBACiAgICAgICAgIGdvdG8gZmFpbDsKICAgICB9CiAKKyAgICAvKiBQcmVz
ZXJ2ZSB0aGUgbXVsdGljYXN0IGFkZHJlc3MsIGFuZCBiaW5kIHRvIGEgbm9uLW11bHRpY2FzdCBn
cm91cCAoZS5nLiBhIAorICAgICAqIGxvY2FsIGFkZHJlc3MpLgorICAgICAqLworICAgIHN0cnVj
dCBpbl9hZGRyIGdyb3VwX2FkZHIgPSBtY2FzdGFkZHItPnNpbl9hZGRyOworICAgIGlmIChsb2Nh
bGFkZHIpIHsKKyAgICAgICAgbWNhc3RhZGRyLT5zaW5fYWRkciA9ICpsb2NhbGFkZHI7CisgICAg
fSBlbHNlIHsKKyAgICAgICAgbWNhc3RhZGRyLT5zaW5fYWRkci5zX2FkZHIgPSBodG9ubChJTkFE
RFJfQU5ZKTsKKyAgICB9CiAgICAgcmV0ID0gYmluZChmZCwgKHN0cnVjdCBzb2NrYWRkciAqKW1j
YXN0YWRkciwgc2l6ZW9mKCptY2FzdGFkZHIpKTsKICAgICBpZiAocmV0IDwgMCkgewogICAgICAg
ICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiY2FuJ3QgYmluZCBpcD0lcyB0byBzb2Nr
ZXQiLApAQCAtMjYwLDcgKzI2OSwxMCBAQAogICAgICAgICBnb3RvIGZhaWw7CiAgICAgfQogCi0g
ICAgLyogQWRkIGhvc3QgdG8gbXVsdGljYXN0IGdyb3VwICovCisgICAgLyogUmVzdG9yZSB0aGUg
bXVsdGljYXN0IGFkZHJlc3MuICovCisgICAgbWNhc3RhZGRyLT5zaW5fYWRkciA9IGdyb3VwX2Fk
ZHI7CisKKyAgICAvKiBBZGQgaG9zdCB0byBtdWx0aWNhc3QgZ3JvdXAuICovCiAgICAgaW1yLmlt
cl9tdWx0aWFkZHIgPSBtY2FzdGFkZHItPnNpbl9hZGRyOwogICAgIGlmIChsb2NhbGFkZHIpIHsK
ICAgICAgICAgaW1yLmltcl9pbnRlcmZhY2UgPSAqbG9jYWxhZGRyOwpAQCAtMjc3LDcgKzI4OSw3
IEBACiAgICAgICAgIGdvdG8gZmFpbDsKICAgICB9CiAKLSAgICAvKiBGb3JjZSBtY2FzdCBtc2dz
IHRvIGxvb3BiYWNrIChlZy4gc2V2ZXJhbCBRRU1VcyBpbiBzYW1lIGhvc3QgKi8KKyAgICAvKiBG
b3JjZSBtY2FzdCBtc2dzIHRvIGxvb3BiYWNrIChlZy4gc2V2ZXJhbCBRRU1VcyBpbiBzYW1lIGhv
c3QpLiAqLwogICAgIGxvb3AgPSAxOwogICAgIHJldCA9IHFlbXVfc2V0c29ja29wdChmZCwgSVBQ
Uk9UT19JUCwgSVBfTVVMVElDQVNUX0xPT1AsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICZs
b29wLCBzaXplb2YobG9vcCkpOwpAQCAtMjg3LDcgKzI5OSw3IEBACiAgICAgICAgIGdvdG8gZmFp
bDsKICAgICB9CiAKLSAgICAvKiBJZiBhIGJpbmQgYWRkcmVzcyBpcyBnaXZlbiwgb25seSBzZW5k
IHBhY2tldHMgZnJvbSB0aGF0IGFkZHJlc3MgKi8KKyAgICAvKiBJZiBhIGJpbmQgYWRkcmVzcyBp
cyBnaXZlbiwgb25seSBzZW5kIHBhY2tldHMgZnJvbSB0aGF0IGFkZHJlc3MuICovCiAgICAgaWYg
KGxvY2FsYWRkciAhPSBOVUxMKSB7CiAgICAgICAgIHJldCA9IHFlbXVfc2V0c29ja29wdChmZCwg
SVBQUk9UT19JUCwgSVBfTVVMVElDQVNUX0lGLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbG9jYWxhZGRyLCBzaXplb2YoKmxvY2FsYWRkcikpOwo=
--0000000000007827ef059e8db1ca--

