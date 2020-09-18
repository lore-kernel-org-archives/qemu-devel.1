Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43BEC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E1220DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N33YTEUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E1220DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOUM-0003YB-7D
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOTA-0002fD-NT
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOT8-0006kF-2e
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600466580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6JlkMsRyTBEKtSE7cplv2wA5eYoduFAZQZPmEv6ha00=;
 b=N33YTEUpK2wV787Xk30CfXoF72/cpwOEpg8KMQH+MI+CayKc+d81V8q8ioKfufAGhuvLbg
 prMPCAnFvVkCIiZmDdI9zkGqPcN5WnnvkKeIpWynZsQdQ/+seEugZ0lN47WkL6ROunSz53
 MTyQz2QGvkLj33o+5s1SD6v3S03sdBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-PTFOF6XCPpKjH9GYTuY59w-1; Fri, 18 Sep 2020 18:02:58 -0400
X-MC-Unique: PTFOF6XCPpKjH9GYTuY59w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0641580732A;
 Fri, 18 Sep 2020 22:02:57 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F43973678;
 Fri, 18 Sep 2020 22:02:56 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:02:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Kang, Luwei" <luwei.kang@intel.com>
Subject: Re: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Message-ID: <20200918220255.GB57321@habkost.net>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

Hi Luwei Kang,

I was looking for info on intel-pt and just saw this series, and
it was never reviewed or merged (sorry for missing it!).  Is this
still the approach we want to follow for intel-pt?

I'm CCing Jiri Denemark because this might be relevant for a
libvirt issue related to intel-pt we were investigating[1].

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1853972


On Mon, Mar 30, 2020 at 09:56:09AM +0000, Kang, Luwei wrote:
> > -----Original Message-----
> > From: Kang, Luwei <luwei.kang@intel.com>
> > Sent: Tuesday, February 25, 2020 5:38 AM
> > To: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com
> > Cc: qemu-devel@nongnu.org; Strong, Beeman <beeman.strong@intel.com>;
> > Kang, Luwei <luwei.kang@intel.com>
> > Subject: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
> > 
> > The Intel PT feature includes some sub-features(CPUID.(EAX=14H,ECX=0H))
> > and these sub-features are different on different HW platforms. To make the
> > live migration safety(get the same CPUID info with same cpu model on
> > different HW platform), the current Intel PT CPUID information is set to a
> > constant value(from ICELAKE Server).
> > 
> > It will block the new feature in the later HW platform. what's more, the support
> > of "IP payloads" will disable the Intel PT in KVM guest(patch 1) but it will come
> > soon.
> > 
> > This patchset remove this limitation and expose all the capabilities to KVM
> > guest. As it will break the live migration safe, Intel PT will be masked as
> > unmigratable.
> 
> Ping.
> 
> Thanks,
> Luwei Kang
> 
> > 
> > Luwei Kang (3):
> >   i386: Remove the limitation of IP payloads for Intel PT
> >   i386: Remove the CPUID limitation of Intel PT
> >   i386: Mark the 'INTEL_PT' CPUID bit as unmigratable
> > 
> >  target/i386/cpu.c | 69 ++++---------------------------------------------------
> >  1 file changed, 5 insertions(+), 64 deletions(-)
> > 
> > --
> > 1.8.3.1
> 

-- 
Eduardo


