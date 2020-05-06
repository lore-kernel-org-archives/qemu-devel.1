Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C46C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7A420663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4QEVZ4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7A420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWEUH-0000xF-Ji
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 03:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jWESl-00084g-Lj
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:27:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jWESk-0008Se-Jc
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588750045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yup8aFfbKD9EC7VvNVPh47SNwrdv4p7R9RDfRlfNcwQ=;
 b=N4QEVZ4+oMYyqzPwm7KPQ+QWjDyJ0X9KBDwy6msgX35RgtwKHbq5Nf+NYv7MCrsTXnaNEW
 HFzupSl/pe2aJ4rS52m5HeZWxt6n53TPDm1nUIUmlOxyhJpp4muhcFQhfK6bOGPVV/oItv
 STzMQxly4Bh9VlNmw/+VB+kXoqBBYSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-3dX6b833P5m5TMo13wXQaQ-1; Wed, 06 May 2020 03:27:23 -0400
X-MC-Unique: 3dX6b833P5m5TMo13wXQaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2781C80058A;
 Wed,  6 May 2020 07:27:22 +0000 (UTC)
Received: from localhost (ovpn-113-195.rdu2.redhat.com [10.10.113.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D81525262;
 Wed,  6 May 2020 07:27:16 +0000 (UTC)
Date: Wed, 6 May 2020 09:27:15 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 11/13] microvm: add acpi_dsdt_add_virtio() for x86
Message-ID: <20200506072715.woe4buwgrtdc7r6h@dritchie>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-12-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200505134305.22666-12-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="77z5roahyohp27uu"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--77z5roahyohp27uu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 03:43:03PM +0200, Gerd Hoffmann wrote:
> Makes x86 linux kernel find virtio-mmio devices automatically.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/acpi-microvm.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Reviewed-by: Sergio Lopez <slp@redhat.com>

> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index ce5ab86d642c..4d91ac9360ce 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -21,6 +21,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
> =20
>  #include "exec/memory.h"
> @@ -32,6 +33,7 @@
>  #include "hw/boards.h"
>  #include "hw/i386/fw_cfg.h"
>  #include "hw/i386/microvm.h"
> +#include "hw/virtio/virtio-mmio.h"
> =20
>  #include "acpi-common.h"
>  #include "acpi-microvm.h"
> @@ -45,6 +47,54 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>      aml_append(scope, dev);
>  }
> =20
> +static void acpi_dsdt_add_virtio(Aml *scope)
> +{
> +    gchar *separator;
> +    long int index;
> +    BusState *bus;
> +    BusChild *kid;
> +
> +    bus =3D sysbus_get_default();
> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +        DeviceState *dev =3D kid->child;
> +        Object *obj =3D object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMI=
O);
> +
> +        if (obj) {
> +            VirtIOMMIOProxy *mmio =3D VIRTIO_MMIO(obj);
> +            VirtioBusState *mmio_virtio_bus =3D &mmio->bus;
> +            BusState *mmio_bus =3D &mmio_virtio_bus->parent_obj;
> +
> +            if (QTAILQ_EMPTY(&mmio_bus->children)) {
> +                continue;
> +            }
> +            separator =3D g_strrstr(mmio_bus->name, ".");
> +            if (!separator) {
> +                continue;
> +            }
> +            if (qemu_strtol(separator + 1, NULL, 10, &index) !=3D 0) {
> +                continue;
> +            }
> +
> +            uint32_t irq =3D VIRTIO_IRQ_BASE + index;
> +            hwaddr base =3D VIRTIO_MMIO_BASE + index * 512;
> +            hwaddr size =3D 512;
> +
> +            Aml *dev =3D aml_device("VR%02u", (unsigned)index);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")=
));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
> +            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +
> +            Aml *crs =3D aml_resource_template();
> +            aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRIT=
E));
> +            aml_append(crs,
> +                       aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE=
_HIGH,
> +                                     AML_EXCLUSIVE, &irq, 1));
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(scope, dev);
> +        }
> +    }
> +}
> +
>  static void
>  build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
>                     MicrovmMachineState *mms)
> @@ -69,6 +119,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *lin=
ker,
>      build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
>                    GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
>      acpi_dsdt_add_power_button(sb_scope);
> +    acpi_dsdt_add_virtio(sb_scope);
>      aml_append(dsdt, sb_scope);
> =20
>      scope =3D aml_scope("\\");
> --=20
> 2.18.4
>=20

--77z5roahyohp27uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl6yZtIACgkQ9GknjS8M
AjXI1Q//SeCiuLEqQc88h8fWbWbSEy37/zpz4Ynnj42NCdkdiCWzao3lKN2jTyF/
+QPGrFix/WDx3xBwryeD8G85h+QhnPSPFVid06lw/Nhd2ULhnYcgJmCG3ZDQz9Bk
+WYGWMPYDpVzdGZ6iAcoApgqY0iJBUjH5XN6C3kQjEpw8XzUitDi0f4Ogp7or49c
mE4L0i98AspKCgVGB/KsYZdYjHkcPZGP+edtpHJH7JMPKCG6KgBGva/ms1S7CzdC
ylUmFf7ub12o8QMfCNfVtGT6esOI7yeO+yz5qbeZPM3Zsv91MdM+CyXx7QUXTIFP
3RdVRG8vUD0j8YAPLO115DsA/ASyyyy/y8JtsWviZFVpFNCVZD1v/yfKwtK0oU4i
EKecgSKuIXica9+T2LQtQzvQjHznOZzenlOtvWChBJHEAp47+4Tx1JQSjZybcHK8
8mqAJ1FZh8Fqua/9S/wPfTCjAOWBsFICuUhjF60VF6LVQFFduC7f1drYAAeuCjVj
Ge05cbMS7v0WAoBv1qjtT2xK2hYCvaXZUwRt4gzzveS4hJxJNCWs0bgn1TB77to1
UmkgaIW7JdAtjx26TiG9+alh3JMkrpsR915c+sj3HQttjqS3pq11/ZD1K0dyE1ti
jk8MqOSGQuejr2/0gGxA32HE5dn5R/nX0D/B9Jono1nLywC5duI=
=Tkub
-----END PGP SIGNATURE-----

--77z5roahyohp27uu--


