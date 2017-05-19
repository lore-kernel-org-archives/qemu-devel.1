Received: from eggs.gnu.org ([2001:4830:134:3::10]:44751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBe9m-0003aE-Nr
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBe9h-00033A-RU
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:25:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dBe9h-000330-Kx
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:25:05 -0400
Message-ID: <1495185902.627.55.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 19 May 2017 11:25:02 +0200
In-Reply-To: <CAJO5WKsHRbOpeSB2BrUhBRuB=xDUbXDm4n+XhO2v2phV+1Sgiw@mail.gmail.com>
References: <CAJO5WKsHRbOpeSB2BrUhBRuB=xDUbXDm4n+XhO2v2phV+1Sgiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] specify memory in QEMU with Virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jenia mtl <jenia.ivlev@gmail.com>
Cc: qemu-devel@nongnu.org

On Do, 2017-05-18 at 22:43 -0400, jenia mtl wrote:
> Hello.
>=20
>=20
> How do I specify how much graphics memory the Windows client should have =
in
> QEMU. I have successfully installed Virtio and can launch the VM (Windows=
)
> with it. This doubles the memory form 8MB to 16MB. But I need 512. How ca=
n
> I set that?

virtio-vga doesn't need dedicated video memory, except for the
(unaccelerated) vga compatibility mode.  But given that there are no
virtio-vga drivers for windows (yet) it'll actually runs in vga mode, so
you have no advantages over stdvga.

stdvga can be configured with up to 256M of video memory (-device
VGA,vgamem_mb=3D64).  This will allow higher resolutions display
resolutions.  Still an unaccelerated framebuffer though.

cheers,
  Gerd
