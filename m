Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDADC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 19:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA09208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 19:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQ7QI9vZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA09208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQaJ-0001Sd-QX
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 15:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOQZk-00012B-6l
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 15:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOQZh-0006Ts-QC
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 15:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601666316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q5GxtpuLWLAL4izMPrSg6uB1Nabi4plFqbKLsjIjIq8=;
 b=FQ7QI9vZuBvJNJzAhDZAhOkfZHmPEhUDzdbwSXZMCy8H1Qzp0oh/FNi4EgSD/LYVatG0bM
 QuF2kPGFiPAwtQMl6efqfHkyMd74pd2P5hb15HihWEsdFfapOOwkow4kYY0xsp13GsjMA0
 2yXhqcFVPzVGgjwrFkp652p7LgDW2fY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-5imWPGZzMUWu-nHaAa2olw-1; Fri, 02 Oct 2020 15:18:33 -0400
X-MC-Unique: 5imWPGZzMUWu-nHaAa2olw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79BC1807330;
 Fri,  2 Oct 2020 19:18:32 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EBDB5D9D3;
 Fri,  2 Oct 2020 19:18:31 +0000 (UTC)
Date: Fri, 2 Oct 2020 15:18:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/8] docs: tweak kernel-doc for QEMU coding standards
Message-ID: <20201002191831.GH7303@habkost.net>
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <20191129140217.17797-3-pbonzini@redhat.com>
 <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
 <20201002183455.GF7303@habkost.net>
 <CAFEAcA_KXvADFm7uQX1a4peofK_On3DaFH2ZCUtWteaiABM-yA@mail.gmail.com>
 <20201002184608.GG7303@habkost.net>
 <e63e073b-31b3-590d-2f9b-e871c9677448@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e63e073b-31b3-590d-2f9b-e871c9677448@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 08:50:22PM +0200, Paolo Bonzini wrote:
> On 02/10/20 20:46, Eduardo Habkost wrote:
> > This is not the code that parses "#MemoryRegionSection", it is
> > the code that parses:
> > 
> > /**
> >  * MemoryRegionSection: describes a fragment of a #MemoryRegion
> >    ^^^^^^^ this line
> 
> We can probably just adjust the comments to include the "struct" keyword
> first.  There aren't that many, (un)fortunately.
> 
> It may even be possible to print to stderr the file and line number so
> that the script tells us where the hack is firing.
> 

There are 3 lines where the hack is correctly triggered, but we
can just change it to use "struct MyTypeName" instead:

include/exec/memory.h:681: HERE
include/exec/memory.h:699: HERE
include/exec/memory.h:743: HERE

And 29 lines where it's probably being triggered by mistake:

include/qom/object.h:47: HERE
include/qom/object.h:66: HERE
include/qom/object.h:78: HERE
include/qom/object.h:87: HERE
include/qom/object.h:110: HERE
include/qom/object.h:118: HERE
include/qom/object.h:140: HERE
include/qom/object.h:162: HERE
include/qom/object.h:179: HERE
include/qom/object.h:200: HERE
include/qom/object.h:218: HERE
include/qom/object.h:241: HERE
include/qom/object.h:259: HERE
include/qom/object.h:313: HERE
include/qom/object.h:330: HERE
include/qom/object.h:353: HERE
include/qom/object.h:370: HERE
include/qom/object.h:432: HERE
include/qom/object.h:442: HERE
include/qom/object.h:452: HERE
include/qom/object.h:469: HERE
include/qom/object.h:483: HERE
include/qom/object.h:496: HERE
include/qom/object.h:506: HERE
include/qom/object.h:521: HERE
include/qom/object.h:531: HERE
include/qom/object.h:543: HERE
include/qom/object.h:861: HERE

-- 
Eduardo


