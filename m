Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A7C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E1A2146E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yp0rAKC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E1A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ZMa-0007J2-5o
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 14:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ZKx-0004se-8W
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ZKw-0004MP-87
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ZKw-0004Gg-21
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 14:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583348741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiIDj0qWNszDLmZREC3DNqckTlFptT/XSgvw6ysOz/k=;
 b=Yp0rAKC3uX+TPkM8230iZSjVgslHlQrOLb9YtUdLfBNSoAsK5YgcE+e2jgd4vYK/Z712iD
 r8VhznlvfhmGvEcgIimVI8kh9pbc72vk3XQtDjHzRuOca3oTl2s8BUmioWlPwewa9R847Z
 temW/KdBYyj4EYXd69aK4YRy8a0VHVI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-pIMyqCJ4NQ-s17kQjhAiKg-1; Wed, 04 Mar 2020 14:05:37 -0500
X-MC-Unique: pIMyqCJ4NQ-s17kQjhAiKg-1
Received: by mail-ed1-f70.google.com with SMTP id ck15so2311758edb.6
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 11:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iiIDj0qWNszDLmZREC3DNqckTlFptT/XSgvw6ysOz/k=;
 b=pDX4rXYC2Lxv9i439f9a7LXe/INogqBIFbJWUEB8YpRFFUJuZVkFGA8/5OA0boOFE8
 U/cAz02/iXX77jwPEvfBcpWNbANIMMz+FTTAYJoLqMigzvFiBTz9mDIQlxHNf3iBmtgH
 wMK67drS0myqkkisaDo9+IN7sKNs6SUv8cXWsdDGw+cwDpylsHo/FKLXA5J4XMem2oDn
 uy7Ri1ZKIogkeo5HXXT/E76U/het21kRcMuowokFES0C5xTA9kmwuipd83GjeeBk1FIn
 YDyYLiQ9ax48+tybcfXfS9nluH5KGIrpt/25iAlEOrUBaLv2szIBBtozas8xEsQhIIat
 G++g==
X-Gm-Message-State: ANhLgQ0GIin6zh8RtERZE5YZ0PL/YRzgmN5jyer+RLanPjil1vXeA9z6
 f/LQaTRO5AChAPa4uhjgkaoipmiwd6meBtCyppV4l19w0XW2w1mvIjGKtbz1B+sL/d+2phb5jOA
 Rrbr8lf09p9Y6LHo=
X-Received: by 2002:aa7:dd95:: with SMTP id g21mr4376093edv.355.1583348735365; 
 Wed, 04 Mar 2020 11:05:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu7JlQoGkD7tbf0jWirKGMRjTCsDL7NkYlJy5NaeJz4K/7FF0ZjGGCOSHRQK9BiDF3f/Gx8BQ==
X-Received: by 2002:aa7:dd95:: with SMTP id g21mr4376077edv.355.1583348735196; 
 Wed, 04 Mar 2020 11:05:35 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id br7sm1315278ejb.13.2020.03.04.11.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 11:05:34 -0800 (PST)
Subject: Re: [PATCH] configure: change a typo in zstd config
To: quintela@redhat.com, Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20200303124925.28079-1-dplotnikov@virtuozzo.com>
 <878skhvbq0.fsf@secure.laptop>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <26715e80-32fa-5ebf-9f3b-c110f6c9b7fa@redhat.com>
Date: Wed, 4 Mar 2020 20:05:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <878skhvbq0.fsf@secure.laptop>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 1:56 PM, Juan Quintela wrote:
> Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:
>> Package manager --exist flag is used instead of --exists.
>> Fix it.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> queued.

It doesn't seem that trivial:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg684754.html

> 
> thanks.
> 
>> ---
>>   configure | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 7b373bc0bb..caa65f5883 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2464,7 +2464,7 @@ fi
>>   # zstd check
>>   
>>   if test "$zstd" != "no" ; then
>> -    if $pkg_config --exist libzstd ; then
>> +    if $pkg_config --exists libzstd ; then
>>           zstd_cflags="$($pkg_config --cflags libzstd)"
>>           zstd_libs="$($pkg_config --libs libzstd)"
>>           LIBS="$zstd_libs $LIBS"
> 
> 


