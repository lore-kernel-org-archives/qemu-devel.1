Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B15C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1724D2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwjiGH5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1724D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mtR-0006WK-8M
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0msD-0005cx-NM
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:16:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0msB-0008I5-NX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596032158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bH7VY3Hwrnao+IfvDBQJlXh7mn6Pu2IQGYb/DjC6oUw=;
 b=WwjiGH5PSL1/uTL9JiOMmnWc4z5UG0ZY7MuU4vRrmDWnyKCvCmR0jN8OVq9jjUB4YyUXVK
 v5EKnE5q1Ljn32nWTtxn01UacQ4fjIZqxWGU8XZQNNfbQ2lxehjRtvLDRpGBKOjAsrn9DE
 akqhJgxWXM3VpZTN4el6kq9aGw6wUK4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-5EbWXgFoNO-fT2nskMvu6g-1; Wed, 29 Jul 2020 10:15:53 -0400
X-MC-Unique: 5EbWXgFoNO-fT2nskMvu6g-1
Received: by mail-wr1-f70.google.com with SMTP id f7so6723566wrs.8
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 07:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bH7VY3Hwrnao+IfvDBQJlXh7mn6Pu2IQGYb/DjC6oUw=;
 b=eVEkYB/XHELvGoA6Zm/fbWNee0Acrenlk2fltfDC30yr71uQBgSGhXyEeM/Vnyq8C/
 oRKp5sW8byWKbWeZ5eyaJT/hj9qZ8R3zMxESWZHso6RpjyvQN1eI1wOylytiT3JwRCmf
 kV4Sux+eaeEqgMZI9ZzYZ86L3qMioi6nxn9z5HsAdViOAbenJec8UrTE62EECqp+QJDO
 VrbOGETmW/CUeXRADaumk7UcMQu4XbnK1VPozTTAspdgegy4vivQxAFQpvOd1o685Ogc
 IosGMT3Bb0yYTV2JJBOEIyiH96aAU7tc7QHllCCQk2pNjBkXMf0+Cmmo+7efkGbcN3wV
 DFbQ==
X-Gm-Message-State: AOAM533mpUK1sJukHY5y85Ru7smv7raZSl5xH/ZydpZ4ty08BIGd8IKc
 WbJQQvl7rkwYXOMsJrbLNP64LEoDLx0kj8nVugFB7xdT8j2TOS4BqEqRsitg7irU/jcQGUP1+P1
 2dSu4FnmJkpcOyEI=
X-Received: by 2002:adf:d84c:: with SMTP id k12mr29548857wrl.250.1596032152521; 
 Wed, 29 Jul 2020 07:15:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygLUT7BduEfNCx5ctazGsBsTSomS/rgEtnt++E7k9i+yCRzA4dRGHp1dknzXjG4qnBGUbKOg==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr29548844wrl.250.1596032152324; 
 Wed, 29 Jul 2020 07:15:52 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id g7sm5553730wrv.82.2020.07.29.07.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 07:15:51 -0700 (PDT)
Date: Wed, 29 Jul 2020 10:15:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC 0/2] virtio-rng: add a control queue
Message-ID: <20200729101522-mutt-send-email-mst@kernel.org>
References: <20200123151700.1367857-1-lvivier@redhat.com>
 <20200124110240.GH736986@stefanha-x1.localdomain>
 <e4b0d666-c2a8-6d95-28f4-b51fe80ef73a@redhat.com>
 <20200129154300.GB157595@stefanha-x1.localdomain>
 <eeb362c9-24e8-49ef-4194-617e8a2881a9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <eeb362c9-24e8-49ef-4194-617e8a2881a9@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 03:45:26PM +0200, Laurent Vivier wrote:
> On 29/01/2020 16:43, Stefan Hajnoczi wrote:
> > On Fri, Jan 24, 2020 at 03:05:18PM +0100, Laurent Vivier wrote:
> >> On 24/01/2020 12:02, Stefan Hajnoczi wrote:
> >>> On Thu, Jan 23, 2020 at 04:16:58PM +0100, Laurent Vivier wrote:
> >>>> The kernel needs sometime to be able to cancel an ongoing command.
> >>>>
> >>>> For instance, if the virtio-rng device uses the egd backend
> >>>> and this backend doesn't provide data, the buffer provided by the
> >>>> kernel is kept as long as it is needed.
> >>>>
> >>>> On the kernel side, a read blocks until the buffer returns from QEMU.
> >>>>
> >>>> As the read is done with a mutex held, all the hw_random interface
> >>>> hangs and we cannot switch to another hw_random backend.
> >>>>
> >>>> So this series adds a control queue to the virtio-rng device to allow
> >>>> to flush the virtio-rng input queue to release the kernel mutex and
> >>>> to allow to switch to another device.
> >>>>
> >>>> The kernel side series can be found at:
> >>>>
> >>>> https://github.com/vivier/linux/commits/virtio-rng-ctrl
> >>>>
> >>>> Laurent Vivier (2):
> >>>>   virtio-rng: prepare the introduction of a control queue
> >>>>   virtio-rng: add a control queue
> >>>>
> >>>>  hw/core/machine.c                           |  1 +
> >>>>  hw/virtio/trace-events                      |  6 ++
> >>>>  hw/virtio/virtio-rng.c                      | 99 ++++++++++++++++++---
> >>>>  include/hw/virtio/virtio-rng.h              |  5 +-
> >>>>  include/standard-headers/linux/virtio_rng.h | 14 +++
> >>>>  5 files changed, 111 insertions(+), 14 deletions(-)
> >>>
> >>> Where can I find the VIRTIO specification for this new virtqueue?
> >>
> >> I didn't update the specs.
> >>
> >> Is https://github.com/oasis-tcs/virtio-spec.git the document to update?
> > 
> > Yes, please.
> 
> I've updated the specs,
> 
> Following
> https://github.com/oasis-tcs/virtio-spec/blob/master/CONTRIBUTING.md,
> I've opened an issue:
> 
> https://github.com/oasis-tcs/virtio-spec/issues/83
> 
> Is this the good process?
> 
> Thanks,
> Laurent


It's ok but you also need to send spec patches by mail so
people can review.


