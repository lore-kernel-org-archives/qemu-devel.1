Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B86DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C719247FF
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnAcfXR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C719247FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXpvA-0004cu-CP
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXpuS-00047t-7p
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXpuQ-0005UT-9x
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603908653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kfTMqjrId9FLWNIp9KzlB73e+t34ZBOv16cIfQx+ZZY=;
 b=gnAcfXR4cDuGt2ebtr0fazm/0G6939hwM293cp8vdQtl73SnRsg+jdtROrAYulKWa6UfDA
 iyXgDpE5fp2j6V5saE6Nwa6SQTaMaRrl+UhANGY8W/1QLat8zrMY0Vlgmpy1PhKcQr/D2X
 jbHrVpJDIYkKA3ATEai+NmKCAUYESUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-m-2mvULRN8eS9n6_dNhYQA-1; Wed, 28 Oct 2020 14:10:50 -0400
X-MC-Unique: m-2mvULRN8eS9n6_dNhYQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 990301882FC6;
 Wed, 28 Oct 2020 18:10:48 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 368595B4B2;
 Wed, 28 Oct 2020 18:10:43 +0000 (UTC)
Subject: Re: [PATCH 00/25] block/nvme: Fix Aarch64 host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9f299973-36c6-6e82-7dfd-aa6eb7b80b63@redhat.com>
Date: Wed, 28 Oct 2020 19:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
> Add a bit of tracing, clean around to finally fix few bugs.
> In particular, restore NVMe on Aarch64 host.
> 
> Eric Auger (4):
>   block/nvme: Change size and alignment of IDENTIFY response buffer
>   block/nvme: Change size and alignment of queue
>   block/nvme: Change size and alignment of prp_list_pages
>   block/nvme: Align iov's va and size on host page size>
> Philippe Mathieu-Daudé (21):
>   MAINTAINERS: Cover 'block/nvme.h' file
>   block/nvme: Use hex format to display offset in trace events
>   block/nvme: Report warning with warn_report()
>   block/nvme: Trace controller capabilities
>   block/nvme: Trace nvme_poll_queue() per queue
>   block/nvme: Improve nvme_free_req_queue_wait() trace information
>   block/nvme: Trace queue pair creation/deletion
>   block/nvme: Simplify device reset
>   block/nvme: Move definitions before structure declarations
>   block/nvme: Use unsigned integer for queue counter/size
>   block/nvme: Make nvme_identify() return boolean indicating error
>   block/nvme: Make nvme_init_queue() return boolean indicating error
>   block/nvme: Introduce Completion Queue definitions
>   block/nvme: Use definitions instead of magic values in add_io_queue()
>   block/nvme: Correctly initialize Admin Queue Attributes
>   block/nvme: Simplify ADMIN queue access
>   block/nvme: Simplify nvme_cmd_sync()
>   block/nvme: Pass AioContext argument to nvme_add_io_queue()
>   block/nvme: Set request_alignment at initialization
>   block/nvme: Correct minimum device page size
>   block/nvme: Fix use of write-only doorbells page on Aarch64 arch
> 
>  include/block/nvme.h |  17 ++--
>  block/nvme.c         | 208 ++++++++++++++++++++++++-------------------
>  MAINTAINERS          |   2 +
>  block/trace-events   |  30 ++++---
>  4 files changed, 148 insertions(+), 109 deletions(-)
> 

I have tested the series on ARM with both 4kB and 64kB pages and it
works for me.

Feel free to add:
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


