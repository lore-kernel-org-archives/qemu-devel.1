Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF5FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0858120661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxf9LRQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0858120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhB2-00031M-7M
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npes87184@gmail.com>) id 1izh5H-00059u-2G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npes87184@gmail.com>) id 1izh5E-0006fA-Cp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:20:42 -0500
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:45951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npes87184@gmail.com>)
 id 1izh5D-0006c0-U8; Thu, 06 Feb 2020 08:20:40 -0500
Received: by mail-vk1-xa43.google.com with SMTP id g7so1578080vkl.12;
 Thu, 06 Feb 2020 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hyZby3fkqwdYpr1tr4MLzj/VtjUzgxGQRGqiktRwAuY=;
 b=mxf9LRQHjVzUIFASRWZdLYfRORqqubzvGgV/w8+pkEqetMPRIuMwA9K7S6Ghq5Fc8a
 PfvCJaUoZSHJhnnK9qh3PI8Vb0VvnTtRPfcplu8zni+ZTmi/Y8ZK0VVzfhgaJDOyluhs
 H7GGC3xAhsN89HrSaskuRQRlXrOanj9nO2+LmAwVB+3RLPcljZT2UWj4VD1Qze4FETsA
 yHZb31hEvoKHbvbyfmNpJ65FHafBgxfc1ObPh/8097iewWefsje4ZUAZkA6nLO3Fje7l
 HElANu0pejQzR7SIlVCC2QGk+jZb7Vg119N/VLl3vNlldcihR5cFgLz1vjyRlgzxvcCd
 YyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hyZby3fkqwdYpr1tr4MLzj/VtjUzgxGQRGqiktRwAuY=;
 b=HyVU+9lZ0Zlk2/7/3DCPyxxmS4YGRgFHcksRi2Jn4Lf1jnVwoP1u9A2DLOWID4GL7m
 tpUS8c6HhSeyJ6ewoVS333tUiTKIMALA17TLi70KWQF7uc8QZSdI1WvypQM2WPtzmYCg
 Q0S5Xt7t0r4uySP6nDqYDTdY0JWxZ+ePSwSmu58b7z6pR6dYYjxatrSsA1w2u4TS/yAY
 aUULNXraBbZSAZ77VQ7fmzxvGcgjGsVL2vUKgYnLGoPfa6RE6fZ92KEilzpce+9bsRTb
 pOg3yXOe63WoFQz1LDsdulU1qKoD8HskmljmxeuasS4oPhv52bgW0XKL+iYUpFMSU0jR
 mtzA==
X-Gm-Message-State: APjAAAWCx0B9rjk/pO3SVk5eHOYx294OiKZW7BCp2oB0fzuxLii3WuE9
 9K/qQo4rgIHioNiIZwde7NODILYXPeuBDU/cj40=
X-Google-Smtp-Source: APXvYqzGHcmPgyf4L+U4fRbwqPNbdq3Cjvin+4Nkvu/zDpAVT+HAOR9hMB7JS13PP3cErXQfwq7PDcrysSHLn03YIiE=
X-Received: by 2002:a1f:ee45:: with SMTP id m66mr1712501vkh.75.1580995237939; 
 Thu, 06 Feb 2020 05:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20191123034306.6139-1-npes87184@gmail.com>
 <20191202155254.GN4184266@redhat.com>
In-Reply-To: <20191202155254.GN4184266@redhat.com>
From: Yu-Chen Lin <npes87184@gmail.com>
Date: Thu, 6 Feb 2020 21:20:02 +0800
Message-ID: <CAPTqjH1TRcoQ9xosc80NCd79c1XunVv-8YwLoRZ0VftYXf3CQw@mail.gmail.com>
Subject: Re: [PATCH] io/channel-websock: treat 'binary' and no sub-protocol as
 the same
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008c90da059de8236d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008c90da059de8236d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since there are no changes in two months.
Simply ping for merging, sorry for bothering you again.

Daniel P. Berrang=C3=A9 <berrange@redhat.com> =E6=96=BC 2019=E5=B9=B412=E6=
=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:53=E5=AF=AB=E9=81=
=93=EF=BC=9A

> On Sat, Nov 23, 2019 at 11:43:06AM +0800, Yu-Chen Lin wrote:
> > noVNC doesn't use 'binary' protocol by default after
> > commit c912230309806aacbae4295faf7ad6406da97617.
> >
> > It will cause qemu return 400 when handshaking.
> >
> > To overcome this problem and remain compatibility of
> > older noVNC client.
> >
> > We treat 'binary' and no sub-protocol as the same
> > so that we can support different version of noVNC
> > client.
> >
> > Tested on noVNC before c912230 and after c912230.
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1849644
> >
> > Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
> > ---
> >  io/channel-websock.c | 35 +++++++++++++++++++++++------------
> >  1 file changed, 23 insertions(+), 12 deletions(-)
>
> Thank you, I have queued this for 5.0.
>
>   Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Also CC'ing stable for the first 4.2 bug fix release.
>
> >
> > diff --git a/io/channel-websock.c b/io/channel-websock.c
> > index fc36d44eba..918e09ea3f 100644
> > --- a/io/channel-websock.c
> > +++ b/io/channel-websock.c
> > @@ -49,13 +49,20 @@
> >      "Server: QEMU VNC\r\n"                       \
> >      "Date: %s\r\n"
> >
> > +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK \
> > +    "HTTP/1.1 101 Switching Protocols\r\n"              \
> > +    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON            \
> > +    "Upgrade: websocket\r\n"                            \
> > +    "Connection: Upgrade\r\n"                           \
> > +    "Sec-WebSocket-Accept: %s\r\n"                      \
> > +    "Sec-WebSocket-Protocol: binary\r\n"                \
> > +    "\r\n"
> >  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK    \
> >      "HTTP/1.1 101 Switching Protocols\r\n"      \
> >      QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON    \
> >      "Upgrade: websocket\r\n"                    \
> >      "Connection: Upgrade\r\n"                   \
> >      "Sec-WebSocket-Accept: %s\r\n"              \
> > -    "Sec-WebSocket-Protocol: binary\r\n"        \
> >      "\r\n"
> >  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND \
> >      "HTTP/1.1 404 Not Found\r\n"                    \
> > @@ -336,6 +343,7 @@
> qio_channel_websock_find_header(QIOChannelWebsockHTTPHeader *hdrs,
> >
> >  static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsoc=
k
> *ioc,
> >                                                        const char *key,
> > +                                                      const bool
> use_protocols,
> >                                                        Error **errp)
> >  {
> >      char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
> > @@ -361,8 +369,13 @@ static void
> qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
> >      }
> >
> >      date =3D qio_channel_websock_date_str();
> > -    qio_channel_websock_handshake_send_res(
> > -        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
> > +    if (use_protocols) {
> > +            qio_channel_websock_handshake_send_res(
> > +                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK,
> date, accept);
> > +    } else {
> > +            qio_channel_websock_handshake_send_res(
> > +                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date,
> accept);
> > +    }
> >
> >      g_free(date);
> >      g_free(accept);
> > @@ -387,10 +400,6 @@ static void
> qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
> >
> >      protocols =3D qio_channel_websock_find_header(
> >          hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
> > -    if (!protocols) {
> > -        error_setg(errp, "Missing websocket protocol header data");
> > -        goto bad_request;
> > -    }
> >
> >      version =3D qio_channel_websock_find_header(
> >          hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
> > @@ -430,10 +439,12 @@ static void
> qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
> >      trace_qio_channel_websock_http_request(ioc, protocols, version,
> >                                             host, connection, upgrade,
> key);
> >
> > -    if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
> > -        error_setg(errp, "No '%s' protocol is supported by client '%s'=
",
> > -                   QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
> > -        goto bad_request;
> > +    if (protocols) {
> > +            if (!g_strrstr(protocols,
> QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
> > +                error_setg(errp, "No '%s' protocol is supported by
> client '%s'",
> > +                           QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY,
> protocols);
> > +                goto bad_request;
> > +            }
> >      }
> >
> >      if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) =
{
> > @@ -467,7 +478,7 @@ static void
> qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
> >          goto bad_request;
> >      }
> >
> > -    qio_channel_websock_handshake_send_res_ok(ioc, key, errp);
> > +    qio_channel_websock_handshake_send_res_ok(ioc, key, !!protocols,
> errp);
> >      return;
> >
> >   bad_request:
> > --
> > 2.17.1
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000008c90da059de8236d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Since there are no changes in two months.<div>Simply ping =
for merging, sorry for bothering you again.</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Daniel P. Berrang=C3=A9 &l=
t;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; =E6=96=
=BC 2019=E5=B9=B412=E6=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=
=8811:53=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Sat, Nov 23, 2019 at 11:43:06AM +0800, Yu-Chen Lin w=
rote:<br>
&gt; noVNC doesn&#39;t use &#39;binary&#39; protocol by default after<br>
&gt; commit c912230309806aacbae4295faf7ad6406da97617.<br>
&gt; <br>
&gt; It will cause qemu return 400 when handshaking.<br>
&gt; <br>
&gt; To overcome this problem and remain compatibility of<br>
&gt; older noVNC client.<br>
&gt; <br>
&gt; We treat &#39;binary&#39; and no sub-protocol as the same<br>
&gt; so that we can support different version of noVNC<br>
&gt; client.<br>
&gt; <br>
&gt; Tested on noVNC before c912230 and after c912230.<br>
&gt; <br>
&gt; Buglink: <a href=3D"https://bugs.launchpad.net/qemu/+bug/1849644" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1849=
644</a><br>
&gt; <br>
&gt; Signed-off-by: Yu-Chen Lin &lt;<a href=3D"mailto:npes87184@gmail.com" =
target=3D"_blank">npes87184@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 io/channel-websock.c | 35 +++++++++++++++++++++++------------<br=
>
&gt;=C2=A0 1 file changed, 23 insertions(+), 12 deletions(-)<br>
<br>
Thank you, I have queued this for 5.0.<br>
<br>
=C2=A0 Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
Also CC&#39;ing stable for the first 4.2 bug fix release.<br>
<br>
&gt; <br>
&gt; diff --git a/io/channel-websock.c b/io/channel-websock.c<br>
&gt; index fc36d44eba..918e09ea3f 100644<br>
&gt; --- a/io/channel-websock.c<br>
&gt; +++ b/io/channel-websock.c<br>
&gt; @@ -49,13 +49,20 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;Server: QEMU VNC\r\n&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;Date: %s\r\n&quot;<br>
&gt;=C2=A0 <br>
&gt; +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK \<br>
&gt; +=C2=A0 =C2=A0 &quot;HTTP/1.1 101 Switching Protocols\r\n&quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 &quot;Upgrade: websocket\r\n&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
&gt; +=C2=A0 =C2=A0 &quot;Connection: Upgrade\r\n&quot;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
&gt; +=C2=A0 =C2=A0 &quot;Sec-WebSocket-Accept: %s\r\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 &quot;Sec-WebSocket-Protocol: binary\r\n&quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 &quot;\r\n&quot;<br>
&gt;=C2=A0 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;HTTP/1.1 101 Switching Protocols\r\n&quot;=
=C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON=C2=A0 =C2=
=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;Upgrade: websocket\r\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;Connection: Upgrade\r\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;Sec-WebSocket-Accept: %s\r\n&quot;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 &quot;Sec-WebSocket-Protocol: binary\r\n&quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;\r\n&quot;<br>
&gt;=C2=A0 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;HTTP/1.1 404 Not Found\r\n&quot;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; @@ -336,6 +343,7 @@ qio_channel_websock_find_header(QIOChannelWebsockH=
TTPHeader *hdrs,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void qio_channel_websock_handshake_send_res_ok(QIOChannel=
Websock *ioc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *key,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const bool use_protocols,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_L=
EN +<br>
&gt; @@ -361,8 +369,13 @@ static void qio_channel_websock_handshake_send_re=
s_ok(QIOChannelWebsock *ioc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 date =3D qio_channel_websock_date_str();<br>
&gt; -=C2=A0 =C2=A0 qio_channel_websock_handshake_send_res(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK=
, date, accept);<br>
&gt; +=C2=A0 =C2=A0 if (use_protocols) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qio_channel_websock_handsha=
ke_send_res(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ioc, QIO_CHAN=
NEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK, date, accept);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qio_channel_websock_handsha=
ke_send_res(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ioc, QIO_CHAN=
NEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(date);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(accept);<br>
&gt; @@ -387,10 +400,6 @@ static void qio_channel_websock_handshake_process=
(QIOChannelWebsock *ioc,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 protocols =3D qio_channel_websock_find_header(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEA=
DER_PROTOCOL);<br>
&gt; -=C2=A0 =C2=A0 if (!protocols) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Missing websocket =
protocol header data&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_request;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 version =3D qio_channel_websock_find_header(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEA=
DER_VERSION);<br>
&gt; @@ -430,10 +439,12 @@ static void qio_channel_websock_handshake_proces=
s(QIOChannelWebsock *ioc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_qio_channel_websock_http_request(ioc, protoc=
ols, version,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0host, connection, upgrade, key);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_=
BINARY)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;No &#39;%s&#39; pr=
otocol is supported by client &#39;%s&#39;&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_request;<br>
&gt; +=C2=A0 =C2=A0 if (protocols) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_strrstr(protocols, Q=
IO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(er=
rp, &quot;No &#39;%s&#39; protocol is supported by client &#39;%s&#39;&quot=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_requ=
est;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPP=
ORTED_VERSION)) {<br>
&gt; @@ -467,7 +478,7 @@ static void qio_channel_websock_handshake_process(=
QIOChannelWebsock *ioc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_request;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 qio_channel_websock_handshake_send_res_ok(ioc, key, err=
p);<br>
&gt; +=C2=A0 =C2=A0 qio_channel_websock_handshake_send_res_ok(ioc, key, !!p=
rotocols, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0bad_request:<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt; <br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--0000000000008c90da059de8236d--

