Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA6C204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7TSYdoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA6C204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw11N-0004Te-Jx
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jw10e-0003jf-Nb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:21:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jw10b-0006GT-JI
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594894856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woR58QtC6e/BY7sYhXn+6nzar860dxN3DNbjQCj1qWo=;
 b=T7TSYdoOm/+Dqv89NnM6ybkWatUXW7fyRKkvtY/ShwmIe9sJmjm9W0n5rzvpxSZEK1gkYi
 Re5GAWgOrm9BaKaSwYgEUkqcN8eoS1UGaiox6AmweRpHLkXIAzwOZ6nP9wTOT/LZ6H4GAc
 GbsEjHTtHTWG743qEEousegMBJgh8xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-nUSF_VHIOaW7SXHW64aFpw-1; Thu, 16 Jul 2020 06:20:54 -0400
X-MC-Unique: nUSF_VHIOaW7SXHW64aFpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A70001081
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:20:53 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C93247B422;
 Thu, 16 Jul 2020 10:20:41 +0000 (UTC)
Date: Thu, 16 Jul 2020 12:20:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: unable to boot windows with 256 cpus
Message-ID: <20200716122039.15448e86@redhat.com>
In-Reply-To: <20200715182819.GF502441@xz-x1.hitronhub.home>
References: <20200715194513.5b19ca27@redhat.com>
 <20200715182819.GF502441@xz-x1.hitronhub.home>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.williamson@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 14:28:19 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jul 15, 2020 at 07:45:13PM +0200, Igor Mammedov wrote:
> > While testing ACPI cpu hotplug changes I stumbled on BSOD in case
> > QEMU is configured with 256 CPUs, Windows Server 2012R2x64 fails to boot
> > with bugcheck 5C
> > 
> > 
> > qemu-system-x86_64 -m 4G -smp 2,sockets=64,cores=4,maxcpus=256 -M q35,kernel-irqchip=split  -enable-kvm -device intel-iommu,intremap=on,eim=on ws2012r2x64DCchk.qcow2
> > 
> > Looking at stacktrace, it seems that is fails when trying to initialize iommu
> > 
> > hal_interrupt_remapping_setup_failure_nt!initbootprocessor
> > 
> > Any idea what to try to figure out what QEMU is missing wrt intremap?
> > 
> > PS:
> > WS2016 boots eventually, but CPU hotplug doesn't work, symptoms (unconfirmed yet) like SCI isn't being delivered.
> > With RHEL76 the same config works fine.  
> 
> Igor,
> 
> Could you try this again but with vtd tracepoints enabled?
> 
>   -trace enable="vtd_*"
> 
> I think we don't need to capture all the trace outputs, but only until when the
> HAL error message triggered should work.

here is all it outputs.

480969@1594894035.927040:vtd_context_cache_reset 
480969@1594894035.928033:vtd_switch_address_space Device 00:00.0 switching address space (iommu enabled=0)
480969@1594894035.934110:vtd_switch_address_space Device 00:01.0 switching address space (iommu enabled=0)
480969@1594894035.935382:vtd_switch_address_space Device 00:02.0 switching address space (iommu enabled=0)
480969@1594894035.936661:vtd_switch_address_space Device 00:1f.0 switching address space (iommu enabled=0)
480969@1594894035.937957:vtd_switch_address_space Device 00:1f.2 switching address space (iommu enabled=0)
480969@1594894035.939258:vtd_switch_address_space Device 00:1f.3 switching address space (iommu enabled=0)
480969@1594894035.950198:vtd_context_cache_reset 
480969@1594894035.950213:vtd_switch_address_space Device 00:00.0 switching address space (iommu enabled=0)
480969@1594894035.950219:vtd_switch_address_space Device 00:01.0 switching address space (iommu enabled=0)
480969@1594894035.950224:vtd_switch_address_space Device 00:02.0 switching address space (iommu enabled=0)
480969@1594894035.950229:vtd_switch_address_space Device 00:1f.0 switching address space (iommu enabled=0)
480969@1594894035.950234:vtd_switch_address_space Device 00:1f.2 switching address space (iommu enabled=0)
480969@1594894035.950238:vtd_switch_address_space Device 00:1f.3 switching address space (iommu enabled=0)

> 
> Thanks,
> 


