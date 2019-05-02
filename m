Received: from eggs.gnu.org ([209.51.188.92]:50083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM5S5-0008RZ-Bo
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM5S1-0005WT-QE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:44:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hM5Rv-0005Ry-GE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:44:11 -0400
Date: Thu, 2 May 2019 08:44:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190502064400.cvfkul7aelyyfme5@sirius.home.kraxel.org>
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412121626.19829-5-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] hw/usb: avoid format truncation
 warning when formatting port name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

On Fri, Apr 12, 2019 at 01:16:25PM +0100, Daniel P. Berrang=C3=A9 wrote:
> hw/usb/hcd-xhci.c: In function =E2=80=98usb_xhci_realize=E2=80=99:
> hw/usb/hcd-xhci.c:3339:66: warning: =E2=80=98%d=E2=80=99 directive outp=
ut may be truncated writing between 1 and 10 bytes into a region of size =
5 [-Wformat-trunca\
> tion=3D]
>  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port=
 #%d", i+1);
>       |                                                                =
  ^~
> hw/usb/hcd-xhci.c:3339:54: note: directive argument in the range [1, 21=
47483647]
>  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port=
 #%d", i+1);
>       |                                                      ^~~~~~~~~~=
~~~~~
>=20
> The xhci code formats the port name into a fixed length
> buffer which is only large enough to hold port numbers
> upto 5 digits in decimal representation. We're never
> going to have a port number that large, so aserting the
> port number is sensible is sufficient to tell GCC the
> formatted string won't be truncated.

Picked into the usb queue.

thanks,
  Gerd
