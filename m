Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0BEC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E69F20880
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E69F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG42s-0003d6-Nc
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:01:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3yI-0000Qo-1U
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3yG-0004lV-LF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:56:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG3yE-0004gi-Ru
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:56:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E176086678
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 15:56:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E3E581001E8C;
	Mon, 15 Apr 2019 15:56:30 +0000 (UTC)
Date: Mon, 15 Apr 2019 16:56:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190415155627.GO5718@redhat.com>
References: <20190415154906.14621-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415154906.14621-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 15 Apr 2019 15:56:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] socket: allow wait=false for client socket
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415155627.X0P3f2hZve7OxdI_qqg1m02ze6aiyroiBOEkc0Ky2EI@z>

On Mon, Apr 15, 2019 at 05:49:06PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> thus fail to add client chardev.
>=20
> Make the code more permissive, allowing wait=3Dfalse with client socket
> chardevs.
>=20
> Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 3916505d67..2ad9c9eea5 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1262,7 +1262,7 @@ static bool qmp_chardev_validate_socket(ChardevSo=
cket *sock,
>              error_setg(errp, "%s", "Websocket client is not implemente=
d");
>              return false;
>          }
> -        if (sock->has_wait) {
> +        if (sock->has_wait && sock->wait) {
>              error_setg(errp, "%s",
>                         "'wait' option is incompatible with "
>                         "socket in client connect mode");

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Though, I think we should issue a deprecation warning if 'has_wait' is
set, because this is still user error, and it would be good to make it
stricter again later.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

