Received: from eggs.gnu.org ([2001:4830:134:3::10]:56132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cootj-00070q-4a
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cootf-0003tQ-TS
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cootf-0003tL-Np
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:14:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE9B37AEA5
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:14:11 +0000 (UTC)
Date: Fri, 17 Mar 2017 10:14:04 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170317101404.GC8050@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170317092802.17973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317092802.17973-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: fix a qio-channel leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Fri, Mar 17, 2017 at 01:28:02PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

> diff --git a/ui/vnc.c b/ui/vnc.c
> index 8bfb1e0685..6e93b883b5 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3677,6 +3677,7 @@ static int vnc_display_listen_addr(VncDisplay *vd=
,
>          qio_channel_set_name(QIO_CHANNEL(sioc), name);
>          if (qio_channel_socket_listen_sync(
>                  sioc, rawaddrs[i], listenerr =3D=3D NULL ? &listenerr =
: NULL) < 0) {
> +            object_unref(OBJECT(sioc));
>              continue;
>          }
>          listening =3D true;

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
