Received: from eggs.gnu.org ([2001:4830:134:3::10]:37381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKbD-0001ME-5C
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKbA-00078f-0K
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:33:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emKb9-00077p-Ql
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:33:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B9933F741
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:33:19 +0000 (UTC)
References: <20180215102602.10864-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2905a78b-72ce-5f76-d9d4-b39fd8058f6e@redhat.com>
Date: Thu, 15 Feb 2018 08:32:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180215102602.10864-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: remove bogus object_unref on client
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 02/15/2018 04:26 AM, Daniel P. Berrang=C3=A9 wrote:
> vnc_listen_io() does not own the reference on the 'cioc' parameter is i=
t
> passed, so should not be unref'ing it.
>=20
> Reported-by: Bandan Das <bsd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   ui/vnc.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index c715bae1cf..b97769aa9e 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3152,7 +3152,6 @@ static void vnc_listen_io(QIONetListener *listene=
r,
>                            isWebsock ? "vnc-ws-server" : "vnc-server");
>       qio_channel_set_delay(QIO_CHANNEL(cioc), false);
>       vnc_connect(vd, cioc, false, isWebsock);
> -    object_unref(OBJECT(cioc));
>   }
>  =20
>   static const DisplayChangeListenerOps dcl_ops =3D {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
