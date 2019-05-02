Received: from eggs.gnu.org ([209.51.188.92]:55239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMBeG-0008Bv-Te
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMBeF-00073K-0G
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hMBeD-000703-4z
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:21:14 -0400
Date: Thu, 2 May 2019 15:21:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190502132105.qkudeunhcueadka7@sirius.home.kraxel.org>
References: <20190502073543.4391-1-kraxel@redhat.com>
	<CAFEAcA-OyrwAqp1Kwt-sFJY3xj=0mUszGtF3RewwLs25vOhNLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-OyrwAqp1Kwt-sFJY3xj=0mUszGtF3RewwLs25vOhNLg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] Usb 20190502 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

> Hi -- I'm afraid this failed to compile on one of my systems:
>=20
>   CC      hw/usb/hcd-xhci.o
> /home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c: In function
> =E2=80=98usb_xhci_realize=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3340:66:
> error: =E2=80=98%d=E2=80=99 directive output may be truncated writing b=
etween 1 and 11
> bytes into a region of size 5 [-Werror=3Dformat-truncation=3D]
>              snprintf(port->name, sizeof(port->name), "usb2 port #%d", =
i+1);

Which system/compiler is this?

cheers,
  Gerd
