Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D6AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F362214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9bxyf3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F362214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4IS-00035m-Ls
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw4Gd-0001wd-GY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw4Gc-0000DJ-EZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:17:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24924
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw4Gc-0000CW-Ba
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580131045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1QNBPm0dPk21ccuCJlkr4/JbdkwMj+uewoMY/utAHg=;
 b=h9bxyf3GYewSmi5F1oUCdOuQzDJWwR3GV2Rhl59O08Hk3IfesX4UIgle2b8rXfn6Paurb2
 ED91NYG/5Y7fcsl+wac7+DOy9mN8k3/4oQY5nLTBlvOAsblN94TOnZ+Ng82V0fdWo3D2qJ
 OQJqP9FUQNSba+xGMhjN0cwtUDHq5jQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-YniVxzA7NjSxWU07fJsl1Q-1; Mon, 27 Jan 2020 08:17:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1A7F803A29;
 Mon, 27 Jan 2020 13:17:20 +0000 (UTC)
Received: from gondolin (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0728F38C;
 Mon, 27 Jan 2020 13:17:13 +0000 (UTC)
Date: Mon, 27 Jan 2020 14:17:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 4/4] vhost-user-blk: default num_queues to -smp N
Message-ID: <20200127141710.5785ba2b.cohuck@redhat.com>
In-Reply-To: <20200124100159.736209-5-stefanha@redhat.com>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-5-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YniVxzA7NjSxWU07fJsl1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 10:01:59 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Automatically size the number of request virtqueues to match the number
> of vCPUs.  This ensures that completion interrupts are handled on the
> same vCPU that submitted the request.  No IPI is necessary to complete
> an I/O request and performance is improved.

Ok, that one is pci-only anyway.

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/vhost-user-blk.c          | 6 +++++-
>  hw/core/machine.c                  | 1 +
>  hw/virtio/vhost-user-blk-pci.c     | 6 ++++++
>  include/hw/virtio/vhost-user-blk.h | 2 ++
>  4 files changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


