Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA57C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DF420717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpfTEPeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DF420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibo1P-0000nw-Cm
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ibo0W-00089U-AH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ibo0U-00067o-SM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:53:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ibo0U-00067V-OZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575301982;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2IMzEz3qIz851v4twhsY+tYOzVNmPCyL+i/hYDZ3s0=;
 b=dpfTEPehRhvF/KF2NTpDL1mlCSjmTqoYO3B/l4Dw1migtTT41m0HN8DvHInvn4EhVABYHd
 6hZGZA3ko0bhPz4i0UTc+3tDwFbceE50g54IcjsOyFHRh5HEafp6mlY4hPA9IUy+YGSpYX
 m1dGtEJB4oJ8LhWcpO7tTtWMovI/NsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-JmruyA85PDCrttuX4lf3GQ-1; Mon, 02 Dec 2019 10:52:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C3B18766F3;
 Mon,  2 Dec 2019 15:52:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 293525DA76;
 Mon,  2 Dec 2019 15:52:57 +0000 (UTC)
Date: Mon, 2 Dec 2019 15:52:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yu-Chen Lin <npes87184@gmail.com>
Subject: Re: [PATCH] io/channel-websock: treat 'binary' and no sub-protocol
 as the same
Message-ID: <20191202155254.GN4184266@redhat.com>
References: <20191123034306.6139-1-npes87184@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191123034306.6139-1-npes87184@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: JmruyA85PDCrttuX4lf3GQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 23, 2019 at 11:43:06AM +0800, Yu-Chen Lin wrote:
> noVNC doesn't use 'binary' protocol by default after
> commit c912230309806aacbae4295faf7ad6406da97617.
>=20
> It will cause qemu return 400 when handshaking.
>=20
> To overcome this problem and remain compatibility of
> older noVNC client.
>=20
> We treat 'binary' and no sub-protocol as the same
> so that we can support different version of noVNC
> client.
>=20
> Tested on noVNC before c912230 and after c912230.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1849644
>=20
> Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
> ---
>  io/channel-websock.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)

Thank you, I have queued this for 5.0.

  Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Also CC'ing stable for the first 4.2 bug fix release.

>=20
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index fc36d44eba..918e09ea3f 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -49,13 +49,20 @@
>      "Server: QEMU VNC\r\n"                       \
>      "Date: %s\r\n"
> =20
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
> @@ -336,6 +343,7 @@ qio_channel_websock_find_header(QIOChannelWebsockHTTP=
Header *hdrs,
> =20
>  static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock =
*ioc,
>                                                        const char *key,
> +                                                      const bool use_pro=
tocols,
>                                                        Error **errp)
>  {
>      char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
> @@ -361,8 +369,13 @@ static void qio_channel_websock_handshake_send_res_o=
k(QIOChannelWebsock *ioc,
>      }
> =20
>      date =3D qio_channel_websock_date_str();
> -    qio_channel_websock_handshake_send_res(
> -        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
> +    if (use_protocols) {
> +            qio_channel_websock_handshake_send_res(
> +                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK, da=
te, accept);
> +    } else {
> +            qio_channel_websock_handshake_send_res(
> +                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept)=
;
> +    }
> =20
>      g_free(date);
>      g_free(accept);
> @@ -387,10 +400,6 @@ static void qio_channel_websock_handshake_process(QI=
OChannelWebsock *ioc,
> =20
>      protocols =3D qio_channel_websock_find_header(
>          hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
> -    if (!protocols) {
> -        error_setg(errp, "Missing websocket protocol header data");
> -        goto bad_request;
> -    }
> =20
>      version =3D qio_channel_websock_find_header(
>          hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
> @@ -430,10 +439,12 @@ static void qio_channel_websock_handshake_process(Q=
IOChannelWebsock *ioc,
>      trace_qio_channel_websock_http_request(ioc, protocols, version,
>                                             host, connection, upgrade, ke=
y);
> =20
> -    if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
> -        error_setg(errp, "No '%s' protocol is supported by client '%s'",
> -                   QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
> -        goto bad_request;
> +    if (protocols) {
> +            if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINAR=
Y)) {
> +                error_setg(errp, "No '%s' protocol is supported by clien=
t '%s'",
> +                           QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocol=
s);
> +                goto bad_request;
> +            }
>      }
> =20
>      if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) {
> @@ -467,7 +478,7 @@ static void qio_channel_websock_handshake_process(QIO=
ChannelWebsock *ioc,
>          goto bad_request;
>      }
> =20
> -    qio_channel_websock_handshake_send_res_ok(ioc, key, errp);
> +    qio_channel_websock_handshake_send_res_ok(ioc, key, !!protocols, err=
p);
>      return;
> =20
>   bad_request:
> --=20
> 2.17.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


