Received: from eggs.gnu.org ([2001:4830:134:3::10]:43425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAaAn-0003ma-8G
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAaAm-0001Sl-Jg
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAaAm-0001SR-Bl
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:34:36 -0400
References: <20181011112436.9305-1-ppandit@redhat.com>
	<a5508166-efdc-d1d9-0fe1-9acb1f590633@redhat.com>
	<nycvar.YSQ.7.76.1810111749490.9486@xnncv>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7569df8e-97e2-8488-ce91-9059428c2d29@redhat.com>
Date: Thu, 11 Oct 2018 14:34:25 +0200
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1810111749490.9486@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ccid-card-passthru: check buffer size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Arash TC <tohidi.arash@gmail.com>

On 11/10/2018 14:29, P J P wrote:
> +-- On Thu, 11 Oct 2018, Philippe Mathieu-Daud=C3=A9 wrote --+
> | The IOReadHandler does not have documentation.
> |=20
> |  typedef void IOReadHandler(void *opaque, const uint8_t *buf, int siz=
e);
> |=20
> | Why is the 'size' argument signed? Does it makes sens to call it with=
 a
> | negative value?
>=20
>   No, it doesn't IMO. I had first changed argument type 'int' to uint32=
_t'.
> as
>=20
>   typedef void IOReadHandler(void *opaque, const uint8_t *buf, uint32_t=
 size);
>=20
> But 'IOReadHandler' is registered and called from multiple char devices=
,=20
> which lead to compile time errors. As the function prototype changed.
>=20
> I'll update them all, if the above change is okay.

Yes, please do so.

Paolo

> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
>=20
