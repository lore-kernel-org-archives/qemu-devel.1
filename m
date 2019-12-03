Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B08C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707812073F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQ9Jm1YZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707812073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icEOo-00022V-K1
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icDKU-0001m4-65
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 13:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icDKH-0004J7-Vt
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 13:55:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icDKH-0003vV-Rb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 13:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575399304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vTHte9KGyHxaU+xTNKi6+g/HmtDH2MbLeyFm5rk6BI=;
 b=VQ9Jm1YZePcq12G0HaMTmWgcMzubBd4eEM7Q1l7oB4rgUX84rRlHBsJ7NJBxgLEIhcmV/g
 4mHh/hHXNY0D11RzHK2kmsZsz0ys0y67r0RQBqyCW8tlugI89te0Ye94snxX8Uh7veoPkR
 TU+ffw0YN5CpSoGRni+XYb3R96y3/jU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-BiPphYx5Oly36IjCic6JSQ-1; Tue, 03 Dec 2019 13:55:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C717183B701;
 Tue,  3 Dec 2019 18:55:00 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 114A0600C8;
 Tue,  3 Dec 2019 18:54:58 +0000 (UTC)
Subject: Re: for 4.2 ??? Re: [PATCH V3 2/2] block/nbd: fix memory leak in
 nbd_open()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "pannengyuan@huawei.com" <pannengyuan@huawei.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>
References: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
 <1575012326-51324-2-git-send-email-pannengyuan@huawei.com>
 <1cff97de-303b-3b27-f737-3f69759746b0@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <08f0d51d-f352-5d64-26a4-9a741a4cf2e0@redhat.com>
Date: Tue, 3 Dec 2019 12:54:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1cff97de-303b-3b27-f737-3f69759746b0@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BiPphYx5Oly36IjCic6JSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "liyiting@huawei.com" <liyiting@huawei.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kuhn.chenqun@huawei.com" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 11:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> It's just a memory leak, but it's a regression in 4.2.
> 
> Should we take it into 4.2?

Sorry, I was on holiday and then jury service, so I missed any chance at 
getting this into -rc3.  The memory leak only happens on failure, and 
you'd have to be pretty desperate to purposefully attempt to open a lot 
of NBD devices where you know you'll get a failure just to trigger 
enough of a leak to cause the OOM-killer to target qemu.  So I'm fine if 
this is deferred to 5.0, and just cc's qemu-stable (now done).

I'll queue this through my NBD tree for 5.0.

> 
> 
> 29.11.2019 10:25, pannengyuan@huawei.com wrote:
>> From: PanNengyuan <pannengyuan@huawei.com>

>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>

I'm not one to tell you that your name is written incorrectly, but it 
does look odd to have a single word rather than a space between two 
capitalized portions.  If that's really how you want your S-o-b and 
authorship to appear, I'm happy to preserve it; but you may want to 
consider updating your git settings, and posting a v4 with an updated 
spelling if you would prefer something different.  (It is also 
acceptable to use UTF-8 characters; some people like listing an S-o-b in 
both native characters and a Westernized variant).

> 
> May add:
> 
> Fixes: 8f071c9db506e03ab

Yes, information like that helps in deciding how long the problem has 
been present (in this case, it is indeed a regression added in 4.2, even 
if minor in nature).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


