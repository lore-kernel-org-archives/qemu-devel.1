Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 02:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373762073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 02:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1/FRYuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373762073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd39S-0005Ma-DP
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 22:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jd38w-0004v7-3O
 for qemu-devel@nongnu.org; Sun, 24 May 2020 22:47:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38848
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jd38u-0005ux-HN
 for qemu-devel@nongnu.org; Sun, 24 May 2020 22:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590374826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxhwvKrLAJf/sYVclQITkDkiNV0IMUKJaeIVnYF4/dA=;
 b=c1/FRYuhjwBHZArzT8MlZSDICdb6UfChtAUihLg6mVXoMm922uPdUSfxDvYyevkObgh/x0
 fGXgMjgIwueaFWFAyo0UZYlDv95EB3WX/Ymf1rdLjade/75A3udxnRjAW6og28MUzSRjOS
 H3mLqU+pSZsZP+qq+lGK0DhhvyuZvFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-VEi3uR_5NmKUCtCyj2VrjQ-1; Sun, 24 May 2020 22:47:04 -0400
X-MC-Unique: VEi3uR_5NmKUCtCyj2VrjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 599BC80183C;
 Mon, 25 May 2020 02:47:02 +0000 (UTC)
Received: from [10.72.13.226] (ovpn-13-226.pek2.redhat.com [10.72.13.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 023585D9DC;
 Mon, 25 May 2020 02:47:00 +0000 (UTC)
Subject: Re: [PATCH V2 0/7] Latest COLO tree queued patches
To: Zhang Chen <chen.zhang@intel.com>
References: <20200522075357.19883-1-chen.zhang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ba019b1f-8201-b17b-3a66-b22a945aa213@redhat.com>
Date: Mon, 25 May 2020 10:46:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522075357.19883-1-chen.zhang@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 22:47:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/22 下午3:53, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> Hi Jason, this series include latest COLO related patches.
> I have finish basic test and review.
> If no other comments, please check and merge this series.
>
> Derek Su (1):
>    colo-compare: Fix memory leak in packet_enqueue()
>
> Lukas Straub (6):
>    net/colo-compare.c: Create event_bh with the right AioContext
>    chardev/char.c: Use qemu_co_sleep_ns if in coroutine
>    net/colo-compare.c: Fix deadlock in compare_chr_send
>    net/colo-compare.c: Only hexdump packets if tracing is enabled
>    net/colo-compare.c: Check that colo-compare is active
>    net/colo-compare.c: Correct ordering in complete and finalize
>
>   chardev/char.c     |   7 +-
>   net/colo-compare.c | 277 +++++++++++++++++++++++++++++++++------------
>   net/colo.c         |   7 ++
>   net/colo.h         |   1 +
>   net/trace-events   |   1 +
>   5 files changed, 222 insertions(+), 71 deletions(-)Philippe
>

Applied with the following tweaks:

- reword the commit log of patch 2 as  Philippe suggested
- a missing ack from Philippe in patch 7

Thanks


