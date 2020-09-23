Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60890C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6A321D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmiNdIzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6A321D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL5af-0006pg-Ne
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 10:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL5YE-0005MP-HX
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL5YA-0002b2-QA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600870513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f55nSkEX1EEVJ4s7cKspxAj2pVy+0V/i+g6+akCxwlM=;
 b=CmiNdIzv+HaUcolmoCNy5b9bSkMUc0AALYgtuTPRW5meLG//r0j2I37xHqlDplGytYZcIu
 VKEYS/2fUlQ8OADxHmpgBDoj/XoIeeY4w7rczOepH7e7Ix1EYIRcWNsCeJujsDAaztR45Y
 RO9+zJwn0Owe7ttvDayjziId5N/CINs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-UlNFSzc1MUSkSyMqTADS5w-1; Wed, 23 Sep 2020 10:15:05 -0400
X-MC-Unique: UlNFSzc1MUSkSyMqTADS5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86D801008542;
 Wed, 23 Sep 2020 14:15:04 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5047C10023A7;
 Wed, 23 Sep 2020 14:15:03 +0000 (UTC)
Date: Wed, 23 Sep 2020 10:15:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Kang, Luwei" <luwei.kang@intel.com>
Subject: Re: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Message-ID: <20200923141502.GO2044576@habkost.net>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
 <20200918220255.GB57321@habkost.net>
 <CY4PR11MB14473A594C244A5B403ADC26803A0@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200921165028.GP57321@habkost.net>
 <CY4PR11MB144737577341CF0A5E8BAD1C80380@CY4PR11MB1447.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB144737577341CF0A5E8BAD1C80380@CY4PR11MB1447.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: "Strong, Beeman" <beeman.strong@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 02:52:50AM +0000, Kang, Luwei wrote:
> > > Hi Eduardo,
> > >     This patch set will remove some limitations of Intel PT CPUID information.
> > >     1. The "IP payloads" feature will disable the Intel PT in guests and it will be
> > coming soon.
> > >     2. To make the live migration safe, we set the Intel PT CPUID as a constant
> > value(Icelake server CPUID). It will mask off the new feature of Intel PT.
> > 
> > Isn't this series doing the opposite of 2?  It replaces all constant CPUID values
> > with kvm_arch_get_supported_cpuid(), making the feature unavailable in
> > migration-safe mode.
> 
> Yes, This series will expose all the HW capabilities to KVM
> guest if the Intel PT is supported in the guest.
> 
> > 
> > Does it mean the plan is to drop intel-pt migration support entirely?
> 
> I don't want to drop intel-pt live migration feature. As
> discussed with you before, the Intel PT feature includes some
> sub-features and may be different on each HW platform. Expose
> all the capabilities to the guest can't make live migration
> safe. Do you have any new proposals?

To support live migration, we need the set of features seen by
the guest be determined only by the input given to QEMU, not host
capabilities.  It can be via:
(1) explicit "-cpu ...,+feat,feat=..." flags;
(2) through data in the CPU model table; or
(3) by hardcoding the same value for all configurations.

The current solution is (3).  (2) is probably the best solution,
with the assumption that the host can always emulate features
from an older CPU in a newer CPU.  If there are features that
can't be emulated if migrating to a newer CPU, a more explicit
configuration mechanism (1) might be better, because not being
able to migrate a VM to newer hardware is inconvenient.

None of those approaches prevent us from implementing passthrough
mode for "-cpu host".  Wouldn't that be preferred instead of
removing support for live migration?

> 
> Thanks,
> Luwei Kang
> 
> > 
> > >
> > >     About this issue https://bugzilla.redhat.com/show_bug.cgi?id=1853972,
> > Intel PT is disabled in the guest by default, we should use "-cpu Icelake-
> > Server,+intel-pt" to enable the Intel PT.
> > 
> > That's correct.  The point of the BZ is that libvirt mode=host-model was
> > expected to include intel-pt automatically when available.  With this series, the
> > request in the BZ stops making sense (because intel-pt won't be migration-safe
> > anymore), but I'm not sure yet that's really the plan.
> > 
> > 
> > >
> > > Thanks,
> > > Luwei Kang
> > >
> > > > -----Original Message-----
> > > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > > Sent: Saturday, September 19, 2020 6:03 AM
> > > > To: Kang, Luwei <luwei.kang@intel.com>
> > > > Cc: pbonzini@redhat.com; rth@twiddle.net; qemu-devel@nongnu.org;
> > > > Strong, Beeman <beeman.strong@intel.com>; Jiri Denemark
> > > > <jdenemar@redhat.com>; Robert Hoo <robert.hu@linux.intel.com>
> > > > Subject: Re: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID
> > > > info
> > > >
> > > > Hi Luwei Kang,
> > > >
> > > > I was looking for info on intel-pt and just saw this series, and it
> > > > was never reviewed or merged (sorry for missing it!).  Is this still
> > > > the approach we want to follow for intel-pt?
> > > >
> > > > I'm CCing Jiri Denemark because this might be relevant for a libvirt
> > > > issue related to intel-pt we were investigating[1].
> > > >
> > > > [1] https://bugzilla.redhat.com/show_bug.cgi?id=1853972
> > > >
> > > >
> > > > On Mon, Mar 30, 2020 at 09:56:09AM +0000, Kang, Luwei wrote:
> > > > > > -----Original Message-----
> > > > > > From: Kang, Luwei <luwei.kang@intel.com>
> > > > > > Sent: Tuesday, February 25, 2020 5:38 AM
> > > > > > To: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com
> > > > > > Cc: qemu-devel@nongnu.org; Strong, Beeman
> > > > <beeman.strong@intel.com>;
> > > > > > Kang, Luwei <luwei.kang@intel.com>
> > > > > > Subject: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID
> > > > > > info
> > > > > >
> > > > > > The Intel PT feature includes some
> > > > > > sub-features(CPUID.(EAX=14H,ECX=0H))
> > > > > > and these sub-features are different on different HW platforms.
> > > > > > To make the live migration safety(get the same CPUID info with
> > > > > > same cpu model on different HW platform), the current Intel PT
> > > > > > CPUID information is set to a constant value(from ICELAKE Server).
> > > > > >
> > > > > > It will block the new feature in the later HW platform. what's
> > > > > > more, the support of "IP payloads" will disable the Intel PT in
> > > > > > KVM guest(patch 1) but it will come soon.
> > > > > >
> > > > > > This patchset remove this limitation and expose all the
> > > > > > capabilities to KVM guest. As it will break the live migration
> > > > > > safe, Intel PT will be masked as unmigratable.
> > > > >
> > > > > Ping.
> > > > >
> > > > > Thanks,
> > > > > Luwei Kang
> > > > >
> > > > > >
> > > > > > Luwei Kang (3):
> > > > > >   i386: Remove the limitation of IP payloads for Intel PT
> > > > > >   i386: Remove the CPUID limitation of Intel PT
> > > > > >   i386: Mark the 'INTEL_PT' CPUID bit as unmigratable
> > > > > >
> > > > > >  target/i386/cpu.c | 69
> > > > > > ++++---------------------------------------------------
> > > > > >  1 file changed, 5 insertions(+), 64 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 1.8.3.1
> > > > >
> > > >
> > > > --
> > > > Eduardo
> > >
> > 
> > --
> > Eduardo
> 

-- 
Eduardo


