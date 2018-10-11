Received: from eggs.gnu.org ([2001:4830:134:3::10]:42199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gAa6O-0000ah-Ia
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gAa6L-0005MF-DR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gAa6L-0005LY-7q
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:30:01 -0400
Date: Thu, 11 Oct 2018 17:59:43 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <a5508166-efdc-d1d9-0fe1-9acb1f590633@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810111749490.9486@xnncv>
References: <20181011112436.9305-1-ppandit@redhat.com>
	<a5508166-efdc-d1d9-0fe1-9acb1f590633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Arash TC <tohidi.arash@gmail.com>

+-- On Thu, 11 Oct 2018, Philippe Mathieu-Daud=C3=A9 wrote --+
| The IOReadHandler does not have documentation.
|=20
|  typedef void IOReadHandler(void *opaque, const uint8_t *buf, int size)=
;
|=20
| Why is the 'size' argument signed? Does it makes sens to call it with a
| negative value?

  No, it doesn't IMO. I had first changed argument type 'int' to uint32_t=
'.
as

  typedef void IOReadHandler(void *opaque, const uint8_t *buf, uint32_t s=
ize);

But 'IOReadHandler' is registered and called from multiple char devices,=20
which lead to compile time errors. As the function prototype changed.

I'll update them all, if the above change is okay.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
