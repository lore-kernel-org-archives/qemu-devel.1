Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D580C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D593C20882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D593C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFvD-0002CO-3V
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 06:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iBFse-0007qN-Ln
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iBFkE-0006Gr-81
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:02:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iBFkE-0006Gl-1Q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:02:30 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 348264705B
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 10:02:29 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id y189so7423424qkb.14
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 03:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7dxNMmQLJlEOo9+UV13ugmnO6nGtIxNVkKMabpppw8o=;
 b=CqpW9vv5wfMUDR9kac4bfqgvWreRl4Gqg5fYHPLh+zKDMnBYSwkL8yS9G4RJyj4LdJ
 J8VbIi38WEJV74yexEGhCF2UOoDScx4Cs6HYbG4fJd5N8lHJh5SsY09cM3P3IBk49Hs4
 THoNvVC7K1R5qGX6JThRhCkMTUjE0/m/S3mjIXTSZLicr3DLiZKsDUl1VZJNDmVn/mfs
 YFpEF75IrfdP3BZ16dxuWPp3YYape1n7OBCAue8sf5q/M2vJdWHDtkte5vz6tXknJqf1
 2gi1jc9SRdZLFxybTg5hYzS9zYqXRnbfNaUiNQwqcBKhARir9e0lm+Mp3zAokzhmbI7x
 w2dg==
X-Gm-Message-State: APjAAAU2G+6EmOg714w0vMtkI1cuKTkmfk3N2D9xZwnH7oatqRLN5fVl
 abylyWa+c6iAkJut9irKOJo6EAV6RhHmDsXy5R5Flg9ug8eI+vFIf2KQMlJwhp37QoBJCDKOAKQ
 at+1R/qpwa3eWD0k=
X-Received: by 2002:a37:62d8:: with SMTP id w207mr2642771qkb.261.1568973748521; 
 Fri, 20 Sep 2019 03:02:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyij004RIFjt9KqGi2VQQKPeicmR7gxBVDUFjE9OuTHObS3lVj1VhAoP2o1ddckuicdYc7YBQ==
X-Received: by 2002:a37:62d8:: with SMTP id w207mr2642748qkb.261.1568973748308; 
 Fri, 20 Sep 2019 03:02:28 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id m19sm698207qke.22.2019.09.20.03.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 03:02:27 -0700 (PDT)
Date: Fri, 20 Sep 2019 06:02:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
Message-ID: <20190920060126-mutt-send-email-mst@kernel.org>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
 <204219fa-ee72-ca60-52a4-fb4bbc887773@redhat.com>
 <20190919052819.GA18391@joy-OptiPlex-7040>
 <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
 <20190919061756.GB18391@joy-OptiPlex-7040>
 <e0efbdc0-aad9-0d17-ec68-36460865501f@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
 <7906030a-00e3-012d-da4f-bb0c1b2901b2@redhat.com>
 <20190919100545-mutt-send-email-mst@kernel.org>
 <1373899c-4cbc-cd23-512b-2994e6b26a27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1373899c-4cbc-cd23-512b-2994e6b26a27@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 'Alex Williamson' <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 09:15:40AM +0800, Jason Wang wrote:
>=20
> On 2019/9/19 =E4=B8=8B=E5=8D=8810:06, Michael S. Tsirkin wrote:
> > On Thu, Sep 19, 2019 at 05:37:48PM +0800, Jason Wang wrote:
> > > On 2019/9/19 =E4=B8=8B=E5=8D=883:16, Tian, Kevin wrote:
> > > > +Paolo to help clarify here.
> > > >=20
> > > > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > > > Sent: Thursday, September 19, 2019 2:32 PM
> > > > >=20
> > > > >=20
> > > > > On 2019/9/19 =E4=B8=8B=E5=8D=882:17, Yan Zhao wrote:
> > > > > > On Thu, Sep 19, 2019 at 02:09:53PM +0800, Jason Wang wrote:
> > > > > > > On 2019/9/19 =E4=B8=8B=E5=8D=881:28, Yan Zhao wrote:
> > > > > > > > On Thu, Sep 19, 2019 at 09:05:12AM +0800, Jason Wang wrot=
e:
> > > > > > > > > On 2019/9/18 =E4=B8=8B=E5=8D=884:37, Tian, Kevin wrote:
> > > > > > > > > > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > > > > > > > > > Sent: Wednesday, September 18, 2019 2:10 PM
> > > > > > > > > > >=20
> > > > > > > > > > > > > Note that the HVA to GPA mapping is not an 1:1 =
mapping. One
> > > > > HVA
> > > > > > > > > > > range
> > > > > > > > > > > > > could be mapped to several GPA ranges.
> > > > > > > > > > > > This is fine. Currently vfio_dma maintains IOVA->=
HVA mapping.
> > > > > > > > > > > >=20
> > > > > > > > > > > > btw under what condition HVA->GPA is not 1:1 mapp=
ing? I didn't
> > > > > realize it.
> > > > > > > > > > > I don't remember the details e.g memory region alia=
s? And neither
> > > > > kvm
> > > > > > > > > > > nor kvm API does forbid this if my memory is correc=
t.
> > > > > > > > > > >=20
> > > > > > > > > > I checked https://qemu.weilnetz.de/doc/devel/memory.h=
tml, which
> > > > > > > > > > provides an example of aliased layout. However, its a=
liasing is all
> > > > > > > > > > 1:1, instead of N:1. From guest p.o.v every writable =
GPA implies an
> > > > > > > > > > unique location. Why would we hit the situation where=
 multiple
> > > > > > > > > > write-able GPAs are mapped to the same HVA (i.e. same=
 physical
> > > > > > > > > > memory location)?
> > > > > > > > > I don't know, just want to say current API does not for=
bid this. So we
> > > > > > > > > probably need to take care it.
> > > > > > > > >=20
> > > > > > > > yes, in KVM API level, it does not forbid two slots to ha=
ve the same
> > > > > HVA(slot->userspace_addr).
> > > > > > > > But
> > > > > > > > (1) there's only one kvm instance for each vm for each qe=
mu process.
> > > > > > > > (2) all ramblock->host (corresponds to HVA and slot->user=
space_addr)
> > > > > in one qemu
> > > > > > > > process is non-overlapping as it's obtained from mmmap().
> > > > > > > > (3) qemu ensures two kvm slots will not point to the same=
 section of
> > > > > one ramblock.
> > > > > > > > So, as long as kvm instance is not shared in two processe=
s, and
> > > > > > > > there's no bug in qemu, we can assure that HVA to GPA is =
1:1.
> > > > > > > Well, you leave this API for userspace, so you can't assume=
 qemu is the
> > > > > > > only user or any its behavior. If you had you should limit =
it in the API
> > > > > > > level instead of open window for them.
> > > > > > >=20
> > > > > > >=20
> > > > > > > > But even if there are two processes operating on the same=
 kvm
> > > > > instance
> > > > > > > > and manipulating on memory slots, adding an extra GPA alo=
ng side
> > > > > current
> > > > > > > > IOVA & HVA to ioctl VFIO_IOMMU_MAP_DMA can still let driv=
er knows
> > > > > the
> > > > > > > > right IOVA->GPA mapping, right?
> > > > > > > It looks fragile. Consider HVA was mapped to both GPA1 and =
GPA2.
> > > > > Guest
> > > > > > > maps IOVA to GPA2, so we have IOVA GPA2 HVA in the new ioct=
l and
> > > > > then
> > > > > > > log through GPA2. If userspace is trying to sync through GP=
A1, it will
> > > > > > > miss the dirty page. So for safety we need log both GPA1 an=
d GPA2. (See
> > > > > > > what has been done in log_write_hva() in vhost.c). The only=
 way to do
> > > > > > > that is to maintain an independent HVA to GPA mapping like =
what KVM
> > > > > or
> > > > > > > vhost did.
> > > > > > >=20
> > > > > > why GPA1 and GPA2 should be both dirty?
> > > > > > even they have the same HVA due to overlaping virtual address=
 space in
> > > > > > two processes, they still correspond to two physical pages.
> > > > > > don't get what's your meaning :)
> > > > > The point is not leave any corner case that is hard to debug or=
 fix in
> > > > > the future.
> > > > >=20
> > > > > Let's just start by a single process, the API allows userspace =
to maps
> > > > > HVA to both GPA1 and GPA2. Since it knows GPA1 and GPA2 are equ=
ivalent,
> > > > > it's ok to sync just through GPA1. That means if you only log G=
PA2, it
> > > > > won't work.
> > > > >=20
> > > > I noted KVM itself doesn't consider such situation (one HVA is ma=
pped
> > > > to multiple GPAs), when doing its dirty page tracking. If you loo=
k at
> > > > kvm_vcpu_mark_page_dirty, it simply finds the unique memslot whic=
h
> > > > contains the dirty gfn and then set the dirty bit within that slo=
t. It
> > > > doesn't attempt to walk all memslots to find out any other GPA wh=
ich
> > > > may be mapped to the same HVA.
> > > >=20
> > > > So there must be some disconnect here. let's hear from Paolo firs=
t and
> > > > understand the rationale behind such situation.
> > >=20
> > > Neither did vhost when IOTLB is disabled. And cc Michael who points=
 out this
> > > issue at the beginning.
> > >=20
> > > Thanks
> > >=20
> > >=20
> > > > Thanks
> > > > Kevin
> > Yes, we fixed with a kind of a work around, at the time I proposed
> > a new interace to fix it fully. I don't think we ever got around
> > to implementing it - right?
>=20
>=20
> Paolo said userspace just need to sync through all GPAs, so my understa=
nding
> is that work around is ok by redundant, so did the API you proposed.
> Anything I miss?
>=20
> Thanks

I just feel an extra lookup is awkward. We don't benchmark
the speed during migration right now but it's something
we might care about down the road.

HTH

--=20
MST

