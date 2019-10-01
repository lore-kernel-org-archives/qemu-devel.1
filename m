Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E834C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FBD2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FBD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLd7-0003je-4J
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sean.j.christopherson@intel.com>) id 1iFLby-0002Ni-An
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sean.j.christopherson@intel.com>) id 1iFLbw-0001ZL-Df
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:06:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:40705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sean.j.christopherson@intel.com>)
 id 1iFLbw-0001YF-5t
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:06:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 10:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; d="scan'208";a="197915381"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.41])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2019 10:06:47 -0700
Date: Tue, 1 Oct 2019 10:06:46 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] x86: Add CPUID KVM support for new instruction WBNOINVD
Message-ID: <20191001170646.GA27090@linux.intel.com>
References: <1545227503-214403-1-git-send-email-robert.hu@linux.intel.com>
 <CALMp9eRZCoZbeyttZdvaCUpOFKygTNVF_x7+TWh6MktmF-ZK9A@mail.gmail.com>
 <263d31d9-b21e-ceb9-b47c-008e30bbd94f@redhat.com>
 <CALMp9eRFWq+F1Dwb8NcBd-Bo-YbT6KMOLo8DoinQQfK9hEi5Qg@mail.gmail.com>
 <20190930175449.GB4084@habkost.net>
 <CALMp9eR88jE7YV-TmZSSD2oJhEpbsgo-LCgsWHkyFtHcHTmnzw@mail.gmail.com>
 <9bbe864ab8fb16d9e64745b930c89b1db24ccc3a.camel@intel.com>
 <CALMp9eSe_7on+F=ng05DkvvBpnWhSirEpSVz9Bua4Sy606xJnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eSe_7on+F=ng05DkvvBpnWhSirEpSVz9Bua4Sy606xJnw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Hu, Robert" <robert.hu@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 07:20:17AM -0700, Jim Mattson wrote:
> On Mon, Sep 30, 2019 at 5:45 PM Huang, Kai <kai.huang@intel.com> wrote:
> >
> > On Mon, 2019-09-30 at 12:23 -0700, Jim Mattson wrote:
> > > On Mon, Sep 30, 2019 at 10:54 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > I had only looked at the SVM implementation of WBNOINVD, which is
> > > exactly the same as the SVM implementation of WBINVD. So, the question
> > > is, "why enumerate WBNOINVD if its implementation is exactly the same
> > > as WBINVD?"
> > >
> > > WBNOINVD appears to be only partially documented in Intel document
> > > 319433-037, "Intel® Architecture Instruction Set Extensions and Future
> > > Features Programming Reference." In particular, there is no
> > > documentation regarding the instruction's behavior in VMX non-root
> > > mode. Does WBNOINVD cause a VM-exit when the VM-execution control,
> > > "WBINVD exiting," is set? If so, does it have the same VM-exit reason
> > > as WBINVD (54), or a different one? If it does have the same VM-exit
> > > reason (a la SVM), how does one distinguish a WBINVD VM-exit from a
> > > WBNOINVD VM-exit? If one can't distinguish (a la SVM), then it would
> > > seem that the VMX implementation also implements WBNOINVD as WBINVD.
> > > If that's the case, the question for VMX is the same as for SVM.
> >
> > Unfortunately WBNOINVD interaction with VMX has not been made to public yet.

Hint: WBNOINVD uses a previously ignored prefix, i.e. it looks a *lot*
      like WBINVD...

> > I am reaching out internally to see when it can be done. I agree it may not be
> > necessary to expose WBNOINVD if its implementation is exactly the same as
> > WBINVD, but it also doesn't have any harm, right?
> 
> If nested VMX changes are necessary to be consistent with hardware,
> then enumerating WBNOINVD support in the guest CPUID information at
> this time--without the attendant nested VMX changes--is premature. No
> changes to nested SVM are necessary, so it's fine for AMD systems.
> 
> If no changes to nested VMX are necessary, then it is true that
> WBNOINVD can be emulated by WBINVD. However, it provides no value to
> specifically enumerate the instruction.
>
> If there is some value that I'm missing, then why make guest support
> for the instruction contingent on host support for the instruction?
> KVM can implement WBNOINVD as WBINVD on any host with WBINVD,
> regardless of whether or not the host supports WBNOINVD.

Agreed.  To play nice with live migration, KVM should enumerate WBNOINVD
regardless of host support.  Since WBNOINVD uses an ignored prefix, it
will simply look like a regular WBINVD on platforms without WBNOINVD.

Let's assume the WBNOINVD VM-Exit behavior is sane, i.e. allows software
to easily differentiate between WBINVD and WBNOINVD.  In that case, the
value added would be that KVM can do WBNOINVD instead of WBINVD in the
unlikely event that (a) KVM needs to executed WBINVD on behalf of the
guest (because the guest has non-coherent DMA), (b) WBNOINVD is supported
on the host, and (c) WBNOINVD is used by the guest (I don't think it would
be safe to assume that the guest doesn't need the caches invalidated on
WBINVD).

