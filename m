Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B176C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289C120409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKIskLt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289C120409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuNS-0006mT-Br
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jDuFl-0001oz-Su
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jDuFk-0001sk-A3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:14:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jDuFi-0001mI-M4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584382454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WdGMnRZ45gFlpMKqHmLurz9MLNWSia9PR7qxMTkxYOs=;
 b=KKIskLt6hcvpk8zN6mtjZ84liDCdv1x6krsodijnvPW/lCx9jZQyHaT4s4Mvii35JSZaYj
 jKSjtP9XFrDFhzfSkacq86vQKrOs2+6Xd4M9xv63ktJOnZ0kFVV/5eJIVy+4esMp4ts+Zh
 IFqwHm9sr2UF65ZKvcsWKLZYditytL8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-9zi9-mP-N4-oNgW3GV7GkQ-1; Mon, 16 Mar 2020 14:14:09 -0400
X-MC-Unique: 9zi9-mP-N4-oNgW3GV7GkQ-1
Received: by mail-qk1-f200.google.com with SMTP id n9so10591427qkh.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aQwmaK5sCKXHj4EjR0+yT1ytibfD1ecQUYBadHTrNos=;
 b=l45C+3kJaFBNe2NiahHCeaazohtTWlwkNCg4RVQ8zJI/xPmI6O8EMeKevTIZS5WR+d
 7UNqCIdCmmkF5iLWo1kS3lJrfiAr3os1mkEzRB8PXysJ+V4G3XixeZtc6K5SgTRlWjP/
 BTL1TKPTxAiSMW/PL7N/9S6dgfSp89SkDSwUH5vscuuBbs/SKynYwCzy+hraV+UpH6dk
 Nw/RuuW8QIi4EaQ49FgkovNpsJY1BmjI3gZDV2Khk0ZhLZUd8h1uy1TusFKJuOyo3Wxw
 h+bPl/UjCJIejyUqu6vWVIrDM3V4Sa9cNCVc53rajcOZGzS0ukVIG40DWhkxyF4x+HS2
 /bQA==
X-Gm-Message-State: ANhLgQ3Q3x4OFUaokOlrcwxdHFbn9YFkz/GAQX+xQwjtWbaeDxlk7S7x
 DvlTKUYTg3V05dRhgev0Sx3CuSZWJqmejhGDRF3tqOYBS5GwqnZWIuvmOK3eDcIX4/smUq0RUgM
 eV4ICwvYdZGDKQBI=
X-Received: by 2002:ad4:4c82:: with SMTP id bs2mr1090963qvb.14.1584382449108; 
 Mon, 16 Mar 2020 11:14:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt9KEne4zx/4fSrRL/Yr/nmyDLoH2nNdPsHOv6yZBYj7DVc08nHbMg7ci3NH39p42YZufc+Wg==
X-Received: by 2002:ad4:4c82:: with SMTP id bs2mr1090928qvb.14.1584382448693; 
 Mon, 16 Mar 2020 11:14:08 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id l12sm332528qtp.44.2020.03.16.11.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:14:07 -0700 (PDT)
Date: Mon, 16 Mar 2020 14:14:05 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200316181405.GB184827@xz-x1>
References: <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <20200313112902-mutt-send-email-mst@kernel.org>
 <20200313163122.GB95517@xz-x1>
 <20200316131723-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200316131723-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 01:19:54PM -0400, Michael S. Tsirkin wrote:
> On Fri, Mar 13, 2020 at 12:31:22PM -0400, Peter Xu wrote:
> > On Fri, Mar 13, 2020 at 11:29:59AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
> > > > [..]
> > > > > >=20
> > > > > > CCing Tom. @Tom does vhost-vsock work for you with SEV and curr=
ent qemu?
> > > > > >=20
> > > > > > Also, one can specify iommu_platform=3Don on a device that ain'=
t a part of
> > > > > > a secure-capable VM, just for the fun of it. And that breaks
> > > > > > vhost-vsock. Or is setting iommu_platform=3Don only valid if
> > > > > > qemu-system-s390x is protected virtualization capable?
> > > > > >=20
> > > > > > BTW, I don't have a strong opinion on the fixes tag. We current=
ly do not
> > > > > > recommend setting iommu_platform, and thus I don't think we car=
e too
> > > > > > much about past qemus having problems with it.
> > > > > >=20
> > > > > > Regards,
> > > > > > Halil
> > > > >=20
> > > > >=20
> > > > > Let's just say if we do have a Fixes: tag we want to set it corre=
ctly to
> > > > > the commit that needs this fix.
> > > > >=20
> > > >=20
> > > > I finally did some digging regarding the performance degradation. F=
or
> > > > s390x the performance degradation on vhost-net was introduced by co=
mmit
> > > > 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
> > > > IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
> > > > calculated as the rest of the memory regions size (from address), a=
nd
> > > > covered most of the guest address space. That is we didn't have a w=
hole
> > > > lot of IOTLB API overhead.
> > > >=20
> > > > With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xfff w=
hich comes
> > > > as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things w=
orking
> > > > properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the lev=
el of
> > > > 076a93d797 and 076a93d797~1.
> > >=20
> > > Peter, what's your take on this one?
> >=20
> > Commit 076a93d797 was one of the patchset where we want to provide
> > sensible IOTLB entries and also that should start to work with huge
> > pages.
>=20
> So the issue bundamentally is that it
> never produces entries larger than page size.
>=20
> Wasteful even just with huge pages, all the more
> so which passthrough which could have giga-byte
> entries.
>=20
> Want to try fixing that?

Yes we can fix that, but I'm still not sure whether changing the
interface of address_space_get_iotlb_entry() to cover adhoc regions is
a good idea, because I think it's still a memory core API and imho it
would still be good to have IOTLBs returned to be what the hardware
will be using (always page aligned IOTLBs).  Also it would still be
not ideal because vhost backend will still need to send the MISSING
messages and block for each of the continuous guest memory ranges
registered, so there will still be misterious delay.  Not to say
logically all the caches can be invalidated too so in that sense I
think it's as hacky as the vhost speedup patch mentioned below..

Ideally I think vhost should be able to know when PT is enabled or
disabled for the device, so the vhost backend (kernel or userspace)
should be able to directly use GPA for DMA.  That might need some new
vhost interface.

For the s390's specific issue, I would think Jason's patch an simple
and ideal solution already.

Thanks,

>=20
>=20
> >  Frankly speaking after a few years I forgot the original
> > motivation of that whole thing, but IIRC there's a patch that was
> > trying to speedup especially for vhost but I noticed it's not merged:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00574.html
> >=20
> > Regarding to the current patch, I'm not sure I understand it
> > correctly, but is that performance issue only happens when (1) there's
> > no intel-iommu device, and (2) there is iommu_platform=3Don specified
> > for the vhost backend?
> >=20
> > If so, I'd confess I am not too surprised if this fails the boot with
> > vhost-vsock because after all we speicified iommu_platform=3Don
> > explicitly in the cmdline, so if we want it to work we can simply
> > remove that iommu_platform=3Don when vhost-vsock doesn't support it
> > yet...  I thougth iommu_platform=3Don was added for that case - when we
> > want to force IOMMU to be enabled from host side, and it should always
> > be used with a vIOMMU device.
> >=20
> > However I also agree that from performance POV this patch helps for
> > this quite special case.
> >=20
> > Thanks,
> >=20
> > --=20
> > Peter Xu
>=20

--=20
Peter Xu


