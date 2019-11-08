Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCBDFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14921214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0LLaoFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14921214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5Ry-00071Y-PX
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iT5R7-0006QM-Ac
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iT5R6-0008Pu-5C
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:40:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40688
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iT5R6-0008PP-1Y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573224027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmYPVH2XyCCzzfya8vyrGX0wsni56aEgm8u01WnGlDI=;
 b=b0LLaoFfg3wYvorODNCSwXmvpVVRKUiW6aByKchDxWaHD6RMZDLAnJgCc3zOGTUAKJyYzm
 zo8ah6QVoq32KfVEqHYjW/1O1iU+nKYJrLQf5XIYsjH/eK9/83CXMVujBgoi2DQoXjr0SG
 V1DhDCVSnP0U8AMCDekwsTKclZJuKMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-98-5RwL4NNmMj4W-wYc58A-1; Fri, 08 Nov 2019 09:40:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DB51005500;
 Fri,  8 Nov 2019 14:40:22 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4C41600D3;
 Fri,  8 Nov 2019 14:39:56 +0000 (UTC)
Date: Fri, 8 Nov 2019 15:39:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v15 11/12] hmat acpi: Build Memory Side Cache
 Information Structure(s)
Message-ID: <20191108153955.04d921e4@redhat.com>
In-Reply-To: <20191107074511.14304-12-tao3.xu@intel.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
 <20191107074511.14304-12-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 98-5RwL4NNmMj4W-wYc58A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com,
 Laszlo Ersek <lersek@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org,
 jingqi.liu@intel.com, fan.du@intel.com, mdroth@linux.vnet.ibm.com,
 Daniel Black <daniel@linux.ibm.com>, armbru@redhat.com,
 jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[...]
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
applies to this and below maskings:
instead of masking add asserts with masks so API would explode instead
of silently ignoring invalid values.
If values are provided by user and graceful error handling is desired
make checks at CLI parsing time.

> +
> +    /* Bits [7:4] : Cache Level described in this structure */
> +    cache_attr |=3D (hmat_cache->level & 0xF) << 4;
> +
> +    /* Bits [11:8] - Cache Associativity */
> +    cache_attr |=3D (hmat_cache->associativity & 0x7) << 8;
> +
> +    /* Bits [15:12] - Write Policy */
> +    cache_attr |=3D (hmat_cache->write_policy & 0x7) << 12;
> +
> +    /* Bits [31:16] - Cache Line size in bytes */
> +    cache_attr |=3D (hmat_cache->line_size & 0xFFFF) << 16;

Would (unit16_t) field be promoted to uint32_t before it's shifted (accordi=
ng to C standard)
or we are just discarding value here?

> +    cache_attr =3D cpu_to_le32(cache_attr);
drop it,
build_append_int_noprefix() takes value in host byte order

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
> @@ -176,6 +225,27 @@ static void hmat_build_table_structs(GArray *table_d=
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
> +        for (cache_level =3D 1; cache_level <=3D MAX_HMAT_CACHE_LEVEL;
> +             cache_level++) {
> +            if (numa_state->hmat_cache[i][cache_level]) {
> +                total_levels++;
> +            }
> +        }
> +        for (cache_level =3D 0; cache_level <=3D total_levels; cache_lev=
el++) {
> +            hmat_cache =3D numa_state->hmat_cache[i][cache_level];
> +            if (hmat_cache) {
> +                hmat_cache->total_levels =3D total_levels;
pass total_levels as additional argument so you wouldn't need custom struct=
ure
(see my comment on 8/12)

> +                build_hmat_cache(table_data, hmat_cache);
> +            }
> +        }
> +    }
>  }
> =20
>  void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_=
state)


