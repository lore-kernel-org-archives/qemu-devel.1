Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4181FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AD5207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8TEpczK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AD5207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIhR-0001Ob-Mj
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGIg9-0008Gr-5J
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:15:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGIg6-0005f8-3C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599729337;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4LhbyuqlF5S6rmEVd7X2hXE/FDCj8fqPB7MayxFhdk=;
 b=A8TEpczKA1ro7p6GoZA1IxbfYh2K71LzX6OvH1UJ0vN5PMLaDX+lpTP4g5cPqWnR/XJoub
 8zgjEYSSScAi+rMWqQXFj6LaMtfIBgV3kDYc51d8hEMuL28KoTXlon0jm43lRYp7EbwTSF
 8OEPWd/Yn62qy8LwUTv8+Rq1Z/7qza4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-j17T7367PC2YHoZh06ZP8g-1; Thu, 10 Sep 2020 05:15:09 -0400
X-MC-Unique: j17T7367PC2YHoZh06ZP8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A0481091061;
 Thu, 10 Sep 2020 09:15:07 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA18960C07;
 Thu, 10 Sep 2020 09:14:56 +0000 (UTC)
Date: Thu, 10 Sep 2020 10:14:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/6] hw/pci-host/q35: Rename PCI 'black hole as '(memory)
 hole'
Message-ID: <20200910091454.GE1083348@redhat.com>
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-6-philmd@redhat.com>
 <7dbdef90-1ca6-bf27-7084-af0c716d01d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dbdef90-1ca6-bf27-7084-af0c716d01d9@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 09:15:02AM +0200, Thomas Huth wrote:
> On 10/09/2020 09.01, Philippe Mathieu-Daudé wrote:
> > In order to use inclusive terminology, rename "blackhole"
> > as "(memory)hole".
> 
> A black hole is a well-known astronomical term, which is simply named
> that way since it absorbes all light. I doubt that anybody could get
> upset by this term?

In this particular case I think the change is the right thing to do
simply because the astronomical analogy is not adding any value in
understanding. Calling it a "memoryhole" is more descriptive in what
is actually is.

> 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> >  include/hw/pci-host/q35.h |  4 ++--
> >  hw/pci-host/q35.c         | 38 +++++++++++++++++++-------------------
> >  tests/qtest/q35-test.c    |  2 +-
> >  3 files changed, 22 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> > index 070305f83df..0fb90aca18b 100644
> > --- a/include/hw/pci-host/q35.h
> > +++ b/include/hw/pci-host/q35.h
> > @@ -48,8 +48,8 @@ typedef struct MCHPCIState {
> >      PAMMemoryRegion pam_regions[13];
> >      MemoryRegion smram_region, open_high_smram;
> >      MemoryRegion smram, low_smram, high_smram;
> > -    MemoryRegion tseg_blackhole, tseg_window;
> > -    MemoryRegion smbase_blackhole, smbase_window;
> > +    MemoryRegion tseg_hole, tseg_window;
> > +    MemoryRegion smbase_hole, smbase_window;
> 
> Maybe rather use smbase_memhole and tseg_memhole?
> 
>  Thomas
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


