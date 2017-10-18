Received: from eggs.gnu.org ([2001:4830:134:3::10]:53196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4nFU-0006PE-LE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4nFR-00032O-HV
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:15:00 -0400
References: <20171017164426.25277-1-f4bug@amsat.org>
	<20171017164426.25277-37-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30402756-92d4-ee2a-056e-fa976991035f@redhat.com>
Date: Wed, 18 Oct 2017 14:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <20171017164426.25277-37-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 36/42] hw/display/vga: "vga_int.h"
 requires "ui/console.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 17.10.2017 18:44, Philippe Mathieu-Daud=C3=A9 wrote:
> since The VGACommonState struct has a GraphicHwOps *hw_ops member,
> then remove the now unnecessary includes.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/display/qxl.h        | 1 -
>  hw/display/vga_int.h    | 3 ++-
>  hw/display/cirrus_vga.c | 1 -
>  hw/display/vga-isa-mm.c | 1 -
>  hw/display/vga-isa.c    | 1 -
>  hw/display/vga-pci.c    | 1 -
>  hw/display/vga.c        | 1 -
>  hw/display/virtio-vga.c | 1 -
>  hw/display/vmware_vga.c | 1 -
>  9 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
