Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9A4C4CED1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8146B2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8146B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGIZ1-0006PM-Kf
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iGIXM-0005TM-T4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iGIXK-0003Py-Ab
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:02:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iGIXJ-0003PU-Nq
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:02:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16AFA88307;
 Fri,  4 Oct 2019 08:02:00 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35C1260BE1;
 Fri,  4 Oct 2019 08:01:58 +0000 (UTC)
Date: Fri, 4 Oct 2019 10:01:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v12 10/11] hmat acpi: Build Memory Side Cache
 Information Structure(s)
Message-ID: <20191004100157.7e3ce374@redhat.com>
In-Reply-To: <20190920074349.2616-11-tao3.xu@intel.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-11-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 04 Oct 2019 08:02:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, Daniel Black <daniel@linux.ibm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 15:43:48 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
>=20
> This structure describes memory side cache information for memory
> proximity domains if the memory side cache is present and the
> physical device forms the memory side cache.
> The software could use this information to effectively place
> the data in memory to maximize the performance of the system
> memory that use the memory side cache.
>=20
> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> No changes in v12.
>=20
> Changes in v11:
>     - Move numa option patches forward.
> ---
>  hw/acpi/hmat.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index e7be849581..6b260eeef5 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -160,13 +160,62 @@ static void build_hmat_lb(GArray *table_data, HMAT_=
LB_Info *hmat_lb,
>      }
>  }
> =20
> +/* ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure: Table 5-1=
47 */
> +static void build_hmat_cache(GArray *table_data, HMAT_Cache_Info *hmat_c=
ache)
> +{
> +    /*
> +     * Cache Attributes: Bits [3:0] =E2=80=93 Total Cache Levels
> +     * for this Memory Proximity Domain
> +     */
> +    uint32_t cache_attr =3D hmat_cache->total_levels & 0xF;
> +
> +    /* Bits [7:4] : Cache Level described in this structure */
> +    cache_attr |=3D (hmat_cache->level & 0xF) << 4;


> +    /* Bits [11:8] - Cache Associativity */
> +    cache_attr |=3D (hmat_cache->associativity & 0xF) << 8;
> +
> +    /* Bits [15:12] - Write Policy */
> +    cache_attr |=3D (hmat_cache->write_policy & 0xF) << 12;

s/0xF/0x7/ for  Cache Associativity /  Write Policy

> +
> +    /* Bits [31:16] - Cache Line size in bytes */
> +    cache_attr |=3D (hmat_cache->line_size & 0xFFFF) << 16;
> +
> +    cache_attr =3D cpu_to_le32(cache_attr);
> +
> +    /* Type */
> +    build_append_int_noprefix(table_data, 2, 2);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Length */
> +    build_append_int_noprefix(table_data, 32, 4);
> +    /* Proximity Domain for the Memory */
> +    build_append_int_noprefix(table_data, hmat_cache->mem_proximity, 4);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +    /* Memory Side Cache Size */
> +    build_append_int_noprefix(table_data, hmat_cache->size, 8);
> +    /* Cache Attributes */
> +    build_append_int_noprefix(table_data, cache_attr, 4);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /*
> +     * Number of SMBIOS handles (n)
> +     * Linux kernel uses Memory Side Cache Information Structure
> +     * without SMBIOS entries for now, so set Number of SMBIOS handles
> +     * as 0.
> +     */
> +    build_append_int_noprefix(table_data, 0, 2);
> +}
> +
>  /* Build HMAT sub table structures */
>  static void hmat_build_table_structs(GArray *table_data, NumaState *nsta=
t)
>  {
>      uint16_t flags;
>      uint32_t *initiator_list =3D NULL;
> -    int i, j, hrchy, type;
> +    int i, j, hrchy, type, level;

s/level/cache_level/

>      HMAT_LB_Info *numa_hmat_lb;
> +    HMAT_Cache_Info *numa_hmat_cache;
> =20
>      for (i =3D 0; i < nstat->num_nodes; i++) {
>          flags =3D 0;
> @@ -205,6 +254,19 @@ static void hmat_build_table_structs(GArray *table_d=
ata, NumaState *nstat)
>          }
>      }
> =20
> +    /*
> +     * ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure:
> +     * Table 5-147
> +     */
> +    for (i =3D 0; i < nstat->num_nodes; i++) {
> +        for (level =3D 0; level <=3D MAX_HMAT_CACHE_LEVEL; level++) {
> +            numa_hmat_cache =3D nstat->hmat_cache[i][level];
> +            if (numa_hmat_cache) {
> +                build_hmat_cache(table_data, numa_hmat_cache);
> +            }
> +        }
> +    }
> +
>      g_free(initiator_list);
>  }
> =20


