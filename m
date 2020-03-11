Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D3FC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7899E20691
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUGdMffy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7899E20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC5fW-00072u-T4
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 14:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC5ed-0006TZ-3K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC5eZ-0000pc-W3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:00:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC5eZ-0000nh-QK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583949622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZU2c2gEM/di/X/3AmUex3SAwnNcneoYIZdVeHg4L858=;
 b=QUGdMffyPR0CFZcSvbCBx51rSSQunxet5bN93RTPLBeo3yzI+6NPTD3qp55BBHOXXaY2cz
 /750khyJNDgTdWKCNit1005Fi02zEypNpIaRy//HjPR6RNaPiyJniKQjiIlL0oeX+8wLZO
 dzQc0cewv7i7iT8GWaz91ws1Ouz8Q8o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-7hxND2KKO5a-RhMrWzEVng-1; Wed, 11 Mar 2020 14:00:21 -0400
X-MC-Unique: 7hxND2KKO5a-RhMrWzEVng-1
Received: by mail-wr1-f69.google.com with SMTP id p5so1281765wrj.17
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 11:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZU2c2gEM/di/X/3AmUex3SAwnNcneoYIZdVeHg4L858=;
 b=SPpz9fdJaiLmuLlakx8FO5CAM6Zr+97NImKoaSP8XG5sJRgWjCMpD7Otw6mKtX3ZAT
 hAol+48CCdlnfp72fFlZm5/5IYEfiiVP0vguHJUTDopm+AzX0hYSOgsMFi5QN+ZVmpJk
 WGWVx0V7wilqXclQ2FsLnZ1YFI2gGxFrgu986Lpy/bxQ8C6vCnkWbKI7fWlnd7MCD/Dy
 JJjzSf91F/UwXusxoUWdxdiwhdU+tpK21YfOPu0JCbqmCmuCZqc81z0uLiBwcC83JamQ
 chI4UhmPW0sb9iFk6nbjUkarT+g8vN3TXncUtiPfUs+W053A8YRpg851LJ8ohKh9YA8F
 nZTg==
X-Gm-Message-State: ANhLgQ3oI1G+4Yysc+/2L5NcRAIJ+PTW3GyX2eUjRwmXEC5iViadqjIC
 OP8xbHqRh7KtnQ2/9mLLm4Ys2dLFUPkxyE3K2HEx22wSbkHxvBHHYbduGo4rhaweVjJqnMzazex
 CTASeixyocpg/69s=
X-Received: by 2002:a5d:6649:: with SMTP id f9mr2723407wrw.212.1583949619818; 
 Wed, 11 Mar 2020 11:00:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt7nu58svkGv8oo8gwtJeapaHmvBoG7hr1FHG90FK7Suedpcb1nrT1kPwKGZst8kDMYp2gW6g==
X-Received: by 2002:a5d:6649:: with SMTP id f9mr2723382wrw.212.1583949619548; 
 Wed, 11 Mar 2020 11:00:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8?
 ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
 by smtp.gmail.com with ESMTPSA id q3sm8667758wmj.38.2020.03.11.11.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 11:00:18 -0700 (PDT)
Subject: Re: [PATCH] oslib-posix: initialize mutex and condition variable
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200310175921.501191-1-pbonzini@redhat.com>
 <39e3ce5a-1ac8-9491-e7ac-72320b824348@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9fa9d363-fb08-3d52-a0cc-120d9c792a30@redhat.com>
Date: Wed, 11 Mar 2020 19:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <39e3ce5a-1ac8-9491-e7ac-72320b824348@de.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: bauerchen <bauerchen@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/20 21:23, Christian Borntraeger wrote:
> 
> 
> On 10.03.20 18:59, Paolo Bonzini wrote:
>> The mutex and condition variable were never initialized, causing
>> -mem-prealloc to abort with an assertion failure.
>>
>> Fixes: 037fb5eb3941c80a2b7c36a843e47207ddb004d4
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> You might want to replace this by 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>

Okay, will do.

Thanks,

Paolo

>> Cc: bauerchen <bauerchen@tencent.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  util/oslib-posix.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 897e8f3ba6..4dd6d7d4b4 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -466,10 +466,17 @@ static inline int get_memset_num_threads(int smp_cpus)
>>  static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>>                              int smp_cpus)
>>  {
>> +    static gsize initialized = 0;
>>      size_t numpages_per_thread, leftover;
>>      char *addr = area;
>>      int i = 0;
>>  
>> +    if (g_once_init_enter(&initialized)) {
>> +        qemu_mutex_init(&page_mutex);
>> +        qemu_cond_init(&page_cond);
>> +        g_once_init_leave(&initialized, 1);
>> +    }
>> +
>>      memset_thread_failed = false;
>>      threads_created_flag = false;
>>      memset_num_threads = get_memset_num_threads(smp_cpus);
>>
> 


