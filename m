Received: from eggs.gnu.org ([2001:4830:134:3::10]:45580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn1Ww-0004cX-0f
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn1Wr-000313-4h
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fn1Wq-00030j-Vx
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:01 -0400
Date: Tue, 7 Aug 2018 14:55:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180807125558.2g7nl5zhgrdblrwh@sirius.home.kraxel.org>
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180803153235.4134-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix crashes upon warm reboot
 with vga mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Aug 03, 2018 at 05:32:35PM +0200, Marc-Andr=E9 Lureau wrote:
> With vga=3D775 on the Linux command line a first boot of the VM running
> Linux works fine. After a warm reboot it crashes during Linux boot.
>=20
> Before that, valgrind points out bad memory write to console
> surface. The VGA code is not aware that virtio-gpu got a message
> surface scanout when the display is disabled. Let's reset VGA graphic
> mode when it is the case, so that a new display surface is created
> when doing further VGA operations.

I guess we should simply call vga_common_reset() in virtio_vga_reset()
instead, can you try that?

thanks,
  Gerd
