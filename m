Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE895C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5314206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZMc0cue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5314206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnITg-0003Vi-UO
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnISd-0002sm-Ur
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:09:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnISb-0006kj-Ib
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816988;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHjtREysJc4CmQKvOmx6dIBNDYuHnka3AwW0ds/rfSU=;
 b=IZMc0cueKjqLz0ob8nUhQZ04YQppTm3oVnS6f4tt49D69TYgbWWPgeoRggnq1aDnf0wR38
 hVyh6GW6l/DdOxhvk75pUTA3u0uQGfIGW56Q+/pBhQS90vjUMYc1H3hhQKqktbK+MgYVhA
 mSmG5P/EM8EsjQSO6A2mqNHnTKnwZ1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-oG97Q2aXO6-kmmgE-sV6nw-1; Mon, 22 Jun 2020 05:09:46 -0400
X-MC-Unique: oG97Q2aXO6-kmmgE-sV6nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43A1683DE2E;
 Mon, 22 Jun 2020 09:09:44 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D638C5C221;
 Mon, 22 Jun 2020 09:09:33 +0000 (UTC)
Date: Mon, 22 Jun 2020 10:09:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 9/9] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200622090930.GB736373@redhat.com>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-10-david@gibson.dropbear.id.au>
 <20200619101245.GC700896@redhat.com>
 <20200619144541.GM17085@umbus.fritz.box>
 <20200619150556.GW700896@redhat.com>
 <20200620082427.GP17085@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200620082427.GP17085@umbus.fritz.box>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 20, 2020 at 06:24:27PM +1000, David Gibson wrote:
> On Fri, Jun 19, 2020 at 04:05:56PM +0100, Daniel P. Berrangé wrote:
> > On Sat, Jun 20, 2020 at 12:45:41AM +1000, David Gibson wrote:
> > > On Fri, Jun 19, 2020 at 11:12:45AM +0100, Daniel P. Berrangé wrote:
> > > > On Fri, Jun 19, 2020 at 12:06:02PM +1000, David Gibson wrote:
> > > > > The default behaviour for virtio devices is not to use the platforms normal
> > > > > DMA paths, but instead to use the fact that it's running in a hypervisor
> > > > > to directly access guest memory.  That doesn't work if the guest's memory
> > > > > is protected from hypervisor access, such as with AMD's SEV or POWER's PEF.
> > > > > 
> > > > > So, if a host trust limitation mechanism is enabled, then apply the
> > > > > iommu_platform=on option so it will go through normal DMA mechanisms.
> > > > > Those will presumably have some way of marking memory as shared with the
> > > > > hypervisor or hardware so that DMA will work.
> > > > > 
> > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > ---
> > > > >  hw/core/machine.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index a71792bc16..8dfc1bb3f8 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -28,6 +28,8 @@
> > > > >  #include "hw/mem/nvdimm.h"
> > > > >  #include "migration/vmstate.h"
> > > > >  #include "exec/host-trust-limitation.h"
> > > > > +#include "hw/virtio/virtio.h"
> > > > > +#include "hw/virtio/virtio-pci.h"
> > > > >  
> > > > >  GlobalProperty hw_compat_5_0[] = {
> > > > >      { "virtio-balloon-device", "page-poison", "false" },
> > > > > @@ -1165,6 +1167,15 @@ void machine_run_board_init(MachineState *machine)
> > > > >           * areas.
> > > > >           */
> > > > >          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> > > > > +
> > > > > +        /*
> > > > > +         * Virtio devices can't count on directly accessing guest
> > > > > +         * memory, so they need iommu_platform=on to use normal DMA
> > > > > +         * mechanisms.  That requires disabling legacy virtio support
> > > > > +         * for virtio pci devices
> > > > > +         */
> > > > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy", "on");
> > > > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platform", "on");
> > > > >      }
> > > > 
> > > > Silently changing the user's request configuration like this
> > > 
> > > It doesn't, though.  register_sugar_prop() effectively registers a
> > > default, so if the user has explicitly specified something, that will
> > > take precedence.
> > 
> > Don't assume that the user has set "disable-legacy=off". People who want to
> > have a transtional device are almost certainly pasing "-device virtio-blk-pci",
> > because historical behaviour is that this is sufficient to give you a
> > transitional device. Changing the default of disable-legacy=on has not
> > honoured the users' requested config.
> 
> Umm.. by this argument we can never change any default, ever.  But we
> do that routinely with new machine versions.  How is changing based on
> a machine option different from that?

It isn't really different. Most of the time we get away with it and no one
sees a problem. Some of the changes made though, do indeed break things,
and libvirt tries to override QEMU's changes in defaults where they are
especially at risk of causing breakage. The virtio device model is one such
change I'd consider especially risky as there are clear guest OS driver
support compatibility issues there, with it being a completely different
PCI device ID & impl.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


