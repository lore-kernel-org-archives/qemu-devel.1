Received: from eggs.gnu.org ([2001:4830:134:3::10]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cv5eb-0001oc-2X
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cv5ea-0004R5-5A
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:20:33 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cv5eZ-0004Qx-WE
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:20:32 -0400
Received: by mail-oi0-x242.google.com with SMTP id f193so20762294oib.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 10:20:31 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170401004624.30886-17-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-17-ehabkost@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 3 Apr 2017 10:20:00 -0700
Message-ID: <CAKmqyKMnZv8-DWh93dpLk7N_OWuiACswd3kxCT0uAj3V2LgH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 16/19] generic-sdhci: Remove user_creatable
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Mar 31, 2017 at 5:46 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> generic-sdhci needs to be wired by other devices' code, so it
> can't be used with -device. Remove the user_creatable flag from
> the device class.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/sd/sdhci.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 186555188b..6d6a791ee9 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1360,11 +1360,6 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->props = sdhci_sysbus_properties;
>      dc->realize = sdhci_sysbus_realize;
>      dc->reset = sdhci_poweron_reset;
> -    /*
> -     * FIXME: Set only for compatibility on q35 machine-type.
> -     * Probably never meant to be user-creatable
> -     */
> -    dc->user_creatable = true;
>  }
>
>  static const TypeInfo sdhci_sysbus_info = {
> --
> 2.11.0.259.g40922b1
>
>
