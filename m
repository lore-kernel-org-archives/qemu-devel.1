Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A404DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A3523787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDDNK7S1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A3523787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRP8-0002QU-UV
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 09:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLROZ-0001zi-Fa
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLROV-0004lc-GQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600954482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fmQ8XYRNuMaNU72IoRVijqt4RrieToyKUW7N+PC7GsY=;
 b=JDDNK7S1GVp5YFvJPaYs7zdVpjpQ5JqdEWSrc7KvTFIlmfBPIODRZcCktjOUA9As9Omsta
 ThjjANzuHAKQ4YPUFJ0JgWk4OylcaARtdnssPDJ7b21G8zzTXNqHLWAPa7kp7bRZQQG+T+
 ZIpfK6CCWdPJ7fZv1qErcdNFADcphnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-JBWM6m6kN2atIq97t8srsw-1; Thu, 24 Sep 2020 09:34:40 -0400
X-MC-Unique: JBWM6m6kN2atIq97t8srsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89CCFAF232;
 Thu, 24 Sep 2020 13:34:31 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04999105DFBC;
 Thu, 24 Sep 2020 13:34:30 +0000 (UTC)
Date: Thu, 24 Sep 2020 09:34:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Kang, Luwei" <luwei.kang@intel.com>
Subject: Re: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Message-ID: <20200924133430.GB3717385@habkost.net>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
 <20200918220255.GB57321@habkost.net>
 <CY4PR11MB14473A594C244A5B403ADC26803A0@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200921165028.GP57321@habkost.net>
 <CY4PR11MB144737577341CF0A5E8BAD1C80380@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200923141502.GO2044576@habkost.net>
 <CY4PR11MB1447BE049AD2F43295C969D680390@CY4PR11MB1447.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB1447BE049AD2F43295C969D680390@CY4PR11MB1447.namprd11.prod.outlook.com>
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
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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

On Thu, Sep 24, 2020 at 12:47:04PM +0000, Kang, Luwei wrote:
> > > > > Hi Eduardo,
> > > > >     This patch set will remove some limitations of Intel PT CPUID
> > information.
> > > > >     1. The "IP payloads" feature will disable the Intel PT in
> > > > > guests and it will be
> > > > coming soon.
> > > > >     2. To make the live migration safe, we set the Intel PT CPUID
> > > > > as a constant
> > > > value(Icelake server CPUID). It will mask off the new feature of Intel PT.
> > > >
> > > > Isn't this series doing the opposite of 2?  It replaces all constant
> > > > CPUID values with kvm_arch_get_supported_cpuid(), making the feature
> > > > unavailable in migration-safe mode.
> > >
> > > Yes, This series will expose all the HW capabilities to KVM guest if
> > > the Intel PT is supported in the guest.
> > >
> > > >
> > > > Does it mean the plan is to drop intel-pt migration support entirely?
> > >
> > > I don't want to drop intel-pt live migration feature. As discussed
> > > with you before, the Intel PT feature includes some sub-features and
> > > may be different on each HW platform. Expose all the capabilities to
> > > the guest can't make live migration safe. Do you have any new
> > > proposals?
> > 
> > To support live migration, we need the set of features seen by the guest be
> > determined only by the input given to QEMU, not host capabilities.  It can be
> > via:
> > (1) explicit "-cpu ...,+feat,feat=..." flags;
> > (2) through data in the CPU model table; or
> > (3) by hardcoding the same value for all configurations.
> > 
> > The current solution is (3).  (2) is probably the best solution, with the
> > assumption that the host can always emulate features from an older CPU in a
> > newer CPU.  If there are features that can't be emulated if migrating to a
> > newer CPU, a more explicit configuration mechanism (1) might be better,
> > because not being able to migrate a VM to newer hardware is inconvenient.
> > 
> > None of those approaches prevent us from implementing passthrough mode
> > for "-cpu host".  Wouldn't that be preferred instead of removing support for
> > live migration?
> 
> Thanks for the comments and suggestions. I think the newer CPU
> includes all the features of the older CPU, but no document
> have such statement. To make sure it can work in all the cases,
> the solution (1) might be better.

Maybe (2) is still viable, as long as there are no expectations
that features will be removed in future hardware.  Compatibility
with future hardware in (2) is more about convenience, not a hard
a requirement.

In either case, (1) is the building block for making (2) work.
This means we can start by implementing (1), and see if we can
include features in new CPU models later.

> The Intel PT virtualization first supported on Icelake and we
> can use this CPUID as basic CPUID information. Any new feature
> which supports on the newer CPUs can be added by "-cpu
> ...,+feat,feat=...". What is your opinion?

Sounds good to me.  I would also make intel-pt passthrough work
if using "-cpu host" and/or an explicit "intel-pt-passthrough=on"
option.

-- 
Eduardo


