Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6454C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01B9214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJ9YiIDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01B9214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4Eg-0000kW-Sz
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw4Dy-0000Aa-TF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw4Dx-0006PY-NO
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:14:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw4Dx-0006Mn-KF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580130880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qb/ulFR6/uvTP2Hxq1vn/YS2A/KqIb2+6zNPYqghZ64=;
 b=DJ9YiIDBMGzsA1ctpDeRUwgm2/llLphymPnZ1ZB8aagUVYjl5K5O+FH4kdagkD5+Dtqzqp
 XvbgWu5Cjf/3kCrwfsEk/2z9ejomJcMaaHYCs7Quk57+M9VH495m+rQ6hFTr6Y7/3mX6Lu
 Gzq9MfGJCD5SsGcSaEXcGKKEUOqipWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-Nnd7UIhLOkG3VkMI1KWSLQ-1; Mon, 27 Jan 2020 08:14:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1317D1800D41;
 Mon, 27 Jan 2020 13:14:38 +0000 (UTC)
Received: from gondolin (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93361863CC;
 Mon, 27 Jan 2020 13:14:31 +0000 (UTC)
Date: Mon, 27 Jan 2020 14:14:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 3/4] virtio-blk: default num_queues to -smp N
Message-ID: <20200127141428.4347b4bd.cohuck@redhat.com>
In-Reply-To: <20200124100159.736209-4-stefanha@redhat.com>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-4-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Nnd7UIhLOkG3VkMI1KWSLQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

On Fri, 24 Jan 2020 10:01:58 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Automatically size the number of request virtqueues to match the number
> of vCPUs.  This ensures that completion interrupts are handled on the
> same vCPU that submitted the request.  No IPI is necessary to complete
> an I/O request and performance is improved.

Same comment regarding other transports.

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/virtio-blk.c          | 6 +++++-
>  hw/core/machine.c              | 1 +
>  hw/virtio/virtio-blk-pci.c     | 9 ++++++++-
>  include/hw/virtio/virtio-blk.h | 2 ++
>  4 files changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


