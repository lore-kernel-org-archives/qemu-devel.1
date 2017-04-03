Received: from eggs.gnu.org ([2001:4830:134:3::10]:55506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cv5eB-0001PO-Ng
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cv5eA-0004FH-TI
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:20:07 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170401004624.30886-11-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-11-ehabkost@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 3 Apr 2017 10:19:35 -0700
Message-ID: <CAKmqyKNxjFK30hhKBxoodYB4OZWc=M4NQrRcQx8QL8UH5HEWuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 10/19] sysbus-ahci: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, Rob Herring <robh@kernel.org>, John Snow <jsnow@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Laszlo Ersek <lersek@redhat.com>

On Fri, Mar 31, 2017 at 5:46 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The sysbus-ahci devices are supposed to be created and wired by
> code from other devices, like calxeda_init() and
> xlnx_zynqmp_realize(), and won't work with -device. Remove the
> user_creatable flag from the device class.
>
> Cc: John Snow <jsnow@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/ide/ahci.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index b1b7780d56..68f2ce09ee 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1721,11 +1721,6 @@ static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
>      dc->props = sysbus_ahci_properties;
>      dc->reset = sysbus_ahci_reset;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> -    /*
> -     * FIXME: Set only for compatibility on q35 machine-type.
> -     * Probably never meant to be user-creatable
> -     */
> -    dc->user_creatable = true;

Part of me thinks this is a step backwards by marking it unsupported.
On the other hand I don't see how this could usefully be connected any
other way.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

>  }
>
>  static const TypeInfo sysbus_ahci_info = {
> --
> 2.11.0.259.g40922b1
>
>
