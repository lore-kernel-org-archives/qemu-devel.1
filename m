Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D04C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB8420644
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB8420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjEh-0001sV-6O
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:37:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1hOjD2-0000ZT-Kt
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1hOjD1-0000Qw-Ld
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:35:40 -0400
Received: from smtp.vivo.cz ([185.219.166.8]:49744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1hOjD1-0000Kl-EU
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:35:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.vivo.cz (Postfix) with ESMTP id 073CF1843346;
	Thu,  9 May 2019 15:35:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vivo.cz
Received: from smtp.vivo.cz ([127.0.0.1])
	by localhost (smtp.vivo.cz [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4MDpeqNJYqSu; Thu,  9 May 2019 15:35:35 +0200 (CEST)
Received: from orkuz.int.mamuti.net (185-219-164-37-static.vivo.cz
	[185.219.164.37])
	by smtp.vivo.cz (Postfix) with ESMTPS id 173011843342;
	Thu,  9 May 2019 15:35:35 +0200 (CEST)
Received: by orkuz.int.mamuti.net (Postfix, from userid 500)
	id 321C92A29C5; Thu,  9 May 2019 15:35:37 +0200 (CEST)
Date: Thu, 9 May 2019 15:35:37 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190509133537.GK7181@orkuz.int.mamuti.net>
References: <20190422234742.15780-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422234742.15780-1-ehabkost@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.219.166.8
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

On Mon, Apr 22, 2019 at 20:47:40 -0300, Eduardo Habkost wrote:
> Currently, libvirt uses the "filtered-features" QOM property at
> runtime to ensure no feature was accidentally disabled on VCPUs
> because it's not available on the host.
> 
> However, the code for "feature-words" assumes that all missing
> features have a corresponding CPUID bit, which is not true for
> MSR-based features like the ones at FEAT_ARCH_CAPABILITIES.
> 
> We could extend X86CPUFeatureWordInfo to include information
> about MSR features, but it's impossible to do that while keeping
> compatibility with clients that (reasonably) expect all elements
> of "filtered-features" to have the cpuid-* fields.
> 
> We have a field in "query-cpu-definitions" that already describes
> all features that are missing on a CPU, including MSR features:
> CpuDefinitionInfo.unavailable-features.  The existing code for
> building the unavailable-features array even uses
> X86CPU::filtered_features to build the feature list.
> 
> This series adds a "unavailable-features" QOM property to X86CPU
> objects that have the same semantics of "unavailable-features" on
> query-cpu-definitions.  The new property has the same goal of
> "filtered-features", but is generic enough to let any kind of CPU
> feature to be listed there without relying on low level details
> like CPUID leaves or MSR numbers.

Thanks.

Would this unavailable-features property contain only canonical names of
the features or all possible aliases of all features? For example,
"tsc-adjust" can also be spelled as "tsc_adjust". When calling
query-cpu-model-expansion, we have a way to request all variants by
running full expansion on the result of a previous static expansion. Can
we get something like this for unavailable-features too?

As you mentioned, there are two interesting QOM properties:
filtered-features and feature-words and both are used by libvirt. We use
feature-words to get CPU features which were enabled in the guest CPU on
top of what we expected. This is the case of, e.g., a feature added to a
given CPU model for new machine types. I guess we could switch to
checking QOM properties for individual features as a replacement for
feature-words which covers both CPUID and MSR features.

Jirka

