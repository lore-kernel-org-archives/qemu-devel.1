Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E6DC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E335A214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E335A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9t1A-0007DV-31
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i9sBc-0004jU-8x
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i9sBa-00070r-8v
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1i9sBa-000704-2U
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72A3410C6354;
 Mon, 16 Sep 2019 14:41:00 +0000 (UTC)
Received: from gondolin (ovpn-116-203.ams2.redhat.com [10.36.116.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C26565C1D6;
 Mon, 16 Sep 2019 14:40:58 +0000 (UTC)
Date: Mon, 16 Sep 2019 16:40:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190916164055.323c1b08.cohuck@redhat.com>
In-Reply-To: <20190913120559.40835-1-slp@redhat.com>
References: <20190913120559.40835-1-slp@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 16 Sep 2019 14:41:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] virtio-mmio: implement modern (v2)
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
Cc: stefanha@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 abologna@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Sep 2019 14:06:01 +0200
Sergio Lopez <slp@redhat.com> wrote:

> Implement the modern (v2) personality, according to the VirtIO 1.0
> specification.
> 
> Support for v2 among guests is not as widespread as it'd be
> desirable. While the Linux driver has had it for a while, support is
> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.
> 
> For this reason, the v2 personality is disabled, keeping the legacy
> behavior as default. Machine types willing to use v2, can enable it
> using MachineClass's compat_props.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changelog:
> 
> v3:
>  - Use %HWADDR_PRIx instead of %x. (Stefan Hajnoczi)
>  - Return 0 if host_features_sel > 0 for legacy mode. (Cornelia Huck)
>  - Mask out legacy features in non-legacy mode. (Cornelia Huck)
>  - Log an error in guest attempts to write guest_features with
>    guest_features_sel > 0 in legacy mode. (Cornelia Huck)
> 
> v2:
>  - Switch from RFC to PATCH.
>  - Avoid the modern vs. legacy dichotomy. Use legacy or non-legacy
>    instead. (Andrea Bolognani, Cornelia Huck)
>  - Include the register offset in the warning messages. (Stefan
>    Hajnoczi)
>  - Fix device endianness for the non-legacy mode. (Michael S. Tsirkin)
>  - Honor the specs in VIRTIO_MMIO_QUEUE_READY. (Michael S. Tsirkin)
> ---
>  hw/virtio/virtio-mmio.c | 342 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 319 insertions(+), 23 deletions(-)
> 

Looks good to me now.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

