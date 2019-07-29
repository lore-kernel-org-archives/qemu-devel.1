Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D8C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461052067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461052067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs78B-0004wx-4c
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hs76q-0003JZ-1F
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hs76p-0004HK-0b
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hs76o-0004GA-RU; Mon, 29 Jul 2019 10:58:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B280E30A7C63;
 Mon, 29 Jul 2019 14:58:40 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A23325C21A;
 Mon, 29 Jul 2019 14:58:29 +0000 (UTC)
Date: Mon, 29 Jul 2019 16:58:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190729165827.565d6265.cohuck@redhat.com>
In-Reply-To: <20190729145229.4333-1-imammedo@redhat.com>
References: <20190729145229.4333-1-imammedo@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 29 Jul 2019 14:58:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] s390: stop abusing
 memory_region_allocate_system_memory()
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 10:52:27 -0400
Igor Mammedov <imammedo@redhat.com> wrote:

cc:ing some folks for awareness.

> While looking into unifying guest RAM allocation to use hostmem backends
> for initial RAM (especially when -mempath is used) and retiring
> memory_region_allocate_system_memory() API, leaving only single hostmem backend,
> I was inspecting how currently it is used by boards and it turns out several
> boards abuse it by calling the function several times (despite documented contract
> forbiding it).
> 
> s390 is one of such boards where KVM limitation on memslot size got propagated
> to board design and memory_region_allocate_system_memory() was abused to satisfy
> KVM requirement for max RAM chunk where memory region alias would suffice.
> 
> Unfortunately, memory_region_allocate_system_memory() usage created migration
> dependency where guest RAM is transferred in migration stream as several RAMBlocks
> if it's more than KVM_SLOT_MAX_BYTES.
> 
> In order to replace these several RAM chunks with a single memdev and keep it
> working with KVM memslot size limit and migration compatible, following was done:
>    * [2/2] use memory region aliases to partition hostmem backend RAM on
>            KVM_SLOT_MAX_BYTES chunks, which should keep KVM side working
>    * [1/2] hacked memory region aliases (to ram memory regions only) to have
>            its own RAMBlocks pointing to RAM chunks owned by aliased memory
>            region. While it's admittedly a hack, but it's relatively simple and
>            allows board code rashape migration stream as necessary
> 
>            I haven't tried to use migratable aliases on x86 machines, but with it
>            it could be possible to drop legacy RAM allocation and compat knob
>            (cd5ff8333a) dropping '-numa node,mem' completely even for old machines.
> 
> PS:
>    Tested with ping pong cross version migration on s390 machine 
>    (with reduced KVM_SLOT_MAX_BYTES since I don't have access to large
>     enough host)
>      
> 
> Igor Mammedov (2):
>   memory: make MemoryRegion alias migratable
>   s390: do not call memory_region_allocate_system_memory() multiple
>     times
> 
>  exec.c                     |  7 ++++---
>  hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
>  memory.c                   |  5 +++++
>  3 files changed, 24 insertions(+), 8 deletions(-)
> 


