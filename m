Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD6C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5D8206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwzqGirn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5D8206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnF0-0007mk-31
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jCnDi-0006vM-Hx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jCnDg-00018X-9g
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:31:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jCnDg-00013Q-1m
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584117090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUnDahcSq0MihJJvtP3Q/wIOONC4J/4Ce5Q+y2Lgg8Y=;
 b=TwzqGirnz/lbcztYmrgiATLtqAvZ/cIufcR8KBCzuCYxHhdVhIEKNECYWsa+uwBhvyf4f9
 UIFruQd4RDmBrQS3wSllAi7mKKiWGqI0F1X0xZEMooPISsFm6FcYjTw6cys3UupwYjVcVm
 X+zyI0RWa5dwBTWoLvGum6auM4H1Spo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-ZiMpUIDLMkOfznplGjrVuA-1; Fri, 13 Mar 2020 12:31:26 -0400
X-MC-Unique: ZiMpUIDLMkOfznplGjrVuA-1
Received: by mail-qt1-f198.google.com with SMTP id r16so8162557qtt.13
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EQaPLRXmdrF9tdq61pE5WBrDqlo3ZIt8r5XuHulLCAM=;
 b=Rjz5Y3/9/jflqZ7tEgNx9VZy6/lACg9lQS6++RCBDQ4wNG5R/d+bKdIHcOng7ulvVL
 eh4CTFtKwIY5Iaj/FvaO1QiLB0zmN1uqvLEABSfxXklH5eZ54CRpqhnH9rcM/LEJU9O2
 wVJrdhzEPxNw3q+ZRZxOcUmeIBHu+34P1eEbHSN+bdH8pYgnU51INX6LaKWHctLTtRzm
 CgwLe5uhnaQebFXq13ezW/eOeTo9uXFPWshH3HHWTySnGxiFf9OTdHFnBgJM/GBkNHX+
 Zdk3r6LJqx8P2j6ErDcQivr/Gjj6deBrAJvB9K+SEtH5ed1kqXGSOaRGK3dW+b6q9kkb
 /xIg==
X-Gm-Message-State: ANhLgQ2Sxbt9s2CgV8vqrEZdgyNwIehHCK3n8ANVy3VMmd1MId8LnfgI
 pmQszRl7lqqAt4eUa/xrBo6CXi1XkuFEUEgADqIXQhblNTbf717uokZIZPgKMhdPeyQOT8mgwQW
 +c8RdMBPkxc/2Q+c=
X-Received: by 2002:ac8:1aed:: with SMTP id h42mr13848530qtk.43.1584117085095; 
 Fri, 13 Mar 2020 09:31:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs5QB47HaGYveRzVLCq5L3AY/Ccre9w6hsSkxjJbavRPyIWM1i3+PzbyG/JjB8AZjXULgX/7A==
X-Received: by 2002:ac8:1aed:: with SMTP id h42mr13848488qtk.43.1584117084660; 
 Fri, 13 Mar 2020 09:31:24 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id p24sm10343322qtq.37.2020.03.13.09.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 09:31:23 -0700 (PDT)
Date: Fri, 13 Mar 2020 12:31:22 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200313163122.GB95517@xz-x1>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <20200313112902-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200313112902-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Fri, Mar 13, 2020 at 11:29:59AM -0400, Michael S. Tsirkin wrote:
> On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
> > [..]
> > > >=20
> > > > CCing Tom. @Tom does vhost-vsock work for you with SEV and current =
qemu?
> > > >=20
> > > > Also, one can specify iommu_platform=3Don on a device that ain't a =
part of
> > > > a secure-capable VM, just for the fun of it. And that breaks
> > > > vhost-vsock. Or is setting iommu_platform=3Don only valid if
> > > > qemu-system-s390x is protected virtualization capable?
> > > >=20
> > > > BTW, I don't have a strong opinion on the fixes tag. We currently d=
o not
> > > > recommend setting iommu_platform, and thus I don't think we care to=
o
> > > > much about past qemus having problems with it.
> > > >=20
> > > > Regards,
> > > > Halil
> > >=20
> > >=20
> > > Let's just say if we do have a Fixes: tag we want to set it correctly=
 to
> > > the commit that needs this fix.
> > >=20
> >=20
> > I finally did some digging regarding the performance degradation. For
> > s390x the performance degradation on vhost-net was introduced by commit
> > 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
> > IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
> > calculated as the rest of the memory regions size (from address), and
> > covered most of the guest address space. That is we didn't have a whole
> > lot of IOTLB API overhead.
> >=20
> > With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xfff which=
 comes
> > as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things worki=
ng
> > properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the level o=
f
> > 076a93d797 and 076a93d797~1.
>=20
> Peter, what's your take on this one?

Commit 076a93d797 was one of the patchset where we want to provide
sensible IOTLB entries and also that should start to work with huge
pages.  Frankly speaking after a few years I forgot the original
motivation of that whole thing, but IIRC there's a patch that was
trying to speedup especially for vhost but I noticed it's not merged:

https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00574.html

Regarding to the current patch, I'm not sure I understand it
correctly, but is that performance issue only happens when (1) there's
no intel-iommu device, and (2) there is iommu_platform=3Don specified
for the vhost backend?

If so, I'd confess I am not too surprised if this fails the boot with
vhost-vsock because after all we speicified iommu_platform=3Don
explicitly in the cmdline, so if we want it to work we can simply
remove that iommu_platform=3Don when vhost-vsock doesn't support it
yet...  I thougth iommu_platform=3Don was added for that case - when we
want to force IOMMU to be enabled from host side, and it should always
be used with a vIOMMU device.

However I also agree that from performance POV this patch helps for
this quite special case.

Thanks,

--=20
Peter Xu


