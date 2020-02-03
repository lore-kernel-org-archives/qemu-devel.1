Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE145C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9B520661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG+gPlFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9B520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWXL-0004R7-QT
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 02:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyWWR-0003hz-6a
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyWWP-0003vh-Fl
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:51:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyWWP-0003vN-61
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580716312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shrxJcLWYa5dcYmO7shA/1HAHpE7/18QYuBpgSLW+Y0=;
 b=BG+gPlFvXR9u5TTU+6jDQOSSbi+zenA67zz62B4k6BxdS46+2O66XbZosTcEbzW/2GySIR
 jr0QhKDpvO5cCxD35UijNDAUbctXjoKZZASRQfO+8w5bBVt4qWIYK5qn/QZ41W0+NBIX2v
 nqa2aoQx0gCmEInvSzDbxBTR9Y5Qu3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-QSFWe5ESNBOfXFi1a38mKw-1; Mon, 03 Feb 2020 02:51:50 -0500
X-MC-Unique: QSFWe5ESNBOfXFi1a38mKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86F1D1800D41;
 Mon,  3 Feb 2020 07:51:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC52960BE2;
 Mon,  3 Feb 2020 07:51:41 +0000 (UTC)
Date: Mon, 3 Feb 2020 08:51:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v22 5/9] ACPI: Record the Generic Error Status Block
 address
Message-ID: <20200203085140.2e7ab793@redhat.com>
In-Reply-To: <02a78eff-865c-b9e0-6d5f-d4caa4daa98d@huawei.com>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
 <20200128154110.04baa5bc@redhat.com>
 <02a78eff-865c-b9e0-6d5f-d4caa4daa98d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2 Feb 2020 20:44:35 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> sorry for the late response due to Chinese new year
> 
> On 2020/1/28 22:41, Igor Mammedov wrote:
> > On Wed, 8 Jan 2020 19:32:19 +0800
> > Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> > 
> > in addition to comments of others:
> >   
> >> Record the GHEB address via fw_cfg file, when recording
> >> a error to CPER, it will use this address to find out
> >> Generic Error Data Entries and write the error.
> >>
> >> Make the HEST GHES to a GED device.  
[...]
> >> @@ -831,7 +832,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >>      acpi_add_table(table_offsets, tables_blob);
> >>      build_spcr(tables_blob, tables->linker, vms);
> >>  
> >> -    if (vms->ras) {
> >> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> >> +                                                       NULL));
> >> +    if (acpi_ged_state &&  vms->ras) {  
> > 
> > there is vms->acpi_dev which is GED, so you don't need to look it up
> > 
> > suggest:  
>    Thanks for the suggestion.
> 
> >  if (ras) {
> >     assert(ged)  
>       assert(vms->acpi_dev), right?

yes, something like this.

 
> >     do other fun stuff ...
> >  }  
> 
> >   
> >>          acpi_add_table(table_offsets, tables_blob);
> >>          build_ghes_error_table(tables->hardware_errors, tables->linker);
> >>          acpi_build_hest(tables_blob, tables->hardware_errors,
[...]


