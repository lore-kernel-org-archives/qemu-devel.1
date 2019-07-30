Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D1C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 10:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8062089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 10:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8062089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsPKt-000110-Kk
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 06:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <abologna@redhat.com>) id 1hsPK7-0000ZS-Sp
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 06:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1hsPK6-00040N-Ua
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 06:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1hsPK6-0003yy-PS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 06:25:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58A5030860C8;
 Tue, 30 Jul 2019 10:25:37 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19692600CC;
 Tue, 30 Jul 2019 10:25:31 +0000 (UTC)
Message-ID: <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Sergio Lopez <slp@redhat.com>, mst@redhat.com
Date: Tue, 30 Jul 2019 12:25:30 +0200
In-Reply-To: <20190729125755.45008-1-slp@redhat.com>
References: <20190729125755.45008-1-slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 30 Jul 2019 10:25:37 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-07-29 at 14:57 +0200, Sergio Lopez wrote:
[...]
>  /* virtio-mmio device */
>  
>  static Property virtio_mmio_properties[] = {
>      DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
>                       format_transport_address, true),
> +    DEFINE_PROP_BOOL("modern", VirtIOMMIOProxy, modern, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };

Not a QEMU developer so forgive me if I say something silly, but IIUC
you'd be able to opt into the new feature by using eg.

  -device virtio-net-device,modern=on

However, virtio-pci devices already have a mechanism to control the
VirtIO protocol version, where you use

  -device virtio-net-pci,disable-modern=no,disable-legacy=yes

to get a VirtIO 1.x-only device and

  -device virtio-net-pci,disable-modern=no,disable-legacy=no

for a transitional device.

Can you please make sure virtio-mmio uses the existing interface
instead of introducing a new one?

-- 
Andrea Bolognani / Red Hat / Virtualization


