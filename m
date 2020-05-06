Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ED4C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1FC206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMqtna4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1FC206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDdt-0000fo-BW
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jWDcd-00007E-0I
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:33:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jWDcb-0002Re-AY
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588746811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVFyJmPNLdzQ6g2F9LClgPJEmDnYLNSS3tnhqWIM5R8=;
 b=NMqtna4T0ej+FzwgHEMQcrKTuO68cNDxbTMdq6aGjt+nP/KO14Fz5mWbOznZNu/GUWbJ31
 QjEylDWVE0LUbtwavHNPK3TvlqNoFfMXy4vUy/l7isoZdNljR3RJuy0k2ibPJAl6ytSai3
 aHgK1B3d4dI4tsPfetPC708J05+IDdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-rDaaDdonM1C8u-GMxwyUbQ-1; Wed, 06 May 2020 02:33:30 -0400
X-MC-Unique: rDaaDdonM1C8u-GMxwyUbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FB25100CCC0;
 Wed,  6 May 2020 06:33:28 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B96BA9CB9;
 Wed,  6 May 2020 06:33:16 +0000 (UTC)
Date: Wed, 6 May 2020 08:33:14 +0200
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 1/3] acpi: Move build_tpm2() in the generic part
Message-ID: <20200506063314.4qvnyfonjixcknuj@kamzik.brq.redhat.com>
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-2-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200505144419.29174-2-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:33:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, gshan@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, imammedo@redhat.com, eric.auger.pro@gmail.com,
 lersek@redhat.com, ardb@kernel.org, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 04:44:17PM +0200, Eric Auger wrote:
> We plan to build the tpm2 table on ARM too. In order to reuse the
> generation code, let's move build_tpm2() to aml-build.c.
>=20
> No change in the implementation.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/hw/acpi/aml-build.h |  2 ++
>  hw/acpi/aml-build.c         | 30 ++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c        | 30 ------------------------------
>  3 files changed, 32 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 0f4ed53d7f..a67ab4618a 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -437,4 +437,6 @@ void build_slit(GArray *table_data, BIOSLinker *linke=
r, MachineState *ms);
> =20
>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                  const char *oem_id, const char *oem_table_id);
> +
> +void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)=
;
>  #endif
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 2c3702b882..1f7fd09112 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -26,6 +26,7 @@
>  #include "qemu/bitops.h"
>  #include "sysemu/numa.h"
>  #include "hw/boards.h"
> +#include "hw/acpi/tpm.h"
> =20
>  static GArray *build_alloc_array(void)
>  {
> @@ -1875,6 +1876,35 @@ build_hdr:
>                   "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_tabl=
e_id);
>  }
> =20
> +void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
> +{
> +    Acpi20TPM2 *tpm2_ptr =3D acpi_data_push(table_data, sizeof *tpm2_ptr=
);
> +    unsigned log_addr_size =3D sizeof(tpm2_ptr->log_area_start_address);
> +    unsigned log_addr_offset =3D
> +        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
> +
> +    tpm2_ptr->platform_class =3D cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> +    if (TPM_IS_TIS_ISA(tpm_find())) {
> +        tpm2_ptr->control_area_address =3D cpu_to_le64(0);
> +        tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
> +    } else if (TPM_IS_CRB(tpm_find())) {
> +        tpm2_ptr->control_area_address =3D cpu_to_le64(TPM_CRB_ADDR_CTRL=
);
> +        tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_CRB);
> +    } else {
> +        g_warn_if_reached();
> +    }
> +
> +    tpm2_ptr->log_area_minimum_length =3D
> +        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> +
> +    /* log area start address to be filled by Guest linker */
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> +                                   log_addr_offset, log_addr_size,
> +                                   ACPI_BUILD_TPMLOG_FILE, 0);
> +    build_header(linker, table_data,
> +                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, N=
ULL);
> +}
> +

I'll let Igor and mst confirm/deny this, but my understanding was that the
build_append* API was the preferred way to create the table. Indeed, I
don't see too many table.field =3D cpu_to_le(...) lines in aml-build.c

I realize this function is just getting moved, but maybe it should get
converted to the build_append* API while being moved?

Thanks,
drew


