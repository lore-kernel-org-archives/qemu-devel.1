Received: from eggs.gnu.org ([2001:4830:134:3::10]:40159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d7gH3-0000Lw-NH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d7gH0-0007cC-U2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:52:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56886
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d7gH0-0007bi-O1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:52:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v48AdxJ2069931
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 06:52:13 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aahm8g1j7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 06:52:13 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 8 May 2017 11:52:09 +0100
Date: Mon, 8 May 2017 12:51:58 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170505203620.GN3482@thinpad.lan.raisama.net>
References: <20170503203604.31462-1-ehabkost@redhat.com>
	<20170503203604.31462-3-ehabkost@redhat.com>
	<20170505093622.37902dea.cornelia.huck@de.ibm.com>
	<20170505165419.GF3482@thinpad.lan.raisama.net>
	<20170505203620.GN3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170508125158.713581ce.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] fixup! sysbus: Set user_creatable=false by
 default on TYPE_SYS_BUS_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, "Gabriel L . Somlo" <somlo@cmu.edu>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, Juergen Gross <jgross@suse.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Rob Herring <robh@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>, sstabellini@kernel.org, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On Fri, 5 May 2017 17:36:20 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Fixup will be included in v3, or can be applied by maintainer:
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/sysbus.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 6a2eec8dd0..5d0887f499 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -327,14 +327,14 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
>      k->init = sysbus_device_init;
>      k->bus_type = TYPE_SYSTEM_BUS;
>      /*
> -     * device_add plugs devices into suitable bus.  For "real" buses,
> +     * device_add plugs devices into a suitable bus.  For "real" buses,
>       * that actually connects the device.  For sysbus, the connections
>       * need to be made separately, and device_add can't do that.  The
>       * device would be left unconnected, and will probably not work
>       *
> -     * However, a few machines and a few devices can handle a few sysbus
> -     * devices. In this case, the device subclass needs to override
> -     * it and set user_creatable=true.
> +     * However, a few machines can handle device_add/-device with
> +     * a few specific sysbus devices. In those cases, the device
> +     * subclass needs to override it and set user_creatable=true.
>       */
>      k->user_creatable = false;
>  }

FWIW: LGTM
