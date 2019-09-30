Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27844C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26BF20679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26BF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEwP9-0002aK-25
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iEwOP-0002Ay-JE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iEwOO-0006I2-0X
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:11:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iEwON-0006HV-OG
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:11:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 380AD368DA;
 Mon, 30 Sep 2019 14:11:10 +0000 (UTC)
Received: from localhost (ovpn-116-88.gru2.redhat.com [10.97.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 234E01001B05;
 Mon, 30 Sep 2019 14:11:05 +0000 (UTC)
Date: Mon, 30 Sep 2019 11:11:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
Message-ID: <20190930141104.GA4084@habkost.net>
References: <20190926214305.17690-1-ehabkost@redhat.com>
 <20190930102453.GO4884@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930102453.GO4884@orkuz.int.mamuti.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 30 Sep 2019 14:11:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: thomas.lendacky@amd.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 libvir-list@redhat.com, qemu-devel@nongnu.org, luwei.kang@intel.com,
 Robert Hoo <robert.hu@linux.intel.com>, kai.huang@intel.com,
 robert.hu@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing qemu-devel and QEMU developers.

On Mon, Sep 30, 2019 at 12:24:53PM +0200, Jiri Denemark wrote:
> On Thu, Sep 26, 2019 at 18:43:05 -0300, Eduardo Habkost wrote:
> > The pconfig feature never worked, and adding "pconfig=off" to the
> > QEMU command-line triggers a regression in QEMU 3.1.1 and 4.0.0.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > I'm sending this as an RFC because I couldn't test it properly,
> > and because I don't know what are the consequences of changing
> > cpu_map between libvirt versions.
> > ---
> >  src/cpu_map/x86_Icelake-Server.xml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/cpu_map/x86_Icelake-Server.xml b/src/cpu_map/x86_Icelake-Server.xml
> > index fb15977a59..188a781282 100644
> > --- a/src/cpu_map/x86_Icelake-Server.xml
> > +++ b/src/cpu_map/x86_Icelake-Server.xml
> > @@ -56,7 +56,9 @@
> >      <feature name='pat'/>
> >      <feature name='pcid'/>
> >      <feature name='pclmuldq'/>
> > -    <feature name='pconfig'/>
> > +    <!-- 'pconfig' was added by accident in QEMU 3.1.0 but never worked.
> > +         It was removed in QEMU 3.1.1 and 4.0.0.  See QEMU commits
> > +         76e5a4d58357 and 712f807e1965 for details -->
> >      <feature name='pdpe1gb'/>
> >      <feature name='pge'/>
> >      <feature name='pku'/>
> 
> IIUC this never worked and a domain started with Icelake-Server CPU
> model would actually end up running with pconfig=off, right? In that
> case removing pconfig from Icelake-Server would not cause any issues
> when a domain is started. However, I'm afraid migration would be broken.
> 
> If a domain is started by new libvirt (with this patch in) using
> Icelake-Server CPU model possibly with additional features added or
> removed, but without pconfig being explicitly mentioned, libvirt would
> not disable pconfig when updating active definition according to the
> actual CPU created by QEMU. This is because libvirt did not ask for
> pconfig (either explicitly or implicitly via the CPU model). When such
> domain gets migrated to an older libvirt (which thinks pconfig is part
> of Icelake-Server), it will complain that QEMU disabled pconfig while
> the source domain was running with pconfig enabled (which is an
> incorrect result caused by inconsistent view of the CPU model).
> 
> Thus we would need to add a hack which would explicitly disable pconfig
> in the domain definition used for migration to make sure the destination
> libvirtd knows pconfig was disabled. New libvirt would just drop the
> disabled pconfig feature from the CPU definition before starting a
> domain.
> 
> [1] From this point of view we could just keep the CPU model in libvirt
> untouched. This way pconfig would always be explicitly disabled when a
> domain is running and the host-model CPU definition would also show it
> as explicitly disabled.
> 
> [2] However starting a domain with Icelake-Server so that it can be
> migrated or saved/restored on QEMU in 3.1.1 and 4.0.0 would be
> impossible. This can be solved by a different hack, which would drop
> pconfig=off from QEMU command line.
> 
> [3] But if pconfig was removed from QEMU and never returned back, we
> could remove it from any domain XML we see (virQEMUCapsCPUFilterFeatures
> mentions several other features which we handle this way).
> 
> That said, I think [3] would be the best option. But if QEMU cannot or
> doesn't want to remove pconfig completely, I'd go with [1] as the hack
> in [2] would be too ugly and confusing.

From the QEMU side, [3] is better, as pconfig was added by
accident in 3.1.0 and it would be simpler to not re-add it.

This might be a problem if there are plans to eventually make KVM
support pconfig, though.  Paolo, Robert, are there plans to
support pconfig in KVM in the future?

-- 
Eduardo

