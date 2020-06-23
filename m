Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4D6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE2C20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TESDFVt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE2C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkNp-0000rt-Ee
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkN2-0008Fb-AT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:57:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkMz-00041s-Jl
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592924271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ln6zJ88iUGTIU6r6jTf+TWHLI5pi2HzvneyDOhOkc1k=;
 b=TESDFVt977CkpjyyS3OdrPZSRNBZ169nL965cvnnyYfIdAfmXqPqz5LYzrtzuowzBDl8rq
 5ryzLPBKDcojCoTVFxNzSCuM3Qg7xG10WFnc8FUxxBtx99VLXj1O6+d1JZeIr//H5e8T7a
 wNQlxIVxTh5XTFSHnkDzp5WgXEHBEwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-tb_hr60hNOKE6RYhnu65vw-1; Tue, 23 Jun 2020 10:57:47 -0400
X-MC-Unique: tb_hr60hNOKE6RYhnu65vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 942B11005513;
 Tue, 23 Jun 2020 14:57:46 +0000 (UTC)
Received: from localhost (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7E0B60CD3;
 Tue, 23 Jun 2020 14:57:42 +0000 (UTC)
Date: Tue, 23 Jun 2020 16:57:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/3] hyperv: vmbus: ACPI various corrections
Message-ID: <20200623165741.5acc1dc6@redhat.com>
In-Reply-To: <e467716d-19cb-ffec-b464-494e975463e3@redhat.com>
References: <20200617160904.681845-1-arilou@gmail.com>
 <e467716d-19cb-ffec-b464-494e975463e3@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rvkagan@yandex-team.ru, vkuznets@redhat.com, mail@maciej.szmigiero.name,
 Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 12:02:40 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 17/06/20 18:09, Jon Doron wrote:
> > After doing further tests and looking at the latest HyperV ACPI DSDT.
> > Do minor fix to our VMBus ACPI entry.
> > 
> > v2:
> > Renamed irq0 to irq now that there is a single IRQ required
> > 
> > Jon Doron (3):
> >   hyperv: vmbus: Remove the 2nd IRQ
> >   i386: acpi: vmbus: Add _ADR definition
> >   acpi: i386: Move VMBus DSDT entry to SB
> > 
> >  dtc                              |  2 +-
> >  hw/hyperv/vmbus.c                |  3 +--
> >  hw/i386/acpi-build.c             | 17 +++++++++--------
> >  include/hw/hyperv/vmbus-bridge.h |  3 +--
> >  4 files changed, 12 insertions(+), 13 deletions(-)
> >   
> 
> Queued, thanks.
> 
> Paolo
> 
> 

Paolo, there is a newer vesion on list
and I don't think _ADR patch should be applied at all


