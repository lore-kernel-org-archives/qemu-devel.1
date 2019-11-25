Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F74207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIJofAWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F74207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZB0D-0003PQ-55
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 04:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iZAzZ-00030Z-Tl
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iZAzY-0007cQ-B9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:49:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iZAzX-0007bV-Sd
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574675350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LI90vjXh2HXUGcnDPIxy5xrhkGpcg6ttLKuY2YJfARU=;
 b=aIJofAWWfB45O1ifaaxgp7F/Mjy1pA1nLVDUAcyWtMsyiRe3ITdUx6z74ODSBP6PynCYGg
 eM1z+ZGaFwr3N4hMhV50tdhiULR7DbGujZAbjcREIuq90IJNcRakCl2cop7aIl7OPRYzM6
 ZrxQdxOGrQZuhqC8koLF60rIleQGw6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-8zfc_lBjPRynSK0RUXnuaA-1; Mon, 25 Nov 2019 04:49:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1D0E107ACE5;
 Mon, 25 Nov 2019 09:49:07 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DDD510016DA;
 Mon, 25 Nov 2019 09:49:00 +0000 (UTC)
Date: Mon, 25 Nov 2019 10:48:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RESEND PATCH v21 3/6] ACPI: Add APEI GHES table generation
 support
Message-ID: <20191125104859.70047602@redhat.com>
In-Reply-To: <20191118082036-mutt-send-email-mst@kernel.org>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-4-zhengxiang9@huawei.com>
 <20191115103801.547fc84d@redhat.com>
 <cf5e5aa4-2283-6cf9-70d0-278d167e3a13@huawei.com>
 <87758ec2-c242-71c3-51f8-a5d348f8e7fd@huawei.com>
 <20191118082036-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 8zfc_lBjPRynSK0RUXnuaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 pbonzini@redhat.com, mtosatti@redhat.com, linuxarm@huawei.com,
 qemu-devel@nongnu.org, gengdongjiu <gengdongjiu@huawei.com>,
 shannon.zhaosl@gmail.com, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, wanghaibin.wang@huawei.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 08:21:18 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Nov 18, 2019 at 09:18:01PM +0800, gengdongjiu wrote:
> > On 2019/11/18 20:49, gengdongjiu wrote:  
> > >>> +     */
> > >>> +    build_append_int_noprefix(table_data, source_id, 2);
> > >>> +    /* Related Source Id */
> > >>> +    build_append_int_noprefix(table_data, 0xffff, 2);
> > >>> +    /* Flags */
> > >>> +    build_append_int_noprefix(table_data, 0, 1);
> > >>> +    /* Enabled */
> > >>> +    build_append_int_noprefix(table_data, 1, 1);
> > >>> +
> > >>> +    /* Number of Records To Pre-allocate */
> > >>> +    build_append_int_noprefix(table_data, 1, 4);
> > >>> +    /* Max Sections Per Record */
> > >>> +    build_append_int_noprefix(table_data, 1, 4);
> > >>> +    /* Max Raw Data Length */
> > >>> +    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
> > >>> +
> > >>> +    /* Error Status Address */
> > >>> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
> > >>> +                     4 /* QWord access */, 0);
> > >>> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> > >>> +        ACPI_GHES_ERROR_STATUS_ADDRESS_OFFSET(hest_start, source_id),  
> > >> it's fine only if GHESv2 is the only entries in HEST, but once
> > >> other types are added this macro will silently fall apart and
> > >> cause table corruption.  
> >    why  silently fall?
> >    I think the acpi_ghes.c only support GHESv2 type, not support other type.
> >   
> > >>
> > >> Instead of offset from hest_start, I suggest to use offset relative
> > >> to GAS structure, here is an idea>>
> > >> #define GAS_ADDR_OFFSET 4
> > >>
> > >>     off = table->len
> > >>     build_append_gas()
> > >>     bios_linker_loader_add_pointer(...,
> > >>         off + GAS_ADDR_OFFSET, ...  
> > 
> > If use offset relative to GAS structure, the code does not easily extend to support more Generic Hardware Error Source.
> > if use offset relative to hest_start, just use a loop, the code can support  more error source, for example:
> > for (source_id = 0; i<n; source_id++)
> > {
> >    ......
> >     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> >         ACPI_GHES_ERROR_STATUS_ADDRESS_OFFSET(hest_start, source_id),
> >         sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> >         source_id * sizeof(uint64_t));
> >   .......
> > }
> > 
> > My previous series patch support 2 error sources, but now only enable 'SEA' type Error Source  
> 
> I'd try to merge this, worry about extending things later.
> This is at v21 and the simpler you can keep things,
> the faster it'll go in.
I don't think the series is ready for merging yet.
It has a number of issues (not stylistic ones) that need to be fixed first.

As for extending, I think I've suggested to simplify series
to account for single error source only in some places so it
would be easier on author and reviewers and worry about extending
it later.



