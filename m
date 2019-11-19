Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E79122365
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxZplH5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E79122365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX63A-0001Df-Cj
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iX62G-0000iy-18
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iX62D-0005BZ-1l
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:07:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iX62C-0005Av-ER
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574179639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eG+/FCXL/N96SDzU2FcBds//pU8xuIZph234SKsN/HY=;
 b=NxZplH5hV4Itw3Y3Rv+r0vI0taRKMjLZ1Z+jTeBgShwyo8OQYwdVNlISb3OUB8SF6apYsP
 i/XFdRYzdZLw9P7nbyvqiDYUOS4fvkYOwfgKxYOcp4Bf4rt4FUCinmqp7Ro1uT9Hy+c6jc
 sEsek0YLQCSDn7zUWZ2l0i4UYmeJh+g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-vUd01f94P9mKy-dgw2ST3Q-1; Tue, 19 Nov 2019 11:06:09 -0500
Received: by mail-qv1-f69.google.com with SMTP id k11so15022767qvw.19
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Z7n0m8XDhzcCucwL2MylJkxeQ1p1EVVENMaPHgt4K4g=;
 b=G6Vw+vajHEeCzj41Ngh0jOqaNj7fZl1SdnsYq8VyCnJC7S/XHRBg4xoS9E1HP17Iyh
 ettVY2WLdyFFbpujxQYQR99sLQ0c3lzDEFKhxtV2Q64bHKNVsaPZRY56r2c8v9BFVnFw
 nN0O7WO6pydo9biBbQXqa7SctagcCrSdpU5Kqla3m5sara74wmsf+hTrQCafrKaQnTWZ
 ddB/oNm/ZEyxXR9zhX7XfLkcCckcSrvDp5PNcoKoAS6AFSWrXZc8jI6yCB+J2DSOMMDQ
 CDiFrxtqvueNyI7rsPt4Q4z/f2kquz4iC6oBwZVzwwOK8fKu2X+xFsyOxFnmEnX6a8VV
 C01g==
X-Gm-Message-State: APjAAAW/8N+lw6oGZ/60auSMPEV9dlJJnu2Du3Gs9ow1PJ9AMnrcbfov
 63EpiNu9Dyj4CA/5+sVnhvjEly7Loav2puFvK1bifDAW+B3wz0lsVH8vbUqzXH5+gBPG0ZhmUeL
 IgWKVMYqH/8b+oRY=
X-Received: by 2002:a0c:c125:: with SMTP id f34mr8248924qvh.22.1574179569221; 
 Tue, 19 Nov 2019 08:06:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwREdoNZuUn2AJL37wKHT4eGa6+cxk9qv76vYONkZvUcldjXfkxli86NWukoW8GTbdc3I9Dyg==
X-Received: by 2002:a0c:c125:: with SMTP id f34mr8248896qvh.22.1574179568905; 
 Tue, 19 Nov 2019 08:06:08 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id x25sm10170887qki.63.2019.11.19.08.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 08:06:08 -0800 (PST)
Date: Tue, 19 Nov 2019 11:06:07 -0500
From: Peter Xu <peterx@redhat.com>
To: qi1.zhang@intel.com
Subject: Re: [PATCH v2 1/2] intel_iommu: split the resevred fields arrays
 into two ones
Message-ID: <20191119160607.GK9053@xz-x1>
References: <cover.1570503331.git.qi1.zhang@intel.com>
 <d3aa65ad0510cdafd5d7dcbc54bc250feb6aa59b.1570503331.git.qi1.zhang@intel.com>
MIME-Version: 1.0
In-Reply-To: <d3aa65ad0510cdafd5d7dcbc54bc250feb6aa59b.1570503331.git.qi1.zhang@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: vUd01f94P9mKy-dgw2ST3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 08:28:13PM +0800, qi1.zhang@intel.com wrote:
> @@ -3547,15 +3548,17 @@ static void vtd_init(IntelIOMMUState *s)
>      /*
>       * Rsvd field masks for spte
>       */
> -    vtd_paging_entry_rsvd_field[0] =3D ~0ULL;
> -    vtd_paging_entry_rsvd_field[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_=
bits);
> -    vtd_paging_entry_rsvd_field[2] =3D VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_=
bits);
> -    vtd_paging_entry_rsvd_field[3] =3D VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_=
bits);
> -    vtd_paging_entry_rsvd_field[4] =3D VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_=
bits);
> -    vtd_paging_entry_rsvd_field[5] =3D VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw=
_bits);
> -    vtd_paging_entry_rsvd_field[6] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw=
_bits);
> -    vtd_paging_entry_rsvd_field[7] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw=
_bits);
> -    vtd_paging_entry_rsvd_field[8] =3D VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw=
_bits);
> +    vtd_spte_rsvd[0] =3D ~0ULL;
> +    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd[2] =3D VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd[3] =3D VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd[4] =3D VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> +
> +    vtd_spte_rsvd_large[0] =3D ~0ULL;
> +    vtd_spte_rsvd_large[1] =3D VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd_large[4] =3D VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);

This looks good to me in general, but... Since we're at it, do you
think we can directly drop VTD_SPTE_LPAGE_L1_RSVD_MASK and
VTD_SPTE_LPAGE_L4_RSVD_MASK?  Are they really useful?

I think I'm using the latest vt-d spec now (June, 2019) and it only
supports 2M/1G huge pages, corresponds to VTD_SPTE_LPAGE_L2_RSVD_MASK
and VTD_SPTE_LPAGE_L3_RSVD_MASK.

--=20
Peter Xu


