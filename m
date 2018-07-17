Received: from eggs.gnu.org ([2001:4830:134:3::10]:44825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPu7-0007Tx-1w
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPu3-0007LU-1p
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:20:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffPu2-0007LH-Si
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:20:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 872BD7C6CA
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:20:30 +0000 (UTC)
Date: Tue, 17 Jul 2018 14:20:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180717132027.GS18603@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
	<20180717125239.22517-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717125239.22517-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] char-socket: correctly set
 has_reconnect when parsing QemuOpts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jul 17, 2018 at 02:52:37PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> qemu_chr_parse_socket() fills all ChardevSocket fields, but that
> doesn't reflect correctly the arguments given with the options / on
> the command line. "reconnect" takes a number as argument, and the
> default value is 0, which doesn't help to identify the missing
> option. The other arguments have default values that are less
> problematic, leave them set by default for now.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index efbad6ee7c..8950f36317 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1111,7 +1111,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts,=
 ChardevBackend *backend,
>      sock->tn3270 =3D is_tn3270;
>      sock->has_wait =3D true;
>      sock->wait =3D is_waitconnect;
> -    sock->has_reconnect =3D true;
> +    sock->has_reconnect =3D qemu_opt_find(opts, "reconnect");
>      sock->reconnect =3D reconnect;
>      sock->tls_creds =3D g_strdup(tls_creds);

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
