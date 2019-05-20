Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC92C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D982C206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D982C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSf2g-0007T1-5G
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 05:57:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hSf1u-0007B5-8p
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hSf1s-0003Ss-TA
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:56:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hSf1s-0003SU-LL
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:56:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D72B1C05D275;
	Mon, 20 May 2019 09:56:21 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F85F60BEC;
	Mon, 20 May 2019 09:56:14 +0000 (UTC)
Date: Mon, 20 May 2019 10:56:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190520095611.GD21976@redhat.com>
References: <20190215103239.28640-1-berrange@redhat.com>
	<20190215103239.28640-2-berrange@redhat.com>
	<20190517190129.GA17245@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517190129.GA17245@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 20 May 2019 09:56:22 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 04:01:29PM -0300, Eduardo Habkost wrote:
> Hi,
>=20
> Sorry for taking so long to look at this more closely:
>=20
> On Fri, Feb 15, 2019 at 10:32:38AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > A number of virtio devices (gpu, crypto, mouse, keyboard, tablet) onl=
y
> > support the virtio-1 (aka modern) mode. Currently if the user launche=
s
> > QEMU, setting those devices to enable legacy mode, QEMU will silently
> > create them in modern mode, ignoring the user's (mistaken) request.
> >=20
> > This patch introduces proper data validation so that an attempt to
> > configure a virtio-1-only devices in legacy mode gets reported as an
> > error to the user.
> >=20
> > Checking this required introduction of a new field to explicitly trac=
k
> > what operating model is to be used for a device, separately from the
> > disable_modern and disable_legacy fields that record the user's
> > requested configuration.
>=20
> I'm still trying to understand why we need to add a new field.
>=20
> If disable_modern, disable_legacy and mode are always expected to
> be consistent with each other, why do we need another field?
>=20
> If they are not always consistent with each other, when exactly
> do we want them to be inconsistent, and why?

The pain point is that we're using the existing variables to record
two distinct pieces of information

 - The user's request for modern vs legacy
 - The PCI bus requirements for modern vs legacy

The existing code would overwrite the user's setting for
"disable_legacy" when deciding whether the device is in
a PCI or PCIe port. This happens in virtio_pci_realize.

We can only report errors with the user's requested config
after the sub-classes call virtio_pci_force_virtio_1, but
this doesn't happen until virtio_${subclass}_pci_release.

So by the time we're able to report errors, virtio_pci_realize
has already overwritten the user's disable_legacy setting, so
we've lost the very piece of info we need to check to report
errors with.

Given the ordering of virtio_pci_realize vs the calls
to virtio_pci_force_virtio_1 by subclasses, I don't see any
option other than to use separate variables for the two
distinct pieces of information.

>=20
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> [...]
> > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > index bd223a6e3b..16ef4c0a3f 100644
> > --- a/hw/virtio/virtio-pci.h
> > +++ b/hw/virtio/virtio-pci.h
> > @@ -15,6 +15,7 @@
> >  #ifndef QEMU_VIRTIO_PCI_H
> >  #define QEMU_VIRTIO_PCI_H
> > =20
> > +#include "qapi/error.h"
> >  #include "hw/pci/msi.h"
> >  #include "hw/virtio/virtio-bus.h"
> > =20
> > @@ -118,6 +119,12 @@ typedef struct VirtIOPCIQueue {
> >    uint32_t used[2];
> >  } VirtIOPCIQueue;
> > =20
> > +typedef enum {
> > +    VIRTIO_PCI_MODE_LEGACY,
> > +    VIRTIO_PCI_MODE_TRANSITIONAL,
> > +    VIRTIO_PCI_MODE_MODERN,
> > +} VirtIOPCIMode;
> > +
> >  struct VirtIOPCIProxy {
> >      PCIDevice pci_dev;
> >      MemoryRegion bar;
> > @@ -142,6 +149,7 @@ struct VirtIOPCIProxy {
> >      bool disable_modern;
> >      bool ignore_backend_features;
> >      OnOffAuto disable_legacy;
> > +    VirtIOPCIMode mode;
> >      uint32_t class_code;
> >      uint32_t nvectors;
> >      uint32_t dfselect;
> > @@ -156,23 +164,34 @@ struct VirtIOPCIProxy {
> > =20
> >  static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
> >  {
> > -    return !proxy->disable_modern;
> > +    return proxy->mode !=3D VIRTIO_PCI_MODE_LEGACY;
> >  }
> > =20
> >  static inline bool virtio_pci_legacy(VirtIOPCIProxy *proxy)
> >  {
> > -    return proxy->disable_legacy =3D=3D ON_OFF_AUTO_OFF;
> > +    return proxy->mode !=3D VIRTIO_PCI_MODE_MODERN;
> >  }
> > =20
> > -static inline void virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy)
> > +static inline bool virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy,
> > +                                             Error **errp)
> >  {
> > -    proxy->disable_modern =3D false;
> > -    proxy->disable_legacy =3D ON_OFF_AUTO_ON;
> > +    if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_OFF) {
> > +        error_setg(errp, "Unable to set disable-legacy=3Doff on a vi=
rtio-1.0 "
> > +                   "only device");
> > +        return false;
> > +    }
> > +    if (proxy->disable_modern =3D=3D true) {
> > +        error_setg(errp, "Unable to set disable-modern=3Don on a vir=
tio-1.0 "
> > +                   "only device");
> > +        return false;
> > +    }
> > +    proxy->mode =3D VIRTIO_PCI_MODE_MODERN;
> > +    return true;
> >  }
> > =20
> >  static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
> >  {
> > -    proxy->disable_modern =3D true;
> > +    proxy->mode =3D VIRTIO_PCI_MODE_LEGACY;
> >  }
> > =20
> >  /*
> > --=20
> > 2.20.1
> >=20
> >=20
>=20
> --=20
> Eduardo
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

