Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A6020797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A6020797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEO5-0004q4-Vv
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kSELT-0001jw-E8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 03:03:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:6738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kSELQ-0001Qa-DM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 03:03:38 -0400
IronPort-SDR: NmYEy2iH6tRva7WPkwddeocGNT3M2GMl93ehtwD0WaHxe6gpgjn6zZAbYuh4td0/ClwhFa14Zz
 +nCcLgKzYn/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165075530"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="165075530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 00:03:32 -0700
IronPort-SDR: yiC8yNDOFHFMq6VXclrifsMfmqj6MBvsTppvCcYTh5upRUuK1B85ppDfm3fitbb9opdaiA4hn1
 gvz6ZX3fKJjw==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="330004494"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.160])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 00:03:32 -0700
Date: Tue, 13 Oct 2020 00:03:31 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: harry harry <hiharryharryharry@gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
Message-ID: <20201013070329.GC11344@linux.intel.com>
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
 <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=sean.j.christopherson@intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:03:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, PLING_QUERY=0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, mathieu.tarral@protonmail.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 01:33:28AM -0400, harry harry wrote:
> > > Do you mean that GPAs are different from their corresponding HVAs when
> > > KVM does the walks (as you said above) in software?
> >
> > What do you mean by "different"?  GPAs and HVAs are two completely
> different
> > address spaces.
> 
> Let me give you one concrete example as follows to explain the meaning of
> ``different''.
> 
> Suppose a program is running in a single-vCPU VM. The program allocates and
> references one page (e.g., array[1024*4]). Assume that allocating and
> referencing the page in the guest OS triggers a page fault and host OS
> allocates a machine page to back it.
> 
> Assume that GVA of array[0] is 0x000000000021 and its corresponding GPA is
> 0x0000000000000081. I think array[0]'s corresponding HVA should also be
> 0x0000000000000081, which is the same as array[0]'s GPA. If array[0]'s HVA
> is not 0x0000000000000081, array[0]'s GPA is* different* from its
> corresponding HVA.
> 
> Now, let's assume array[0]'s GPA is different from its corresponding HVA. I
> think there might be one issue like this: I think MMU's hardware logic to
> translate ``GPA ->[extended/nested page tables] -> HPA''[1] should be the
> same as ``VA-> [page tables] -> PA"[2]; if true, how does KVM find the
> correct HPA with the different HVA (e.g., array[0]'s HVA is not
> 0x0000000000000081) when there are EPT violations?

This is where memslots come in.  Think of memslots as a one-level page tablea
that translate GPAs to HVAs.  A memslot, set by userspace, tells KVM the
corresponding HVA for a given GPA.

Before the guest is running (assuming host userspace isn't broken), the
userspace VMM will first allocate virtual memory (HVA) for all physical
memory it wants to map into the guest (GPA).  It then tells KVM how to
translate a given GPA to its HVA by creating a memslot.

To avoid getting lost in a tangent about page offsets, let's assume array[0]'s
GPA = 0xa000.  For KVM to create a GPA->HPA mapping for the guest, there _must_
be a memslot that translates GPA 0xa000 to an HVA[*].  Let's say HVA = 0xb000.

On an EPT violation, KVM does a memslot lookup to translate the GPA (0xa000) to
its HVA (0xb000), and then walks the host page tables to translate the HVA into
a HPA (let's say that ends up being 0xc000).  KVM then stuffs 0xc000 into the
EPT tables, which yields:

  GPA    -> HVA    (KVM memslots)
  0xa000    0xb000

  HVA    -> HPA    (host page tables)
  0xb000    0xc000

  GPA    -> HPA    (extended page tables)
  0xa000    0xc000

To keep the EPT tables synchronized with the host page tables, if HVA->HPA
changes, e.g. HVA 0xb000 is remapped to HPA 0xd000, then KVM will get notified
by the host kernel that the HVA has been unmapped and will find and unmap
the corresponding GPA (again via memslots) to HPA translations.

Ditto for the case where userspace moves a memslot, e.g. if HVA is changed
to 0xe000, KVM will first unmap all old GPA->HPA translations so that accesses
to GPA 0xa000 from the guest will take an EPT violation and see the new HVA
(and presumably a new HPA).

[*] If there is no memslot, KVM will exit to userspace on the EPT violation,
    with some information about what GPA the guest was accessing.  This is how
    emulated MMIO is implemented, e.g. userspace intentionally doesn't back a
    GPA with a memslot so that it can trap guest accesses to said GPA for the
    purpose of emulating a device.

> [1] Please note that this hardware walk is the last step, which only
> translates the guest physical address to the host physical address through
> the four-level nested page table.
> [2] Please note that this hardware walk assumes translating the VA to the
> PA without virtualization involvement.
> 
> Please note that the above addresses are not real and just use for
> explanations.
> 
> Thanks,
> Harry

