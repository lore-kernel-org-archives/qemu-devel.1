Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C1C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430E922296
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430E922296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQ87-0006Fy-Fi
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hvQ7R-0005Rm-QQ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hvQ7Q-00075M-PD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hvQ7Q-00072l-KC; Wed, 07 Aug 2019 13:53:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9D4E3D962;
 Wed,  7 Aug 2019 17:52:58 +0000 (UTC)
Received: from localhost (ovpn-121-66.rdu2.redhat.com [10.10.121.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC625600CC;
 Wed,  7 Aug 2019 17:52:57 +0000 (UTC)
Date: Wed, 7 Aug 2019 14:52:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190807175256.GD4669@habkost.net>
References: <20190805071302.6260-1-tao3.xu@intel.com>
 <20190806145055.4f645f60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806145055.4f645f60@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 07 Aug 2019 17:52:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] numa: Introduce
 MachineClass::auto_enable_numa for implicit NUMA node
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
Cc: Tao Xu <tao3.xu@intel.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 06, 2019 at 02:50:55PM +0200, Igor Mammedov wrote:
> On Mon,  5 Aug 2019 15:13:02 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
> > Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
> > is expected to be created implicitly.
> > 
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Tao Xu <tao3.xu@intel.com>
[...]
> > +    mc->auto_enable_numa = true;
> 
> this will always create a numa node (that will affect not only RAM but
> also all other components that depends on numa state (like CPUs)),
> where as spapr_populate_memory() was only faking numa node in DT for RAM.
> It makes non-numa configuration impossible.
> Seeing David's ACK on the patch it might be fine, but I believe
> commit message should capture that and explain why the change in
> behavior is fine.

After a quick look, all spapr code seems to have the same
behavior when nb_numa_nodes==0 and nb_numa_nodes==1, but I'd like
to be sure.

David and/or Tao Xu: do you confirm there's no ABI change at all
on spapr after implicitly creating a NUMA node?

> 
> >      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
> >      smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 2eb9a0b4e0..4a350b87d2 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -220,6 +220,7 @@ struct MachineClass {
> >      bool smbus_no_migration_support;
> >      bool nvdimm_supported;
> >      bool numa_mem_supported;
> > +    bool auto_enable_numa;
> >  
> >      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> >                                             DeviceState *dev);
> 

-- 
Eduardo

