Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B250C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3572064A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oR6iS9zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3572064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmnV-0002zQ-2l
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48515)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbmWw-0005jP-Bh
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbmWu-0001uS-CU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:46:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbmWq-0001mO-Kn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:46:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id j184so2013283oih.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iuenxfymjYPK6FovMGEgPgdUqIKEtkY+xzVJEShwu5o=;
 b=oR6iS9zdmBQc7fm3m1PcvEYPfPm/hFoXZQiGn8VrcNTHyJ7ZJFcdZrfzOQ8qlmWc0a
 jB6E35Tf3wiGSRv6ghl86QIXiZ0CfUJM87pylk4bI8wvyv3DcEgms0Px14R1glNwvYUy
 xpQbiyOXqx7q8jtcWy9SxUVYuu9jTohtc0Za6Y8dWBZTx7Onpb5YjOkl7i7LU0rIgxLC
 eLlzOQJrLGnJUNJ8RlCdueQzaelBA3sXdmaD8ygDj5JFW++loY2ayUHo8DTjUlC6qBcc
 RGJOlVYdfcUMowr/TJ3witULt1+qfBPTfGfotBniq/4A7aDq79iM27Z5crfrObdnQKfW
 39Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iuenxfymjYPK6FovMGEgPgdUqIKEtkY+xzVJEShwu5o=;
 b=uoUsWHBtsmozxT5ngZoNf955PvIXbTbe8+dPkyaibRM5xWAHtSD2TDIC8G6m6Zx3PK
 1gjj4QlQKGjQUgHNxzX2tokiUnF3qTceHPzEjh23aKDUh4Mve3ufm/uhUGY2cC92Ke50
 RqscmbD+8L8iNVN/6aqpxFz5IUlIGkBVHuwir/F9gOjcsHiO1vTgJ9F8t6ydCVvm7nQB
 NJKexjglkx2BoPK7w6RqmgoM3LoDCWU2kN3mbLNcOS9dMI9NDYwvmV0EujMIMWp6CHPL
 u3ldTlnXl36Oe05ZPfCbSzPZ0GMq3eVlMWTgXz20tN33lh9FbH4GB8WrY5Uk7XF0XUd2
 IJ7Q==
X-Gm-Message-State: APjAAAWrsaevCX4jbdAV7HJOESK8e4BA36J1nh82FxxWK3GqXJr90+Yk
 /5Ywz4HDXbzptWEc6MtNnmzc3hTTmiZfthli0k4aXA==
X-Google-Smtp-Source: APXvYqy/MeI7i6p/BSLAKRGvkqaMR2nvWlT9J2ys1u4oxYwjIC1izU3i/Mmom0aDYa4cLlFo06oaXd6vjLMUudN1VYE=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr1903243oij.98.1560519961536; 
 Fri, 14 Jun 2019 06:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190611142821.3874-1-eric.auger@redhat.com>
 <20190611142821.3874-3-eric.auger@redhat.com>
 <CAFEAcA_OYdL1TPN+OTdkZ0J2fx_4vFiXCs0fUVdGjkkMURCfZA@mail.gmail.com>
 <ef87a46b-06fc-a66d-37ca-4499afc76663@redhat.com>
In-Reply-To: <ef87a46b-06fc-a66d-37ca-4499afc76663@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 14:45:50 +0100
Message-ID: <CAFEAcA-Zo_qSsRfjrr-ewRU5ozc083Lw_vxaR1DufVOmtw5mdA@mail.gmail.com>
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/smmuv3: Implement dummy replay
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 at 14:40, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Peter,
>
> On 6/14/19 3:26 PM, Peter Maydell wrote:
> > On Tue, 11 Jun 2019 at 15:29, Eric Auger <eric.auger@redhat.com> wrote:
> >>
> >> On ARM we currently do not support VFIO-PCI devices protected
> >> by the IOMMU. Any attempt to run such use case results in this
> >> kind of warning:
> >>
> >> "-device vfio-pci,host=0004:01:00.0,id=hostdev0,bus=pci.1,addr=0x0:
> >> warning: SMMUv3 does not support notification on MAP: device vfio-pci
> >> will not function properly".

> >> +static inline void
> >> +smmuv3_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> >> +{
> >> +}
> >
> > This doesn't seem like a valid implementation of the replay
> > method to me. The API doc comment says
> >      * The default implementation of memory_region_iommu_replay() is to
> >      * call the IOMMU translate method for every page in the address space
> >      * with flag == IOMMU_NONE and then call the notifier if translate
> >      * returns a valid mapping. If this method is implemented then it
> >      * overrides the default behaviour, and must provide the full semantics
> >      * of memory_region_iommu_replay(), by calling @notifier for every
> >      * translation present in the IOMMU.
> >
> > This empty function is definitely not going to call the notifier
> > for every IOMMU translation...
> The situation is a bit odd. SMMUv3 is not integrated with VFIO so VFIO
> devices will not work anyway (we are not able to notify on MAP). There
> is a warning already reporting the issue. However the default
> implementation of memory_region_iommu_replay() prevents the guest from
> booting. So what would you advise?

I dunno, but if the API isn't supposed to behave the way we've
documented it to, we should fix the documentation... Since
the only user of memory_region_iommu_replay() is the vfio code
I guess we can define it however is most convenient for vfio,
but we should document what the method has to do to make things
work.

PS: we have a memory_region_iommu_replay_all() which currently
appears to be not used by anybody, could we get rid of it?

thanks
-- PMM

