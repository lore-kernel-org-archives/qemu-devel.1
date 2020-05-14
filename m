Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2D5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DE9205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee0bYxzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DE9205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZELt-0008FX-Bz
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZEHc-0001ok-ME
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:52:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28337
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZEHb-000792-Kv
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589464338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBQUpl2gbrr4CKbO4wL5bsSnCSA/hdFqeXGYvAcb6dc=;
 b=ee0bYxzJUOE7Jn3qXcOpoAZ4b2quDn2+QzJ1kXNxTuuB1WojPg2anmdlT1x6z8tTST7yl0
 W459dP6Xr+Ip8ylaQHx2RAnkP/zDc8nO8bRQvv3FpvPD8tuZuJEnGIgNrJnlTepRh1ZmYK
 JIZ9ytFP6U0phfoFKUm8NgJDmeqwX6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-yQofZomCOhugmDRV86gbjw-1; Thu, 14 May 2020 09:52:14 -0400
X-MC-Unique: yQofZomCOhugmDRV86gbjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7281E800053;
 Thu, 14 May 2020 13:52:13 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0922D61989;
 Thu, 14 May 2020 13:52:12 +0000 (UTC)
Subject: Re: [PATCH] bitmaps: Add myself as maintainer
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200513141407.185198-1-eblake@redhat.com>
 <55059458-923c-505c-d16b-89ff3334c3c5@redhat.com>
 <30070988-e0da-00f2-3780-d4fae816b589@virtuozzo.com>
 <ad142f8d-8d10-1909-c1d4-7ca8441ab3ba@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <962f8c29-6b42-ea7c-cdf9-ad63288da955@redhat.com>
Date: Thu, 14 May 2020 08:52:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ad142f8d-8d10-1909-c1d4-7ca8441ab3ba@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 12:08 AM, John Snow wrote:
> 
> 
> On 5/14/20 12:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 13.05.2020 23:24, John Snow wrote:
>>>
>>>
>>> On 5/13/20 10:14 AM, Eric Blake wrote:
>>>> Dirty bitmaps are important to incremental backups, including exposure
>>>> over NBD where I'm already maintainer.  Also, I'm aware that lately I
>>>> have been doing as much code/review on bitmaps as John Snow, who is
>>>> hoping to scale back on this front.
>>>>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>>
>>>> ---

>>>>    Dirty Bitmaps
>>>>    M: John Snow <jsnow@redhat.com>
>>>> +M: Eric Blake <eblake@redhat.com>
>>>>    R: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>    L: qemu-block@nongnu.org
>>>>    S: Supported
>>>>
>>>
>>> I'd also like to point out that I wouldn't mind if Vladimir became an
>>> official maintainer, but I can't remember if he wanted the title when we
>>> last spoke at KVM Forum.
>>
>> Actually, it would be nice, I'd glad to get it, thanks :)
>> I can send a separate patch, or we may s/R/M/ in this one?
>>
> 
> That would be very good!
> 
> I'd be quite happy to be demoted to reviewer; it's about all the time
> I've been truthfully able to give lately.
> 
> (I won't speak for Eric!)

I can post a v2 that produces the following results:

M: Vladimir
M: Eric
R: John

Does that sound reasonable?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


