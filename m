Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50348C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A25E21873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A25E21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoWVz-0008Gw-Ej
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 13:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52635)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoWVo-0007nr-Bb
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoWVm-0002kn-Hh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:17:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoWVm-0002kG-Bn
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:17:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so32943411wrf.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 10:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G4Hibuos6Ajw0szDWr9RISzyykzhdWeEeGSY8sQ4Inc=;
 b=icrEvYLfIFrzHAJkQL9iHCMUgtWvaH0XMdeHxnf+n4mm1gbimiLl2xfQh5U8cMN/5v
 J9XpqTUEeKzuVp/7GuFwsktlg8OPFb36XSkyGCB8I+xToud1RNEdzNCU8vImYbItjjmM
 QOCmlSbCcp7vWlHKGYcD8SlCfojCC9BS/UerZGLbmFHZMAEC3vRkfPj0igtd0803Yi7e
 mOOsZMIgbbFahk45imGagIF8GRSt1lM2ohzyGVU5wocxomTbAfPJEc3/MViqCoN99tXF
 GSRwjdfokq49ukRHsbtIct6k75ojAe50Gou14utELRlR4sSa5eDAylh6GJSeEzW+iTU7
 3nog==
X-Gm-Message-State: APjAAAVPFnR0XBJemdn73Dw20+rw2ysnGYDwF7SUYirCyHic/dWLivVJ
 cfFGJEku6LL30X9kELBVendxTw==
X-Google-Smtp-Source: APXvYqzoepqCfC5N+s6cusFKUp1wKwWE0XF/raA0sSxo2uvycNL1F1VRYc+TNmxiRPj/PdIMAGsnGw==
X-Received: by 2002:adf:f186:: with SMTP id h6mr44766028wro.274.1563556657273; 
 Fri, 19 Jul 2019 10:17:37 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o3sm23268727wrs.59.2019.07.19.10.17.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 10:17:36 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190719150313.29198-1-eblake@redhat.com>
 <01532f52-0c41-1bd3-72ca-97916c1499a9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <67e4a177-9307-1c42-8882-f6b5bdc81dcd@redhat.com>
Date: Fri, 19 Jul 2019 19:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <01532f52-0c41-1bd3-72ca-97916c1499a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] nbd: Initialize reply on failure
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

On 7/19/19 7:15 PM, Eric Blake wrote:
> On 7/19/19 10:03 AM, Eric Blake wrote:
>> We've had two separate reports of a caller running into use of
>> uninitialized data if s->quit is set (one detected by gcc -O3, another
>> by valgrind), due to checking 'nbd_reply_is_simple(reply) || s->quit'
>> in the wrong order. Rather than chasing down which callers need to
>> pre-initialize reply, it's easier to guarantee that reply will always
>> be set by nbd_co_receive_one_chunk() even on failure.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Reported-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
> 
> Blech. Needs a v2.  Expanding context:
> 
> 
>> +++ b/block/nbd.c
>> @@ -640,6 +640,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
>>                                            request_ret, qiov, payload, errp);
>>
>>      if (ret < 0) {
>> +        memset(reply, 0, sizeof *reply);
>>          s->quit = true;
>>      } else {
>>          /* For assert at loop start in nbd_connection_entry */
>         if (reply) {
>             *reply = s->reply;
>         }
> 
> either callers can pass in reply==NULL (in which case the memset()
> dereferences NULL, oops), or always pass in non-NULL reply (in which

Oh good catch...

> case the null check is dead code).
> 

