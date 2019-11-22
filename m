Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDBAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4708220714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6GhPiWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4708220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY88N-0005Cu-D8
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iY873-0004Lg-Ul
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iY870-00031b-Dl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:32:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29660
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iY86z-00031I-QZ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574425952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1EnpEUS7iebMr2roZTH3kFD+uHBYWnGmltlBYxJYT8=;
 b=P6GhPiWIlnbMIq+ZS5hFh4UeASeYUBcpMvMJCBGd9g4VSFYCkXfWTKEXyHjvAkBt2d4NCE
 Iih5MA/GqX7/XxFuc3cVV3QKFBGiDY8hXiPuaNO+/vTqxq2GecO1SeE/eNijC2ernPmHha
 sWQwirXVjHaBYGSuVnZNNsB3zWRzK0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-guMKxv28NUWWI4HTTkPWhg-1; Fri, 22 Nov 2019 07:32:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1C41801E76;
 Fri, 22 Nov 2019 12:32:26 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26A8019C70;
 Fri, 22 Nov 2019 12:32:20 +0000 (UTC)
Date: Fri, 22 Nov 2019 13:32:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 12/14] hmat acpi: Build Memory Side Cache
 Information Structure(s)
Message-ID: <20191122133219.1d46d30c@redhat.com>
In-Reply-To: <20191122074826.1373-13-tao3.xu@intel.com>
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-13-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: guMKxv28NUWWI4HTTkPWhg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-devel@nongnu.org, sw@weilnetz.de, fan.du@intel.com, armbru@redhat.com,
 Daniel Black <daniel@linux.ibm.com>, mdroth@linux.vnet.ibm.com,
 jingqi.liu@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 Nov 2019 15:48:24 +0800
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

for the future reference,
You are not supposed to carry over Reviewed-by tags
if you do non trivial change to the patch.

> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>=20
> No changes in v17.
>=20
> Changes in v16:
>     - Use checks and assert to replace masks (Igor)
>     - Fields in Cache Attributes are promoted to uint32_t before
>       shifting (Igor)
>     - Drop cpu_to_le32() (Igor)
>=20
> Changes in v13:
>     - rename level as cache_level
> ---
>  hw/acpi/hmat.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index e5ee8b4317..bb6adb0ccf 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -143,14 +143,62 @@ static void build_hmat_lb(GArray *table_data, HMAT_=
LB_Info *hmat_lb,
>      g_free(entry_list);
>  }
> =20
> +/* ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure: Table 5-1=
47 */
> +static void build_hmat_cache(GArray *table_data, uint8_t total_levels,
> +                             NumaHmatCacheOptions *hmat_cache)
> +{
> +    /*
> +     * Cache Attributes: Bits [3:0] =E2=80=93 Total Cache Levels
> +     * for this Memory Proximity Domain
> +     */
> +    uint32_t cache_attr =3D total_levels;
> +
> +    /* Bits [7:4] : Cache Level described in this structure */
> +    cache_attr |=3D (uint32_t) hmat_cache->level << 4;
> +
> +    /* Bits [11:8] - Cache Associativity */
> +    cache_attr |=3D (uint32_t) hmat_cache->assoc << 8;
> +
> +    /* Bits [15:12] - Write Policy */
> +    cache_attr |=3D (uint32_t) hmat_cache->policy << 12;
> +
> +    /* Bits [31:16] - Cache Line size in bytes */
> +    cache_attr |=3D (uint32_t) hmat_cache->line << 16;
> +
> +    /* Type */
> +    build_append_int_noprefix(table_data, 2, 2);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Length */
> +    build_append_int_noprefix(table_data, 32, 4);
> +    /* Proximity Domain for the Memory */
> +    build_append_int_noprefix(table_data, hmat_cache->node_id, 4);
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
>  static void hmat_build_table_structs(GArray *table_data, NumaState *numa=
_state)
>  {
>      uint16_t flags;
>      uint32_t num_initiator =3D 0;
>      uint32_t initiator_list[MAX_NODES];
> -    int i, hierarchy, type;
> +    int i, hierarchy, type, cache_level, total_levels;
>      HMAT_LB_Info *hmat_lb;
> +    NumaHmatCacheOptions *hmat_cache;
> =20
>      for (i =3D 0; i < numa_state->num_nodes; i++) {
>          flags =3D 0;
> @@ -184,6 +232,25 @@ static void hmat_build_table_structs(GArray *table_d=
ata, NumaState *numa_state)
>              }
>          }
>      }
> +
> +    /*
> +     * ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure:
> +     * Table 5-147
> +     */
> +    for (i =3D 0; i < numa_state->num_nodes; i++) {
> +        total_levels =3D 0;
> +        for (cache_level =3D 1; cache_level < HMAT_LB_LEVELS; cache_leve=
l++) {
> +            if (numa_state->hmat_cache[i][cache_level]) {
> +                total_levels++;
> +            }
> +        }
> +        for (cache_level =3D 0; cache_level <=3D total_levels; cache_lev=
el++) {
> +            hmat_cache =3D numa_state->hmat_cache[i][cache_level];
> +            if (hmat_cache) {
> +                build_hmat_cache(table_data, total_levels, hmat_cache);
> +            }
> +        }
> +    }
>  }
> =20
>  void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_=
state)


