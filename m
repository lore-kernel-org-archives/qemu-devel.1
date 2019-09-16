Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D419FC4CEC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACED920650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACED920650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lmj-0000UA-T5
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 03:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i9lm5-0008Nc-2n
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i9lm2-0002Lg-CE
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:50:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i9lm2-0002Ky-4b
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:50:14 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B23C181DEC
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:50:10 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c188so5193762wmd.9
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 00:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t4ChABtJVmT8hr4uHwfH33h8GwiDD8BI8885GG0C1KM=;
 b=BgcjftOzNHLfu8tEcsC+HJ2iPzUq2n72NeNhN68drcVQvjVQU+recyluYQQBskP0Mb
 1qrBMZu/U/ttSFzhFapuK6GhmlNjuHZNOYFmFQqMqotGw5nGWHeKCV1Xssjl9r2hoxJy
 MB7+/utPkOvjmM59v+iGv0aVs2OePbvJUF/W7K+plRcQL6KZFKXl01PlPouVDFum2qO+
 kyuITs9qkvjwnmHIE2vkRmR4vSdhpDAhiQ761prJh43190qu1ydZRh84wsqbKHTUFDlL
 FacZffMwddsLB0DALYxzuGf/KIRmZao28Jj+1WRaEX9lBM1RTdYbGoGX6kGuaul+QkFx
 vefw==
X-Gm-Message-State: APjAAAVGa5kfv+QSOg4VaoXZcyJfrqNFoO2M7ol11HIk2ZpooHY2V33P
 cit3hp1Y0cjLmV8k6GEiXymTgFFa4Rj/xevCIqzQTdfRPk8fFfcpHdIz4dO6jHs1VpXE7hIyUxD
 jGkTDsSwazy9DRQU=
X-Received: by 2002:a05:600c:254f:: with SMTP id
 e15mr4652035wma.163.1568620209339; 
 Mon, 16 Sep 2019 00:50:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQmLfmScqh0YREILw9DH2SaoVaTDl6psd75MCMZCR1yfGZEc+BjPyocf3G05P647KOPwLcEA==
X-Received: by 2002:a05:600c:254f:: with SMTP id
 e15mr4652022wma.163.1568620209110; 
 Mon, 16 Sep 2019 00:50:09 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r28sm50374455wrr.94.2019.09.16.00.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 00:50:08 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
 <20190321082555.21118-3-richardw.yang@linux.intel.com>
 <d5fb9e01-acb9-06ab-edf9-57e2b80bd880@redhat.com>
 <20190823010750.GA21179@richard> <20190912025150.GA25169@richard>
 <c9f18d8e-b7cc-b9d1-1e10-ddbbb4cfd43a@redhat.com>
 <20190912230244.6puc4hwfxxwejx6m@master>
 <20793db8-7cfc-2a9d-aa60-5020e84a5950@redhat.com>
 <20190916020228.GA8247@richard>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8f5f7272-d80f-019e-ab6d-e2fc32f62a03@redhat.com>
Date: Mon, 16 Sep 2019 09:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916020228.GA8247@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/6] exec.c: remove an unnecessary assert
 on PHYS_MAP_NODE_NIL in phys_map_node_alloc()
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
Cc: rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org,
 Wei Yang <richard.weiyang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/19 04:02, Wei Yang wrote:
> On Fri, Sep 13, 2019 at 11:12:05AM +0200, Paolo Bonzini wrote:
>> On 13/09/19 01:02, Wei Yang wrote:
>>> It shows PHYS_MAP_NODE_NIL may represents more node the tree could hold.
>>
>> Which is good, it means the assert can trigger.
>>
> 
> Per my understanding, it means the assert can't trigger.

You're right, sorry.  That's what I meant.

Paolo

>>> The assert here is not harmful, while maybe we can have a better way to handle
>>> it?
>>
>> I don't know... The assert just says "careful, someone treats
>> PHYS_MAP_NODE_NIL specially!".  It's documentation too.
>>
>> Paolo
> 


