Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2238AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 19:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD5E2071C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASOmHRo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD5E2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYEFO-0000G9-3P
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 14:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iYEDz-0007o4-Hs
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 14:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iYEDw-0002Qh-Sm
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 14:04:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46058
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iYEDt-0002Ph-Lj
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 14:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574449444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZtDMnAaJ6tfi/HjI8JF5OOd9hEr549YpG3sEbuiL5g=;
 b=ASOmHRo7q6uvbjtpINXJ0SfgJRuzk2qveWYSDpevNViAWNGS5ZQH5krt9upwGbIkoHgWUw
 a2lDodvNu91uSILalsNN9Np00glu77vI0orPzHozogvrlCzq4d0LJNeg6LOjwEoW51wCYg
 I+R6n06H0MWTv3FkbhOsrrUoqNzBlX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-euji1tPHNV6dIL6t26KjeQ-1; Fri, 22 Nov 2019 14:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20C3F107ACC5;
 Fri, 22 Nov 2019 19:04:01 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76FAB5890;
 Fri, 22 Nov 2019 19:03:45 +0000 (UTC)
Date: Fri, 22 Nov 2019 19:03:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 12/20] qapi: Introduce DEFINE_PROP_INTERVAL
Message-ID: <20191122190343.GP2785@work-vm>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-13-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-13-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: euji1tPHNV6dIL6t26KjeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Auger (eric.auger@redhat.com) wrote:
> Introduce a new property defining a labelled interval:
> <low address>,<high address>,label.
>=20
> This will be used to encode reserved IOVA regions. The label
> is left undefined to ease reuse accross use cases.
>=20
> For instance, in virtio-iommu use case, reserved IOVA regions
> will be passed by the machine code to the virtio-iommu-pci
> device (an array of those). The label will match the
> virtio_iommu_probe_resv_mem subtype value:
> - VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)
> - VIRTIO_IOMMU_RESV_MEM_T_MSI (1)
>=20
> This is used to inform the virtio-iommu-pci device it should
> bypass the MSI region: 0xfee00000, 0xfeefffff, 1.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/core/qdev-properties.c    | 90 ++++++++++++++++++++++++++++++++++++
>  include/exec/memory.h        |  6 +++
>  include/hw/qdev-properties.h |  3 ++
>  include/qemu/typedefs.h      |  1 +
>  4 files changed, 100 insertions(+)
>=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index ac28890e5a..8d70f34e37 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -13,6 +13,7 @@
>  #include "qapi/visitor.h"
>  #include "chardev/char.h"
>  #include "qemu/uuid.h"
> +#include "qemu/cutils.h"
> =20
>  void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                    Error **errp)
> @@ -585,6 +586,95 @@ const PropertyInfo qdev_prop_macaddr =3D {
>      .set   =3D set_mac,
>  };
> =20
> +/* --- Labelled Interval --- */
> +
> +/*
> + * accepted syntax versions:
> + *   <low address>,<high address>,<type>
> + *   where low/high addresses are uint64_t in hexa (feat. 0x prefix)
> + *   and type is an unsigned integer
> + */
> +static void get_interval(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    Interval *interval =3D qdev_get_prop_ptr(dev, prop);
> +    char buffer[64];
> +    char *p =3D buffer;
> +
> +    snprintf(buffer, sizeof(buffer), "0x%"PRIx64",0x%"PRIx64",%d",
> +             interval->low, interval->high, interval->type);
> +
> +    visit_type_str(v, name, &p, errp);
> +}
> +
> +static void set_interval(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    Interval *interval =3D qdev_get_prop_ptr(dev, prop);
> +    Error *local_err =3D NULL;
> +    unsigned int type;
> +    gchar **fields;
> +    uint64_t addr;
> +    char *str;
> +    int ret;
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_str(v, name, &str, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    fields =3D g_strsplit(str, ",", 3);
> +
> +    ret =3D qemu_strtou64(fields[0], NULL, 16, &addr);
> +    if (!ret) {
> +        interval->low =3D addr;
> +    } else {
> +        error_setg(errp, "Failed to decode interval low addr");
> +        error_append_hint(errp,
> +                          "should be an address in hexa with 0x prefix\n=
");
> +        goto out;
> +    }
> +
> +    ret =3D qemu_strtou64(fields[1], NULL, 16, &addr);
> +    if (!ret) {
> +        interval->high =3D addr;
> +    } else {
> +        error_setg(errp, "Failed to decode interval high addr");
> +        error_append_hint(errp,
> +                          "should be an address in hexa with 0x prefix\n=
");
> +        goto out;
> +    }
> +
> +    ret =3D qemu_strtoui(fields[2], NULL, 10, &type);
> +    if (!ret) {
> +        interval->type =3D type;
> +    } else {
> +        error_setg(errp, "Failed to decode interval type");
> +        error_append_hint(errp, "should be an unsigned int in decimal\n"=
);
> +    }
> +out:
> +    g_free(str);
> +    g_strfreev(fields);
> +    return;
> +}
> +
> +const PropertyInfo qdev_prop_interval =3D {
> +    .name  =3D "labelled_interval",
> +    .description =3D "Labelled interval, example: 0xFEE00000,0xFEEFFFFF,=
0",
> +    .get   =3D get_interval,
> +    .set   =3D set_interval,
> +};
> +
>  /* --- on/off/auto --- */
> =20
>  const PropertyInfo qdev_prop_on_off_auto =3D {
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e499dc215b..e238d1c352 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -57,6 +57,12 @@ struct MemoryRegionMmio {
>      CPUWriteMemoryFunc *write[3];
>  };
> =20
> +struct Interval {
> +    hwaddr low;
> +    hwaddr high;
> +    unsigned int type;
> +};
> +

Just an observation that 'Interval' is a very generic name.
We've got 'AddrRange' but that's Int128.

Dave

>  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
> =20
>  /* See address_space_translate: bit 0 is read, bit 1 is write.  */
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index c6a8cb5516..2ba7c8711b 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -20,6 +20,7 @@ extern const PropertyInfo qdev_prop_chr;
>  extern const PropertyInfo qdev_prop_tpm;
>  extern const PropertyInfo qdev_prop_ptr;
>  extern const PropertyInfo qdev_prop_macaddr;
> +extern const PropertyInfo qdev_prop_interval;
>  extern const PropertyInfo qdev_prop_on_off_auto;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
>  extern const PropertyInfo qdev_prop_blockdev_on_error;
> @@ -202,6 +203,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>      DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
>  #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
> +#define DEFINE_PROP_INTERVAL(_n, _s, _f)         \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_interval, Interval)
>  #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
>  #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 375770a80f..a827c9a3fe 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -58,6 +58,7 @@ typedef struct ISABus ISABus;
>  typedef struct ISADevice ISADevice;
>  typedef struct IsaDma IsaDma;
>  typedef struct MACAddr MACAddr;
> +typedef struct Interval Interval;
>  typedef struct MachineClass MachineClass;
>  typedef struct MachineState MachineState;
>  typedef struct MemoryListener MemoryListener;
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


