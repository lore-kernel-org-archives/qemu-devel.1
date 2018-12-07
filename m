Received: from eggs.gnu.org ([2001:4830:134:3::10]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gVK3e-00058L-Oy
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gVK3Z-0007sZ-RQ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:36:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gVK3Z-0007ov-LE
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:36:53 -0500
Date: Fri, 7 Dec 2018 12:36:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181207123456-mutt-send-email-mst@kernel.org>
References: <20181207165103.3992-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181207165103.3992-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Introduce the hw/firmware/ namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Fri, Dec 07, 2018 at 05:50:59PM +0100, Philippe Mathieu-Daud=E9 wrote:
> QEMU interacts with various firmwares. We already have some helpers
> for some firmwares. Later we will add UEFI helpers.
> This series introduce the hw/firmware namespace for this.
>=20
> There is no need to move hw/smbios sources into a specific directory,
> we only focus on the headers.

I like this

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

will queue after giving people a bit of time for review.

> Philippe Mathieu-Daud=E9 (4):
>   tests: Remove unused include
>   hw/smbios: Restrict access to "smbios_ipmi.h"
>   hw/smbios: Remove "smbios_ipmi.h"
>   hw/smbios: Move to the hw/firmware/ namespace
>=20
>  MAINTAINERS                              |  2 +-
>  hw/arm/virt.c                            |  2 +-
>  hw/i386/pc.c                             |  2 +-
>  hw/i386/pc_piix.c                        |  2 +-
>  hw/i386/pc_q35.c                         |  2 +-
>  hw/smbios/smbios-stub.c                  |  2 +-
>  hw/smbios/smbios.c                       |  3 +--
>  hw/smbios/smbios_build.h                 |  4 ++++
>  hw/smbios/smbios_type_38-stub.c          |  2 +-
>  hw/smbios/smbios_type_38.c               |  3 +--
>  include/hw/{smbios =3D> firmware}/smbios.h |  0
>  include/hw/smbios/ipmi.h                 | 15 ---------------
>  tests/acpi-utils.c                       |  1 -
>  tests/bios-tables-test.c                 |  2 +-
>  vl.c                                     |  2 +-
>  15 files changed, 15 insertions(+), 29 deletions(-)
>  rename include/hw/{smbios =3D> firmware}/smbios.h (100%)
>  delete mode 100644 include/hw/smbios/ipmi.h
>=20
> --=20
> 2.17.2
