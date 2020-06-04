Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AF6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE95D2053B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE95D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsfi-00043T-7i
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1jgsbR-0008NK-HD; Thu, 04 Jun 2020 12:20:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:20327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1jgsbP-0007Ch-PP; Thu, 04 Jun 2020 12:20:24 -0400
IronPort-SDR: qUnwrMbtB3p8IyIQjjXjJSWB0TNMdFNepNDhX11W+WGaTo7wZfsONDyurCyTNNNWpceeu0+GNU
 xfuho98R19Lw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 09:20:13 -0700
IronPort-SDR: 0STHlrEs9f5V4unbDzgHVn1raqy2xRABHf/PWcn7KiK0SmxBBhUd0TkB/ahsSvElQ21AXW5beg
 3r2QJS0aRH/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; d="scan'208";a="471584291"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.152])
 by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2020 09:20:12 -0700
Date: Thu, 4 Jun 2020 09:20:12 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200604162012.GA30456@linux.intel.com>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200529221926.GA3168@linux.intel.com>
 <20200601091618.GC2743@work-vm>
 <20200604031129.GB228651@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604031129.GB228651@umbus.fritz.box>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=sean.j.christopherson@intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 12:20:13
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 01:11:29PM +1000, David Gibson wrote:
> On Mon, Jun 01, 2020 at 10:16:18AM +0100, Dr. David Alan Gilbert wrote:
> > * Sean Christopherson (sean.j.christopherson@intel.com) wrote:
> > > On Thu, May 21, 2020 at 01:42:46PM +1000, David Gibson wrote:
> > > > Note: I'm using the term "guest memory protection" throughout to refer
> > > > to mechanisms like this.  I don't particular like the term, it's both
> > > > long and not really precise.  If someone can think of a succinct way
> > > > of saying "a means of protecting guest memory from a possibly
> > > > compromised hypervisor", I'd be grateful for the suggestion.
> > > 
> > > Many of the features are also going far beyond just protecting memory, so
> > > even the "memory" part feels wrong.  Maybe something like protected-guest
> > > or secure-guest?
> > > 
> > > A little imprecision isn't necessarily a bad thing, e.g. memory-encryption
> > > is quite precise, but also wrong once it encompasses anything beyond plain
> > > old encryption.
> > 
> > The common thread I think is 'untrusted host' - but I don't know of a
> > better way to describe that.
> 
> Hrm..  UntrustedHost? CompromisedHostMitigation? HostTrustMitigation
> (that way it has the same abbreviation as hardware transactional
> memory for extra confusion)?  HypervisorPowerLimitation?

GuestWithTrustIssues?  Then we can shorten it to InsecureGuest and cause all
kinds of confusion :-D.

> HostTrustLimitation? "HTL". That's not too bad, actually, I might go
> with that unless someone suggests something better.

DePrivelegedHost?  "DPH".  The "de-privelege" phrase seems to be another
recurring theme.

