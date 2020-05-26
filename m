Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D12DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 21:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC77F208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 21:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i43IBKaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC77F208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdhFE-00055j-35
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 17:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdhE4-0004MW-OB
 for qemu-devel@nongnu.org; Tue, 26 May 2020 17:35:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdhE3-0001iA-TS
 for qemu-devel@nongnu.org; Tue, 26 May 2020 17:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590528907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UJId7lqqdaybWE5TH6eKKHVva/tq076hQ1L10mj6Uk=;
 b=i43IBKawZ3Bf1ARcMForydKvK3oghGGb7GORyAySy/DkkyHryQNxxPkT87FvSOj3+wLLRC
 hQdhK66hYf592Ud/K9qXawUHEuplXKz4mGvwM49y/TBlR5LUsh7cz6Y2+8XuvsPP3PUdTm
 ygXhWleB/Ffp+ssEDC4SEbNmFbSjnIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-hYH7_1SWOc-tlfqq8ghxaQ-1; Tue, 26 May 2020 17:35:03 -0400
X-MC-Unique: hYH7_1SWOc-tlfqq8ghxaQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07672800053;
 Tue, 26 May 2020 21:35:02 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B6121BCBE;
 Tue, 26 May 2020 21:34:58 +0000 (UTC)
Subject: Re: [PATCH v4 4/5] block: drop bdrv_prwv
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200525100801.13859-1-vsementsov@virtuozzo.com>
 <20200525100801.13859-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <efe8d83b-6c4c-a919-44bd-8c9dbdde55c6@redhat.com>
Date: Tue, 26 May 2020 16:34:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525100801.13859-5-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 5:08 AM, Vladimir Sementsov-Ogievskiy wrote:
> Now, when we are not more paying extra code for coroutine wrappers,
> there no more sence in extra indirection layer: bdrv_prwv(). Let's drop
> it and instead genereate pure bdrv_preadv() and bdrv_pwritev().

Typos and grammar; I suggest:

Now that we are not maintaining boilerplate code for coroutine wrappers, 
there is no more sense in keeping the extra indirection layer of 
bdrv_prwv().  Let's drop it and instead generate pure bdrv_preadv() and 
bdrv_pwritev().

> 
> Currently, bdrv_pwritev() and bdrv_preadv() are returning bytes on
> success, auto generated functions will instead return zero, as their
> _co_ prototype. Still, it's simple to make the conversion safe: the
> only external user of bdrv_pwritev() is test-bdrv-drain, and it is
> comfortable enough with bdrv_co_pwritev() instead. So prototypes are
> moved to local block/coroutines.h. Next, the only internal use is
> bdrv_pread() and bdrv_pwrite(), which are modified to return bytes on
> success.

Does returning bytes on success buy us anything useful?  We don't allow 
partial success, so blindly returning 0 on success is no less useful. 
True, we'd have to audit callers to make sure we aren't doing an 
inadvertent semantic change.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/coroutines.h      | 10 ++++-----
>   include/block/block.h   |  2 --
>   block/io.c              | 49 ++++++++---------------------------------
>   tests/test-bdrv-drain.c |  2 +-
>   4 files changed, 15 insertions(+), 48 deletions(-)
> 

At any rate, I think this patch is reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


