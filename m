Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377B1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 00:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E151B2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 00:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8rWXkng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E151B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaTrM-0006TW-1z
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 19:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npes87184@gmail.com>) id 1iaThv-0003f1-F9
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 19:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npes87184@gmail.com>) id 1iaTXx-0003jP-IM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 18:50:08 -0500
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:44996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npes87184@gmail.com>) id 1iaTXx-0003Rb-6J
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 18:50:05 -0500
Received: by mail-vs1-xe41.google.com with SMTP id p6so13203815vsj.11
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ORoCGWD47Ce4qvaZzkFbr+wCipA6evmSqbjaiaMQHkE=;
 b=I8rWXkngnJh57/P/XRO9afcbqhqF1KGmG2hKYrho1Y023aTJTbHyijeQ1pf/TJH19O
 wZGnpLDNlpdrKCZoj3yBsO2kyDkEJno926BJErIwthf0fGsa56N/YHkUNJC0NfdtQwYp
 i8FrHfMmA6l+2IuLmWvKJzuR/Cg/R4riVyJXz/XDz82seewGiU6WIMvFeBmjXkxlxFcQ
 6IYMKk1srit/GCpQ2EA4CF3xazgCFpOf+PG30tKd2ckSnFBrqSZOMzJZM5QPq5KcKsan
 FCVumjjxJ7M4YSSDQaCpjeCsuWba6xxVqGVJq3mJGhts2YxfB751ta5zAj9RNL+5DWy5
 em8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ORoCGWD47Ce4qvaZzkFbr+wCipA6evmSqbjaiaMQHkE=;
 b=CMYesEk0uwzVE0dOlfwkdeTCG9iZWaWAkpa4/Sg9PSETxrUAnUcx9mbKeH7cybQQ3v
 qdVZQIxMj4ydb8Uw/gaO+ZhTY58Z+q+uPHTcKUJPKc/EMHVLtWnkGE644MkJ7KuwkKMk
 ldcMIZhBQIjSTKrFUuk38XFcZq7235c8DOFzgIFSX+lPxltsyjJ5V5C6gYxHggJuBLRO
 eDV1ATXH22eKozhuUjJ1stp6g1oylAlU+QsMUiJu31IDXYORiIhjaG1takU1/N+C9fGE
 o0BBPN+MiQVY2xHGmFpPJcLkC3deht88DYCbnXBpSDTRQwZ8y4cnSv+kyJOgACBJZZQQ
 1RGA==
X-Gm-Message-State: APjAAAXVoCSJZ35MHV5DQXoNav5MpJkDxOUlRgNAMKliDaAKiOeQZaeL
 u5wAUto745A5kI6Gom2CJQ3NakwOgiFFzzR3MG3QMa7h
X-Google-Smtp-Source: APXvYqxvNv1cZ+IWaqOM3VgY3TnF7PGhlW3ZSb53uSMhmPxU5ovWVo4baxS+V5bKlBAfza3ACWlPJsblruapqDvO/JU=
X-Received: by 2002:a67:b84c:: with SMTP id o12mr7698257vsh.134.1574984999921; 
 Thu, 28 Nov 2019 15:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20191123034306.6139-1-npes87184@gmail.com>
In-Reply-To: <20191123034306.6139-1-npes87184@gmail.com>
From: Yu-Chen Lin <npes87184@gmail.com>
Date: Fri, 29 Nov 2019 07:49:47 +0800
Message-ID: <CAPTqjH35J1SvoECSHcVB8pb6biNrO3uLZf05NGJ22Ptk5VMXKw@mail.gmail.com>
Subject: Re: [PATCH] io/channel-websock: treat 'binary' and no sub-protocol as
 the same
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000726e03059870c535"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e41
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000726e03059870c535
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

Yu-Chen Lin <npes87184@gmail.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E5=85=AD 11:43 =E5=AF=AB=E9=81=93=EF=BC=9A

> noVNC doesn't use 'binary' protocol by default after
> commit c912230309806aacbae4295faf7ad6406da97617.
>
> It will cause qemu return 400 when handshaking.
>
> To overcome this problem and remain compatibility of
> older noVNC client.
>
> We treat 'binary' and no sub-protocol as the same
> so that we can support different version of noVNC
> client.
>
> Tested on noVNC before c912230 and after c912230.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1849644
>
> Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
> ---
>  io/channel-websock.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index fc36d44eba..918e09ea3f 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -49,13 +49,20 @@
>      "Server: QEMU VNC\r\n"                       \
>      "Date: %s\r\n"
>
> +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK \
> +    "HTTP/1.1 101 Switching Protocols\r\n"              \
> +    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON            \
> +    "Upgrade: websocket\r\n"                            \
> +    "Connection: Upgrade\r\n"                           \
> +    "Sec-WebSocket-Accept: %s\r\n"                      \
> +    "Sec-WebSocket-Protocol: binary\r\n"                \
> +    "\r\n"
>  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK    \
>      "HTTP/1.1 101 Switching Protocols\r\n"      \
>      QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON    \
>      "Upgrade: websocket\r\n"                    \
>      "Connection: Upgrade\r\n"                   \
>      "Sec-WebSocket-Accept: %s\r\n"              \
> -    "Sec-WebSocket-Protocol: binary\r\n"        \
>      "\r\n"
>  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND \
>      "HTTP/1.1 404 Not Found\r\n"                    \
> @@ -336,6 +343,7 @@
> qio_channel_websock_find_header(QIOChannelWebsockHTTPHeader *hdrs,
>
>  static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock
> *ioc,
>                                                        const char *key,
> +                                                      const bool
> use_protocols,
>                                                        Error **errp)
>  {
>      char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
> @@ -361,8 +369,13 @@ static void
> qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
>      }
>
>      date =3D qio_channel_websock_date_str();
> -    qio_channel_websock_handshake_send_res(
> -        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
> +    if (use_protocols) {
> +            qio_channel_websock_handshake_send_res(
> +                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK,
> date, accept);
> +    } else {
> +            qio_channel_websock_handshake_send_res(
> +                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept)=
;
> +    }
>
>      g_free(date);
>      g_free(accept);
> @@ -387,10 +400,6 @@ static void
> qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
>
>      protocols =3D qio_channel_websock_find_header(
>          hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
> -    if (!protocols) {
> -        error_setg(errp, "Missing websocket protocol header data");
> -        goto bad_request;
> -    }
>
>      version =3D qio_channel_websock_find_header(
>          hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
> @@ -430,10 +439,12 @@ static void
> qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
>      trace_qio_channel_websock_http_request(ioc, protocols, version,
>                                             host, connection, upgrade,
> key);
>
> -    if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
> -        error_setg(errp, "No '%s' protocol is supported by client '%s'",
> -                   QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
> -        goto bad_request;
> +    if (protocols) {
> +            if (!g_strrstr(protocols,
> QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
> +                error_setg(errp, "No '%s' protocol is supported by clien=
t
> '%s'",
> +                           QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY,
> protocols);
> +                goto bad_request;
> +            }
>      }
>
>      if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) {
> @@ -467,7 +478,7 @@ static void
> qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
>          goto bad_request;
>      }
>
> -    qio_channel_websock_handshake_send_res_ok(ioc, key, errp);
> +    qio_channel_websock_handshake_send_res_ok(ioc, key, !!protocols,
> errp);
>      return;
>
>   bad_request:
> --
> 2.17.1
>
>

--000000000000726e03059870c535
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Ping?<br><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">Yu-Chen Lin &lt;<a href=3D"mailto:npes87184@gmail=
.com">npes87184@gmail.com</a>&gt; =E6=96=BC 2019=E5=B9=B411=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E5=85=AD 11:43 =E5=AF=AB=E9=81=93=EF=BC=9A<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">noVNC doesn&#39;t use &#39;binary&#39; protocol by=
 default after<br>
commit c912230309806aacbae4295faf7ad6406da97617.<br>
<br>
It will cause qemu return 400 when handshaking.<br>
<br>
To overcome this problem and remain compatibility of<br>
older noVNC client.<br>
<br>
We treat &#39;binary&#39; and no sub-protocol as the same<br>
so that we can support different version of noVNC<br>
client.<br>
<br>
Tested on noVNC before c912230 and after c912230.<br>
<br>
Buglink: <a href=3D"https://bugs.launchpad.net/qemu/+bug/1849644" rel=3D"no=
referrer noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug=
/1849644</a><br>
<br>
Signed-off-by: Yu-Chen Lin &lt;<a href=3D"mailto:npes87184@gmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">npes87184@gmail.com</a>&gt;<br>
---<br>
=C2=A0io/channel-websock.c | 35 +++++++++++++++++++++++------------<br>
=C2=A01 file changed, 23 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/io/channel-websock.c b/io/channel-websock.c<br>
index fc36d44eba..918e09ea3f 100644<br>
--- a/io/channel-websock.c<br>
+++ b/io/channel-websock.c<br>
@@ -49,13 +49,20 @@<br>
=C2=A0 =C2=A0 =C2=A0&quot;Server: QEMU VNC\r\n&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0&quot;Date: %s\r\n&quot;<br>
<br>
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK \<br>
+=C2=A0 =C2=A0 &quot;HTTP/1.1 101 Switching Protocols\r\n&quot;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 &quot;Upgrade: websocket\r\n&quot;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
+=C2=A0 =C2=A0 &quot;Connection: Upgrade\r\n&quot;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
+=C2=A0 =C2=A0 &quot;Sec-WebSocket-Accept: %s\r\n&quot;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 &quot;Sec-WebSocket-Protocol: binary\r\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 &quot;\r\n&quot;<br>
=C2=A0#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0&quot;HTTP/1.1 101 Switching Protocols\r\n&quot;=C2=A0 =
=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON=C2=A0 =C2=A0 \=
<br>
=C2=A0 =C2=A0 =C2=A0&quot;Upgrade: websocket\r\n&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0&quot;Connection: Upgrade\r\n&quot;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0&quot;Sec-WebSocket-Accept: %s\r\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 &quot;Sec-WebSocket-Protocol: binary\r\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0&quot;\r\n&quot;<br>
=C2=A0#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND \<br>
=C2=A0 =C2=A0 =C2=A0&quot;HTTP/1.1 404 Not Found\r\n&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -336,6 +343,7 @@ qio_channel_websock_find_header(QIOChannelWebsockHTTPHe=
ader *hdrs,<br>
<br>
=C2=A0static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebso=
ck *ioc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *key,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const bool use_protocols,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +<=
br>
@@ -361,8 +369,13 @@ static void qio_channel_websock_handshake_send_res_ok(=
QIOChannelWebsock *ioc,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0date =3D qio_channel_websock_date_str();<br>
-=C2=A0 =C2=A0 qio_channel_websock_handshake_send_res(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, dat=
e, accept);<br>
+=C2=A0 =C2=A0 if (use_protocols) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qio_channel_websock_handshake_se=
nd_res(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ioc, QIO_CHANNEL_W=
EBSOCK_HANDSHAKE_WITH_PROTO_RES_OK, date, accept);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qio_channel_websock_handshake_se=
nd_res(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ioc, QIO_CHANNEL_W=
EBSOCK_HANDSHAKE_RES_OK, date, accept);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(date);<br>
=C2=A0 =C2=A0 =C2=A0g_free(accept);<br>
@@ -387,10 +400,6 @@ static void qio_channel_websock_handshake_process(QIOC=
hannelWebsock *ioc,<br>
<br>
=C2=A0 =C2=A0 =C2=A0protocols =3D qio_channel_websock_find_header(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_P=
ROTOCOL);<br>
-=C2=A0 =C2=A0 if (!protocols) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Missing websocket proto=
col header data&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_request;<br>
-=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0version =3D qio_channel_websock_find_header(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_V=
ERSION);<br>
@@ -430,10 +439,12 @@ static void qio_channel_websock_handshake_process(QIO=
ChannelWebsock *ioc,<br>
=C2=A0 =C2=A0 =C2=A0trace_qio_channel_websock_http_request(ioc, protocols, =
version,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 host, connection, upgrade, key);<br>
<br>
-=C2=A0 =C2=A0 if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINAR=
Y)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;No &#39;%s&#39; protoco=
l is supported by client &#39;%s&#39;&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QIO_C=
HANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_request;<br>
+=C2=A0 =C2=A0 if (protocols) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_strrstr(protocols, QIO_CH=
ANNEL_WEBSOCK_PROTOCOL_BINARY)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &=
quot;No &#39;%s&#39; protocol is supported by client &#39;%s&#39;&quot;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad_request;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED=
_VERSION)) {<br>
@@ -467,7 +478,7 @@ static void qio_channel_websock_handshake_process(QIOCh=
annelWebsock *ioc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad_request;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 qio_channel_websock_handshake_send_res_ok(ioc, key, errp);<b=
r>
+=C2=A0 =C2=A0 qio_channel_websock_handshake_send_res_ok(ioc, key, !!protoc=
ols, errp);<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
<br>
=C2=A0 bad_request:<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div></div></div>

--000000000000726e03059870c535--

