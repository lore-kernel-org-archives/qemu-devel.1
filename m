Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A3C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 19:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1AB20848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 19:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1AB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52615 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRi86-0000g5-FG
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 15:02:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hRi71-0008RR-Sj
	for qemu-devel@nongnu.org; Fri, 17 May 2019 15:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hRi70-00077d-FE
	for qemu-devel@nongnu.org; Fri, 17 May 2019 15:01:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hRi6z-00075h-MB
	for qemu-devel@nongnu.org; Fri, 17 May 2019 15:01:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6595936883;
	Fri, 17 May 2019 19:01:37 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94947413C;
	Fri, 17 May 2019 19:01:31 +0000 (UTC)
Date: Fri, 17 May 2019 16:01:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190517190129.GA17245@habkost.net>
References: <20190215103239.28640-1-berrange@redhat.com>
	<20190215103239.28640-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190215103239.28640-2-berrange@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 17 May 2019 19:01:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw: report invalid
 disable-legacy|modern usage for virtio-1-only devs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Sorry for taking so long to look at this more closely:

On Fri, Feb 15, 2019 at 10:32:38AM +0000, Daniel P. Berrang=E9 wrote:
> A number of virtio devices (gpu, crypto, mouse, keyboard, tablet) only
> support the virtio-1 (aka modern) mode. Currently if the user launches
> QEMU, setting those devices to enable legacy mode, QEMU will silently
> create them in modern mode, ignoring the user's (mistaken) request.
>=20
> This patch introduces proper data validation so that an attempt to
> configure a virtio-1-only devices in legacy mode gets reported as an
> error to the user.
>=20
> Checking this required introduction of a new field to explicitly track
> what operating model is to be used for a device, separately from the
> disable_modern and disable_legacy fields that record the user's
> requested configuration.

I'm still trying to understand why we need to add a new field.

If disable_modern, disable_legacy and mode are always expected to
be consistent with each other, why do we need another field?

If they are not always consistent with each other, when exactly
do we want them to be inconsistent, and why?

>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
[...]
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index bd223a6e3b..16ef4c0a3f 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -15,6 +15,7 @@
>  #ifndef QEMU_VIRTIO_PCI_H
>  #define QEMU_VIRTIO_PCI_H
> =20
> +#include "qapi/error.h"
>  #include "hw/pci/msi.h"
>  #include "hw/virtio/virtio-bus.h"
> =20
> @@ -118,6 +119,12 @@ typedef struct VirtIOPCIQueue {
>    uint32_t used[2];
>  } VirtIOPCIQueue;
> =20
> +typedef enum {
> +    VIRTIO_PCI_MODE_LEGACY,
> +    VIRTIO_PCI_MODE_TRANSITIONAL,
> +    VIRTIO_PCI_MODE_MODERN,
> +} VirtIOPCIMode;
> +
>  struct VirtIOPCIProxy {
>      PCIDevice pci_dev;
>      MemoryRegion bar;
> @@ -142,6 +149,7 @@ struct VirtIOPCIProxy {
>      bool disable_modern;
>      bool ignore_backend_features;
>      OnOffAuto disable_legacy;
> +    VirtIOPCIMode mode;
>      uint32_t class_code;
>      uint32_t nvectors;
>      uint32_t dfselect;
> @@ -156,23 +164,34 @@ struct VirtIOPCIProxy {
> =20
>  static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
>  {
> -    return !proxy->disable_modern;
> +    return proxy->mode !=3D VIRTIO_PCI_MODE_LEGACY;
>  }
> =20
>  static inline bool virtio_pci_legacy(VirtIOPCIProxy *proxy)
>  {
> -    return proxy->disable_legacy =3D=3D ON_OFF_AUTO_OFF;
> +    return proxy->mode !=3D VIRTIO_PCI_MODE_MODERN;
>  }
> =20
> -static inline void virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy)
> +static inline bool virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy,
> +                                             Error **errp)
>  {
> -    proxy->disable_modern =3D false;
> -    proxy->disable_legacy =3D ON_OFF_AUTO_ON;
> +    if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_OFF) {
> +        error_setg(errp, "Unable to set disable-legacy=3Doff on a virt=
io-1.0 "
> +                   "only device");
> +        return false;
> +    }
> +    if (proxy->disable_modern =3D=3D true) {
> +        error_setg(errp, "Unable to set disable-modern=3Don on a virti=
o-1.0 "
> +                   "only device");
> +        return false;
> +    }
> +    proxy->mode =3D VIRTIO_PCI_MODE_MODERN;
> +    return true;
>  }
> =20
>  static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
>  {
> -    proxy->disable_modern =3D true;
> +    proxy->mode =3D VIRTIO_PCI_MODE_LEGACY;
>  }
> =20
>  /*
> --=20
> 2.20.1
>=20
>=20

--=20
Eduardo

