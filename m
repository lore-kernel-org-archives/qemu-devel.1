Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3A2C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F63E22311
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkq+u1dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F63E22311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMwr-0001fc-Dw
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iXMvt-000192-44
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iXMvq-0002SJ-BN
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:09:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iXMvq-0002Pu-7I
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574244592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mtn7tBdlPUYqNOBcP+SG27VFhWIvdk0RvbVJWkD9Zqc=;
 b=gkq+u1dAuxljxlA01PHDsmhr+e9kX++ckqMWRg+yl8SXt8XKMHZKZIveNn+nR1ZltfbDEN
 Fb6fXXiGCQvBpVi8SkBYiQgus12CtMiaZwDuX6Dj2Eai40znlTUTz9oH7enhxZ6gaRjaMq
 LzsZrSnoBfdCFqdoVhrGNY5mqJR61lM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-LjuLkPESPXKGno2Ig5S_2g-1; Wed, 20 Nov 2019 05:09:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD7051005510;
 Wed, 20 Nov 2019 10:09:46 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC6B13AB8;
 Wed, 20 Nov 2019 10:09:41 +0000 (UTC)
Date: Wed, 20 Nov 2019 11:09:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v16 11/14] hmat acpi: Build System Locality Latency and
 Bandwidth Information Structure(s)
Message-ID: <20191120110939.7c60b184@redhat.com>
In-Reply-To: <20191115075352.17734-12-tao3.xu@intel.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-12-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LjuLkPESPXKGno2Ig5S_2g-1
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 15:53:49 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
>=20
> This structure describes the memory access latency and bandwidth
> information from various memory access initiator proximity domains.
> The latency and bandwidth numbers represented in this structure
> correspond to rated latency and bandwidth for the platform.
> The software could use this information as hint for optimization.
>=20
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v16:
>     - Add more description for lb_length (Igor)
>     - Drop entry_list and calculate entries in this patch (Igor)
>=20
> Changes in v13:
>     - Calculate the entries in a new patch.
> ---
>  hw/acpi/hmat.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 104 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index 9ff79308a4..ed19ebed2f 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -25,8 +25,10 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "sysemu/numa.h"
>  #include "hw/acpi/hmat.h"
> +#include "qemu/error-report.h"

do you really need this header in this patch?


modulo above nit, patch looks good so
with above fixed (if necessary)

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> =20
>  /*
>   * ACPI 6.3:
> @@ -67,11 +69,89 @@ static void build_hmat_mpda(GArray *table_data, uint1=
6_t flags,
>      build_append_int_noprefix(table_data, 0, 8);
>  }
> =20
> +/*
> + * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
> + * Structure: Table 5-146
> + */
> +static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
> +                          uint32_t num_initiator, uint32_t num_target,
> +                          uint32_t *initiator_list)
> +{
> +    int i, index;
> +    HMAT_LB_Data *lb_data;
> +    uint16_t *entry_list;
> +    uint32_t base;
> +    /* Length in bytes for entire structure */
> +    uint32_t lb_length
> +        =3D 32 /* Table length upto and including Entry Base Unit */
> +        + 4 * num_initiator /* Initiator Proximity Domain List */
> +        + 4 * num_target /* Target Proximity Domain List */
> +        + 2 * num_initiator * num_target; /* Latency or Bandwidth Entrie=
s */
> +
> +    /* Type */
> +    build_append_int_noprefix(table_data, 1, 2);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Length */
> +    build_append_int_noprefix(table_data, lb_length, 4);
> +    /* Flags: Bits [3:0] Memory Hierarchy, Bits[7:4] Reserved */
> +    assert(!(hmat_lb->hierarchy >> 4));
> +    build_append_int_noprefix(table_data, hmat_lb->hierarchy, 1);
> +    /* Data Type */
> +    build_append_int_noprefix(table_data, hmat_lb->data_type, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Number of Initiator Proximity Domains (s) */
> +    build_append_int_noprefix(table_data, num_initiator, 4);
> +    /* Number of Target Proximity Domains (t) */
> +    build_append_int_noprefix(table_data, num_target, 4);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +
> +    /* Entry Base Unit */
> +    if (hmat_lb->data_type <=3D HMAT_LB_DATA_WRITE_LATENCY) {
> +        /* Convert latency base from nanoseconds to picosecond */
> +        base =3D hmat_lb->base * 1000;
> +    } else {
> +        /* Convert bandwidth base from Byte to Megabyte */
> +        base =3D hmat_lb->base / MiB;
> +    }
> +    build_append_int_noprefix(table_data, base, 8);
> +
> +    /* Initiator Proximity Domain List */
> +    for (i =3D 0; i < num_initiator; i++) {
> +        build_append_int_noprefix(table_data, initiator_list[i], 4);
> +    }
> +
> +    /* Target Proximity Domain List */
> +    for (i =3D 0; i < num_target; i++) {
> +        build_append_int_noprefix(table_data, i, 4);
> +    }
> +
> +    /* Latency or Bandwidth Entries */
> +    entry_list =3D g_malloc0(hmat_lb->list->len * sizeof(uint16_t));
> +    for (i =3D 0; i < hmat_lb->list->len; i++) {
> +        lb_data =3D &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
> +        index =3D lb_data->initiator * num_target + lb_data->target;
> +
> +        entry_list[index] =3D (uint16_t)(lb_data->data / hmat_lb->base);
> +    }
> +
> +    for (i =3D 0; i < num_initiator * num_target; i++) {
> +        build_append_int_noprefix(table_data, entry_list[i], 2);
> +    }
> +
> +    g_free(entry_list);
> +}
> +
>  /* Build HMAT sub table structures */
>  static void hmat_build_table_structs(GArray *table_data, NumaState *numa=
_state)
>  {
>      uint16_t flags;
> -    int i;
> +    uint32_t num_initiator =3D 0;
> +    uint32_t initiator_list[MAX_NODES];
> +    int i, hierarchy, type;
> +    HMAT_LB_Info *hmat_lb;
> =20
>      for (i =3D 0; i < numa_state->num_nodes; i++) {
>          flags =3D 0;
> @@ -82,6 +162,29 @@ static void hmat_build_table_structs(GArray *table_da=
ta, NumaState *numa_state)
> =20
>          build_hmat_mpda(table_data, flags, numa_state->nodes[i].initiato=
r, i);
>      }
> +
> +    for (i =3D 0; i < numa_state->num_nodes; i++) {
> +        if (numa_state->nodes[i].has_cpu) {
> +            initiator_list[num_initiator++] =3D i;
> +        }
> +    }
> +
> +    /*
> +     * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Informat=
ion
> +     * Structure: Table 5-146
> +     */
> +    for (hierarchy =3D HMAT_LB_MEM_MEMORY;
> +         hierarchy <=3D HMAT_LB_MEM_CACHE_3RD_LEVEL; hierarchy++) {
> +        for (type =3D HMAT_LB_DATA_ACCESS_LATENCY;
> +             type <=3D HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
> +            hmat_lb =3D numa_state->hmat_lb[hierarchy][type];
> +
> +            if (hmat_lb) {
> +                build_hmat_lb(table_data, hmat_lb, num_initiator,
> +                              numa_state->num_nodes, initiator_list);
> +            }
> +        }
> +    }
>  }
> =20
>  void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_=
state)


