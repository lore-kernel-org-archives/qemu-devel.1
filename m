Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB7C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35432075A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxOWAti6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35432075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdxj-0002pA-V1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVdx0-0002Dd-0f
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:28:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVdwy-00051Z-7Z
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588609690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQg95Xb8HRfUR/0S1jrh8PBCStCCg6pkceXCSP7bfcI=;
 b=FxOWAti6CaX3Lgy7QdLSsJwGS0Lxi/7CErkvTQSXQbUfiSd/9HaZXSm+XXo7sWdd0tYQuD
 ocRbQ4NLhhfAWA5AY716OzU1fFuTU2FdKKjxGxfm3v+VcruJ1kmwGc+BMJPe7Q92zdeisM
 qbKLOH9/1SvOF2xjEUqztRM6yydUxNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-wH1Bz6S0POuSYf6DHMD1sg-1; Mon, 04 May 2020 12:28:09 -0400
X-MC-Unique: wH1Bz6S0POuSYf6DHMD1sg-1
Received: by mail-wm1-f72.google.com with SMTP id 72so229037wmb.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 09:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u1NUL82EPz99lTpfYev3U8JxUh+sTrGeoGPzRGrO3Rg=;
 b=DP2r5wg43XRixFh8N13ccb94PnuoHZsv9rcMpMydfakweAbOb5445aVlXHFwRrL6iY
 hXOg840CyvaXpV8SVPYyDiWSHfqmAARCVTBMU3nnsGWakmOhsT2BhWz0nQNIAw1XN6QD
 2wEnsL5QQDuSJjKzCrgWpqqSrvN+Nth7gSc+mF5/8lHs1V7HAkNpABhJ4xb0IQcHV82l
 4WRVjpcgYIN4Q2332w/lGB755bU+WtnO6n/HV2QfgBUZJLI/IRpaj9iTBSc2nRa43rVJ
 L3roQ7YbU8HNyde9lKcmN04Q2dM8KPWN77PtCkpHRkPRhMH52rQO7AWV99OfUefs+QGT
 xkHQ==
X-Gm-Message-State: AGi0PuaxMetqNvTCKLjjvm/BgjDtUREIkVvGRWv94YVoTVpFgy+gYjUT
 C+ien3u+HnB9OEcQe60KiBSFh0fUjXVzOGbr1FF34MiOYWgjNJSMe/okDeSOowdv6m14x7W//+b
 DeyaNsmU1LxV4tFE=
X-Received: by 2002:adf:e2c2:: with SMTP id d2mr101891wrj.55.1588609687985;
 Mon, 04 May 2020 09:28:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypKDvcjMuuooaA4Az7vIsuzwHepEXZ3mJiurS3XCun1XAdyYDb22UQKbFvL6eXRcTY6qDGqFjQ==
X-Received: by 2002:adf:e2c2:: with SMTP id d2mr101861wrj.55.1588609687647;
 Mon, 04 May 2020 09:28:07 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id q8sm21016946wrp.58.2020.05.04.09.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 09:28:07 -0700 (PDT)
Subject: Re: [PATCH 15/17] qdev: Unrealize must not fail
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-16-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <19959f15-8f2a-7e23-4123-5dee9102250d@redhat.com>
Date: Mon, 4 May 2020 18:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-16-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 6:34 PM, Markus Armbruster wrote:
> Devices may have component devices and buses.
>=20
> Device realization may fail.  Realization is recursive: a device's
> realize() method realizes its components, and device_set_realized()
> realizes its buses (which should in turn realize the devices on that
> bus, except bus_set_realized() doesn't implement that, yet).
>=20
> When realization of a component or bus fails, we need to roll back:
> unrealize everything we realized so far.  If any of these unrealizes
> failed, the device would be left in an inconsistent state.  Must not
> happen.
>=20
> device_set_realized() lets it happen: it ignores errors in the roll
> back code starting at label child_realize_fail.
>=20
> Since realization is recursive, unrealization must be recursive, too.
> But how could a partly failed unrealize be rolled back?  We'd have to
> re-realize, which can fail.  This design is fundamentally broken.
>=20
> device_set_realized() does not roll back at all.  Instead, it keeps
> unrealizing, ignoring further errors.
>=20
> It can screw up even for a device with no buses: if the lone
> dc->unrealize() fails, it still unregisters vmstate, and calls
> listeners' unrealize() callback.
>=20
> bus_set_realized() does not roll back either.  Instead, it stops
> unrealizing.
>=20
> Fortunately, no unrealize method can fail, as we'll see below.
>=20
> To fix the design error, drop parameter @errp from all the unrealize
> methods.
>=20
> Any unrealize method that uses @errp now needs an update.  This leads
> us to unrealize() methods that can fail.  Merely passing it to another
> unrealize method cannot cause failure, though.  Here are the ones that
> do other things with @errp:
>=20
> * virtio_serial_device_unrealize()
>=20
>    Fails when qbus_set_hotplug_handler() fails, but still does all the
>    other work.  On failure, the device would stay realized with its
>    resources completely gone.  Oops.  Can't happen, because
>    qbus_set_hotplug_handler() can't actually fail here.  Pass
>    &error_abort to qbus_set_hotplug_handler() instead.
>=20
> * hw/ppc/spapr_drc.c's unrealize()
>=20
>    Fails when object_property_del() fails, but all the other work is
>    already done.  On failure, the device would stay realized with its
>    vmstate registration gone.  Oops.  Can't happen, because
>    object_property_del() can't actually fail here.  Pass &error_abort
>    to object_property_del() instead.
>=20
> * spapr_phb_unrealize()
>=20
>    Fails and bails out when remove_drcs() fails, but other work is
>    already done.  On failure, the device would stay realized with some
>    of its resources gone.  Oops.  remove_drcs() fails only when
>    chassis_from_bus()'s object_property_get_uint() fails, and it can't
>    here.  Pass &error_abort to remove_drcs() instead.
>=20
> Therefore, no unrealize method can fail before this patch.
>=20
> device_set_realized()'s recursive unrealization via bus uses
> object_property_set_bool().  Can't drop @errp there, so pass
> &error_abort.
>=20
> We similarly unrealize with object_property_set_bool() elsewhere,
> always ignoring errors.  Pass &error_abort instead.
>=20
> Several unrealize methods no longer handle errors from other unrealize
> methods: virtio_9p_device_unrealize(),
> virtio_input_device_unrealize(), scsi_qdev_unrealize(), ...
> Much of the deleted error handling looks wrong anyway.
>=20
> One unrealize methods no longer ignore such errors:
> usb_ehci_pci_exit().
>=20
> Several realize methods no longer ignore errors when rolling back:
> v9fs_device_realize_common(), pci_qdev_unrealize(),
> spapr_phb_realize(), usb_qdev_realize(), vfio_ccw_realize(),
> virtio_device_realize().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/9pfs/9p.h                    |  2 +-
>   hw/s390x/virtio-ccw.h           |  2 +-
>   hw/sd/sdhci-internal.h          |  2 +-
>   hw/usb/ccid.h                   |  2 +-
>   hw/usb/hcd-ehci.h               |  2 +-
>   include/hw/qdev-core.h          |  4 ++--
>   include/hw/s390x/s390-ccw.h     |  2 +-
>   include/hw/scsi/scsi.h          |  2 +-
>   include/hw/usb.h                |  2 +-
>   include/hw/xen/xen-block.h      |  2 +-
>   include/hw/xen/xen-bus.h        |  2 +-
>   hw/9pfs/9p.c                    |  4 ++--
>   hw/9pfs/virtio-9p-device.c      |  4 ++--
>   hw/acpi/pcihp.c                 |  2 +-
>   hw/audio/intel-hda.c            |  2 +-
>   hw/block/pflash_cfi02.c         |  2 +-
>   hw/block/vhost-user-blk.c       |  2 +-
>   hw/block/virtio-blk.c           |  2 +-
>   hw/block/xen-block.c            |  8 ++++----
>   hw/char/serial-pci-multi.c      |  2 +-
>   hw/char/serial-pci.c            |  2 +-
>   hw/char/serial.c                |  2 +-
>   hw/char/virtio-console.c        |  2 +-
>   hw/char/virtio-serial-bus.c     |  8 ++++----
>   hw/core/bus.c                   | 17 ++++-------------
>   hw/core/cpu.c                   |  2 +-
>   hw/core/generic-loader.c        |  2 +-
>   hw/core/qdev.c                  | 17 ++++++-----------
>   hw/display/virtio-gpu-base.c    |  2 +-
>   hw/dma/rc4030.c                 |  2 +-
>   hw/i386/kvm/apic.c              |  2 +-
>   hw/i386/pc.c                    |  4 ++--
>   hw/ide/qdev.c                   |  4 ++--
>   hw/input/virtio-input-hid.c     |  2 +-
>   hw/input/virtio-input-host.c    |  2 +-
>   hw/input/virtio-input.c         |  9 ++-------
>   hw/intc/apic.c                  |  2 +-
>   hw/intc/apic_common.c           |  4 ++--
>   hw/intc/ioapic.c                |  2 +-
>   hw/intc/xics.c                  |  2 +-
>   hw/ipack/ipack.c                |  6 ++----
>   hw/mem/pc-dimm.c                |  2 +-
>   hw/net/virtio-net.c             |  2 +-
>   hw/nvram/mac_nvram.c            |  2 +-
>   hw/pci/pci.c                    | 14 +++++++-------
>   hw/pci/pcie.c                   |  2 +-
>   hw/pci/shpc.c                   |  2 +-
>   hw/ppc/pnv_core.c               |  2 +-
>   hw/ppc/spapr.c                  |  8 ++++----
>   hw/ppc/spapr_cpu_core.c         |  2 +-
>   hw/ppc/spapr_drc.c              | 14 ++++----------
>   hw/ppc/spapr_iommu.c            |  2 +-
>   hw/ppc/spapr_pci.c              | 14 +++++---------
>   hw/ppc/spapr_tpm_proxy.c        |  2 +-
>   hw/s390x/css-bridge.c           |  2 +-
>   hw/s390x/s390-ccw.c             |  2 +-
>   hw/s390x/s390-pci-bus.c         |  4 ++--
>   hw/s390x/virtio-ccw.c           |  8 ++++----
>   hw/scsi/lsi53c895a.c            |  2 +-
>   hw/scsi/scsi-bus.c              | 13 ++++---------
>   hw/scsi/scsi-disk.c             |  2 +-
>   hw/scsi/vhost-scsi.c            |  2 +-
>   hw/scsi/vhost-user-scsi.c       |  2 +-
>   hw/scsi/virtio-scsi.c           |  2 +-
>   hw/sd/sdhci-pci.c               |  2 +-
>   hw/sd/sdhci.c                   |  6 +++---
>   hw/usb/bus.c                    | 12 ++++++------
>   hw/usb/ccid-card-emulated.c     |  2 +-
>   hw/usb/dev-audio.c              |  2 +-
>   hw/usb/dev-hid.c                |  2 +-
>   hw/usb/dev-hub.c                |  2 +-
>   hw/usb/dev-network.c            |  2 +-
>   hw/usb/dev-smartcard-reader.c   | 11 +++--------
>   hw/usb/dev-uas.c                |  2 +-
>   hw/usb/dev-wacom.c              |  2 +-
>   hw/usb/hcd-ehci-pci.c           |  2 +-
>   hw/usb/hcd-ehci.c               |  2 +-
>   hw/usb/host-libusb.c            |  2 +-
>   hw/usb/redirect.c               |  2 +-
>   hw/vfio/ap.c                    |  2 +-
>   hw/vfio/ccw.c                   |  6 +++---
>   hw/virtio/vhost-user-fs.c       |  2 +-
>   hw/virtio/vhost-vsock.c         |  2 +-
>   hw/virtio/virtio-balloon.c      |  2 +-
>   hw/virtio/virtio-crypto.c       |  2 +-
>   hw/virtio/virtio-iommu.c        |  2 +-
>   hw/virtio/virtio-pmem.c         |  2 +-
>   hw/virtio/virtio-rng.c          |  2 +-
>   hw/virtio/virtio.c              | 11 +++--------
>   hw/watchdog/wdt_diag288.c       |  2 +-
>   hw/xen/xen-bus.c                | 12 ++++++------
>   target/i386/cpu.c               |  9 ++-------
>   target/ppc/translate_init.inc.c |  9 ++-------
>   93 files changed, 158 insertions(+), 214 deletions(-)
[...]
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index b6c8ef5bc0..850fcce5e7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3622,7 +3622,7 @@ static void virtio_device_realize(DeviceState *dev,=
 Error **errp)
>       virtio_bus_device_plugged(vdev, &err);
>       if (err !=3D NULL) {
>           error_propagate(errp, err);
> -        vdc->unrealize(dev, NULL);
> +        vdc->unrealize(dev);

Not related to this patch, but I'm surprise we are not checking for=20
vdc->unrealize non-NULL here ...

>           return;
>       }
>  =20
> @@ -3630,20 +3630,15 @@ static void virtio_device_realize(DeviceState *de=
v, Error **errp)
>       memory_listener_register(&vdev->listener, vdev->dma_as);
>   }
>  =20
> -static void virtio_device_unrealize(DeviceState *dev, Error **errp)
> +static void virtio_device_unrealize(DeviceState *dev)
>   {
>       VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>       VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(dev);
> -    Error *err =3D NULL;
>  =20
>       virtio_bus_device_unplugged(vdev);
>  =20
>       if (vdc->unrealize !=3D NULL) {

... while here we do.

> -        vdc->unrealize(dev, &err);
> -        if (err !=3D NULL) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +        vdc->unrealize(dev);
>       }
>  =20
>       g_free(vdev->bus_name);
[...]

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


