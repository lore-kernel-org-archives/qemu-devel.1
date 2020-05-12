Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B0C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EEB2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmbKdHqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EEB2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLpT-0000wc-Jl
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYLos-0000X4-0o
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:43:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYLor-0006Bi-1a
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589254979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/EMSZsdeSmHyeMtkBdBqYqqnd00W3DNypbFTfpYhjc=;
 b=KmbKdHqmmp/hfI7/t9jy9Fofay5HBsppIq1i5qb8FOxSBER8c63SxjHJJjYfElWAv4zN+q
 Afh9+QX3ZyK8/AVkW4gDBoqzPE4U43W9EaFKaU1hjSyElHXr7+ehvk5FYkV60FckMhnEL0
 vw7iEgoFiCL656rjv2jXzgSxfKF4m2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-4L_WAeiFOUeWYNmR2jY1WA-1; Mon, 11 May 2020 23:42:58 -0400
X-MC-Unique: 4L_WAeiFOUeWYNmR2jY1WA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4D80846375;
 Tue, 12 May 2020 03:42:56 +0000 (UTC)
Received: from [10.72.13.96] (ovpn-13-96.pek2.redhat.com [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2031170919;
 Tue, 12 May 2020 03:42:51 +0000 (UTC)
Subject: Re: [PATCH v8 0/7] reference implementation of RSS and hash report
To: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
References: <20200508125934.7861-1-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c483e590-b7b9-88d5-4297-4c22dea3da02@redhat.com>
Date: Tue, 12 May 2020 11:42:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508125934.7861-1-yuri.benditovich@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:33:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/8 下午8:59, Yuri Benditovich wrote:
> Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> features in QEMU for reference purpose.
> Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
> Uses calculated hash for decision on receive virtqueue
> and/or reports the hash in the virtio header
>
> Changes from v7:
> Patch 7.1: removed (RSS and hash report definitions)
> Patch 7.2: delete configuration struct with RSS definitions
> Patch 7.4: delete duplicated packet structure
> Added patch 7 - adapt RSC definitions to updated header
>
> Yuri Benditovich (7):
>    virtio-net: implement RSS configuration command
>    virtio-net: implement RX RSS processing
>    tap: allow extended virtio header with hash info
>    virtio-net: reference implementation of hash report
>    vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
>    virtio-net: add migration support for RSS and hash report
>    virtio-net: align RSC fields with updated virtio-net header
>
>   hw/net/trace-events            |   3 +
>   hw/net/virtio-net.c            | 387 +++++++++++++++++++++++++++++----
>   include/hw/virtio/virtio-net.h |  16 ++
>   include/migration/vmstate.h    |  10 +
>   net/tap.c                      |   3 +-
>   5 files changed, 379 insertions(+), 40 deletions(-)
>

Applied.

Thanks



