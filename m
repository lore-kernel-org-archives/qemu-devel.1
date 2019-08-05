Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ABAC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BBB216B7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BBB216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hueKR-0001uh-5J
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40977)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hueJk-0001Qk-GI
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hueJj-0000ON-8t
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:50:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hueJj-0000NV-2w
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:50:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so5793894wre.12
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RUH3LN9pk9hClvwRnfUNIAsQ6DTq9rTaAdVgtfC7uaE=;
 b=EvXi4COVgLXmyVt4T+qHjLTSirgR8YBg5NCMk4k1MrZIBx6xEE+vZPgsHqqu9vcSxv
 GrNqyLIrkkOv7j4IOGzwz3Nv9wSgkssG5odGQvyP6sYUXR1Ruf5Ck6sSQcyTWMTB5DNg
 Pe3kqxQybPL20hb4Hu4LevkHBZ8XUc/9odYQNPpUx53U2+dTSuOZWl5liMvuJH2EC1FN
 yM8b+qEyq1laOvT6uAW9J/22fx/vfJf9OEzyXMV5QhSYn91zkeiKlu8sRrBmvhE631Kf
 kivsm9VTiDNwSeerRSr9BQTco+T0Q8G6uTg7ghdtiWtE/5/AzmrBoSmsoiWmJHFbQfA3
 +f2g==
X-Gm-Message-State: APjAAAVCKApDrxSgByGfTGv/8WZQPteRZQDvyor0yRoFpNAlr2Y2IVAq
 sOaw464FfsmlJQ678+PFthhupw==
X-Google-Smtp-Source: APXvYqww8AwBbZDy09FL4TUFYePhGH8AImiTG6Z9oFTk8eg7vzvxafnVHuvGwBl8p975O3OaCMd9jw==
X-Received: by 2002:adf:e483:: with SMTP id i3mr14504299wrm.210.1565016629827; 
 Mon, 05 Aug 2019 07:50:29 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
 by smtp.gmail.com with ESMTPSA id o3sm73126758wrs.59.2019.08.05.07.50.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 07:50:29 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190805120120.23585-1-vsementsov@virtuozzo.com>
 <95578562-dd2a-08f2-2a00-d5f5ec723ebe@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b773e90-157e-8e2b-b890-6b1ad5e0edd2@redhat.com>
Date: Mon, 5 Aug 2019 16:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <95578562-dd2a-08f2-2a00-d5f5ec723ebe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-4.1] util/hbitmap: update orig_size on
 truncate
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/19 14:19, Max Reitz wrote:
> On 05.08.19 14:01, Vladimir Sementsov-Ogievskiy wrote:
>> Without this, hbitmap_next_zero and hbitmap_next_dirty_area are broken
>> after truncate. So, orig_size is broken since it's introduction in
>> 76d570dc495c56bb.
>>
>> Fixes: 76d570dc495c56bb
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi!
>>
>> Here is one more hbitmap bug I noticed. It's my fault, I'm sorry :(
>> Broken in 4.0, but if we are already going to fix in 4.1 some things
>> around it, it's a small meaningful addition.
> 
> Hm. :-/
> 
>> Users of broken API are incremental backup, sync mirror (but it may not
>> be broken, if truncates not allowed during mirror, are they?),
> 
> It doesn’t appear that way (we don’t share BLK_PERM_RESIZE).
> 
>> bitmap export through NBD.
> 
> I suppose that counts as block-y enough for me to take it.  Well, I’d
> still like a test case to see the impact...  I’ll see whether I can come
> up with something.

And also a unit test...

Paolo

