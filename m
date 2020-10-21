Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4AEC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0608A21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6Lc1BBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0608A21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVGtn-0000MM-T0
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVGsC-0007bD-Fu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVGsA-0003yC-55
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603297316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tf2GOavOs4XjPb5miOMUuacqpIENacbEkRZV9R+fots=;
 b=G6Lc1BBeQcI7GPmAR1OIXG1PDeC8S1nQz3b7JyY9b4/jvNASS1xUgbpCHPHzl0hdVMOLsS
 7n3KuUyXmQEGhMWQOZbeWYch4m0J3i84usGoiYa5/S43L8gakjW0jC6E80GSSSCoqjsm1h
 VMoSwTqfSanoO1J/KAhzuE68crH59kw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-XJ9JSCuUO8mwlmdzQstrQA-1; Wed, 21 Oct 2020 12:21:53 -0400
X-MC-Unique: XJ9JSCuUO8mwlmdzQstrQA-1
Received: by mail-wr1-f71.google.com with SMTP id b6so2907881wrn.17
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tf2GOavOs4XjPb5miOMUuacqpIENacbEkRZV9R+fots=;
 b=K7FKw6F5jOWcnj9bIn4JSPrfZGcKGT93rSBHx8WV+nVq6qJrL7q60BtiDE6jtMvMk2
 34ht/5RyQj1pyhLiXUmpdNBo8WCGon1TkrT2JoVuZRblek7cyjUBSJZ57QGjEpR3SkuH
 D/gQ3s7E2hKE/sRg2uzsrUN2hDQF8O3MaA7O9J5G3fJMWXy5cFyAbaafAK/AiR+Jy3d6
 d38MeoFRzidm0LOQwoQyaJ1f9kdxfwLrAPGN2lI6m9PoK53fQC4Z1F6ztJcBXvK8YkTm
 VNxxECyCGndgoiqDKuRwZQ1HBOu1thoMbNSClQI/pVq5epXfiJqUeKQrPc5+izA2D5x3
 J1Zw==
X-Gm-Message-State: AOAM530rk8WOQyYC13l7vaHYr34A1qmpDWzqxS1TQ9O46ny1PVu7Xsof
 YPY6qvTtfrMnENevPtsYlLnJyDa25ZgnlgFDCiofQWoSaaOxcOAAj2r7eHJwHD+SsJvJy95Mxzp
 LeMY5wa/QbLpDZdw=
X-Received: by 2002:a7b:c935:: with SMTP id h21mr4205169wml.99.1603297309515; 
 Wed, 21 Oct 2020 09:21:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX+chci9MIHkAQfSDy2YDVhWBd2piFaQN3DgREzDS4FghCnux9GAQwttroL4BfgXNIjr7ERA==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr4205154wml.99.1603297309218; 
 Wed, 21 Oct 2020 09:21:49 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o3sm4849029wru.15.2020.10.21.09.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 09:21:48 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] util/oslib: Assert qemu_try_memalign() alignment
 is a power of 2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201020111743.2074694-1-philmd@redhat.com>
 <20201020111743.2074694-3-philmd@redhat.com>
 <9c578c16-ad57-33d8-9900-b6513cf207e1@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <53fe6833-719c-9449-79b7-a6b7dddd63ee@redhat.com>
Date: Wed, 21 Oct 2020 18:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <9c578c16-ad57-33d8-9900-b6513cf207e1@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 6:01 PM, Richard Henderson wrote:
> On 10/20/20 4:17 AM, Philippe Mathieu-Daudé wrote:
>> @@ -200,6 +200,9 @@ void *qemu_try_memalign(size_t alignment, size_t size)
>>   
>>       if (alignment < sizeof(void*)) {
>>           alignment = sizeof(void*);
>> +    } else {
>> +        g_assert(QEMU_IS_ALIGNED(alignment, sizeof(void *)));
> 
> This is redundant with the if above, and the assert below.

Indeed, thanks =)

> 
>> +        g_assert(is_power_of_2(alignment));
> 
> 
> r~
> 


