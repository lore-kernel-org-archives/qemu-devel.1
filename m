Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908F9C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5444A2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5444A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyfXb-000880-Ev
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1hyfWt-0007UJ-AS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hyfWr-0007cW-Sm
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hyfWr-0007bm-Jn
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:56:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DB81796E0;
 Fri, 16 Aug 2019 16:56:40 +0000 (UTC)
Received: from localhost (ovpn-116-32.gru2.redhat.com [10.97.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C4C384278;
 Fri, 16 Aug 2019 16:56:36 +0000 (UTC)
Date: Fri, 16 Aug 2019 13:56:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190816165635.GC3908@habkost.net>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-4-ehabkost@redhat.com>
 <20190816152011.0c673027@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816152011.0c673027@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 16 Aug 2019 16:56:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] pc: Don't make CPU properties
 mandatory unless necessary
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
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 03:20:11PM +0200, Igor Mammedov wrote:
> On Thu, 15 Aug 2019 15:38:03 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > We have this issue reported when using libvirt to hotplug CPUs:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1741451
> > 
> > Basically, libvirt is not copying die-id from
> > query-hotpluggable-cpus, but die-id is now mandatory.
> 
> this should have been gated on compat property and affect
> only new machine types.
> Maybe we should do just that instead of fixup so libvirt
> would finally make proper handling of query-hotpluggable-cpus.
> 
>  
> > We could blame libvirt and say it is not following the documented
> > interface, because we have this buried in the QAPI schema
> > documentation:
> 
> I wouldn't say buried, if I understand it right QAPI schema
> should be the authoritative source of interface description.
> 
> If I recall it's not the first time, there was similar issue
> for exactly the same reason (libvirt not passing through
> all properties from query-hotpluggable-cpus).
> 
> And we had to fix it up on QEMU side (numa_cpu_pre_plug),
> but it seems 2 years later libvirt is still broken the same way :(
> 
> Should we really do fixups or finaly fix it on libvirt side?

Is it truly a bug in libvirt?  Making QEMU behave differently
when getting exactly the same input sounds like a bad idea, even
if we documented that at the QAPI documentation.

My suggestion is to instead drop the comment below from the QAPI
documentation.  New properties shouldn't become mandatory.

>  
> > > Note: currently there are 5 properties that could be present
> > > but management should be prepared to pass through other
> > > properties with device_add command to allow for future
> > > interface extension. This also requires the filed names to be kept in
> > > sync with the properties passed to -device/device_add.  
> > 
> > But I don't think this would be reasonable from us.  We can just
> > make QEMU more flexible and let CPU properties to be omitted when
> > there's no ambiguity.  This will allow us to keep compatibility
> > with existing libvirt versions.
> 
> I don't really like making rule from exceptions so I'd suggest doing
> it only for  die_id if we have to do fix it up (with fat comment
> like in numa_cpu_pre_plug).
> The rest are working fine as is.

I will insist we make it consistent for all properties, but I
don't want this discussion to hold the bug fix.  So I'll do this:

I will submit a new patch that makes only die-id optional, and CC
qemu-stable.

After that, i will submit this patch again, and we can discuss
whether we should make all properties optional.

-- 
Eduardo

