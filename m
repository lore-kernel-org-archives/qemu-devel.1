Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77BFC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841EA2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8xcJDtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841EA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHP9w-0003Y6-OO
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHP9F-00033B-H5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHP9D-0000i2-NX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:50:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60067)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHP9D-0000hj-It
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585216199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwO+HnAcp9+MiFktD7YUOCU8dCndtW+TvunYGZUn6vI=;
 b=A8xcJDtLTvux+Ov33FhpIQvJIvngR5wnEPMBNBOrWSXC3BwCevCXznt2dKQT3NQzqEMK3C
 m8FcP6BiBhTaU+DOIqvUnH/nxmur3/bR3DKXU5sDvCQwzQoHM6SSMtkB5A1XHxdxF7Pl5o
 2mAhMDfA+eb0z3eJBiVaQ65pjA7d6Vo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-9dSSwn46OyWXHDkr8ijXZg-1; Thu, 26 Mar 2020 05:49:57 -0400
X-MC-Unique: 9dSSwn46OyWXHDkr8ijXZg-1
Received: by mail-wr1-f69.google.com with SMTP id e10so2765774wru.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 02:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NSdLnkX5cWkW77BXDTK3F4eLxqaTUjnvmwt+R66r9DM=;
 b=VbesZB7zVHmxybVpQBtf80aA35NBssj9F3lCuT1m7xFq/vJ6SPYEdPtBEMdCuR0sbE
 Xc1MX249y237dl1RLYMgnQp7G76pYabSdDyngtNinZ6AoyMjBZyY348BdntMScQyjfBa
 THuN/AVHDriWOY7D6EXX9Td5EJ/+48d3hiAI5nF1YFJRvqhRMv89n+piKkvF/wvFyvOW
 AQSAubs9UBb6CZSmPO0NuLPzX2PZJv1RiO3jgC3N8+p414oAHvmm6VPaecvyWowGc+oM
 vdKqIMzkoVqEGWC0DaA19mV1IDx7yLKPJBRDc+9IAVW2adD/ANNc4FmMVmH/PiSgh3px
 aXRw==
X-Gm-Message-State: ANhLgQ2t5Yk+xUKUv+0aj1IKYXWEOAJOwGr4l62S3w+3kj8xOqDDfq4R
 8B+zPwbeX+tn5bbZjBnSc+c8ywtrYCzsr+1oBfq5Vc5COVZFFXZNSKdUvIHDzCddldRg8ftj7hj
 p/GWUI4sqjAw9njE=
X-Received: by 2002:a05:600c:54d:: with SMTP id
 k13mr2200278wmc.161.1585216195791; 
 Thu, 26 Mar 2020 02:49:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vthiOYCqhaQ4ipeqgslIrJP5TXRiX5GolPTyZ0QmSXOrjZV02Xrn9oHBY26s1ICvZAq9CZzAQ==
X-Received: by 2002:a05:600c:54d:: with SMTP id
 k13mr2200244wmc.161.1585216195492; 
 Thu, 26 Mar 2020 02:49:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
 by smtp.gmail.com with ESMTPSA id 9sm2667566wmm.6.2020.03.26.02.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 02:49:54 -0700 (PDT)
Date: Thu, 26 Mar 2020 05:49:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200326054554-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
MIME-Version: 1.0
In-Reply-To: <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
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
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
>=20
>=20
> > Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
> >=20
> > =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wr=
ote:
> >>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >>>> 2. You are essentially stealing THPs in the guest. So the fastest
> >>>> mapping (THP in guest and host) is gone. The guest won't be able to =
make
> >>>> use of THP where it previously was able to. I can imagine this impli=
es a
> >>>> performance degradation for some workloads. This needs a proper
> >>>> performance evaluation.
> >>>=20
> >>> I think the problem is more with the alloc_pages API.
> >>> That gives you exactly the given order, and if there's
> >>> a larger chunk available, it will split it up.
> >>>=20
> >>> But for balloon - I suspect lots of other users,
> >>> we do not want to stress the system but if a large
> >>> chunk is available anyway, then we could handle
> >>> that more optimally by getting it all in one go.
> >>>=20
> >>>=20
> >>> So if we want to address this, IMHO this calls for a new API.
> >>> Along the lines of
> >>>=20
> >>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>                    unsigned int max_order, unsigned int *order)
> >>>=20
> >>> the idea would then be to return at a number of pages in the given
> >>> range.
> >>>=20
> >>> What do you think? Want to try implementing that?
> >>=20
> >> You can just start with the highest order and decrement the order unti=
l
> >> your allocation succeeds using alloc_pages(), which would be enough fo=
r
> >> a first version. At least I don't see the immediate need for a new
> >> kernel API.
> >=20
> > OK I remember now.  The problem is with reclaim. Unless reclaim is
> > completely disabled, any of these calls can sleep. After it wakes up,
> > we would like to get the larger order that has become available
> > meanwhile.
> >=20
>=20
> Yes, but that=E2=80=98s a pure optimization IMHO.
> So I think we should do a trivial implementation first and then see what =
we gain from a new allocator API. Then we might also be able to justify it =
using real numbers.
>=20

Well how do you propose implement the necessary semantics?
I think we are both agreed that alloc_page_range is more or
less what's necessary anyway - so how would you approximate it
on top of existing APIs?


> >=20
> >> --=20
> >> Thanks,
> >>=20
> >> David / dhildenb
> >=20


