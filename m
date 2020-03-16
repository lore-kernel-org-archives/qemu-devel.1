Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA5CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4675D205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gK0HypSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4675D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtj5-00080f-FB
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDtPN-0005rT-48
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDtPK-0004JT-67
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:20:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDtPK-00046L-0B
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584379205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VrAnODQA8RSpoxkZwm8E3zk0I33OfLI2F2f6gx5SO5A=;
 b=gK0HypSf7zw/smVhsJCu6cOuQtYEXQqQLbDN7B8cEvBSEE4Xbhqpn9DPDD81lgdooUnb3R
 fT1q8HC6rKDw6g6fYLUalClht4qrn0j6HZuIvQLWu+tVOJ3IymImsq6LbXiSdsKocMYA1N
 RrnPh2y3lKNFGsOlfHeJ5Z32Y9aFgx8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-J96A8VOcOOKLYf0YIuUfHg-1; Mon, 16 Mar 2020 13:20:00 -0400
X-MC-Unique: J96A8VOcOOKLYf0YIuUfHg-1
Received: by mail-wr1-f72.google.com with SMTP id f13so3152005wro.23
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KW81Xfmr23SQJN0YOnO6ewwkq/Jy/N/uDlYPT400wzQ=;
 b=MKlFsuuL4dRHhs7TeTmGat7UHX580clW7QATVnXZUGWel6p/DIE6WyEgo1YUURh6Bp
 fqT+UM4kIJWFESLmXJsO5QxvTqkUFKsdbqoSzQBNob0IuIzmApEp7GOBDJGbM2RSJF2t
 qWL3fH76vAwVVH9XA7L4u392XRKF5zkssvxjolrrAwaad5prwsrFaKnWnwKC1Ca+VnRR
 pwOhwwDYRxL0SdiN841kK4ThSjD+lT3AOF+DDdWetwPNfuMlqvo8EZhknbsEZ5zEcFdx
 uffuPxs1jpi1ZOjw9zwF9KLwkrkWiNKi5rSD8MpjqBjuRxhmtpQlRHyJhInwQ++TWEPH
 tbxg==
X-Gm-Message-State: ANhLgQ0QbtvgFBY0o0ifAJf3+g/fnoLqbUt7hczRFjzYkQBroZpRwxg5
 izIWJ9zlubtcryy3LDgOCf9tYzE+cTznMiN57R1ls2dZauwPyJT+97X64snZ9U4i4wR0PgebDuk
 uKIV3+TjqebCJmd8=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr410783wrw.358.1584379199445;
 Mon, 16 Mar 2020 10:19:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt0/QHmoL9Z7uWS9hl2cjtA9VoYM25WEKPNqvkacm9dOGRZsP5tgqhfXSV4jWXk5TRF10hHLw==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr410767wrw.358.1584379199152;
 Mon, 16 Mar 2020 10:19:59 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 f203sm436818wmf.18.2020.03.16.10.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:19:58 -0700 (PDT)
Date: Mon, 16 Mar 2020 13:19:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200316131723-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <20200313112902-mutt-send-email-mst@kernel.org>
 <20200313163122.GB95517@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200313163122.GB95517@xz-x1>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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

On Fri, Mar 13, 2020 at 12:31:22PM -0400, Peter Xu wrote:
> On Fri, Mar 13, 2020 at 11:29:59AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
> > > [..]
> > > > >=20
> > > > > CCing Tom. @Tom does vhost-vsock work for you with SEV and curren=
t qemu?
> > > > >=20
> > > > > Also, one can specify iommu_platform=3Don on a device that ain't =
a part of
> > > > > a secure-capable VM, just for the fun of it. And that breaks
> > > > > vhost-vsock. Or is setting iommu_platform=3Don only valid if
> > > > > qemu-system-s390x is protected virtualization capable?
> > > > >=20
> > > > > BTW, I don't have a strong opinion on the fixes tag. We currently=
 do not
> > > > > recommend setting iommu_platform, and thus I don't think we care =
too
> > > > > much about past qemus having problems with it.
> > > > >=20
> > > > > Regards,
> > > > > Halil
> > > >=20
> > > >=20
> > > > Let's just say if we do have a Fixes: tag we want to set it correct=
ly to
> > > > the commit that needs this fix.
> > > >=20
> > >=20
> > > I finally did some digging regarding the performance degradation. For
> > > s390x the performance degradation on vhost-net was introduced by comm=
it
> > > 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
> > > IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
> > > calculated as the rest of the memory regions size (from address), and
> > > covered most of the guest address space. That is we didn't have a who=
le
> > > lot of IOTLB API overhead.
> > >=20
> > > With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xfff whi=
ch comes
> > > as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things wor=
king
> > > properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the level=
 of
> > > 076a93d797 and 076a93d797~1.
> >=20
> > Peter, what's your take on this one?
>=20
> Commit 076a93d797 was one of the patchset where we want to provide
> sensible IOTLB entries and also that should start to work with huge
> pages.

So the issue bundamentally is that it
never produces entries larger than page size.

Wasteful even just with huge pages, all the more
so which passthrough which could have giga-byte
entries.

Want to try fixing that?


>  Frankly speaking after a few years I forgot the original
> motivation of that whole thing, but IIRC there's a patch that was
> trying to speedup especially for vhost but I noticed it's not merged:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00574.html
>=20
> Regarding to the current patch, I'm not sure I understand it
> correctly, but is that performance issue only happens when (1) there's
> no intel-iommu device, and (2) there is iommu_platform=3Don specified
> for the vhost backend?
>=20
> If so, I'd confess I am not too surprised if this fails the boot with
> vhost-vsock because after all we speicified iommu_platform=3Don
> explicitly in the cmdline, so if we want it to work we can simply
> remove that iommu_platform=3Don when vhost-vsock doesn't support it
> yet...  I thougth iommu_platform=3Don was added for that case - when we
> want to force IOMMU to be enabled from host side, and it should always
> be used with a vIOMMU device.
>=20
> However I also agree that from performance POV this patch helps for
> this quite special case.
>=20
> Thanks,
>=20
> --=20
> Peter Xu


