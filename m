Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260CDC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27B120789
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJeMnUOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27B120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7d0-0006tc-3R
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jH7cD-0005yt-7h
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jH7cC-0000tb-3J
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:06:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jH7cB-0000tG-VK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585148803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27GxiLohBT5suEBlZpL3Il4w5Sf42Cq/mInk93gYD7s=;
 b=EJeMnUOCCpHLOcH6ArUZc4bOwDm0eDkwcIDp3U8kDnkJfFIYR53b6h2iW6+LBkpoDNFO9c
 higlmGhxALvCsNgrxR61lCGh52HVv9Yo0gUWGgLBUhb5/9Tmrv4TyG6sHc7DXYrzkUgtnn
 Bp2Fptps/1zzRQxwohCL1lWPqlLyckU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-wjdDku6qMfG52sN3KsPeRw-1; Wed, 25 Mar 2020 11:06:42 -0400
X-MC-Unique: wjdDku6qMfG52sN3KsPeRw-1
Received: by mail-wr1-f70.google.com with SMTP id b11so1262554wru.21
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FAab9/HeMr7kMt5AjMuUFNn2lljVsGjPi5izW+gN+7c=;
 b=WA240jIGyGuTawPlTEj6AG59bzzQBZdYgniTe45ulGwzqY0vXRvpGIl3H8GU7HRxjH
 LbmZbtEmCf/JBWSoYnzhkffEE16xgYwcyj7aBSdjLthLP5ii8dlrOTRIhGM4HTVmubyg
 V5TOOBJtuOaSec6mXp8MCPRxc/+AbjalMSEGnC+bFRiWwEUb/rgNNyJvLLRgIbjLUBnw
 +zlw7EYaV+2HQADsAf2Ih7dDsHoLz9vCzhAaSnfbTiRwMiNYGY9Ikm9qzQqApRfbqY3W
 4i8FdVwFpLHKI3gDZn/yhpmcYVl0Pb2IoZOET1K6szluXo6KtBeA95VVA3dM5khGwMdg
 tWnQ==
X-Gm-Message-State: ANhLgQ3qDc/6Oa2NcY8vJZAZat14cfv/ZZWMexOJAlemntRIAvvhqd2o
 5kOvhPUZJonnDiqhUaP2FTvamMHisLGsQULiYpM2zHvtzoV9EpJvk7+yWWDN4r1j2Q3wdigUSgU
 Ej8qbTvMj0GD1fDA=
X-Received: by 2002:adf:b641:: with SMTP id i1mr3983442wre.18.1585148799901;
 Wed, 25 Mar 2020 08:06:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt5ETVSo8dR+R+7i8SSLf/LUWWs9NXlkdrJEmQOHyPVXPwdmfg86Sy0hcGgWkpOc6gB33aZuA==
X-Received: by 2002:adf:b641:: with SMTP id i1mr3983412wre.18.1585148799682;
 Wed, 25 Mar 2020 08:06:39 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id w204sm9654772wma.1.2020.03.25.08.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:06:39 -0700 (PDT)
Date: Wed, 25 Mar 2020 11:06:34 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 15/22] intel_iommu: replay guest pasid bindings to host
Message-ID: <20200325150634.GC354390@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-16-git-send-email-yi.l.liu@intel.com>
 <20200324180013.GZ127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A202251@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A202251@SHSMSX104.ccr.corp.intel.com>
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 01:14:26PM +0000, Liu, Yi L wrote:

[...]

> > > +/**
> > > + * Caller of this function should hold iommu_lock.
> > > + */
> > > +static bool vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
> > > +                                        dma_addr_t pt_base,
> > > +                                        int start,
> > > +                                        int end,
> > > +                                        vtd_pasid_table_walk_info *i=
nfo)
> > > +{
> > > +    VTDPASIDEntry pe;
> > > +    int pasid =3D start;
> > > +    int pasid_next;
> > > +    VTDPASIDAddressSpace *vtd_pasid_as;
> > > +    VTDPASIDCacheEntry *pc_entry;
> > > +
> > > +    while (pasid < end) {
> > > +        pasid_next =3D pasid + 1;
> > > +
> > > +        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
> > > +            && vtd_pe_present(&pe)) {
> > > +            vtd_pasid_as =3D vtd_add_find_pasid_as(s,
> > > +                                       info->vtd_bus, info->devfn, p=
asid);
> >=20
> > For this chunk:
> >=20
> > > +            pc_entry =3D &vtd_pasid_as->pasid_cache_entry;
> > > +            if (s->pasid_cache_gen =3D=3D pc_entry->pasid_cache_gen)=
 {
> > > +                vtd_update_pe_in_cache(s, vtd_pasid_as, &pe);
> > > +            } else {
> > > +                vtd_fill_in_pe_in_cache(s, vtd_pasid_as, &pe);
> > > +            }
> >=20
> > We already got &pe, then would it be easier to simply call:
> >=20
> >                vtd_update_pe_in_cache(s, vtd_pasid_as, &pe);
> >=20
> > ?
>=20
> If the pasid_cache_gen is equal to iommu_state's, then it means there is
> a chance that the cached pasid entry is equal to pe here. While for the
> else case, it is surely there is no valid pasid entry in the pasid_as. An=
d
> the difference between vtd_update_pe_in_cache() and
> vtd_fill_in_pe_in_cache() is whether do a compare between the new pasid e=
ntry
> and cached pasid entry.
>=20
> > Since IIUC the cache_gen is only helpful to avoid looking up the &pe.
> > And the vtd_pasid_entry_compare() check should be even more solid than
> > the cache_gen.
>=20
> But if the cache_gen is not equal the one in iommu_state, then the cached
> pasid entry is not valid at all. The compare is only needed after the cac=
he_gen
> is checked.

Wait... If "the pasid entry context" is already exactly the same as
the "cached pasid entry context", why we still care the generation
number?  I'd just update the generation to latest and cache it again.
Maybe there's a tricky point when &pe=3D=3Dcache but generation number is
old, then IIUC what we can do better is simply update the generation
number to latest.

But OK - let's keep that.  I don't see anything incorrect with current
code either.

--=20
Peter Xu


