Received: from eggs.gnu.org ([2001:4830:134:3::10]:48721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbrtD-00046F-UJ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbrtA-0003gk-RX
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:48:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cbrtA-0003gH-LB
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:48:08 -0500
Message-ID: <1486658883.31104.71.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 09 Feb 2017 17:48:03 +0100
In-Reply-To: <20170209135851.GC4742@redhat.com>
References: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA_3end4WrkELu9LBxL8jnUWt0SKRwMJtuMh_1QeVQy4=g@mail.gmail.com>
	<20170209135851.GC4742@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 00/10] vnc: add support for multiple
 listening sockets.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

> Gerd, just squash
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 77f2a99..bffc650 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3529,7 +3529,7 @@ static int vnc_display_get_address(const char *addr=
str,
>      } else {
>          const char *port;
>          size_t hostlen;
> -        unsigned long long baseport;
> +        unsigned long long baseport =3D 0;
>          InetSocketAddress *inet;
> =20
>          port =3D strrchr(addrstr, ':');
>=20
>=20
> Into this commit:
>=20
>     ui: refactor code for populating SocketAddress from vnc_display_open
>=20
> Just confirmed this fixes it with a local clang build

Thanks.  Done, new pull on the way.

>=20
> Regards,
> Daniel
