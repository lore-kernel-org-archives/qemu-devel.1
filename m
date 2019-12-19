Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8964820684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CITP3TJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8964820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxGh-00012f-Lq
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ihx7Y-0003qr-7o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ihx7V-0004NZ-Uh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:49:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ihx7V-0004GI-MG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1ipqa5OHZtHNf2lKB/75/Pigv0YWOWhwRNr4xbpilQ=;
 b=CITP3TJIohlfTftxnxuF2Pz6PpaG7rmNYVoBRLIzv886As+OHTPaLSCBcFmZtnd5iKyYO2
 U8Y5munFavU78mwqUEBRi8KBulQvq3lUcD9yHEqZbe0HaE0GPaKsK3d2Ai5AmXP7IB9nMR
 jMVjZQgiJH+uMLzLjyOmBuhF0EEp4f4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-UkTv5fTTOMiISPdmqxqOdA-1; Thu, 19 Dec 2019 09:49:39 -0500
Received: by mail-qv1-f72.google.com with SMTP id v3so778731qvm.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QcEDdS4yPAEfgnuLolXGQpaGkrW+DFNO/rchi1OL1H8=;
 b=TE2N5zhWqlnHrknsndnWEGdoSH1B1KA+ELYjtmy/iY/G4ldDTL2gF/qEB3iDvxFqqf
 iiezQtECadUe+dVqI98Pr4TLwT1iPP89A2jNUopNZtGgTiYDxN4iT9JCs2atmmfDhl5j
 XEKBjj6PpSyiVoST3sIWCcENxT3szEkSyuY+C36FzTQ00/Usrjuiot+8WNCmyr3gubdr
 /fXjeo8oJZS9Sxs/pSQwHK6dpj+PUL0PO68RV5qP8Sa5WxMf0gG8GykfPY1DOb5uDYdO
 0uZlAR2GIFpI7T7qLojqB4rT4IGHHnU/OdYtY5QPqahRbZmzn+Rni8h/yfmrARcqv+6Z
 3UbA==
X-Gm-Message-State: APjAAAWim/UZ5NjxpRmcqvLNeMHBlLREeXgXlgRD95v+iMrBvUWWVcpy
 l5/uR/Ds3gcgigmI1kvUmwgFspmZ4IUTldV3cf7ur0TvqStOkq7qlF4eNNlaWZjOLxpmXZnkH8k
 RC7kU1wtYetvkSXw=
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr7455839qtu.2.1576766978592;
 Thu, 19 Dec 2019 06:49:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDSmMC1/uJcrp/vMGki65iYTB2oZsfrn+xtKSFdAmqx+R5HSXTeKZNXOkI5VZxj1YfU58TRg==
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr7455812qtu.2.1576766978297;
 Thu, 19 Dec 2019 06:49:38 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id f42sm1969151qta.0.2019.12.19.06.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 06:49:37 -0800 (PST)
Date: Thu, 19 Dec 2019 09:49:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20191219144936.GB50561@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com>
 <20191210193342.GJ3352@xz-x1>
 <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
 <20191219133308.GA4246@xz-x1>
 <9d58b293-ada0-353e-bba2-ad1f538dfc62@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9d58b293-ada0-353e-bba2-ad1f538dfc62@redhat.com>
X-MC-Unique: UkTv5fTTOMiISPdmqxqOdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 03:38:34PM +0100, Auger Eric wrote:
> Hi Peter,
>=20
> On 12/19/19 2:33 PM, Peter Xu wrote:
> > On Thu, Dec 19, 2019 at 11:30:40AM +0100, Auger Eric wrote:
> >> Hi Peter,
> >> On 12/10/19 8:33 PM, Peter Xu wrote:
> >>> On Fri, Nov 22, 2019 at 07:29:31PM +0100, Eric Auger wrote:
> >>>> This patch implements the translate callback
> >>>>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>>
> >>>> ---
> >>>>
> >>>> v10 -> v11:
> >>>> - take into account the new value struct and use
> >>>>   g_tree_lookup_extended
> >>>> - switched to error_report_once
> >>>>
> >>>> v6 -> v7:
> >>>> - implemented bypass-mode
> >>>>
> >>>> v5 -> v6:
> >>>> - replace error_report by qemu_log_mask
> >>>>
> >>>> v4 -> v5:
> >>>> - check the device domain is not NULL
> >>>> - s/printf/error_report
> >>>> - set flags to IOMMU_NONE in case of all translation faults
> >>>> ---
> >>>>  hw/virtio/trace-events   |  1 +
> >>>>  hw/virtio/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++++++=
++-
> >>>>  2 files changed, 63 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> >>>> index f25359cee2..de7cbb3c8f 100644
> >>>> --- a/hw/virtio/trace-events
> >>>> +++ b/hw/virtio/trace-events
> >>>> @@ -72,3 +72,4 @@ virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc e=
ndpoint=3D%d"
> >>>>  virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=3D%d"
> >>>>  virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
> >>>>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
> >>>> +virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, =
uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
> >>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> >>>> index f0a56833a2..a83666557b 100644
> >>>> --- a/hw/virtio/virtio-iommu.c
> >>>> +++ b/hw/virtio/virtio-iommu.c
> >>>> @@ -412,19 +412,80 @@ static IOMMUTLBEntry virtio_iommu_translate(IO=
MMUMemoryRegion *mr, hwaddr addr,
> >>>>                                              int iommu_idx)
> >>>>  {
> >>>>      IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> >>>> +    viommu_interval interval, *mapping_key;
> >>>> +    viommu_mapping *mapping_value;
> >>>> +    VirtIOIOMMU *s =3D sdev->viommu;
> >>>> +    viommu_endpoint *ep;
> >>>> +    bool bypass_allowed;
> >>>>      uint32_t sid;
> >>>> +    bool found;
> >>>> +
> >>>> +    interval.low =3D addr;
> >>>> +    interval.high =3D addr + 1;
> >>>> =20
> >>>>      IOMMUTLBEntry entry =3D {
> >>>>          .target_as =3D &address_space_memory,
> >>>>          .iova =3D addr,
> >>>>          .translated_addr =3D addr,
> >>>> -        .addr_mask =3D ~(hwaddr)0,
> >>>> +        .addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1,
> >>>>          .perm =3D IOMMU_NONE,
> >>>>      };
> >>>> =20
> >>>> +    bypass_allowed =3D virtio_has_feature(s->acked_features,
> >>>> +                                        VIRTIO_IOMMU_F_BYPASS);
> >>>> +
> >>>
> >>> Would it be easier to check bypass_allowed here once and then drop th=
e
> >>> latter [1] and [2] check?
> >> bypass_allowed does not mean you systematically bypass. You bypass if
> >> the SID is unknown or if the device is not attached to any domain.
> >> Otherwise you translate. But maybe I miss your point.
> >=20
> > Ah ok, then could I ask how will this VIRTIO_IOMMU_F_BYPASS be used?
> > For example, I think VT-d defines passthrough in a totally different
> > way in that the PT mark will be stored in the per-device context
> > entries, then we can allow a specific device to be pass-through when
> > doing DMA.  That information is explicit (e.g., unknown SID will
> > always fail the DMA), and per-device.
> >=20
> > Here do you mean that you just don't put a device into any domain to
> > show it wants to use PT?  Then I'm not sure how do you identify
> > whether this is a legal PT or a malicious device (e.g., an unknown
> > device that even does not have any driver bound to it, which will also
> > satisfy "unknown SID" and "not attached to any domain", iiuc).
>=20
> The virtio-iommu spec currently says:
>=20
> "If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
> unattached endpoints are
> allowed and translated by the IOMMU using the identity function. If the
> feature is not negotiated, any
> memory access from an unattached endpoint fails. Upon attaching an
> endpoint in bypass mode to a new
> domain, any memory access from the endpoint fails, since the domain does
> not contain any mapping.
> "
>=20
> I guess this can serve the purpose of devices doing early accesses,
> before the guest OS gets the hand and maps them?

OK, so there's no global enablement knob for virtio-iommu? Hmm... Then:

  - This flag is a must for all virtio-iommu emulation, right?
    (otherwise I can't see how system bootstraps..)

  - Should this flag be gone right after OS starts (otherwise I think
    we still have the issue that any malicious device can be seen as
    in PT mode as default)?  How is that done?

Thanks,

--=20
Peter Xu


