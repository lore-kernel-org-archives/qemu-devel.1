Received: from eggs.gnu.org ([2001:4830:134:3::10]:34249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daIuu-0003iq-Ri
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daIuq-0000gF-Nb
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:47:44 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:37190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1daIuq-0000g3-Dt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:47:40 -0400
Received: by mail-wr0-x230.google.com with SMTP id 33so72724070wrz.4
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 02:47:40 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <5D91140C-97D6-4114-AB26-52F460362DA8@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Wed, 26 Jul 2017 12:47:37 +0300
In-Reply-To: <20170726084153.10121-2-maozy.fnst@cn.fujitsu.com>
References: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
	<20170726084153.10121-2-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/scsi/vmw_pvscsi: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


> On 26 Jul 2017, at 11:41 AM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com> =
wrote:
>=20
> Convert a device model where initialization obviously
> can't fail, make it implement realize() rather than init().

Acked-by: Dmitry Fleytman <dmitry@daynix.com <mailto:dmitry@daynix.com>>

>=20
> Cc: Dmitry Fleytman <dmitry@daynix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
> hw/scsi/vmw_pvscsi.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index d92973e..77d8b6f 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -1103,8 +1103,8 @@ static const struct SCSIBusInfo pvscsi_scsi_info =
=3D {
>         .cancel =3D pvscsi_request_cancelled,
> };
>=20
> -static int
> -pvscsi_init(PCIDevice *pci_dev)
> +static void
> +pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
> {
>     PVSCSIState *s =3D PVSCSI(pci_dev);
>=20
> @@ -1144,8 +1144,6 @@ pvscsi_init(PCIDevice *pci_dev)
>     /* override default SCSI bus hotplug-handler, with pvscsi's one */
>     qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(s), &error_abort);
>     pvscsi_reset_state(s);
> -
> -    return 0;
> }
>=20
> static void
> @@ -1278,7 +1276,7 @@ static void pvscsi_class_init(ObjectClass =
*klass, void *data)
>     PVSCSIClass *pvs_k =3D PVSCSI_DEVICE_CLASS(klass);
>     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);
>=20
> -    k->init =3D pvscsi_init;
> +    k->realize =3D pvscsi_realizefn;
>     k->exit =3D pvscsi_uninit;
>     k->vendor_id =3D PCI_VENDOR_ID_VMWARE;
>     k->device_id =3D PCI_DEVICE_ID_VMWARE_PVSCSI;
> --=20
> 2.9.4
>=20
>=20
>=20
