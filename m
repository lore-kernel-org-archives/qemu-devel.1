Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B5C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD832073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EP0Vxn3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD832073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCglm-0001UL-IW
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 05:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jCgkh-0000V9-1z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jCgkf-0005DU-SL
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:37:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jCgkf-0005Bw-FF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584092228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3wccgn+mnhxVpYbw/Kj4A9Xxcgx1caEqmPfxiD74q4=;
 b=EP0Vxn3RQhS2bFJe6OOLpbLjXQW3gYNaIBC5YT1waK6OVXk80U+yueIc28Y8Gx5+cESVwx
 uxdDlhTzkql6glsxz9C2Og/EoPYtAFntkq3EynPBHlRopjHHeEWEh/kkuezNDRyJAQzcB5
 MZk+KzWXTce/3/9o8nwMuOkIv/kQbGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-qYxgHPWFO7GPV-kKDnhNYg-1; Fri, 13 Mar 2020 05:37:04 -0400
X-MC-Unique: qYxgHPWFO7GPV-kKDnhNYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3693B107ACC4;
 Fri, 13 Mar 2020 09:37:03 +0000 (UTC)
Received: from localhost (ovpn-200-60.brq.redhat.com [10.40.200.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79CB819C6A;
 Fri, 13 Mar 2020 09:36:57 +0000 (UTC)
Date: Fri, 13 Mar 2020 10:36:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200313103656.094ec89b@redhat.com>
In-Reply-To: <20200312130854-mutt-send-email-mst@kernel.org>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200312172745.1b7b2222@redhat.com>
 <20200312130854-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Liran Alon <liran.alon@oracle.com>, Elad Gabay <elad.gabay@oracle.com>,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 13:09:51 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Mar 12, 2020 at 05:27:45PM +0100, Igor Mammedov wrote:
> > On Wed, 11 Mar 2020 19:08:26 +0200
> > Liran Alon <liran.alon@oracle.com> wrote:
> >   
> > > From: Elad Gabay <elad.gabay@oracle.com>
> > > 
> > > Microsoft introduced this ACPI table to avoid Windows guests performing
> > > various workarounds for device erratas. As the virtual device emulated
> > > by VMM may not have the errata.
> > > 
> > > Currently, WAET allows hypervisor to inform guest about two
> > > specific behaviors: One for RTC and the other for ACPI PM Timer.
> > > 
> > > Support for WAET have been introduced since Windows Vista. This ACPI
> > > table is also exposed by other hypervisors, such as VMware, by default.
> > > 
> > > This patch adds WAET ACPI Table to QEMU. It also makes sure to introduce
> > > the new ACPI table only for new machine-types.  
> > 
> > in addition to comments made by Michael ...
> >   
> > > 
> > > Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
> > > Co-developed-by: Liran Alon <liran.alon@oracle.com>
> > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > ---
> > >  hw/i386/acpi-build.c        | 18 ++++++++++++++++++
> > >  hw/i386/pc_piix.c           |  2 ++
> > >  hw/i386/pc_q35.c            |  2 ++
> > >  include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
> > >  include/hw/i386/pc.h        |  1 +
> > >  5 files changed, 48 insertions(+)
> > > 
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 9c4e46fa7466..29f70741cd96 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
> > >      build_header(linker, table_data, (void *)(table_data->data + dmar_start),
> > >                   "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
> > >  }
> > > +
> > > +static void
> > > +build_waet(GArray *table_data, BIOSLinker *linker)  
> > see build_hmat_lb() for example how to doc comment for such function
> > should look like. Use earliest spec version where table was introduced.
> >   
> > > +{
> > > +    AcpiTableWaet *waet;
> > > +
> > > +    waet = acpi_data_push(table_data, sizeof(*waet));
> > > +    waet->emulated_device_flags = cpu_to_le32(ACPI_WAET_PM_TIMER_GOOD);  
> > 
> > we don't use packed structures for building ACPI tables anymore (there is
> > old code that still does but that's being converted when we touch it)
> > 
> > pls use build_append_int_noprefix() api instead, see build_amd_iommu() as
> > an example how to build binary tables using it and how to use comments
> > to document fields.
> > Basic idea is that api makes function building a table match table's
> > description in spec (each call represents a row in spec) and comment
> > belonging to a row should contain verbatim field name as used by spec
> > so reader could copy/past and grep it easily.  
> 
> 
> BTW how about a better name for this function?

how about [aml|acpi]_int_raw 
[...]


