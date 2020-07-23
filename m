Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01573C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE2F20768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4ApkufW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE2F20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyamJ-0003dA-2w
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyak4-0000CM-4i
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:54:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyak2-0007gG-7K
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTJhLqXBmxj/4dVTaPvLm1Yk734MNLQxS+qR5/YkRHU=;
 b=Y4ApkufWDPvtlnjIq+feqg3dgUs1Ep3QRncA9drP89rFcdhwYXBEsrqlvGKvqABDIMBgl8
 kmDXRaRbSK/LKpQ6QSjVMZRl/XC+HryfdN7oQlT+f1FaWSLUGzVTYPI2dDN/B6uw6xz7F+
 QOBgNkiZSGaB47bQiUiETRlMCZeRgCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-lANMCmYYOaCdTRg2VHZ_mQ-1; Thu, 23 Jul 2020 08:54:26 -0400
X-MC-Unique: lANMCmYYOaCdTRg2VHZ_mQ-1
Received: by mail-wm1-f71.google.com with SMTP id u68so2330918wmu.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gTJhLqXBmxj/4dVTaPvLm1Yk734MNLQxS+qR5/YkRHU=;
 b=MNPtFqUCvUZ+fjm0dO7CnwXMQTobiS1jm8RGYVxLr6njuRneJDzG/SzpRnjSssUSZS
 Pl4mKzqXJe8QdzNb4I4JqiHKdCOBrR7oV87p4uKXgEQcY4kOOMNdWiKbJ9yBAZoCBXfw
 ORIwyLYjQg68Mfc419821dhpQm+o4Kwg1uZSUJz2UcPJYxAg86Mpqm+f8OGnxEu7gwg3
 5ejCQZD3KGcHDiobEiCZNR650r9WVgLvUQALsSF7PDE0exJybwRIX8hT//W+sI8+hR78
 ZUNyeLrY5drMHSnaxCrzOKL4qV5kC9oULpn5kUGmjGop4lOfMAZtqrmp6cjx0CGHVOG1
 N+eQ==
X-Gm-Message-State: AOAM530oYH9n3mRwgVY64I6WFHot05d1v5tSxMAPzFCTOWNcKt6nBxFr
 HVeonz7b6kr4Sg59bfAo/Qr/WDJj4bIsDJD2N2y2v5iJ9fkqchMOxZVi3bf5BjVvgsynfPxHvW1
 T3mqfIwq4E7YC/VQ=
X-Received: by 2002:adf:df89:: with SMTP id z9mr3899386wrl.395.1595508865391; 
 Thu, 23 Jul 2020 05:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1IqX8aJfbN1V82tdEO0faLQNAQT7ORMSqd6/ZyQJeTyv6yGBvpW/Ip+TD7txN/Dz4KKSw8w==
X-Received: by 2002:adf:df89:: with SMTP id z9mr3899370wrl.395.1595508865181; 
 Thu, 23 Jul 2020 05:54:25 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id z16sm3640366wrr.35.2020.07.23.05.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 05:54:24 -0700 (PDT)
Date: Thu, 23 Jul 2020 08:54:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/2] virtio: non-legacy device handling
Message-ID: <20200723085313-mutt-send-email-mst@kernel.org>
References: <20200707105446.677966-1-cohuck@redhat.com>
 <51e457ef-106e-1c1a-778d-4d53d9e48d8e@redhat.com>
 <20200720050215-mutt-send-email-mst@kernel.org>
 <4309b9dd-cc94-e183-60f8-67e4ec36c666@redhat.com>
 <20200723083313.49e3502a.cohuck@redhat.com>
 <c4c2e135-d648-0754-cae4-264a3d3f9892@redhat.com>
 <20200723141507.2e3004d8.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723141507.2e3004d8.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 02:15:07PM +0200, Cornelia Huck wrote:
> On Thu, 23 Jul 2020 13:57:08 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > On 23.07.20 08:33, Cornelia Huck wrote:
> > > On Mon, 20 Jul 2020 11:07:51 +0200
> > > David Hildenbrand <david@redhat.com> wrote:
> > >   
> > >> On 20.07.20 11:03, Michael S. Tsirkin wrote:  
> > >>> On Mon, Jul 20, 2020 at 10:09:57AM +0200, David Hildenbrand wrote:    
> > >>>> On 07.07.20 12:54, Cornelia Huck wrote:    
> > >>>>> As discussed in "virtio-fs: force virtio 1.x usage", it seems like
> > >>>>> a good idea to make sure that any new virtio device (which does not
> > >>>>> support legacy virtio) is indeed a non-transitional device, just to
> > >>>>> catch accidental misconfigurations. We can easily compile a list
> > >>>>> of virtio devices with legacy support and have transports verify
> > >>>>> in their plugged callbacks that legacy support is off for any device
> > >>>>> not in that list.
> > >>>>>
> > >>>>> Most new virtio devices force non-transitional already, so nothing
> > >>>>> changes for them. vhost-user-fs-pci even does not allow to configure
> > >>>>> a non-transitional device, so it is fine as well.
> > >>>>>
> > >>>>> One problematic device, however, is virtio-iommu-pci. It currently
> > >>>>> offers both the transitional and the non-transitional variety of the
> > >>>>> device, and does not force anything. I'm unsure whether we should
> > >>>>> consider transitional virtio-iommu unsupported, or if we should add
> > >>>>> some compat handling. (The support for legacy or not generally may
> > >>>>> change based upon the bus, IIUC, so I'm unsure how to come up with
> > >>>>> something generic.)
> > >>>>>
> > >>>>> Cornelia Huck (2):
> > >>>>>   virtio: list legacy-capable devices
> > >>>>>   virtio: verify that legacy support is not accidentally on    
> > >>>>
> > >>>> I'd squash both patches. Looking at patch #1, I wonder why we don't
> > >>>> store that information along with the device implementation? What was
> > >>>> the motivation to define this information separately?    
> > >>>
> > >>> Because people seem to cut and paste code, so when one
> > >>> enables it in an old device, it gets pasted into a new one.
> > >>> With a list in a central place, it's easier to figure out
> > >>> what's going on.    
> > >>
> > >> Makes sense, I suggest adding that to the patch description.  
> > > 
> > > "The list of devices supporting legacy is supposed to be static. We
> > > keep it in a central place to make sure that new devices do not enable
> > > legacy by accident."
> > > 
> > > ?  
> > 
> > Ack!
> > 
> > >   
> > >>
> > >> Both patches look sane to me (- squashing them).
> > >>  
> > > 
> > > Patch 1 does not change behaviour, while patch 2 does (for
> > > virtio-iommu-pci). Still would like an opinion whether changing the
> > > behaviour for virtio-iommu-pci with no compat handling is ok.
> > > 
> > > (I could be persuaded to squash them.)  
> > 
> > I'm a friend of introducing helper functions along with code that
> > actually uses it. But I agree that the change in behavior might be
> > hairy. Maybe we can split that out somehow to give it more attention?
> 
> It should not really be noticeable for anything but virtio-iommu.
> 
> However, I see these are already in a pull request...

Yea, sorry about being hasty.

-- 
MST


