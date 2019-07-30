Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D180C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577242089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577242089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsR5L-0002OP-EE
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <abologna@redhat.com>) id 1hsR4o-0001zS-0Y
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1hsR4m-0007Tm-VG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1hsR4m-0007TL-Q0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:17:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D646F308338F;
 Tue, 30 Jul 2019 12:17:55 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E655819C65;
 Tue, 30 Jul 2019 12:17:49 +0000 (UTC)
Message-ID: <09e5ceb5e7c03f74f05307a3b9f9a4df035ff74f.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 30 Jul 2019 14:17:48 +0200
In-Reply-To: <20190730133546.056f8b19.cohuck@redhat.com>
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
 <20190730133546.056f8b19.cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 30 Jul 2019 12:17:55 +0000 (UTC)
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

On Tue, 2019-07-30 at 13:35 +0200, Cornelia Huck wrote:
> On Tue, 30 Jul 2019 12:25:30 +0200
> Andrea Bolognani <abologna@redhat.com> wrote:
> > Can you please make sure virtio-mmio uses the existing interface
> > instead of introducing a new one?
> 
> FWIW, I really hate virtio-pci's disable-modern/disable-legacy... for a
> starter, what is 'modern'? Will we have 'ultra-modern' in the future?

AIUI the modern/legacy terminology is part of the VirtIO spec, so
while I agree that it's not necessarily the least prone to ambiguity
at least it's well defined.

> It is also quite backwards with the 'disable' terminology.

That's also true. I never claimed the way virtio-pci does it is
perfect!

> We also have a different mechanism for virtio-ccw ('max_revision',
> which covers a bit more than virtio-1; it doesn't have a 'min_revision',
> as negotiating the revision down is fine), so I don't see why
> virtio-mmio should replicate the virtio-pci mechanism.
> 
> Also, IIUC, virtio-mmio does not have transitional devices, but either
> version 1 (legacy) or version 2 (virtio-1). It probably makes more
> sense to expose the device version instead; either as an exact version
> (especially if it isn't supposed to go up without incompatible
> changes), or with some min/max concept (where version 1 would stand a
> bit alone, so that would probably be a bit awkward.)

I think that if reinventing the wheel is generally agreed not to be
a good idea, then it stands to reason that reinventing it twice can
only be described as absolute madness :)

We should have a single way to control the VirtIO protocol version
that works for all VirtIO devices, regardless of transport. We might
even want to have virtio-*-{device,ccw}-non-transitional to mirror
the existing virtio-*-pci-non-transitional.

FWIW, libvirt already implements support for (non)-transitional
virtio-pci devices using either the dedicated devices or the base
virtio-pci plus the disable-{modern,legacy} attributes.

-- 
Andrea Bolognani / Red Hat / Virtualization


