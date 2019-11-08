Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E58FC6196
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F174421D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qd8dLGhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F174421D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57155 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6yd-0007P9-JT
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iT6xY-0006Q5-Bj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iT6xW-0002Hk-0H
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:18:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iT6xV-0002Gi-3z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573229878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4Jix9NabG0otXDbqUQ6itxjepo67TQzsB7CUbH+vJw=;
 b=Qd8dLGhyRqrxTqpV2SNDU2YnctMilwGtvlvmOVBFxkpj4CZ01uSl1Mr4BfarqGmSNTz4kV
 CSI8Y4zXHJaAGKO5p/RQJ/VLYXhqvsf/kdfDFHabKoka8BGOSQ/wCXEaQohHYmop96Ce7j
 I/5FuGVaOV8dQIDxTkkahZG0THRRKVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-mdUmDLnVPaiJWgUvaJ-k6A-1; Fri, 08 Nov 2019 11:17:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 618028017DD;
 Fri,  8 Nov 2019 16:17:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95D3D5D6B7;
 Fri,  8 Nov 2019 16:17:47 +0000 (UTC)
Date: Fri, 8 Nov 2019 17:17:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 1/5] hw/arm: Align ACPI blob len to PAGE size
Message-ID: <20191108171745.1465295b@redhat.com>
In-Reply-To: <20191004155302.4632-2-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <20191004155302.4632-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mdUmDLnVPaiJWgUvaJ-k6A-1
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
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 16:52:58 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> If ACPI blob length modifications happens after the initial
> virt_acpi_build() call, and the changed blob length is within
> the PAGE size boundary, then the revised size is not seen by
> the firmware on Guest reboot. The is because in the
> virt_acpi_build_update() -> acpi_ram_update() -> qemu_ram_resize()
> path, qemu_ram_resize() uses ram_block size which is aligned
> to PAGE size and the "resize callback" to update the size seen
> by firmware is not getting invoked. Hence align ACPI blob sizes
> to PAGE boundary.
>=20
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> More details on this issue can be found here,
> https://patchwork.kernel.org/patch/11154757/
re-read it again and it seems to me that this patch is workaround
rather than a solution to the problem.
CCing Michael as an author this code.

on x86 we have crazy history of manually aligning acpi blobs, see code unde=
r comment

  /* We'll expose it all to Guest so we want to reduce

so used_length endups with over-sized value which includes table and paddin=
g
and it happens that ACPI_BUILD_TABLE_SIZE is much bigger than host page siz=
e
so if on reboot we happen to exceed ACPI_BUILD_TABLE_SIZE, the next padded =
table
size (used_length) would be  2 x ACPI_BUILD_TABLE_SIZE which doesn't trigge=
r
  block->used_length =3D=3D HOST_PAGE_ALIGN(newsize)
condition so fwcfg gets updated value.


> ---
>  hw/arm/virt-acpi-build.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 4cd50175e0..074e0c858e 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -790,6 +790,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuild=
Tables *tables)
>      GArray *table_offsets;
>      unsigned dsdt, xsdt;
>      GArray *tables_blob =3D tables->table_data;
> +    GArray *cmd_blob =3D tables->linker->cmd_blob;
>      MachineState *ms =3D MACHINE(vms);
> =20
>      table_offsets =3D g_array_new(false, true /* clear */,
> @@ -854,6 +855,19 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
>          build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
>      }
> =20
> +    /*
> +     * Align the ACPI blob lengths to PAGE size so that on ACPI table
> +     * regeneration, the length that firmware sees really gets updated
> +     * through 'resize' callback in qemu_ram_resize() in the
> +     * virt_acpi_build_update() -> acpi_ram_update() -> qemu_ram_resize(=
)
> +     * path.
> +     */
> +    g_array_set_size(tables_blob,
> +                     TARGET_PAGE_ALIGN(acpi_data_len(tables_blob)));
here it would depend on TARGET_PAGE_ALIGN vs HOST_PAGE_ALIGN relation
so depending on host it could flip it's behavior to opposite.

one thing we could do is dropping (block->used_length =3D=3D newsize) condi=
tion
another is to use value of block->used_length for s->files->f[index].size.

Michael,
what's your take in this?

> +    g_array_set_size(tables->rsdp,
> +                     TARGET_PAGE_ALIGN(acpi_data_len(tables->rsdp)));
> +    g_array_set_size(cmd_blob,
> +                     TARGET_PAGE_ALIGN(acpi_data_len(cmd_blob)));
>      /* Cleanup memory that's no longer used. */
>      g_array_free(table_offsets, true);
>  }


