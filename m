Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD637C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41362067B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41362067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44741 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxBh-0000EA-SS
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAx4y-0008JI-Qe
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAx4w-0002Je-Ii
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAx4w-0002Ic-AN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:06:38 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50ACBC057F20
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:06:36 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id e13so4009499qto.18
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KfRtE4DtvcLjZqJHQLhl42mBYywH0dJPoWBRYCjw13Y=;
 b=i5yO+M6bpvx1QyYh97ffjNT1QfXYofzHj1iQrZftEqL9AuU2gSieZVUSKUovAhiNjI
 C9pZb0XqMt0Jz/An/vui2zV0yRsBnugZGMiRuatZwNBJoo58+46k8c9vuTT5mIECg4h4
 rWq2n61m9lSohLQ4ITn7AGjnOOkYFOMe9ES6/wBrk75iae2RyFKNvuAf/3K/U4zVh1t7
 CMXEeIS4k/TfwE7OVcbHPHTp8AcU8MfUcUT3H0dQoC5bEzZP4HbPE3F57Iu4jShJ0FVH
 tBz8oQvWAZa4XSBlwaTXAsCA6Jo3u+2APYm/neTkRk5xzXkRdvEPkWBp+IXjlQwJsp1i
 kBlQ==
X-Gm-Message-State: APjAAAXdPk5s6XO1BugcwrlAKW9LGTnwJ1r7Zy9OCnm5G4KzNqQ4kQJi
 kpvmt0Id5TYzbl6//cEGdnn78uZTJDG9wafdAF4cN+9xgUJ1+XykDrpyAd7p++lITdbdpgJ1SXa
 vtlMbD5utCJ17ICw=
X-Received: by 2002:a37:4286:: with SMTP id p128mr3142957qka.40.1568901995618; 
 Thu, 19 Sep 2019 07:06:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3CQTlapBH0+G6VI3PMEL77ZIlxofWLKCKf/PWfhZsj49frLLzAyPDlnKLcz9sU0RvaOd3eQ==
X-Received: by 2002:a37:4286:: with SMTP id p128mr3142924qka.40.1568901995307; 
 Thu, 19 Sep 2019 07:06:35 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id h68sm4466965qkf.2.2019.09.19.07.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 07:06:34 -0700 (PDT)
Date: Thu, 19 Sep 2019 10:06:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Message-ID: <20190919100545-mutt-send-email-mst@kernel.org>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
 <204219fa-ee72-ca60-52a4-fb4bbc887773@redhat.com>
 <20190919052819.GA18391@joy-OptiPlex-7040>
 <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
 <20190919061756.GB18391@joy-OptiPlex-7040>
 <e0efbdc0-aad9-0d17-ec68-36460865501f@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
 <7906030a-00e3-012d-da4f-bb0c1b2901b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7906030a-00e3-012d-da4f-bb0c1b2901b2@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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

On Thu, Sep 19, 2019 at 05:37:48PM +0800, Jason Wang wrote:
>=20
> On 2019/9/19 =E4=B8=8B=E5=8D=883:16, Tian, Kevin wrote:
> > +Paolo to help clarify here.
> >=20
> > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > Sent: Thursday, September 19, 2019 2:32 PM
> > >=20
> > >=20
> > > On 2019/9/19 =E4=B8=8B=E5=8D=882:17, Yan Zhao wrote:
> > > > On Thu, Sep 19, 2019 at 02:09:53PM +0800, Jason Wang wrote:
> > > > > On 2019/9/19 =E4=B8=8B=E5=8D=881:28, Yan Zhao wrote:
> > > > > > On Thu, Sep 19, 2019 at 09:05:12AM +0800, Jason Wang wrote:
> > > > > > > On 2019/9/18 =E4=B8=8B=E5=8D=884:37, Tian, Kevin wrote:
> > > > > > > > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > > > > > > > Sent: Wednesday, September 18, 2019 2:10 PM
> > > > > > > > >=20
> > > > > > > > > > > Note that the HVA to GPA mapping is not an 1:1 mapp=
ing. One
> > > HVA
> > > > > > > > > range
> > > > > > > > > > > could be mapped to several GPA ranges.
> > > > > > > > > > This is fine. Currently vfio_dma maintains IOVA->HVA =
mapping.
> > > > > > > > > >=20
> > > > > > > > > > btw under what condition HVA->GPA is not 1:1 mapping?=
 I didn't
> > > realize it.
> > > > > > > > > I don't remember the details e.g memory region alias? A=
nd neither
> > > kvm
> > > > > > > > > nor kvm API does forbid this if my memory is correct.
> > > > > > > > >=20
> > > > > > > > I checked https://qemu.weilnetz.de/doc/devel/memory.html,=
 which
> > > > > > > > provides an example of aliased layout. However, its alias=
ing is all
> > > > > > > > 1:1, instead of N:1. From guest p.o.v every writable GPA =
implies an
> > > > > > > > unique location. Why would we hit the situation where mul=
tiple
> > > > > > > > write-able GPAs are mapped to the same HVA (i.e. same phy=
sical
> > > > > > > > memory location)?
> > > > > > > I don't know, just want to say current API does not forbid =
this. So we
> > > > > > > probably need to take care it.
> > > > > > >=20
> > > > > > yes, in KVM API level, it does not forbid two slots to have t=
he same
> > > HVA(slot->userspace_addr).
> > > > > > But
> > > > > > (1) there's only one kvm instance for each vm for each qemu p=
rocess.
> > > > > > (2) all ramblock->host (corresponds to HVA and slot->userspac=
e_addr)
> > > in one qemu
> > > > > > process is non-overlapping as it's obtained from mmmap().
> > > > > > (3) qemu ensures two kvm slots will not point to the same sec=
tion of
> > > one ramblock.
> > > > > > So, as long as kvm instance is not shared in two processes, a=
nd
> > > > > > there's no bug in qemu, we can assure that HVA to GPA is 1:1.
> > > > > Well, you leave this API for userspace, so you can't assume qem=
u is the
> > > > > only user or any its behavior. If you had you should limit it i=
n the API
> > > > > level instead of open window for them.
> > > > >=20
> > > > >=20
> > > > > > But even if there are two processes operating on the same kvm
> > > instance
> > > > > > and manipulating on memory slots, adding an extra GPA along s=
ide
> > > current
> > > > > > IOVA & HVA to ioctl VFIO_IOMMU_MAP_DMA can still let driver k=
nows
> > > the
> > > > > > right IOVA->GPA mapping, right?
> > > > > It looks fragile. Consider HVA was mapped to both GPA1 and GPA2=
.
> > > Guest
> > > > > maps IOVA to GPA2, so we have IOVA GPA2 HVA in the new ioctl an=
d
> > > then
> > > > > log through GPA2. If userspace is trying to sync through GPA1, =
it will
> > > > > miss the dirty page. So for safety we need log both GPA1 and GP=
A2. (See
> > > > > what has been done in log_write_hva() in vhost.c). The only way=
 to do
> > > > > that is to maintain an independent HVA to GPA mapping like what=
 KVM
> > > or
> > > > > vhost did.
> > > > >=20
> > > > why GPA1 and GPA2 should be both dirty?
> > > > even they have the same HVA due to overlaping virtual address spa=
ce in
> > > > two processes, they still correspond to two physical pages.
> > > > don't get what's your meaning :)
> > >=20
> > > The point is not leave any corner case that is hard to debug or fix=
 in
> > > the future.
> > >=20
> > > Let's just start by a single process, the API allows userspace to m=
aps
> > > HVA to both GPA1 and GPA2. Since it knows GPA1 and GPA2 are equival=
ent,
> > > it's ok to sync just through GPA1. That means if you only log GPA2,=
 it
> > > won't work.
> > >=20
> > I noted KVM itself doesn't consider such situation (one HVA is mapped
> > to multiple GPAs), when doing its dirty page tracking. If you look at
> > kvm_vcpu_mark_page_dirty, it simply finds the unique memslot which
> > contains the dirty gfn and then set the dirty bit within that slot. I=
t
> > doesn't attempt to walk all memslots to find out any other GPA which
> > may be mapped to the same HVA.
> >=20
> > So there must be some disconnect here. let's hear from Paolo first an=
d
> > understand the rationale behind such situation.
>=20
>=20
> Neither did vhost when IOTLB is disabled. And cc Michael who points out=
 this
> issue at the beginning.
>=20
> Thanks
>=20
>=20
> >=20
> > Thanks
> > Kevin

Yes, we fixed with a kind of a work around, at the time I proposed
a new interace to fix it fully. I don't think we ever got around
to implementing it - right?


