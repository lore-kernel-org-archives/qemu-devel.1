Received: from eggs.gnu.org ([209.51.188.92]:38010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEyIn-0003ou-Kc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEyIm-0003MI-HJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:41:17 -0400
MIME-Version: 1.0
References: <20190412153647.19027-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190412153647.19027-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Apr 2019 17:41:03 +0200
Message-ID: <CAJ+F1CKDLkpWAA4W1auMdvQ1Pm0FdRT+UvTCfyn0VoRKk+W6Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/13] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi

On Fri, Apr 12, 2019 at 5:38 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> vhost-user allows to drive a virtio device in a seperate
> process. After vhost-user-net, we have seen
> vhost-user-{scsi,blk,crypto} added more recently.
>
> This series, initially proposed ~3 years ago, time flies
> (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
> contributes with vhost-user-input and vhost-user-gpu.
>
> You may start a vhost-user-gpu with virgl rendering in a separate
> process like this:
>
> $ ./vhost-user-gpu --virgl -s vgpu.sock &
> $ qemu...
>   -chardev socket,id=3Dchr,path=3Dvgpu.sock
>   -device vhost-user-vga,chardev=3Dchr
>
> v5:
>  - remove user-creatable version of vhost-user-backend
>  - remove optinal management of sub-process in vhost-user-backend
>  - removed daemonize/pid code
>  - drop introduction of new input & gpu messages for PCI config space
>    handling, instead use VHOST_USER_PROTOCOL_F_CONFIG
>  - plain mem & udmabuf fallback for 2d rendering
>  - rebased, kconfig-ify, rst-ify
>
> Gerd Hoffmann (1):
>   curses: fix wchar_t printf warning
>
> Greg Kurz (1):
>   spapr_pci: Fix broken naming of PCI bus
>
> Marc-Andr=C3=A9 Lureau (10):
>   Add vhost-user-backend
>   Add vhost-user-input-pci
>   libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
>   contrib: add vhost-user-input
>   vhost-user: add vhost_user_gpu_set_socket()
>   virtio: add virtio-gpu bswap helpers header
>   contrib: add vhost-user-gpu
>   virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
>   virtio-gpu: split virtio-gpu-pci & virtio-vga
>   hw/display: add vhost-user-vga & gpu-pci
>
> Peter Maydell (1):
>   Update version for v4.0.0-rc3 release
>

oops, some bonus patches :) my bad, please ignore



--=20
Marc-Andr=C3=A9 Lureau
