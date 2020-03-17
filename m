Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA4C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCDA2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRA0/USF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCDA2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jED0T-0007qR-6g
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jECyE-0004cr-S7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jECyD-0006hL-DJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:13:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32809)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jECyD-0006fA-9G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584454404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8a/Z2IOyUSb9V91dtDf91kJ6b5T/iwDRrUdAxIfFOL0=;
 b=hRA0/USFv9f8f+MzSeitec8Yfy28orRYe66zXcr4Z+L30Y7y6v58xVt23fsKpRx+EkS4+Q
 XqR1xYRgYCTyOED9vwbduxOaQEL6vYrblsBRGIqSNcsDJds5pxupU94Vzs+G7pFnnS7vnl
 cj8DCl++ouw10NCKtydATEd/yDnvYO4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-kQfoNdPWOmuApM09gpoJXQ-1; Tue, 17 Mar 2020 10:13:20 -0400
X-MC-Unique: kQfoNdPWOmuApM09gpoJXQ-1
Received: by mail-qt1-f200.google.com with SMTP id l1so21202597qtp.10
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nPavcgGBX1eR/CAge6T/JWebMF1Xn2eabWi2I2DnX0M=;
 b=EoBvleuhUyVVWH91uY8rae1r/J+70+cRqG+1xznmQRTVXomohCYgEkGrJXiO1gZhoY
 AjNr8R04O4imAcrlNxLfZ/qrRr5rAJQubbIKNdIbL83EeVN9Iw+YVlUQCFv7yyoBZldx
 DdhPtamnHkoBASGfZOVs2vCditzVbaZxleK9r6Zwzz/05ZrREjlQOwXV4NrO4OoPmQM5
 tktmB3V4wPWxTu8NBpGkpjdclh//vWER27j7LQpDIeHw5ugG5Rdx8dyjsm+fUunwlPGB
 68elRpdVlcgtc5YOfkzs3WhYgGe+xDx+toQiLRbl0JTws0geG2uXE1XGFluEt+MbpsfS
 LJYw==
X-Gm-Message-State: ANhLgQ0f7NtGJbrT7uALI+Ctyh6veWEaVB6iBEWr6fPdMSeiOxr8ZOF7
 aiYO6vIyUI9UcJAXbYTO/TUY17NF3EiiYbrhku0jAL8FohFej1KgjW3P/TeFJL/7+kAh7dnbzNr
 BP7LloCjCCHRia6E=
X-Received: by 2002:a37:482:: with SMTP id 124mr4896202qke.306.1584454399800; 
 Tue, 17 Mar 2020 07:13:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vthi+odn2LkvaujHeZJkhnPRRo3FvA+4J++ZlHO3knQIW+lR9KFpeZ9DOPb1T5CICcGcP6rbg==
X-Received: by 2002:a37:482:: with SMTP id 124mr4896165qke.306.1584454399395; 
 Tue, 17 Mar 2020 07:13:19 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id d185sm2072246qkf.46.2020.03.17.07.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 07:13:18 -0700 (PDT)
Date: Tue, 17 Mar 2020 10:13:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200317141316.GA199571@xz-x1>
References: <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <20200313112902-mutt-send-email-mst@kernel.org>
 <20200313163122.GB95517@xz-x1>
 <20200316131723-mutt-send-email-mst@kernel.org>
 <20200316181405.GB184827@xz-x1>
 <158fbd3b-1285-e18d-b535-a1e7a9802f1f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <158fbd3b-1285-e18d-b535-a1e7a9802f1f@redhat.com>
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
 Brijesh" <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 11:04:26AM +0800, Jason Wang wrote:
>=20
> On 2020/3/17 =E4=B8=8A=E5=8D=882:14, Peter Xu wrote:
> > On Mon, Mar 16, 2020 at 01:19:54PM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Mar 13, 2020 at 12:31:22PM -0400, Peter Xu wrote:
> > > > On Fri, Mar 13, 2020 at 11:29:59AM -0400, Michael S. Tsirkin wrote:
> > > > > On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
> > > > > > [..]
> > > > > > > > CCing Tom. @Tom does vhost-vsock work for you with SEV and =
current qemu?
> > > > > > > >=20
> > > > > > > > Also, one can specify iommu_platform=3Don on a device that =
ain't a part of
> > > > > > > > a secure-capable VM, just for the fun of it. And that break=
s
> > > > > > > > vhost-vsock. Or is setting iommu_platform=3Don only valid i=
f
> > > > > > > > qemu-system-s390x is protected virtualization capable?
> > > > > > > >=20
> > > > > > > > BTW, I don't have a strong opinion on the fixes tag. We cur=
rently do not
> > > > > > > > recommend setting iommu_platform, and thus I don't think we=
 care too
> > > > > > > > much about past qemus having problems with it.
> > > > > > > >=20
> > > > > > > > Regards,
> > > > > > > > Halil
> > > > > > > Let's just say if we do have a Fixes: tag we want to set it c=
orrectly to
> > > > > > > the commit that needs this fix.
> > > > > > >=20
> > > > > > I finally did some digging regarding the performance degradatio=
n. For
> > > > > > s390x the performance degradation on vhost-net was introduced b=
y commit
> > > > > > 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Be=
fore
> > > > > > IOMMUTLBEntry.addr_mask used to be based on plen, which in turn=
 was
> > > > > > calculated as the rest of the memory regions size (from address=
), and
> > > > > > covered most of the guest address space. That is we didn't have=
 a whole
> > > > > > lot of IOTLB API overhead.
> > > > > >=20
> > > > > > With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xf=
ff which comes
> > > > > > as ~TARGET_PAGE_MASK from flatview_do_translate(). To have thin=
gs working
> > > > > > properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the=
 level of
> > > > > > 076a93d797 and 076a93d797~1.
> > > > > Peter, what's your take on this one?
> > > > Commit 076a93d797 was one of the patchset where we want to provide
> > > > sensible IOTLB entries and also that should start to work with huge
> > > > pages.
> > > So the issue bundamentally is that it
> > > never produces entries larger than page size.
> > >=20
> > > Wasteful even just with huge pages, all the more
> > > so which passthrough which could have giga-byte
> > > entries.
> > >=20
> > > Want to try fixing that?
> > Yes we can fix that, but I'm still not sure whether changing the
> > interface of address_space_get_iotlb_entry() to cover adhoc regions is
> > a good idea, because I think it's still a memory core API and imho it
> > would still be good to have IOTLBs returned to be what the hardware
> > will be using (always page aligned IOTLBs).  Also it would still be
> > not ideal because vhost backend will still need to send the MISSING
> > messages and block for each of the continuous guest memory ranges
> > registered, so there will still be misterious delay.  Not to say
> > logically all the caches can be invalidated too so in that sense I
> > think it's as hacky as the vhost speedup patch mentioned below..
> >=20
> > Ideally I think vhost should be able to know when PT is enabled or
> > disabled for the device, so the vhost backend (kernel or userspace)
> > should be able to directly use GPA for DMA.  That might need some new
> > vhost interface.
>=20
>=20
> Yes but I think we don't need another API since we can send GPA->HVA mapp=
ing
> via device IOTLB API when we find there's no DMA translation at all (eith=
er
> PT or no vIOMMU).

Jason,

Do you mean what we've worked on before?

https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00574.html

(I just read the previous discussion on that patch, it seems to be
 exactly what we've discussed again...)

Thanks,

>=20
> Vhost doesn't need to know whether an address is an IOVA (vIOMMU) , GPA (=
no
> vIOMMU), or even HVA (dpdk virtio-user).
>=20
> Thanks
>=20
>=20
> >=20
> > For the s390's specific issue, I would think Jason's patch an simple
> > and ideal solution already.
> >=20
> > Thanks,
> >=20
>=20

--=20
Peter Xu


