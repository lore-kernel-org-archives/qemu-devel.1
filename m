Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3559C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A289220818
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A289220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG4T1-0000W9-NX
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:28:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG4SH-0000AQ-OO
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG4SG-0001SP-HH
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG4SG-0001RQ-5X
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:27:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4419959458
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 16:27:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 40B3C608C2;
	Mon, 15 Apr 2019 16:27:28 +0000 (UTC)
Date: Mon, 15 Apr 2019 17:27:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190415162725.GR5718@redhat.com>
References: <20190415162129.30511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415162129.30511-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 15 Apr 2019 16:27:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] socket: allow wait=false for client
 socket
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415162725.cqvnxqCIew51ZRAnKnFKC44H6EBVT_0QKuVWKAO2eJg@z>

On Mon, Apr 15, 2019 at 06:21:29PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> thus fail to add client chardev.
>=20
> Make the code more permissive, allowing wait=3Dfalse with client socket
> chardevs. Deprecate usage of 'wait' with client sockets.
>=20
> Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 10 +++++++---
>  qemu-deprecated.texi  |  5 +++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 3916505d67..ebc1adb83e 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1263,9 +1263,13 @@ static bool qmp_chardev_validate_socket(ChardevS=
ocket *sock,
>              return false;
>          }
>          if (sock->has_wait) {
> -            error_setg(errp, "%s",
> -                       "'wait' option is incompatible with "
> -                       "socket in client connect mode");
> +            warn_report("'wait' option is deprecated with "
> +                        "socket in client connect mode");
> +            if (sock->wait) {
> +                error_setg(errp, "%s",
> +                           "'wait' option is incompatible with "
> +                           "socket in client connect mode");
> +            }
>              return false;

Oh wait, don't you need to put the 'return false' inside the
if branch above, otherwise we're still failing validation.

>          }
>      }
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2219386769..842e71b11d 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -105,6 +105,11 @@ details.
>  The ``query-events'' command has been superseded by the more powerful
>  and accurate ``query-qmp-schema'' command.
> =20
> +@subsection chardev client socket with 'wait' option (since 4.0)
> +
> +Character devices creating sockets in client mode should not specify
> +the 'wait' field, which is only applicable to sockets in server mode
> +
>  @section Human Monitor Protocol (HMP) commands
> =20
>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (=
since 3.1)
> --=20
> 2.21.0.313.ge35b8cb8e2
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

