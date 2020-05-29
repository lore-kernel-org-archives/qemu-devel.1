Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 22:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C56207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 22:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C56207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jenMr-0005f1-Mt
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 18:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1jenLn-0004xn-Kz; Fri, 29 May 2020 18:19:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:38610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1jenLk-0004GB-KW; Fri, 29 May 2020 18:19:38 -0400
IronPort-SDR: PNgEdyY2gAeNVs6qnbsHe3ImsnjY7Mcg7BsAAXyxc8C7UuHe01kONWwU2UG7IFZ1wpqaurcTP5
 X2X//WYQ3hkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 15:19:26 -0700
IronPort-SDR: 8fsBnJ8/eVoxsb0uNjg6+LtIBoIDkvbbx2dRkZ02g8tdonPt1pulU3aJFOiVwrMeUtOnyIWz/P
 cbGQOEhN0mfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,450,1583222400"; d="scan'208";a="469643380"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.152])
 by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 15:19:26 -0700
Date: Fri, 29 May 2020 15:19:26 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200529221926.GA3168@linux.intel.com>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521034304.340040-1-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=sean.j.christopherson@intel.com; helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 18:19:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 01:42:46PM +1000, David Gibson wrote:
> A number of hardware platforms are implementing mechanisms whereby the
> hypervisor does not have unfettered access to guest memory, in order
> to mitigate the security impact of a compromised hypervisor.
> 
> AMD's SEV implements this with in-cpu memory encryption, and Intel has
> its own memory encryption mechanism.  POWER has an upcoming mechanism
> to accomplish this in a different way, using a new memory protection
> level plus a small trusted ultravisor.  s390 also has a protected
> execution environment.
> 
> The current code (committed or draft) for these features has each
> platform's version configured entirely differently.  That doesn't seem
> ideal for users, or particularly for management layers.
> 
> AMD SEV introduces a notionally generic machine option
> "machine-encryption", but it doesn't actually cover any cases other
> than SEV.
> 
> This series is a proposal to at least partially unify configuration
> for these mechanisms, by renaming and generalizing AMD's
> "memory-encryption" property.  It is replaced by a
> "guest-memory-protection" property pointing to a platform specific
> object which configures and manages the specific details.
> 
> For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> can be extended to cover the Intel and s390 mechanisms as well,
> though.
> 
> Note: I'm using the term "guest memory protection" throughout to refer
> to mechanisms like this.  I don't particular like the term, it's both
> long and not really precise.  If someone can think of a succinct way
> of saying "a means of protecting guest memory from a possibly
> compromised hypervisor", I'd be grateful for the suggestion.

Many of the features are also going far beyond just protecting memory, so
even the "memory" part feels wrong.  Maybe something like protected-guest
or secure-guest?

A little imprecision isn't necessarily a bad thing, e.g. memory-encryption
is quite precise, but also wrong once it encompasses anything beyond plain
old encryption.

