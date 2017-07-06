Received: from eggs.gnu.org ([2001:4830:134:3::10]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT9KY-0005ba-VQ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT9KV-0007f4-QG
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dT9KV-0007eM-KN
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:08:35 -0400
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-3-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d9df986e-2b4c-4648-3cbc-b99826a52aaf@redhat.com>
Date: Thu, 6 Jul 2017 18:08:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170706101611.27031-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/7] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, anderson@redhat.com, imammedo@redhat.com, Richard Henderson <rth@twiddle.net>

On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
> The VM coreinfo (vmcoreinfo) device is an emulated device which
> exposes a 4k memory range to the guest to store various informations
> useful to debug the guest OS. (it is greatly inspired by the VMGENID
> device implementation)
>=20
> This is an early-boot alternative to the qemu-ga VMDUMP_INFO event
> proposed in "[PATCH 00/21] WIP: dump: add kaslr support".
>=20
> A proof-of-concept kernel module:
> https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/acpi/aml-build.h        |   1 +
>  include/hw/acpi/vmcoreinfo.h       |  36 +++++++
>  hw/acpi/aml-build.c                |   2 +
>  hw/acpi/vmcoreinfo.c               | 208 +++++++++++++++++++++++++++++=
++++++++
>  hw/i386/acpi-build.c               |  14 +++
>  default-configs/arm-softmmu.mak    |   1 +
>  default-configs/i386-softmmu.mak   |   1 +
>  default-configs/x86_64-softmmu.mak |   1 +
>  docs/specs/vmcoreinfo.txt          | 138 ++++++++++++++++++++++++
>  hw/acpi/Makefile.objs              |   1 +
>  10 files changed, 403 insertions(+)
>  create mode 100644 include/hw/acpi/vmcoreinfo.h
>  create mode 100644 hw/acpi/vmcoreinfo.c
>  create mode 100644 docs/specs/vmcoreinfo.txt

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
