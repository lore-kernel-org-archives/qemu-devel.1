Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A650C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D771320721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQre7bBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D771320721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKP3S-0005YK-Vx
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jKP2k-00054Z-OS
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jKP2i-0002JI-Vl
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:19:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jKP2i-0002Bv-La
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585930779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5isDP5hCYkjoQKMyfv8LDqDIgyzoAXB9d7DDEN3hZbA=;
 b=iQre7bBKNyNOsq3wt+sHDsZgwC7WubKa3+i2MiMBzx9AaiKWi3ORTuCa+QgGw9YF3KsguK
 jpJqGu6w/X8ZYmPbwzFIyq7BHonm+ttcTIyaA5S6/pFczH8fH5Shsu09qZ0TFEZbOKOwy/
 NX12z8BF+QXC0+oG9h3fV7kyqnQ7iWY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-mHjqRSEUPZGjMq6EaZmqyw-1; Fri, 03 Apr 2020 12:19:37 -0400
X-MC-Unique: mHjqRSEUPZGjMq6EaZmqyw-1
Received: by mail-wr1-f72.google.com with SMTP id a10so801836wra.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jC5f8fZGiX7uKor8bbyTsCc+YaC+MPnESGHQw8UFRR4=;
 b=dwuLAkzYvPoeD/FT00c7mrT5dRalxV1tGZ5ERMnO7e47NM+XveYzmXKaV2WW7CJs/M
 0SPuHQjaDBcULvqTYDChHg1QfbnYUTdFo61XlVT1eL/CPG0rwe/YFrZIcGQVLXslfVcf
 1yOf0tdm340UB63L9T5HF+DdVJdU0NPVLhF+KBhPJz7+anI97YRD062I+4pUZt0eU9mM
 XnvFEKDO+vkvDQEA9nXomLWXVLSggvUT2Gbd4Ufj9LCTFVhyf7YTqFFFMzIlV+Gr1AoR
 8dtUIK6dVVeGB2ZPZVFZ2KapaG7a7HT7Xt2b7BotZWEyZyZnpaozXlXRqmIxqZstImB4
 1RjQ==
X-Gm-Message-State: AGi0PuZDedetKsxM826TXi9PoNuT5mnZqS28Y/YGT8U4ZpqxyLSL1If1
 LCw6/qL9Cp+tgKFPX5tYFMu88xRkJ4VlArgHq1ZEkZI6tOFjSI3w6M+S5puLvu9S8m+897CjFNX
 dDAE+fqy8S7RzPVk=
X-Received: by 2002:a1c:5410:: with SMTP id i16mr9509908wmb.150.1585930776480; 
 Fri, 03 Apr 2020 09:19:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypLY+zT3xRq5nEtQagJKJDJGIGotV34rqRYEb9vMb//qbdDy8BDqxKwC2pquDy6yEduGRb4pJA==
X-Received: by 2002:a1c:5410:: with SMTP id i16mr9509883wmb.150.1585930776266; 
 Fri, 03 Apr 2020 09:19:36 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
 by smtp.gmail.com with ESMTPSA id 127sm12731831wmd.38.2020.04.03.09.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 09:19:35 -0700 (PDT)
Date: Fri, 3 Apr 2020 12:19:31 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 13/22] intel_iommu: add PASID cache management
 infrastructure
Message-ID: <20200403161931.GO103677@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-14-git-send-email-yi.l.liu@intel.com>
 <20200402000225.GC7174@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A21EAAD@SHSMSX104.ccr.corp.intel.com>
 <20200402134436.GI7174@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A220DE7@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A220DE7@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
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

On Fri, Apr 03, 2020 at 03:05:57PM +0000, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Thursday, April 2, 2020 9:45 PM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v2 13/22] intel_iommu: add PASID cache management
> > infrastructure
> >=20
> > On Thu, Apr 02, 2020 at 06:46:11AM +0000, Liu, Yi L wrote:
> >=20
> > [...]
> >=20
> > > > > +/**
> > > > > + * This function replay the guest pasid bindings to hots by
> > > > > + * walking the guest PASID table. This ensures host will have
> > > > > + * latest guest pasid bindings. Caller should hold iommu_lock.
> > > > > + */
> > > > > +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
> > > > > +                                            VTDPASIDCacheInfo
> > > > > +*pc_info) {
> > > > > +    VTDHostIOMMUContext *vtd_dev_icx;
> > > > > +    int start =3D 0, end =3D VTD_HPASID_MAX;
> > > > > +    vtd_pasid_table_walk_info walk_info =3D {.flags =3D 0};
> > > >
> > > > So vtd_pasid_table_walk_info is still used.  I thought we had
> > > > reached a consensus that this can be dropped?
> > >
> > > yeah, I did have considered your suggestion and plan to do it. But
> > > when I started coding, it looks a little bit weird to me:
> > > For one, there is an input VTDPASIDCacheInfo in this function. It may
> > > be nature to think about passing the parameter to further calling
> > > (vtd_replay_pasid_bind_for_dev()). But, we can't do that. The
> > > vtd_bus/devfn fields should be filled when looping the assigned
> > > devices, not the one passed by vtd_replay_guest_pasid_bindings() call=
er.
> >=20
> > Hacky way is we can directly modify VTDPASIDCacheInfo* with bus/devfn f=
or the
> > loop.  Otherwise we can duplicate the object when looping, so that we c=
an avoid
> > introducing a new struct which seems to contain mostly the same informa=
tion.
>=20
> I see. Please see below reply.
>=20
> > > For two, reusing the VTDPASIDCacheInfo for passing walk info may
> > > require the final user do the same thing as what the
> > > vtd_replay_guest_pasid_bindings() has done here.
> >=20
> > I don't see it happen, could you explain?
>=20
> my concern is around flags field in VTDPASIDCacheInfo. The flags not
> only indicates the invalidation granularity, but also indicates the
> field presence. e.g. VTD_PASID_CACHE_DEVSI indicates the vtd_bus/devfn
> fields are valid. If reuse it to pass walk info to vtd_sm_pasid_table_wal=
k_one,
> it would be meaningless as vtd_bus/devfn fields are always valid. But
> I'm fine to reuse it's more prefered. Instead of modifying the vtd_bus/de=
vn
> in VTDPASIDCacheInfo*, I'd rather to define another VTDPASIDCacheInfo var=
iable
> and pass it to vtd_sm_pasid_table_walk_one. This may not affect the futur=
e
> caller of vtd_replay_guest_pasid_bindings() as vtd_bus/devfn field are no=
t
> designed to bring something back to caller.

Yeah, let's give it a shot.  I know it's not ideal, but IMHO it's
still better than defining the page_walk struct and that might confuse
readers on what's the difference between the two.  When duplicating
the object, we can add some comment explaining this.

Thanks,

--=20
Peter Xu


