Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2DC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A712186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A712186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoWbv-0004dj-DD
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 13:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoWbl-0004AZ-1l
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoWbj-00062r-AZ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:23:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoWbh-00061o-5s
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:23:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so18003806wrr.9
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 10:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P14oYhMDOLY4MUxP+Ryj7ORLKmdKRM/lMb8YgkgoJKY=;
 b=WPejUl3i4HVqDo7SpFAkVWyujThCfUHOLSFTgtney8fFUsMe4b6R00rRlDZLE7WIhA
 oKbQ26G15VCrfFfEtEw6RXpWLxR8jDEg+Tv3d1/x/0Gtnz4cF7TAo1kcaKbJmSNGvq2g
 6bCJr4FLugoVj0y2pcVorGFCgUydMH/JQwuOKLUBDZBzR8cnHejSZ5E83xG/wkWbo7Uc
 pIJdo6PWmezo20uVLb48sZ8SAZQN5qu31coywJI8W7IyQE4Bxji8PA5P9CpJwzPfHpb4
 NwJG5upIrfswbDDtH1jMIFkDisG9G/2sPK8bwqO67u+cUBvHXSgFVB9jDt4qlY8YtgKB
 AXKA==
X-Gm-Message-State: APjAAAVcbUPxW3OpUrkV21PMPxIS68m1FQ+iG80Kbgk4USqju7TtVUEw
 5z8oH9bLR48dzv0UjqZ4L0ZCQA==
X-Google-Smtp-Source: APXvYqwK/Eeu9TFoJjNdzTec3ybPYfqVVL1YAQBCIybE0VGzBkmQbbyOokznCsNnHl+FCVOMDx/Ulg==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr7411003wrv.128.1563557024236; 
 Fri, 19 Jul 2019 10:23:44 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id u2sm28254664wmc.3.2019.07.19.10.23.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 10:23:43 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190719172001.19770-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bb58292c-0039-3774-3384-aae12be8d6cc@redhat.com>
Date: Fri, 19 Jul 2019 19:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719172001.19770-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] nbd: Initialize reply on failure
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 7:20 PM, Eric Blake wrote:
> We've had two separate reports of different callers running into use
> of uninitialized data if s->quit is set (one detected by gcc -O3,
> another by valgrind), due to checking 'nbd_reply_is_simple(reply) ||
> s->quit' in the wrong order. Rather than chasing down which callers
> need to pre-initialize reply, and whether there are any other
> uninitialized uses, it's easier to guarantee that reply will always be
> set by nbd_co_receive_one_chunk() even on failure.
> 
> The uninitialized use happens to be harmless (the only time the
> variable is uninitialized is if s->quit is set, so the conditional
> results in the same action regardless of what was read from reply),
> and was introduced in commit 65e01d47.
> 
> In fixing the problem, it can also be seen that all (one) callers pass
> in a non-NULL reply, so there is a dead condtional to also be cleaned

"conditional"

> up.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Reported-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/nbd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 81edabbf35ed..57c1a205811a 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -640,12 +640,11 @@ static coroutine_fn int nbd_co_receive_one_chunk(
>                                            request_ret, qiov, payload, errp);
> 
>      if (ret < 0) {
> +        memset(reply, 0, sizeof(*reply));
>          s->quit = true;
>      } else {
>          /* For assert at loop start in nbd_connection_entry */
> -        if (reply) {
> -            *reply = s->reply;
> -        }
> +        *reply = s->reply;
>          s->reply.handle = 0;
>      }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

