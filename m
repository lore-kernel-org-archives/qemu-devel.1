Received: from eggs.gnu.org ([2001:4830:134:3::10]:52550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYWnh-00082Q-FB
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYWne-0007yl-63
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:17:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYWnd-0007xk-Vo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F9247A7E5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:17:25 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.48])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 24ED9213ED6A
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:17:25 +0000 (UTC)
Date: Thu, 28 Jun 2018 14:17:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628131722.GA13766@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180607101019.14958-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180607101019.14958-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] doc: switch to modern syntx for VNC TLS
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ping, anyone have comments on this, besides the typo in $SUBJECT,
also repeated in commit msg

On Thu, Jun 07, 2018 at 11:10:19AM +0100, Daniel P. Berrang=C3=A9 wrote:
> The use of 'tls', 'x509' and 'x509verify' properties is the legacy
> backcompat syntx, replaced by use of TLS creds objects.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qemu-doc.texi | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f00706b999..d526870479 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1097,7 +1097,9 @@ support provides a secure session, but no authent=
ication. This allows any
>  client to connect, and provides an encrypted session.
> =20
>  @example
> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509=3D/etc/pki/qemu -mon=
itor stdio
> +qemu-system-i386 [...OPTIONS...] \
> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserv=
er,verify-peer=3Dno \
> +  -vnc :1,tls-creds=3Dtls0 -monitor stdio
>  @end example
> =20
>  In the above example @code{/etc/pki/qemu} should contain at least thre=
e files,
> @@ -1112,10 +1114,14 @@ only be readable by the user owning it.
>  Certificates can also provide a means to authenticate the client conne=
cting.
>  The server will request that the client provide a certificate, which i=
t will
>  then validate against the CA certificate. This is a good choice if dep=
loying
> -in an environment with a private internal certificate authority.
> +in an environment with a private internal certificate authority. It us=
es the
> +same syntax as previously, but with @code{verify-peer} set to @code{ye=
s}
> +instead.
> =20
>  @example
> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509verify=3D/etc/pki/qem=
u -monitor stdio
> +qemu-system-i386 [...OPTIONS...] \
> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserv=
er,verify-peer=3Dyes \
> +  -vnc :1,tls-creds=3Dtls0 -monitor stdio
>  @end example
> =20
> =20
> @@ -1126,7 +1132,9 @@ Finally, the previous method can be combined with=
 VNC password authentication
>  to provide two layers of authentication for clients.
> =20
>  @example
> -qemu-system-i386 [...OPTIONS...] -vnc :1,password,tls,x509verify=3D/et=
c/pki/qemu -monitor stdio
> +qemu-system-i386 [...OPTIONS...] \
> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserv=
er,verify-peer=3Dyes \
> +  -vnc :1,tls-creds=3Dtls0,password -monitor stdio
>  (qemu) change vnc password
>  Password: ********
>  (qemu)
> @@ -1163,7 +1171,9 @@ credentials. This can be enabled, by combining th=
e 'sasl' option
>  with the aforementioned TLS + x509 options:
> =20
>  @example
> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509,sasl -monitor stdio
> +qemu-system-i386 [...OPTIONS...] \
> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserv=
er,verify-peer=3Dyes \
> +  -vnc :1,tls-creds=3Dtls0,sasl -monitor stdio
>  @end example
> =20
>  @node vnc_setup_sasl
> --=20
> 2.17.0
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
