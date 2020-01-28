Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C27FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249B6214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE7mdXLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249B6214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTas-0000Yj-AH
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwTa9-0008Tt-Mc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwTa7-0003i0-W2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:19:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwTa7-0003gt-Ht
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580228354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvgTVseyWvXm4+yLdxqYTDHmsvugnTvv6esW8T158zQ=;
 b=ZE7mdXLW1G+QDBarEF1gQPnL4P9ab9InSO3ILnWdrT64sZlg8BYsSJSCj0lJ+Z+mU66nY6
 T6c7Jd5uNZsKBkSmRjaIyNqhauXIKt1oB4h6pLHpF9703nC4XXQ3vOcW5e6x35rZ29sFFi
 FCfzDQAnbHIfdL02vsp21cNBS5H+2ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-odjdjK8COimfz7FpoA3kWg-1; Tue, 28 Jan 2020 11:19:13 -0500
X-MC-Unique: odjdjK8COimfz7FpoA3kWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24464107ACC9;
 Tue, 28 Jan 2020 16:19:11 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B43B5DA7E;
 Tue, 28 Jan 2020 16:19:05 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:19:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v22 5/9] ACPI: Record the Generic Error Status Block
 address
Message-ID: <20200128171903.7055874a@redhat.com>
In-Reply-To: <20200128154110.04baa5bc@redhat.com>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
 <20200128154110.04baa5bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 15:41:10 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 8 Jan 2020 19:32:19 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
> in addition to comments of others:
> 
> > Record the GHEB address via fw_cfg file, when recording
> > a error to CPER, it will use this address to find out
> > Generic Error Data Entries and write the error.
> > 
> > Make the HEST GHES to a GED device.  
> 
> It's hard to parse this even kno
mine comments are not readable either, let me try again:

What I've lost at the end and wanted to say is
that even when one knows context it's hard to read commit message
and it will definitely be unreadable when one forgets context.

> Pls rephrase/make commit message more verbose,
> so it would describe why and what patch is supposed to do
[...]


