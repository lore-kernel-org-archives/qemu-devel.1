Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9C0C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E299E206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E299E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQRK-0008Q3-7U
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54367)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hsQQ8-000762-Bs
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hsQQ7-0004NQ-C9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hsQQ7-0004NC-6E
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:35:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C04C3092649;
 Tue, 30 Jul 2019 11:35:54 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CBC319C67;
 Tue, 30 Jul 2019 11:35:48 +0000 (UTC)
Date: Tue, 30 Jul 2019 13:35:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190730133546.056f8b19.cohuck@redhat.com>
In-Reply-To: <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 30 Jul 2019 11:35:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Sergio Lopez <slp@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 12:25:30 +0200
Andrea Bolognani <abologna@redhat.com> wrote:

> On Mon, 2019-07-29 at 14:57 +0200, Sergio Lopez wrote:
> [...]
> >  /* virtio-mmio device */
> >  
> >  static Property virtio_mmio_properties[] = {
> >      DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
> >                       format_transport_address, true),
> > +    DEFINE_PROP_BOOL("modern", VirtIOMMIOProxy, modern, false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };  
> 
> Not a QEMU developer so forgive me if I say something silly, but IIUC
> you'd be able to opt into the new feature by using eg.
> 
>   -device virtio-net-device,modern=on
> 
> However, virtio-pci devices already have a mechanism to control the
> VirtIO protocol version, where you use
> 
>   -device virtio-net-pci,disable-modern=no,disable-legacy=yes
> 
> to get a VirtIO 1.x-only device and
> 
>   -device virtio-net-pci,disable-modern=no,disable-legacy=no
> 
> for a transitional device.
> 
> Can you please make sure virtio-mmio uses the existing interface
> instead of introducing a new one?
> 

FWIW, I really hate virtio-pci's disable-modern/disable-legacy... for a
starter, what is 'modern'? Will we have 'ultra-modern' in the future?
It is also quite backwards with the 'disable' terminology.

We also have a different mechanism for virtio-ccw ('max_revision',
which covers a bit more than virtio-1; it doesn't have a 'min_revision',
as negotiating the revision down is fine), so I don't see why
virtio-mmio should replicate the virtio-pci mechanism.

Also, IIUC, virtio-mmio does not have transitional devices, but either
version 1 (legacy) or version 2 (virtio-1). It probably makes more
sense to expose the device version instead; either as an exact version
(especially if it isn't supposed to go up without incompatible
changes), or with some min/max concept (where version 1 would stand a
bit alone, so that would probably be a bit awkward.)

