Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56171C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 01:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECB62072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 01:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="fqAHCY4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECB62072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbwrV-0006Le-AY
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 21:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jbwqY-0004t0-47
 for qemu-devel@nongnu.org; Thu, 21 May 2020 21:51:38 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:43905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jbwqV-0005p9-A9
 for qemu-devel@nongnu.org; Thu, 21 May 2020 21:51:37 -0400
Received: by mail-pg1-x52f.google.com with SMTP id f4so4229877pgi.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8MV40ObIwHeM+EHUMt8XD3Z7XgbtUo8DNIToRTif1qI=;
 b=fqAHCY4sNqlRAihrhaKqP286d5d4YpLe+nl5X8igL0GyzkDa1IbidetkfuIm38StWR
 mMDg/vJ2ewBfvM6zB5S8sgd2ub0Lqb1Dtt8tlGHBNMkVa6sFlBJaAV5HHSZS25tJzi5U
 +KjcHiUaQ3LkJsRaBbPUmYUt39WUTQXgbFCwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8MV40ObIwHeM+EHUMt8XD3Z7XgbtUo8DNIToRTif1qI=;
 b=Xn4rrXknGgdvZdjblMWpJ/WKS/qv0D1ks6AgR7yEI3X/svMMAtH45tdIxS+Ox50chU
 bNedws8TpOcUJkfOu8rTwPX0iYDg3rMM17V1rOxne+d0wqtFGCUHuaKG0T0RJu/SJfFU
 sZbiXnIQDvQccSAov+hSHd2dT2Bz/VnuyW8BtGQ2NdnUrFnxyLNl3kgT90sp9dZUCddw
 u6l6MZIB6UB0Tu9WTIcnkrRkWLCMydijbZoJtcCqfZZkZHUuqZInXiyyPyBAl1zgZv8w
 Qes7DY9yR6DkqHKBY9r+xkZv2qciRSGXmBCB17Pz8uyl/dYAynVdU43VEuWDZRvIGHNp
 M8eA==
X-Gm-Message-State: AOAM532COuObZ35A3XQu6Y9zl9FlUC4kc7rYHsbP+YTiuL74OhBKR3Zp
 Yr+8Uiliua3HN+Cg9ZSFHrRB/w==
X-Google-Smtp-Source: ABdhPJwTkqzZ4wbxx840e9LEmsZfldJStVnVnFkqmeAlB9/gHncrRO/R2rGsolbwHZ1JL6yKF6tLEw==
X-Received: by 2002:a65:6801:: with SMTP id l1mr11549948pgt.73.1590112293358; 
 Thu, 21 May 2020 18:51:33 -0700 (PDT)
Received: from Jing-Weide-MacBook-Pro-3.local
 (202-39-79-13.HINET-IP.hinet.net. [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id w12sm3895103pjb.11.2020.05.21.18.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 18:51:32 -0700 (PDT)
Subject: Re: cluster_size got from backup_calculate_cluster_size()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <7b96191b-2c16-7257-9ae3-50457bf82e27@qnap.com>
 <3d66b51e-7112-d368-1d86-b63637413abd@redhat.com>
 <fc69468b-10d8-9869-88f5-b6798cfc0835@virtuozzo.com>
From: Derek Su <dereksu@qnap.com>
Message-ID: <40aedbc3-8818-e58b-2247-b76f1d7b891b@qnap.com>
Date: Fri, 22 May 2020 09:51:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <fc69468b-10d8-9869-88f5-b6798cfc0835@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dereksu@qnap.com; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/5/22 上午4:53, Vladimir Sementsov-Ogievskiy wrote:
> 21.05.2020 21:19, John Snow wrote:
>>
>>
>> On 5/21/20 5:56 AM, Derek Su wrote:
>>> Hi,
>>>
>>> The cluster_size got from backup_calculate_cluster_size(),
>>> MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size), is 64K regardless
>>> of the target image's cluster size.
>>
>> Not regardless -- but it is using 64K as a minimum.

Right, 64K is a minimum. Thanks for the correctness.

>>
>>>
>>>
>>> For example:
>>>
>>> If the cluster size of source and target qcow2 images are both 16K, the
>>> 64K from backup_calculate_cluster_size() results in unwanted copies of
>>> clusters.
>>>
>>> The behavior slows down the backup (block-copy) process when the
>>> source image receives lots of rand writes.
>>
>> Are we talking about incremental, full, or top?

Our use case is MIRROR_SYNC_MODE_NONE (only copy new writes from source 
image to the target).

>>
>>>
>>>
>>> Is the following calculation reasonable for the above issue?
>>>
>>>
>>> ```
>>> static int64_t backup_calculate_cluster_size(BlockDriverState *target,
>>>                                               Error **errp)
>>> {
>>>      ...
>>>
>>>      ret = bdrv_get_info(target, &bdi);
>>>
>>>      ...
>>>
>>>      return (bdi.cluster_size == 0 ?
>>>                  BACKUP_CLUSTER_SIZE_DEFAULT : cluster_size);
>>> }
>>>
>>> ```
>>>
>>> Thanks.
>>> Regards,
>>>
>>> Derek
>>>
>>
>>
>> Might be reasonable. When I made this the "default", it actually used to
>> just be "hardcoded." We could continue in this direction and go all the
>> way and turn it into a tune-able.
>>
>> I didn't think to make it lower than 64K because I was thinking about
>> the linear, full backup case where cluster sizes that were too small
>> might slow down the loop with too much metadata.
> 
> Yes, currently backup-loop is copying cluster-by-cluster, so if we allow 
> clusters less than 64k, it may become slower (at least for full-backup). 
> Still, my work about backup-performance is close to its end, and I hope, 
> in 5.1 will be merged. One of effects is that backup copying loop may 
> copy more than a cluster at once, so this problem will gone.
> 
> Keeping this in mind, I think we can allow smaller clusters now, as 
> anyway, small clusters is a rare special case.
> 
>>
>> (And the default qcow2 is 64K, so it seemed like a good choice at the 
>> time.)
>>
>> We could create a default-cluster-size tunable, perhaps. It's at 64K
>> now, but perhaps you can override it down to 16 or lower. We could
>> possibly treat a value of 0 as "no minimum; use the smallest common 
>> size."
>>
>> This is a separate issue entirely, but we may also wish to begin
>> offering a cluster-size override directly. In the case that we know this
>> value is unsafe, we reject the command. In the case that it's ambiguous
>> due to lack of info, we can defer to the user's judgment. This would
>> allow us to force the backup to run in cases where we presently abort
>> out of fear.
>>
>> CCing Vladimir who has been working on the backup loop extensively.
>>
>> --js
>>
> 
> 

Yes. I agree with that the minimum 64K or larger is a good choice for 
the linear and full backup choice.

In the COLO application (https://wiki.qemu.org/Features/COLO), the 
primary vm (PVM)'s write requests are replicated to the secondary 
vm(SVM)'s secondary disk. The writes also trigger block copies copying 
the old data on the secondary disk (source) to the hidden disk (target). 
However, the checkpoint mechanism empties the hidden disk periodically, 
so it is a endless backup (block-copy) process.

If the PVM write requests are random 4K blocks, the block copy on SVM 
becomes inefficient in the above use case.

I conducted some performance tests.
If the qcow2 cluster size 16K, compared with the 64K backup granularity 
size, the 16K backup granularity size shows that the seq. write 
performance decreases by 10% and the rand. write performance increases 
by 40%.

I think a tunable default-cluster-size seems good for such applications.

Thanks.
Regards,
Derek

