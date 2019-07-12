Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24B1C742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77BE208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77BE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlsOf-0002Rh-Qg
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52354)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hlsOT-00022y-Vg
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hlsOT-0000zl-09
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:03:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hlsOS-0000wc-Od
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:03:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20A629177C;
 Fri, 12 Jul 2019 10:03:05 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B4E06062A;
 Fri, 12 Jul 2019 10:03:03 +0000 (UTC)
Date: Fri, 12 Jul 2019 12:03:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190712120301.7e6b6098.cohuck@redhat.com>
In-Reply-To: <20190712073554.21918-4-pagupta@redhat.com>
References: <20190712073554.21918-1-pagupta@redhat.com>
 <20190712073554.21918-4-pagupta@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 12 Jul 2019 10:03:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] virtio pmem: remove transational
 device info
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
Cc: peter.maydell@linaro.org, david@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jul 2019 13:05:54 +0530
Pankaj Gupta <pagupta@redhat.com> wrote:

> Remove transactional & non transactional device info
> for virtio pmem. 

s/device info/names/ ?

> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  hw/virtio/virtio-pmem-pci.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

