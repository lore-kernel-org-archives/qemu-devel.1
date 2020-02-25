Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29076C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBE8222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+XLYenn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBE8222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aiy-0002FA-69
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6aiJ-0001Pc-GT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6aiH-0002k6-P5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:57:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36229
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6aiH-0002jv-Gz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582639048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u5oyKfwsQp27bsa1IAdlRDT3QgLdAO2qyRAcmzr55s=;
 b=O+XLYenn4TAA/vBnZQYKFmarxIUjPp+RCV1vbUEwFcYy0PIoOa9PsL30dFStUAfS3LsTKz
 q0HSRLuxORvO+dygZVZYzWpDCMvNxI6lt7ns6E8UkUsmj7tpBO6f6bTWUnY63iNlJnEaWo
 KewKstdc/HfrzCnPfh1o+igTGzRIVms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-yqzhWlsOPaSQZmysm31UDA-1; Tue, 25 Feb 2020 08:57:24 -0500
X-MC-Unique: yqzhWlsOPaSQZmysm31UDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D649477;
 Tue, 25 Feb 2020 13:57:21 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6582F65E80;
 Tue, 25 Feb 2020 13:57:14 +0000 (UTC)
Date: Tue, 25 Feb 2020 14:57:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v24 04/10] ACPI: Build related register address fields
 via hardware error fw_cfg blob
Message-ID: <20200225145712.4dd410d2@redhat.com>
In-Reply-To: <20200225094804.3ae51b86@redhat.com>
References: <20200217131248.28273-1-gengdongjiu@huawei.com>
 <20200217131248.28273-5-gengdongjiu@huawei.com>
 <20200225094804.3ae51b86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, james.morse@arm.com,
 shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com,
 pbonzini@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 09:48:04 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 17 Feb 2020 21:12:42 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
> > This patch builds error_block_address and read_ack_register fields
> > in hardware errors table , the error_block_address points to Generic
> > Error Status Block(GESB) via bios_linker. The max size for one GESB
> > is 1kb in bytes, For more detailed information, please refer to  
> 
> s/1kb in bytes/1Kb/
> 
> > document: docs/specs/acpi_hest_ghes.rst
> > 
> > Now we only support one Error source, if necessary, we can extend to
> > support more.
> > 
> > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> > Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
>

On the second glance,


[...]
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index bd5f771..6819fcf 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -48,6 +48,7 @@
> >  #include "sysemu/reset.h"
> >  #include "kvm_arm.h"
> >  #include "migration/vmstate.h"
> > +#include "hw/acpi/ghes.h"
> >  
> >  #define ARM_SPI_BASE 32
> >  
> > @@ -830,6 +831,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >      acpi_add_table(table_offsets, tables_blob);
> >      build_spcr(tables_blob, tables->linker, vms);
> >  
> > +    if (vms->ras) {

> > +        acpi_add_table(table_offsets, tables_blob);
that doesn't look right, it's for tables that  should be referenced
from XSDT

> > +        build_ghes_error_table(tables->hardware_errors, tables->linker);

but this table isn't pointed by XSDT directly.

I suggest to move acpi_add_table() to the patch that adds acpi_build_hest()

> > +    }
> > +
> >      if (ms->numa_state->num_nodes > 0) {
> >          acpi_add_table(table_offsets, tables_blob);
> >          build_srat(tables_blob, tables->linker, vms);
[...]


