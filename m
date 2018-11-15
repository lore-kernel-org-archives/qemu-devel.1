Received: from eggs.gnu.org ([2001:4830:134:3::10]:34256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gNKER-0007fc-OV
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gNKER-0001vV-4T
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:11:03 -0500
Date: Thu, 15 Nov 2018 17:10:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181115171009.3d59a535.cohuck@redhat.com>
In-Reply-To: <20181114132931.22624-1-marcandre.lureau@redhat.com>
References: <20181114132931.22624-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vmstate: constify VMStateField
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:S390" <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open
	list:PowerPC" <qemu-ppc@nongnu.org>

On Wed, 14 Nov 2018 17:29:30 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Because they are supposed to remain const.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/migration/vmstate.h |   6 +-
>  hw/display/virtio-gpu.c     |   4 +-
>  hw/intc/s390_flic_kvm.c     |   4 +-
>  hw/nvram/eeprom93xx.c       |   6 +-
>  hw/nvram/fw_cfg.c           |   6 +-
>  hw/pci/msix.c               |   4 +-
>  hw/pci/pci.c                |   8 +--
>  hw/pci/shpc.c               |   7 ++-
>  hw/scsi/scsi-bus.c          |   4 +-
>  hw/timer/twl92230.c         |   4 +-
>  hw/usb/redirect.c           |  12 ++--
>  hw/virtio/virtio.c          |   8 +--
>  migration/savevm.c          |   7 ++-
>  migration/vmstate-types.c   | 119 ++++++++++++++++++++----------------
>  migration/vmstate.c         |  31 +++++-----
>  target/alpha/machine.c      |   5 +-
>  target/arm/machine.c        |  12 ++--
>  target/hppa/machine.c       |  10 +--
>  target/mips/machine.c       |  14 +++--
>  target/openrisc/machine.c   |   5 +-
>  target/ppc/machine.c        |  14 +++--
>  target/sparc/machine.c      |   7 ++-
>  22 files changed, 162 insertions(+), 135 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
