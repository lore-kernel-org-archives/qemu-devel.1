Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C58C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD09206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROn2F+sL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD09206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmHI-00060z-KB
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCmGK-0005CO-3X
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCmGH-0006dz-Pc
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:30:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30243
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCmGH-0006db-L9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584113409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyexBr+8KqHq8J29LV61OED9DMH98E0XqRozPeWmMFA=;
 b=ROn2F+sLvn9NK6eGxVs65kzUQgreMUGFubathu200kXj3GEpYQT0QkkiGtZc/HyXHRbKE6
 y/BHv8T6tpx6hvJjYFiRca/m4wcQa+zOOpa2I6q12Mg0y6ufBng7kxyVnnugnf+tXQHFR1
 3f10jPZ/UzXzGzR0FZFzpNAF0fl2djA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-rMLSLnL6N9S_ZPwJ_L0I8A-1; Fri, 13 Mar 2020 11:30:07 -0400
X-MC-Unique: rMLSLnL6N9S_ZPwJ_L0I8A-1
Received: by mail-qv1-f70.google.com with SMTP id l16so7790463qvo.15
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 08:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8QhZGRIh2CUy5eYCd/wAtYqcw5kTMU5ZayIslBGh1qk=;
 b=IkpuVsPSwB6j09QeazxnXIPDQp6ZUDmHeZ360MoD/UAjkVytTSx2Q9gBPE2FReCySL
 kb8Jd4OVP5OG4biGBVwz5k3eFHASVaLotL81xARsbl9fTbiZRhPHqCCsmMD+Wh1Sy1NN
 gdfyOQ0DONOi5tWnFyzEGzGoRFpRCd+WdSp4atMwHlld2J4CgUQYBnPDn6Q/a2FYgEsW
 uct9qB1P7c0dn6cxW4yFpwn3FYQwtFJ9ngNcQTjqVRlKz0souNa5+VNT1LEgWO0MVFDL
 QPGrO2gC2epVFQpP/MJsIH/a3WmXM/Hz18hnlZo7nd0mpf2UPl4HXuncTMUXkBRPurvb
 wHwQ==
X-Gm-Message-State: ANhLgQ3shNTA4SmNXZiUVxkbRykYymVSQsWmC2kKO0NxD61HfjUmXshC
 EoXTe97nmUyFSzbejyrb68TheBLxo02z0p1sBe2dV5+lPVHFQ3ccKhm2pQfcgAbklLF6C6BMxF7
 JD5y1mY5BoTV88lQ=
X-Received: by 2002:aed:2591:: with SMTP id x17mr13153861qtc.380.1584113407023; 
 Fri, 13 Mar 2020 08:30:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vttDoeEXJiyF2bLdnFNpU41LU31LK/XdG45WbJjb4Y1KQdUd8pPEj7XilU6NyTFQsxrmL8HDg==
X-Received: by 2002:aed:2591:: with SMTP id x17mr13153816qtc.380.1584113406622; 
 Fri, 13 Mar 2020 08:30:06 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id c18sm292951qka.111.2020.03.13.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 08:30:04 -0700 (PDT)
Date: Fri, 13 Mar 2020 11:29:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200313112902-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200313134446.782c5f7c.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
> [..]
> > >=20
> > > CCing Tom. @Tom does vhost-vsock work for you with SEV and current qe=
mu?
> > >=20
> > > Also, one can specify iommu_platform=3Don on a device that ain't a pa=
rt of
> > > a secure-capable VM, just for the fun of it. And that breaks
> > > vhost-vsock. Or is setting iommu_platform=3Don only valid if
> > > qemu-system-s390x is protected virtualization capable?
> > >=20
> > > BTW, I don't have a strong opinion on the fixes tag. We currently do =
not
> > > recommend setting iommu_platform, and thus I don't think we care too
> > > much about past qemus having problems with it.
> > >=20
> > > Regards,
> > > Halil
> >=20
> >=20
> > Let's just say if we do have a Fixes: tag we want to set it correctly t=
o
> > the commit that needs this fix.
> >=20
>=20
> I finally did some digging regarding the performance degradation. For
> s390x the performance degradation on vhost-net was introduced by commit
> 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
> IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
> calculated as the rest of the memory regions size (from address), and
> covered most of the guest address space. That is we didn't have a whole
> lot of IOTLB API overhead.
>=20
> With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xfff which c=
omes
> as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things working
> properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the level of
> 076a93d797 and 076a93d797~1.

Peter, what's your take on this one?


> Regarding vhost-vsock. It does not work with iommu_platform=3Don since th=
e
> very beginning (i.e. 8607f5c307 ("virtio: convert to use DMA api")). Not
> sure if that is a good or a bad thing. (If the vhost driver in the kernel
> would actually have to do the IOTLB translation, then failing in case
> where it does not support it seems sane. The problem is that
> ACCESS_PLATFORM is used for more than one thing (needs translation, and
> restricted memory access).)
>=20
> I don't think I've heard back from AMD whether vsock works with SEV or
> not... I don't have access to HW to test it myself.
>=20
> We (s390) don't require this being backported to the stable qemus,
> because for us iommu_platform=3Don becomes relevant with protected
> virtualization, and those qemu versions don't support it.
>=20
> Cheers,
> Halil


