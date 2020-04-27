Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F7C5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411C020656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="defwkSU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411C020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0fS-0000ji-Hy
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT0di-0006t0-9I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT0dh-0008LN-CZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:05:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jT0dg-0008K6-Tw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587981922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pfsaZc4m0oWgu2DaWDz4QTJL0IvG2s2lURLJ2uLvok=;
 b=defwkSU4Z6EJKfAYKnjvTCqmBG3IIHZdsqy04U6dRIB1QDgGMJIXrxSbfVDXjW2fnTH7xy
 1B9ic8yesPourzCzgNaaNs9LLDyMl2jSSZMiPu7meHNzw+6kFjkzit/0FkJ/ZvVp+5NMGu
 uEsBjNa2QSl45Dv6fo5REO27KBkMI5I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-EqP4ZgkTNaKT7h8m0t8kQg-1; Mon, 27 Apr 2020 06:05:21 -0400
X-MC-Unique: EqP4ZgkTNaKT7h8m0t8kQg-1
Received: by mail-wm1-f69.google.com with SMTP id o26so8477716wmh.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4pfsaZc4m0oWgu2DaWDz4QTJL0IvG2s2lURLJ2uLvok=;
 b=dkgr7jjesld/HpwLybLovChkYiV50J2u+YG5Yor2I8cEMrbNOetUdEpFvixf9Lgk05
 aUGCAItVtjmDt7QshTxdTOwJCxtqR7kDZKP9hqpZUu5Ddfz5d7+f7uK4xLZPHHpTv9BO
 mkho1TSinFO2tM9q8cQykcTVkV9nHlJA/LFbUtJI9Q8weSHkVTtgycLG4FEnCueIo+6L
 7+uzPgz76HbHe6upfVCUjbctmmBazTeeMel4yq3o33E3Grleh/uTJPWyzS7Oebl6gF9J
 siaMBGl84zoMytgIh5C81g0y7n/RTzXn5ACJe7KZpwqh7df5bOOJOLmrJZLxhLUVw3g0
 147Q==
X-Gm-Message-State: AGi0PuYFBaBSWlVQCbLAihAWkHGIiOGbFmIx3RlYF73HbyUVmucKk5aP
 jOlLO+4cU4+xTj/q/BOLJkAxjV0tXFSZLJ6IFuDuqPDKSEFXTC5QBVOHTr+0ukCyL6kJ1RIPnQz
 QBfE0Izao+fXK+1Y=
X-Received: by 2002:adf:ab18:: with SMTP id q24mr25969451wrc.214.1587981920328; 
 Mon, 27 Apr 2020 03:05:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypJr4SzknM1S+Dx3Nwh7+LRUsNsYWiuCFsHx2ox6UlL7AdggRDgwdcpDZcTIod2cGbwKbEvYkA==
X-Received: by 2002:adf:ab18:: with SMTP id q24mr25969420wrc.214.1587981920090; 
 Mon, 27 Apr 2020 03:05:20 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id j13sm20227511wro.51.2020.04.27.03.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 03:05:19 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] block/throttle-groups:
 throttle_group_co_io_limits_intercept(): 64bit bytes
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-2-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4618c626-b757-f83a-d231-ef08eef9311d@redhat.com>
Date: Mon, 27 Apr 2020 12:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427082325.10414-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 ronniesahlberg@gmail.com, sw@weilnetz.de, stefanha@redhat.com, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 sheepdog@lists.wpkg.org, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 namei.unix@gmail.com, den@openvz.org, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 10:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> The function is called from 64bit io handlers, and bytes is just passed
> to throttle_account() which is 64bit too (unsigned though). So, let's
> convert intermediate argument to 64bit too.

What is the meaning of negative bytes in this function?

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/throttle-groups.h | 2 +-
>   block/throttle-groups.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
> index 712a8e64b4..f921994b8a 100644
> --- a/include/block/throttle-groups.h
> +++ b/include/block/throttle-groups.h
> @@ -76,7 +76,7 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm);
>   void throttle_group_restart_tgm(ThrottleGroupMember *tgm);
>   
>   void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
> -                                                        unsigned int bytes,
> +                                                        int64_t bytes,
>                                                           bool is_write);
>   void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
>                                          AioContext *new_context);
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 37695b0cd7..37d1b7a8b8 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -358,7 +358,7 @@ static void schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
>    * @is_write:  the type of operation (read/write)
>    */
>   void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
> -                                                        unsigned int bytes,
> +                                                        int64_t bytes,
>                                                           bool is_write)
>   {
>       bool must_wait;
> 


