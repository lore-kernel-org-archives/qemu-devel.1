Received: from eggs.gnu.org ([2001:4830:134:3::10]:45989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTrsI-0004ha-LQ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTrsH-0005CP-WB
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:46:58 -0400
References: <20180613122948.18149-1-kraxel@redhat.com>
	<20180613122948.18149-3-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9af3a798-2a20-24bb-8f07-b803a6c262a8@redhat.com>
Date: Fri, 15 Jun 2018 18:46:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180613122948.18149-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/4] hw/display: add standalone ramfb
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/13/18 14:29, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/display/ramfb.h    |  3 +++
>  hw/arm/sysbus-fdt.c           |  7 +++++
>  hw/arm/virt.c                 |  2 ++
>  hw/display/ramfb-standalone.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_piix.c             |  2 ++
>  hw/i386/pc_q35.c              |  2 ++
>  hw/display/Makefile.objs      |  1 +
>  7 files changed, 79 insertions(+)
>  create mode 100644 hw/display/ramfb-standalone.c

Tested-by: Laszlo Ersek <lersek@redhat.com>
