Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F035C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DC220656
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TC8QBphr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DC220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXau-0001Lu-AM
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iUXXa-0006TA-7K
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iUXXY-0004M1-4p
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:53:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iUXXX-0004LR-KA
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573570386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPTS6mLbTN7tU940wnGTobkD2V7rdyFvf0zuWM59LE8=;
 b=TC8QBphrc4MNBqq6CvetTPDuIn87NT/4CPl+gsDfHbZzf7I3DAia3XFUrMs/qAv/BSZBV8
 opnWoxWqg58CNpFzDTbk+pKmf18Nq+92qGBu8H8sjgg9lBV7maUkS3ZMGk8iJl+QvR7FKk
 b7kKqra63eeLtHgq/hQwfHnkwMxxe/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-5urAgn5-O2W-hbbjGpxvpA-1; Tue, 12 Nov 2019 09:53:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BB51107ACCD;
 Tue, 12 Nov 2019 14:53:02 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B924610E5;
 Tue, 12 Nov 2019 14:52:55 +0000 (UTC)
Date: Tue, 12 Nov 2019 15:52:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [RFC v2 14/14] virt/acpi: add SDEI table if SDEI is enabled
Message-ID: <20191112155253.543e15ad@redhat.com>
In-Reply-To: <20191105091056.9541-15-guoheyi@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-15-guoheyi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5urAgn5-O2W-hbbjGpxvpA-1
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, James Morse <james.morse@arm.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 17:10:56 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> Add SDEI table if SDEI is enabled, so that guest OS can get aware and
> utilize the interfaces.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>=20
> Notes:
>     v2:
>     - Drop SDEI table definition and add comments
>=20
>  hw/arm/virt-acpi-build.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 4cd50175e0..73d3f8cd15 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -32,6 +32,7 @@
>  #include "trace.h"
>  #include "hw/core/cpu.h"
>  #include "target/arm/cpu.h"
> +#include "target/arm/sdei.h"
>  #include "hw/acpi/acpi-defs.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/nvram/fw_cfg.h"
> @@ -475,6 +476,26 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
>                   "IORT", table_data->len - iort_start, 0, NULL, NULL);
>  }
> =20
> +/*
> + * ACPI spec 6.2 Software Delegated Exception Interface (SDEI).
> + * (Revision 1.0)
> + * "SDEI" was reserved in ACPI 6.2. See "Links to ACPI-Related Documents=
"
> + * (http://uefi.org/acpi) under the heading "Software
> + * Delegated Exceptions Interface." The definition is under
> + * "10 Appendix C: ACPI table definitions for SDEI" in the linked docume=
nt.
> + *
> + * This is a dummy table to expose platform SDEI capbility to OS.
> + */
> +static void
> +build_sdei(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms=
)
> +{
> +    int sdei_start =3D table_data->len;
> +
> +    (void)acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +    build_header(linker, table_data, (void *)(table_data->data + sdei_st=
art),
> +                 "SDEI", table_data->len - sdei_start, 1, NULL, NULL);
> +}
> +
>  static void
>  build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms=
)
>  {
> @@ -825,6 +846,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
>      acpi_add_table(table_offsets, tables_blob);
>      build_spcr(tables_blob, tables->linker, vms);
> =20
> +    if (sdei_enabled) {
globals shouldn't be introduced in new code

> +        acpi_add_table(table_offsets, tables_blob);
> +        build_sdei(tables_blob, tables->linker, vms);
> +    }
> +
>      if (ms->numa_state->num_nodes > 0) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, vms);


