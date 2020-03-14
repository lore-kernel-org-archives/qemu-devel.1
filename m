Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F0BC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 18:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7180420751
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 18:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp+cgMDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7180420751
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDBRU-0000Gd-E7
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 14:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDBQr-00088I-65
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDBQp-00016y-8J
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:22:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27703
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDBQp-00012r-4r
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584210162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQb+iBTnzwuymekHVpiE0GaqWaAtgh1LKmDD/jRfaRE=;
 b=Xp+cgMDcEuQEqXMVQFsj+rdSIcmkc0Fj3Hpnv5BjD2HpO3mwUoPE+evXf16yG27BNj7f0k
 vvngN7OHt+Bqf57KElgTbGG5/7LAUPgHM/TWsh2vUEnQmdRG3Etfdg2DLN0y7fqu00q9UI
 JSHMnRuND7sglDxzteDtVmNArkuLsR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-CKnhZH5cNIuWvLSOmSkIbA-1; Sat, 14 Mar 2020 14:22:40 -0400
X-MC-Unique: CKnhZH5cNIuWvLSOmSkIbA-1
Received: by mail-wr1-f71.google.com with SMTP id u18so6211495wrn.11
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 11:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nvX4hyRK+FdnahxsvXMFwjI5fSn9UQUuLFLcGpb+YCs=;
 b=gou5pVFY7NkAgm10Ysz1lYpCmKndnXuSd4k4uC62pTUXpic2RidJjqzrPdbFBEYKEP
 59vbW4SSl+DZy6sMJLRduhXiINbgEgImzSPW+YcXuBr3Uw1Md9JeHtHTyRt3z0IgNLOH
 YbNUmts+YlbFmo8skxvkjVWt1DiAcI1gIQBeWrZn1zzVR9luDul/EewAI8IjZ9DPpgTY
 ovmPzOzIu1e8e5gobNMUsNxff3z5magf0P+YqQINnKWEnfbdEQvHpjWP3y/9wkVfebDI
 DVx3ZNdBl5+SG+FYrCbfGqoLguAi/wHeZQSDkHMo609wxYzpKmhu1YBCOUxUdqukWsA2
 cFlQ==
X-Gm-Message-State: ANhLgQ3GyfOIU7eO/6h2rysYTscoVHompY9e6FaZVf3Ctz+RBT9eewD0
 yfzLUywrdfRhFXSYkTAhgUfz8xRlR/1A7ZIiw31OSfQCww+VkRWul2JAbk5aq30QGezR4yWkw3B
 mf66AP0wLv6rSUbE=
X-Received: by 2002:adf:f583:: with SMTP id f3mr6714649wro.243.1584210159505; 
 Sat, 14 Mar 2020 11:22:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvVREQqP5FW/+StaM0Ice/ouR7BrgiEMgy6Njnq+MZGD8V1g0t7DF5o0X//NdIQQkuxb9sqMQ==
X-Received: by 2002:adf:f583:: with SMTP id f3mr6714632wro.243.1584210159250; 
 Sat, 14 Mar 2020 11:22:39 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 o3sm23896329wme.36.2020.03.14.11.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 11:22:38 -0700 (PDT)
Date: Sat, 14 Mar 2020 14:22:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200314142114-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <a79eec52-ec68-31a8-f692-17da0723e36c@amd.com>
MIME-Version: 1.0
In-Reply-To: <a79eec52-ec68-31a8-f692-17da0723e36c@amd.com>
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 03:27:59PM -0500, Brijesh Singh wrote:
>=20
> On 3/13/20 7:44 AM, Halil Pasic wrote:
> > [..]
> >>> CCing Tom. @Tom does vhost-vsock work for you with SEV and current qe=
mu?
> >>>
> >>> Also, one can specify iommu_platform=3Don on a device that ain't a pa=
rt of
> >>> a secure-capable VM, just for the fun of it. And that breaks
> >>> vhost-vsock. Or is setting iommu_platform=3Don only valid if
> >>> qemu-system-s390x is protected virtualization capable?
> >>>
> >>> BTW, I don't have a strong opinion on the fixes tag. We currently do =
not
> >>> recommend setting iommu_platform, and thus I don't think we care too
> >>> much about past qemus having problems with it.
> >>>
> >>> Regards,
> >>> Halil
> >>
> >> Let's just say if we do have a Fixes: tag we want to set it correctly =
to
> >> the commit that needs this fix.
> >>
> > I finally did some digging regarding the performance degradation. For
> > s390x the performance degradation on vhost-net was introduced by commit
> > 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
> > IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
> > calculated as the rest of the memory regions size (from address), and
> > covered most of the guest address space. That is we didn't have a whole
> > lot of IOTLB API overhead.
> >
> > With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0xfff which=
 comes
> > as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things worki=
ng
> > properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the level o=
f
> > 076a93d797 and 076a93d797~1.
> >
> > Regarding vhost-vsock. It does not work with iommu_platform=3Don since =
the
> > very beginning (i.e. 8607f5c307 ("virtio: convert to use DMA api")). No=
t
> > sure if that is a good or a bad thing. (If the vhost driver in the kern=
el
> > would actually have to do the IOTLB translation, then failing in case
> > where it does not support it seems sane. The problem is that
> > ACCESS_PLATFORM is used for more than one thing (needs translation, and
> > restricted memory access).)
> >
> > I don't think I've heard back from AMD whether vsock works with SEV or
> > not... I don't have access to HW to test it myself.
>=20
>=20
> I just tried vhost-vsock on AMD SEV machine and it does not work. I am
> using FC31 (qemu 4.1.1.1.fc31).

Neither does vhost scsi - no ACCESS_PLATFORM support. But with Jason's
patch I think both should work. Pls give it a try.

>=20
> > We (s390) don't require this being backported to the stable qemus,
> > because for us iommu_platform=3Don becomes relevant with protected
> > virtualization, and those qemu versions don't support it.
> >
> > Cheers,
> > Halil
> >


