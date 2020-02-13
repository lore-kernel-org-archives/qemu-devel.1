Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4DBC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FB220873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd5BuFs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FB220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FXd-0006LA-4n
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2FWU-0005jU-Oo
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2FWS-0001iL-ST
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:31:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42371
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2FWR-0001ar-At
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581604277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUteR72xgXThKQXsHqnRlSJO4a1mhfdTJyWRJwDdcdY=;
 b=bd5BuFs831f3/qkARXnx6NyjxQ+8rKGTwVM5v/8f0JYdNf1cbDZn/+Lt2VnOFicwM5o2k5
 J+eQBcV4MdIX/TpZi12+YFBzMRNd7r4dSXqw2QOzYSP3MHh9mI7JNgmzOOyx4GJgJUdr4h
 KuKelp/6PgHF3EF+W9+MgJQiFGNNKMA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-M86b12dNOM-0MDa8SYSDig-1; Thu, 13 Feb 2020 09:31:15 -0500
Received: by mail-qv1-f70.google.com with SMTP id v19so208965qvk.16
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H2iZA/EjBmlcJxLGlNtElex77R9i5KIlucE+aasVj8E=;
 b=RQ6Uys8I61r/N2wrtNe9nqw2XADMvmcjZSho6XKqMt8gUK/9ppKxNn3g+Li8vgzNlJ
 x1W/Y9iQV1kgbEAMgHeh44pF0ki8XRsf1ZxhIY+oSNr71sNYYT/pvAzqNttGco2CIUfr
 Aa0zV3XJJ0w2PWmxu7pPR30AUMsm5aumrIPAl2cDLFjm9nrtDCvW/AtkbrpgWyjDod7+
 rkbA1S+MjVQWK4hKfRiBnogHYu/YzCWD6XCcDSKOszN/CXGfvEDVkYV1FthgYcSjY90a
 8bxaWAa0LF2+qT9iAHEPMbC/z4lslP6VE2VnzCSZTtuRGO2iZp6+AiJJEWGQJmQk8qmP
 lpMA==
X-Gm-Message-State: APjAAAXDijk4VnwwLODVS345nUI41FJQ0mMYALhkpU+2S90rAbozagmS
 F+14qVdlnVvLrO8galuolQzB6fRSdXVcOqLS/ZuDa62/K48ShgpJUao+gK5CUEMC1FOjN/h4prv
 IMZZlrJgTekV/P7A=
X-Received: by 2002:a05:620a:2194:: with SMTP id
 g20mr12410544qka.227.1581604274536; 
 Thu, 13 Feb 2020 06:31:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCnsR5FnTgRpYraPOQNFn5JMYoRRe4NWXIkIMt3XhtrK99IdkD46xnA0clVscK4ouGtCvpXA==
X-Received: by 2002:a05:620a:2194:: with SMTP id
 g20mr12410505qka.227.1581604274188; 
 Thu, 13 Feb 2020 06:31:14 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id 8sm1422500qkm.92.2020.02.13.06.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:31:13 -0800 (PST)
Date: Thu, 13 Feb 2020 09:31:10 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 14/25] intel_iommu: add virtual command capability support
Message-ID: <20200213143110.GA1103216@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-15-git-send-email-yi.l.liu@intel.com>
 <20200211215630.GN984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BBBF4@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1BBBF4@SHSMSX104.ccr.corp.intel.com>
X-MC-Unique: M86b12dNOM-0MDa8SYSDig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 02:40:45AM +0000, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Wednesday, February 12, 2020 5:57 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v3 14/25] intel_iommu: add virtual command capability=
 support
> >=20
> > On Wed, Jan 29, 2020 at 04:16:45AM -0800, Liu, Yi L wrote:
> > > +/*
> > > + * The basic idea is to let hypervisor to set a range for available
> > > + * PASIDs for VMs. One of the reasons is PASID #0 is reserved by
> > > + * RID_PASID usage. We have no idea how many reserved PASIDs in futu=
re,
> > > + * so here just an evaluated value. Honestly, set it as "1" is enoug=
h
> > > + * at current stage.
> > > + */
> > > +#define VTD_MIN_HPASID              1
> > > +#define VTD_MAX_HPASID              0xFFFFF
> >=20
> > One more question: I see that PASID is defined as 20bits long.  It's
> > fine.  However I start to get confused on how the Scalable Mode PASID
> > Directory could service that much of PASID entries.
> >=20
> > I'm looking at spec 3.4.3, Figure 3-8.
> >=20
> > Firstly, we only have two levels for a PASID table.  The context entry
> > of a device stores a pointer to the "Scalable Mode PASID Directory"
> > page. I see that there're 2^14 entries in "Scalable Mode PASID
> > Directory" page, each is a "Scalable Mode PASID Table".
> > However... how do we fit in the 4K page if each entry is a pointer of
> > x86_64 (8 bytes) while there're 2^14 entries?  A simple math gives me
> > 4K/8 =3D 512, which means the "Scalable Mode PASID Directory" page can
> > only have 512 entries, then how the 2^14 come from?  Hmm??
>=20
> I checked with Kevin. The spec doesn't say the dir table is 4K. It says 4=
K
> only for pasid table. Also, if you look at 9.4, scalabe-mode context entr=
y
> includes a PDTS field to specify the actual size of the directory table.

Ah I see.  Then it seems to be lost then in this series.  Say, I think
vtd_sm_pasid_table_walk() should also stop walking until reaching the
size there, and you need to fetch that size info from the context
entry before walk starts.

>=20
> > Apart of this: also I just noticed (when reading the latter part of
> > the series) that the time that a pasid table walk can consume will
> > depend on this value too.  I'd suggest to make this as small as we
> > can, as long as it satisfies the usage.  We can even bump it in the
> > future.
>=20
> I see. This looks to be an optimization. right? Instead of modify the
> value of this macro,  I think we can do this optimization by tracking
> the allocated PASIDs in QEMU. Thus, the pasid table walk  would be more
> efficient and also no dependency on the VTD_MAX_HPASID. Does it make
> sense to you? :-)

Yeah sounds good. :)

Thanks,

--=20
Peter Xu


