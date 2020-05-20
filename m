Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48586C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 02:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083D920829
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 02:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGBRgE4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083D920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbEme-0008Te-9H
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 22:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jbEm5-0007y2-Ra
 for qemu-devel@nongnu.org; Tue, 19 May 2020 22:48:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jbEm4-0004rA-B4
 for qemu-devel@nongnu.org; Tue, 19 May 2020 22:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589942882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Emh1SuNdifQHpJ/1fjDYF12yvQnIK6ah+p5ZDWyTpg=;
 b=HGBRgE4n50qiAQmIzQXle/x3QlqP9EUOAJ17mrSydLcBR3qcl5OyAEUCQwFRkkPnUCpir1
 bbfKYVN0P2/PeyudDaDth9usQTfCo1nVa7gd9QPfxcnth7Xar6//UqlHYEBhFQ6zRbR06O
 RL6P4RRefMy6w5j2l+BT7youbZP5FG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-il8e4aYGP1SpnDqHpD88WQ-1; Tue, 19 May 2020 22:47:59 -0400
X-MC-Unique: il8e4aYGP1SpnDqHpD88WQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0AED8005AA;
 Wed, 20 May 2020 02:47:58 +0000 (UTC)
Received: from [10.72.13.246] (ovpn-13-246.pek2.redhat.com [10.72.13.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D07D6ACE6;
 Wed, 20 May 2020 02:47:57 +0000 (UTC)
Subject: Re: [PATCH 0/7] Latest COLO tree queued patches
To: Zhang Chen <chen.zhang@intel.com>
References: <20200519200207.17773-1-chen.zhang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b6e8a622-86bd-ccdd-66ae-bcd498b2e22f@redhat.com>
Date: Wed, 20 May 2020 10:47:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519200207.17773-1-chen.zhang@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 2020/5/20 上午4:02, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> Hi Jason, this series include latest COLO related patches.
> I have finish basic test and review.
> If no other comments, please check and merge this series.


Applied.

Thanks


>
> Derek Su (1):
>    colo-compare: Fix memory leak in packet_enqueue()
>
> Lukas Straub (6):
>    net/colo-compare.c: Create event_bh with the right AioContext
>    chardev/char.c: Use qemu_co_sleep_ns if in coroutine
>    net/colo-compare.c: Fix deadlock in compare_chr_send
>    net/colo-compare.c: Only hexdump packets if tracing is enabled
>    net/colo-compare.c, softmmu/vl.c: Check that colo-compare is active
>    net/colo-compare.c: Correct ordering in complete and finalize
>
>   chardev/char.c     |   7 +-
>   net/colo-compare.c | 277 +++++++++++++++++++++++++++++++++------------
>   net/colo-compare.h |   1 +
>   net/colo.c         |   7 ++
>   net/colo.h         |   1 +
>   net/trace-events   |   1 +
>   softmmu/vl.c       |   2 +
>   7 files changed, 225 insertions(+), 71 deletions(-)
>


