Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DAAECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F6B2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwXFvZRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F6B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFM9d-0007PR-4k
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jmattson@google.com>) id 1iFLsH-0008OD-8d
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jmattson@google.com>) id 1iFLsF-0008BJ-Th
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:23:45 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jmattson@google.com>) id 1iFLsF-0008B4-NK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:23:43 -0400
Received: by mail-io1-xd41.google.com with SMTP id z19so50143138ior.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8xozfczvIWG0Y2vsrBbOpjZK317MVtMR97uRKfEeqqs=;
 b=cwXFvZRlT7iYMECk+nNP180Y0aucbUjcyJov1D5QuGO2uZr2rRh4Mq2uGjUthqxsra
 FeMmWE4H2lp+LiYAOWCerSOH3FFIUo0moHdI7b4IxQBaI6Po7FTskocmUBJHeRPfCAGI
 v9ZG8w8ILLflo9F/M8CBomqGCu/tOk0VhjZkBbzKT0BMNHEYX9mjotEySUGWkiyvnsbs
 vvGE9nlapb/d1D0fki74tiZv+cjDIsCuu8JsaPahBZQKEex1KXHZsFZaO37wZKlgFK50
 bUKtOgDJmAlwEVHCAXnB5upt3kG1foE/gXe6eKnt7FuX1a+ZW/cbuOzShxqufNyTfO7V
 yIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8xozfczvIWG0Y2vsrBbOpjZK317MVtMR97uRKfEeqqs=;
 b=TbN//Z7PHZ5Y9RUanschQ7gDekGGcXU9X5fV5u37RDI7rsv9mv9BgRQRKQMj9A5KRn
 6alWLZIyv96+FGEfNrThtcHvb0HzWo7c78xivRa2JSqnwVEPz6Tq2qwgtG8OL23n0wNU
 uRy6nlJqpsmxmb2T5bPx+CGB1A7Oq4KZOToiJpg7CWfKlgSNZ3rrxrP212ETVgiXASaB
 zKsFun2jhCHIYvtCg9xVemmcwX/1kOUVmJNbRquFxssLpjI1BR8Tw57vRcMdO0ZFShaC
 ogP8oIO3iakr3p5A13WQzznOAVKrJz9sNCJCaMTk2XzucE0Kmnlyy3eBVCgmQY82Bjnp
 kqjw==
X-Gm-Message-State: APjAAAWCX0iz5WznTM6DaZv0sHWUBheLEQN9vogouNq6VkPc75z7MROK
 nFtf3bt1aWegsADY4iIF6DqgqkoddPahdK2EnwtuUw==
X-Google-Smtp-Source: APXvYqwMMYqnkgfTd4cRC9oaitJxx48ATAxxvxhvOAer3742O+Ste/bSfS0iuYPZeoQWV8SeZgu9/xodXpUII3N6ILk=
X-Received: by 2002:a92:5e0b:: with SMTP id s11mr27925232ilb.26.1569950622482; 
 Tue, 01 Oct 2019 10:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <1545227503-214403-1-git-send-email-robert.hu@linux.intel.com>
 <CALMp9eRZCoZbeyttZdvaCUpOFKygTNVF_x7+TWh6MktmF-ZK9A@mail.gmail.com>
 <263d31d9-b21e-ceb9-b47c-008e30bbd94f@redhat.com>
 <CALMp9eRFWq+F1Dwb8NcBd-Bo-YbT6KMOLo8DoinQQfK9hEi5Qg@mail.gmail.com>
 <20190930175449.GB4084@habkost.net>
 <CALMp9eR88jE7YV-TmZSSD2oJhEpbsgo-LCgsWHkyFtHcHTmnzw@mail.gmail.com>
 <9bbe864ab8fb16d9e64745b930c89b1db24ccc3a.camel@intel.com>
 <CALMp9eSe_7on+F=ng05DkvvBpnWhSirEpSVz9Bua4Sy606xJnw@mail.gmail.com>
 <20191001170646.GA27090@linux.intel.com>
In-Reply-To: <20191001170646.GA27090@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 1 Oct 2019 10:23:31 -0700
Message-ID: <CALMp9eSj=KJC6SjOnPfN7R0vHB_75KjBeF3aYD2J75Sy3L7tcA@mail.gmail.com>
Subject: Re: [PATCH] x86: Add CPUID KVM support for new instruction WBNOINVD
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Huang, Kai" <kai.huang@intel.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, 
 "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 1, 2019 at 10:06 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Oct 01, 2019 at 07:20:17AM -0700, Jim Mattson wrote:
> > On Mon, Sep 30, 2019 at 5:45 PM Huang, Kai <kai.huang@intel.com> wrote:
> > >
> > > On Mon, 2019-09-30 at 12:23 -0700, Jim Mattson wrote:
> > > > On Mon, Sep 30, 2019 at 10:54 AM Eduardo Habkost <ehabkost@redhat.c=
om> wrote:
> > > > I had only looked at the SVM implementation of WBNOINVD, which is
> > > > exactly the same as the SVM implementation of WBINVD. So, the quest=
ion
> > > > is, "why enumerate WBNOINVD if its implementation is exactly the sa=
me
> > > > as WBINVD?"
> > > >
> > > > WBNOINVD appears to be only partially documented in Intel document
> > > > 319433-037, "Intel=C2=AE Architecture Instruction Set Extensions an=
d Future
> > > > Features Programming Reference." In particular, there is no
> > > > documentation regarding the instruction's behavior in VMX non-root
> > > > mode. Does WBNOINVD cause a VM-exit when the VM-execution control,
> > > > "WBINVD exiting," is set? If so, does it have the same VM-exit reas=
on
> > > > as WBINVD (54), or a different one? If it does have the same VM-exi=
t
> > > > reason (a la SVM), how does one distinguish a WBINVD VM-exit from a
> > > > WBNOINVD VM-exit? If one can't distinguish (a la SVM), then it woul=
d
> > > > seem that the VMX implementation also implements WBNOINVD as WBINVD=
.
> > > > If that's the case, the question for VMX is the same as for SVM.
> > >
> > > Unfortunately WBNOINVD interaction with VMX has not been made to publ=
ic yet.
>
> Hint: WBNOINVD uses a previously ignored prefix, i.e. it looks a *lot*
>       like WBINVD...

Because of the opcode selection, I would assume that we're not going
to see a VM-execution control for "enable WBNOINVD." To avoid breaking
legacy hypervisors, then, I would expect the "enable WBINVD exiting"
control to apply to WBNOINVD as well, and I would expect the exit
reason to be the same for both instructions. The exit qualification
field is cleared for WBINVD exits, so perhaps we will see a bit in
that field set to one for WBNOINVD. If so, will this new behavior be
indicated by a bit in one of the VMX capability MSRs? That seems to be
a closely guarded secret, for some reason.

> > > I am reaching out internally to see when it can be done. I agree it m=
ay not be
> > > necessary to expose WBNOINVD if its implementation is exactly the sam=
e as
> > > WBINVD, but it also doesn't have any harm, right?
> >
> > If nested VMX changes are necessary to be consistent with hardware,
> > then enumerating WBNOINVD support in the guest CPUID information at
> > this time--without the attendant nested VMX changes--is premature. No
> > changes to nested SVM are necessary, so it's fine for AMD systems.
> >
> > If no changes to nested VMX are necessary, then it is true that
> > WBNOINVD can be emulated by WBINVD. However, it provides no value to
> > specifically enumerate the instruction.
> >
> > If there is some value that I'm missing, then why make guest support
> > for the instruction contingent on host support for the instruction?
> > KVM can implement WBNOINVD as WBINVD on any host with WBINVD,
> > regardless of whether or not the host supports WBNOINVD.
>
> Agreed.  To play nice with live migration, KVM should enumerate WBNOINVD
> regardless of host support.  Since WBNOINVD uses an ignored prefix, it
> will simply look like a regular WBINVD on platforms without WBNOINVD.
>
> Let's assume the WBNOINVD VM-Exit behavior is sane, i.e. allows software
> to easily differentiate between WBINVD and WBNOINVD.

That isn't the case with SVM, oddly.

> In that case, the
> value added would be that KVM can do WBNOINVD instead of WBINVD in the
> unlikely event that (a) KVM needs to executed WBINVD on behalf of the
> guest (because the guest has non-coherent DMA), (b) WBNOINVD is supported
> on the host, and (c) WBNOINVD is used by the guest (I don't think it woul=
d
> be safe to assume that the guest doesn't need the caches invalidated on
> WBINVD).

I agree that there would be value if KVM implemented WBNOINVD using
WBNOINVD, but that isn't what this change does. My question was, "What
is the value in enumerating WBNOINVD if KVM is just going to implement
it with WBINVD anyway?"

