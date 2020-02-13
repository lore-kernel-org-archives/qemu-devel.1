Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0E3C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA05D2168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f91rJqt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA05D2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EvU-0006lf-6v
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j2EuU-0006Dg-5e
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j2EuS-0002dr-PT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:52:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j2EuS-0002dJ-LZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581601922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bdlxpebOLDXwDCiTdWFGG+Pcudohv2k1GHzwI5d88I=;
 b=f91rJqt0QupB/vuwEVWrb22RafD6uCD9ynJcUA4rF334h7mZbiV5FS178hDP28ucXNI948
 DU1+SnTrYKQv6jf+4lG7ZG2k2xr3f5g1BzMjUQ7y9SJopBZNDZg2Jacr16Sx5FuFXwcmgP
 VhaFCYHSOT+QTyKFW7lG1KCGDe3kV/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-RKlJvaIFNCetrWs0X-GmNQ-1; Thu, 13 Feb 2020 08:51:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8B748017DF;
 Thu, 13 Feb 2020 13:51:52 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22F7A5C1D6;
 Thu, 13 Feb 2020 13:51:47 +0000 (UTC)
Date: Thu, 13 Feb 2020 13:51:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Message-ID: <20200213135145.GN594756@redhat.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-3-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200213074952.544-3-miaoyubo@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: RKlJvaIFNCetrWs0X-GmNQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 03:49:52PM +0800, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
>=20
> Since devices could not directly plugged into pxb-pcie, under arm, one
> pcie-root port is plugged into pxb-pcie. Due to the bus for each pxb-pcie
> is defined as 2 in acpi dsdt tables(one for pxb-pcie, one for pcie-root-p=
ort),
> only one device could be plugged into one pxb-pcie.

What is the cause of this arm specific requirement for pxb-pcie and
more importantly can be fix it so that we don't need this patch ?
I think it is highly undesirable to have such a per-arch difference
in configuration of the pxb-pcie device. It means any mgmt app
which already supports pxb-pcie will be broken and need to special
case arm.

>=20
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 9 +++++++++
>  include/hw/pci/pcie_port.h          | 1 +
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
> index 47aaaf8fd1..3d896dd452 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -15,6 +15,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_host.h"
> +#include "hw/pci/pcie_port.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "qemu/range.h"
> @@ -233,7 +234,15 @@ static void pxb_dev_realize_common(PCIDevice *dev, b=
ool pcie, Error **errp)
> =20
>      ds =3D qdev_create(NULL, TYPE_PXB_HOST);
>      if (pcie) {
> +#ifdef __aarch64__
> +        bus =3D pci_root_bus_new(ds, "pxb-pcie-internal",
> +                               NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
> +        bds =3D qdev_create(BUS(bus), "pcie-root-port");
> +        bds->id =3D dev_name;
> +        qdev_prop_set_uint8(bds, PCIE_ROOT_PORT_PROP_CHASSIS, pxb->bus_n=
r);
> +#else
>          bus =3D pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_P=
CIE_BUS);
> +#endif
>      } else {
>          bus =3D pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE=
_PXB_BUS);
>          bds =3D qdev_create(BUS(bus), "pci-bridge");
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index 4b3d254b08..b41d473220 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -64,6 +64,7 @@ int pcie_chassis_add_slot(struct PCIESlot *slot);
>  void pcie_chassis_del_slot(PCIESlot *s);
> =20
>  #define TYPE_PCIE_ROOT_PORT         "pcie-root-port-base"
> +#define PCIE_ROOT_PORT_PROP_CHASSIS "chassis"
>  #define PCIE_ROOT_PORT_CLASS(klass) \
>       OBJECT_CLASS_CHECK(PCIERootPortClass, (klass), TYPE_PCIE_ROOT_PORT)
>  #define PCIE_ROOT_PORT_GET_CLASS(obj) \
> --=20
> 2.19.1
>=20
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


