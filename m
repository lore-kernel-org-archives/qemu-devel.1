Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80AAC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A735220872
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3Ghf34G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A735220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWxib-0001nm-QI
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 02:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iWxhk-0001Gj-3N
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iWxhh-0007on-D0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:13:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iWxhh-0007nK-2V
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574147615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KaGiH8UihxFjgVIQeqeO8XXji6MdpvnkI4WRvt3YLf8=;
 b=L3Ghf34GblAwjwxa2PX9+OoiLIE3PJjFqzCeiiYIJNanpKcWLeqof9MzEbFQG//xIuxOea
 G+vDU2ulyZ6p8krAs/QbG513JrDJuSb7rj6Tf0GwS45+TtUefUHrssCa/Sm0ArgdepnlQo
 MqSPuZ7+BBSrrMPsyP7J6Z8W1nQAYZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-XzxU3NXYMBueqra6AgFMNA-1; Tue, 19 Nov 2019 02:13:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DC3518B9FC1;
 Tue, 19 Nov 2019 07:13:32 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC26E6404A;
 Tue, 19 Nov 2019 07:13:27 +0000 (UTC)
Date: Tue, 19 Nov 2019 08:13:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] mem: move nvdimm_device_list to utilities
Message-ID: <20191119081326.275531af@redhat.com>
In-Reply-To: <157107825148.27733.10924648339824665145.stgit@lep8c.aus.stglabs.ibm.com>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107825148.27733.10924648339824665145.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XzxU3NXYMBueqra6AgFMNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 sbhat@linux.vnet.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 13:37:37 -0500
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> nvdimm_device_list is required for parsing the list for devices
> in subsequent patches. Move it to common utility area.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/acpi/nvdimm.c            |   28 +---------------------------
>  include/qemu/nvdimm-utils.h |    7 +++++++
>  util/Makefile.objs          |    1 +
>  util/nvdimm-utils.c         |   29 +++++++++++++++++++++++++++++
instead of creating new file, why not to move it to existing hw/mem/nvdimm.=
c?

>  4 files changed, 38 insertions(+), 27 deletions(-)
>  create mode 100644 include/qemu/nvdimm-utils.h
>  create mode 100644 util/nvdimm-utils.c
>=20
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 9fdad6dc3f..5219dd0e2e 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -32,33 +32,7 @@
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/mem/nvdimm.h"
> -
> -static int nvdimm_device_list(Object *obj, void *opaque)
> -{
> -    GSList **list =3D opaque;
> -
> -    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
> -        *list =3D g_slist_append(*list, DEVICE(obj));
> -    }
> -
> -    object_child_foreach(obj, nvdimm_device_list, opaque);
> -    return 0;
> -}
> -
> -/*
> - * inquire NVDIMM devices and link them into the list which is
> - * returned to the caller.
> - *
> - * Note: it is the caller's responsibility to free the list to avoid
> - * memory leak.
> - */
> -static GSList *nvdimm_get_device_list(void)
> -{
> -    GSList *list =3D NULL;
> -
> -    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
> -    return list;
> -}
> +#include "qemu/nvdimm-utils.h"
> =20
>  #define NVDIMM_UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)         =
    \
>     { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0x=
ff, \
> diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
> new file mode 100644
> index 0000000000..4b8b198ba7
> --- /dev/null
> +++ b/include/qemu/nvdimm-utils.h
> @@ -0,0 +1,7 @@
> +#ifndef NVDIMM_UTILS_H
> +#define NVDIMM_UTILS_H
> +
> +#include "qemu/osdep.h"
> +
> +GSList *nvdimm_get_device_list(void);
> +#endif
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 41bf59d127..a0f40d26e3 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -20,6 +20,7 @@ util-obj-y +=3D envlist.o path.o module.o
>  util-obj-y +=3D host-utils.o
>  util-obj-y +=3D bitmap.o bitops.o hbitmap.o
>  util-obj-y +=3D fifo8.o
> +util-obj-y +=3D nvdimm-utils.o
>  util-obj-y +=3D cacheinfo.o
>  util-obj-y +=3D error.o qemu-error.o
>  util-obj-y +=3D qemu-print.o
> diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
> new file mode 100644
> index 0000000000..5cc768ca47
> --- /dev/null
> +++ b/util/nvdimm-utils.c
> @@ -0,0 +1,29 @@
> +#include "qemu/nvdimm-utils.h"
> +#include "hw/mem/nvdimm.h"
> +
> +static int nvdimm_device_list(Object *obj, void *opaque)
> +{
> +    GSList **list =3D opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
> +        *list =3D g_slist_append(*list, DEVICE(obj));
> +    }
> +
> +    object_child_foreach(obj, nvdimm_device_list, opaque);
> +    return 0;
> +}
> +
> +/*
> + * inquire NVDIMM devices and link them into the list which is
> + * returned to the caller.
> + *
> + * Note: it is the caller's responsibility to free the list to avoid
> + * memory leak.
> + */
> +GSList *nvdimm_get_device_list(void)
> +{
> +    GSList *list =3D NULL;
> +
> +    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
> +    return list;
> +}
>=20
>=20


