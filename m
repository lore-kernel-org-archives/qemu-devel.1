Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1677C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A23D2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfzuRxi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A23D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8SX-0007bm-Sc
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kY8RX-0006ju-Ci
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kY8RU-00021X-TS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603979894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0Fp0Ug9dUMWiTX//IyJqvUw86sZdy5IrNimmx08F6Q=;
 b=DfzuRxi05Y55Stj8ElcFVltSeNF5kok0zgqug/E6moviCMazWMcnOf/HKyUO4hHe6TO90Y
 ueimcyg+RCm2FdurOTAKOCZ1gwgLE5YQEOhsDWn3hiwQmO/c1q7b5CATfVoDplJAgTdUJv
 8SouOm8ICXCVuliIdbO/6p5ZzUK6VnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Z8FBV2sBN2GO0ZiY_pXUOw-1; Thu, 29 Oct 2020 09:58:10 -0400
X-MC-Unique: Z8FBV2sBN2GO0ZiY_pXUOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7970C802B48;
 Thu, 29 Oct 2020 13:58:09 +0000 (UTC)
Received: from localhost (unknown [10.40.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3ACB5D9EF;
 Thu, 29 Oct 2020 13:58:01 +0000 (UTC)
Date: Thu, 29 Oct 2020 14:57:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ben Widawsky <ben@bwidawsk.net>
Subject: Re: [PATCH 2/2] acpi/crs: Support ranges > 32b for hosts
Message-ID: <20201029145759.33267164@redhat.com>
In-Reply-To: <20201027154505.346awd3dicockef7@mail.bwidawsk.net>
References: <20201026193924.985014-1-ben.widawsky@intel.com>
 <20201026193924.985014-2-ben.widawsky@intel.com>
 <20201027153612.35e9faac@redhat.com>
 <20201027154505.346awd3dicockef7@mail.bwidawsk.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, jusual@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 08:45:05 -0700
Ben Widawsky <ben@bwidawsk.net> wrote:

> On 20-10-27 15:36:12, Igor Mammedov wrote:
> > On Mon, 26 Oct 2020 12:39:24 -0700
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > According to PCIe spec 5.0 Type 1 header space Base Address Registers
> > > are defined by 7.5.1.2.1 Base Address Registers (same as Type 0). The
> > > _CRS region should allow for the same range (up to 64b). Prior to this
> > > change, any host bridge utilizing more than 32b for the BAR would have
> > > the address truncated and likely lead to conflicts when the operating
> > > systems reads the _CRS object.
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> > 
> > Looks good to me, so
> > 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > 
> > 
> > CCing,
> > Michael to have a send pair of eyes on it 
> > 
> > but I wonder how/why ivshm (which might have quite large BAR) works.  
> 
> I think this will only hit things that subclass TYPE_PCI_HOST_BRIDGE. AFAICT,
> ivshm is a regular TYPE_PCI_DEVICE. Is there a _CRS created for ivshm?

no, but device uses _CRS provided by bus, so I'd expect it would fail
on guest side if its BAR is bigger than window provided by host bridge.

[...]


