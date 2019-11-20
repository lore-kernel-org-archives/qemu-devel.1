Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A8C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A828A2251D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0SK/vQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A828A2251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPSN-0005Y7-QP
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iXPRX-0004fd-Uw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iXPRW-0005jF-MB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:50:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iXPRW-0005j1-IY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574254246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMlc9EOVLyPZ5uYcknUWdK11Wll5PVOUn3wOQ5BPCOc=;
 b=E0SK/vQx6TQd4TxKhTZ+rUXoXwOyxJXzGjKGF4quT+0AJ1MK+B3dC2PQzF7Q5KhVZozXo1
 mtIPnSaUI7p+CZ/L3zOwlDV6KgKkHC6613bm89sCyGbthbHaLX0bFJfjODdyB9mmUTf8bn
 wwN/bper2ONFaZiSeKZIfHiWXOtCaww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-ViadLZTNNTaZ7kkChctbxQ-1; Wed, 20 Nov 2019 07:50:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEFB3803420;
 Wed, 20 Nov 2019 12:50:40 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6955410016EB;
 Wed, 20 Nov 2019 12:50:35 +0000 (UTC)
Date: Wed, 20 Nov 2019 13:50:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v16 12/14] hmat acpi: Build Memory Side Cache
 Information Structure(s)
Message-ID: <20191120135033.78e0a20c@redhat.com>
In-Reply-To: <20191115075352.17734-13-tao3.xu@intel.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-13-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ViadLZTNNTaZ7kkChctbxQ-1
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
 qemu-devel@nongnu.org, jingqi.liu@intel.com, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, Daniel Black <daniel@linux.ibm.com>,
 armbru@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 15:53:50 +0800
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

looks good, but I'll skip the patch this round
since it will be changed by HMAT_Cache_Info removal in [9/14]

> ---
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
> index ed19ebed2f..2b4f760e0e 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -144,14 +144,62 @@ static void build_hmat_lb(GArray *table_data, HMAT_=
LB_Info *hmat_lb,
>      g_free(entry_list);
>  }
> =20
> +/* ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure: Table 5-1=
47 */
> +static void build_hmat_cache(GArray *table_data, HMAT_Cache_Info *hmat_c=
ache,
> +                             uint8_t total_levels)
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
> +    cache_attr |=3D (uint32_t) hmat_cache->associativity << 8;
> +
> +    /* Bits [15:12] - Write Policy */
> +    cache_attr |=3D (uint32_t) hmat_cache->write_policy << 12;
> +
> +    /* Bits [31:16] - Cache Line size in bytes */
> +    cache_attr |=3D (uint32_t) hmat_cache->line_size << 16;
> +
> +    /* Type */
> +    build_append_int_noprefix(table_data, 2, 2);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Length */
> +    build_append_int_noprefix(table_data, 32, 4);
> +    /* Proximity Domain for the Memory */
> +    build_append_int_noprefix(table_data, hmat_cache->proximity, 4);
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
> +    HMAT_Cache_Info *hmat_cache;
> =20
>      for (i =3D 0; i < numa_state->num_nodes; i++) {
>          flags =3D 0;
> @@ -185,6 +233,25 @@ static void hmat_build_table_structs(GArray *table_d=
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
> +                build_hmat_cache(table_data, hmat_cache, total_levels);
> +            }
> +        }
> +    }
>  }
> =20
>  void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_=
state)


