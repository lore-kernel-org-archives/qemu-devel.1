Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8CFC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2499621783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDATR3LI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2499621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAyn-0003PA-4i
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iUAxo-0002tG-VB
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iUAxn-0001ER-Dt
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:46:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iUAxn-0001Dp-AG
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573483602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZydry80oyQXH8KpJ6MxrynCvNld+ei+1kOrA0VeTJo=;
 b=LDATR3LIzci3NHeXRmOfx38Z/QXunMHdmWa5KlFl1RI9AocCGImPaCOOjiKYcZY7FNCfSh
 QpeLh6wm22guPmD4ESjKsYPbzy8wSzglfmf6sDVTtI4MM7PktZLGjTkJjkcaXuGV4H/U1S
 v8b/2o7GINZDUjCK+RfqigznN1LDZDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-pcuDuBSgNvGijyqUsKvevw-1; Mon, 11 Nov 2019 09:46:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD768017E0;
 Mon, 11 Nov 2019 14:46:38 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E47D17196;
 Mon, 11 Nov 2019 14:46:29 +0000 (UTC)
Date: Mon, 11 Nov 2019 15:46:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 4/5] hw/arm/boot: Expose the pmem nodes in the DT
Message-ID: <20191111154627.63fc061b@redhat.com>
In-Reply-To: <20191004155302.4632-5-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <20191004155302.4632-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: pcuDuBSgNvGijyqUsKvevw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 16:53:01 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
>=20
> In case of NV-DIMM slots, let's add /pmem DT nodes
Why should we do it for NVDIMM but not for PC-DIMM?

>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/boot.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index c264864c11..bd6d72b33e 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -20,6 +20,7 @@
>  #include "hw/boards.h"
>  #include "sysemu/reset.h"
>  #include "hw/loader.h"
> +#include "hw/mem/memory-device.h"
>  #include "elf.h"
>  #include "sysemu/device_tree.h"
>  #include "qemu/config-file.h"
> @@ -523,6 +524,44 @@ static void fdt_add_psci_node(void *fdt)
>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
>  }
> =20
> +static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t scells=
)
> +{
> +    MemoryDeviceInfoList *info, *info_list =3D qmp_memory_device_list();
> +    MemoryDeviceInfo *mi;
> +    int ret;
> +
> +    for (info =3D info_list; info !=3D NULL; info =3D info->next) {
> +        mi =3D info->value;
> +
> +        if (mi->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM) {
> +            PCDIMMDeviceInfo *di =3D mi->u.nvdimm.data;
> +            char *nodename;
> +
> +            nodename =3D g_strdup_printf("/pmem@%" PRIx64, di->addr);
> +            qemu_fdt_add_subnode(fdt, nodename);
> +            qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-r=
egion");
> +            ret =3D qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", a=
cells,
> +                                               di->addr, scells, di->siz=
e);
> +            /* only set the NUMA ID if it is specified */
> +            if (!ret && di->node >=3D 0) {
> +                ret =3D qemu_fdt_setprop_cell(fdt, nodename, "numa-node-=
id",
> +                                            di->node);
> +            }
> +
> +            g_free(nodename);
> +
> +            if (ret < 0) {
> +                fprintf(stderr, "couldn't add NVDIMM /memory@%"PRIx64" n=
ode\n",
shouldn't it be s:/memory:/pmem:

and maybe move error printing outside like it's done in fdt_add_memory_node=
()
to be consistent with current code.

> +                        di->addr);
> +                goto out;
> +            }
> +        }
> +    }
> +out:
> +    qapi_free_MemoryDeviceInfoList(info_list);
> +    return ret;
> +}
> +
>  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>                   hwaddr addr_limit, AddressSpace *as, MachineState *ms)
>  {
> @@ -622,6 +661,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
>          }
>      }
> =20
> +    rc =3D fdt_add_pmem_node(fdt, acells, scells);
> +    if (rc < 0) {
> +        fprintf(stderr, "couldn't add pmem memory nodes\n");
> +        goto fail;
> +    }
> +
>      rc =3D fdt_path_offset(fdt, "/chosen");
>      if (rc < 0) {
>          qemu_fdt_add_subnode(fdt, "/chosen");


