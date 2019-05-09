Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E7C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199F420675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199F420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54969 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjXx-0003ic-Cx
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:57:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOjX6-0003Iy-G6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOjX5-0006k9-Cz
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:56:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hOjX5-0006jx-5H
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62EC181243;
	Thu,  9 May 2019 13:56:20 +0000 (UTC)
Received: from localhost (ovpn-116-61.gru2.redhat.com [10.97.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E43CC600C7;
	Thu,  9 May 2019 13:56:19 +0000 (UTC)
Date: Thu, 9 May 2019 10:56:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20190509135617.GH4189@habkost.net>
References: <20190422234742.15780-1-ehabkost@redhat.com>
	<20190509133537.GK7181@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509133537.GK7181@orkuz.int.mamuti.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 09 May 2019 13:56:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] i386: "unavailable-features" QOM
 property
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 03:35:37PM +0200, Jiri Denemark wrote:
> On Mon, Apr 22, 2019 at 20:47:40 -0300, Eduardo Habkost wrote:
> > Currently, libvirt uses the "filtered-features" QOM property at
> > runtime to ensure no feature was accidentally disabled on VCPUs
> > because it's not available on the host.
> > 
> > However, the code for "feature-words" assumes that all missing
> > features have a corresponding CPUID bit, which is not true for
> > MSR-based features like the ones at FEAT_ARCH_CAPABILITIES.
> > 
> > We could extend X86CPUFeatureWordInfo to include information
> > about MSR features, but it's impossible to do that while keeping
> > compatibility with clients that (reasonably) expect all elements
> > of "filtered-features" to have the cpuid-* fields.
> > 
> > We have a field in "query-cpu-definitions" that already describes
> > all features that are missing on a CPU, including MSR features:
> > CpuDefinitionInfo.unavailable-features.  The existing code for
> > building the unavailable-features array even uses
> > X86CPU::filtered_features to build the feature list.
> > 
> > This series adds a "unavailable-features" QOM property to X86CPU
> > objects that have the same semantics of "unavailable-features" on
> > query-cpu-definitions.  The new property has the same goal of
> > "filtered-features", but is generic enough to let any kind of CPU
> > feature to be listed there without relying on low level details
> > like CPUID leaves or MSR numbers.
> 
> Thanks.
> 
> Would this unavailable-features property contain only canonical names of
> the features or all possible aliases of all features? For example,
> "tsc-adjust" can also be spelled as "tsc_adjust". When calling
> query-cpu-model-expansion, we have a way to request all variants by
> running full expansion on the result of a previous static expansion. Can
> we get something like this for unavailable-features too?

I'd like to avoid that, and refer only to the canonical names.

Could you explain the use case you have in mind, so we can look
for alternatives?

> 
> As you mentioned, there are two interesting QOM properties:
> filtered-features and feature-words and both are used by libvirt. We use
> feature-words to get CPU features which were enabled in the guest CPU on
> top of what we expected. This is the case of, e.g., a feature added to a
> given CPU model for new machine types. I guess we could switch to
> checking QOM properties for individual features as a replacement for
> feature-words which covers both CPUID and MSR features.

I guess it depends on your goal:

If your just want to know if one specific feature is missing for
some reason, you can check the QOM properties directly.  That's
OK, and it's even better than checking the `feature-words`
property.

If you want to be 100% sure no property was missing when starting
the VM (e.g. emulate the behavior of the "enforce" option), I
suggest you check if `unavailable-features` is empty.

-- 
Eduardo

