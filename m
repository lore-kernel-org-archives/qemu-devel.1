Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F52C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963A620830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963A620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OTY-0004W7-Jy
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8OQg-0001jY-LU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8OQf-0000x2-FC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:42:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8OQf-0000wp-AC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:42:29 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81E65636C
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:42:28 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id b1so11938953wru.4
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Er/2SjTbGiTyQTXDhOfSpSakj1+5Tjb2qAfNosvD4BU=;
 b=LKrNhs0h6tr2cOf3ZaLT+n2EEsyJtTzqjDpMpzJI/nDQCSM1fsES9M9zL+FSdOFvWF
 uZlLU6cy+0kCNkiIHrDK31pfynT01BEC9/6SW5ZrffNFYEpEbLWxjzzoar9CX/eH2o1G
 LcEAbZZLW+fdgg+84pgGBLp50uWcfGRD0OaH0uBolSIjHDiwwKrq7yuK2NZ73su4hGu6
 ALwfW7ltmSGjgXGzZ6TGYob4vMd9Jm3FciFJwbbNBAAdb774jkT29+sxrHJF6qNFORHV
 7A4v8G4MLfJ652r0B1IA1N4CoZxcJ311WwMe0bp/QVmUB5mFwAmVGnGFyaFah4MeIZbv
 wIQg==
X-Gm-Message-State: APjAAAXUaw/1wQxZfXc0e1c1ZklVbrjQs9eUJzPH+jh+31kkp8raWxcR
 MO3eSw3Ioa753U2HpN9UbVfcB10anBlfBMMV5SGpXfA4wZsaKB6NdExU0c+FrXxklKQhdmTSg+A
 rDx1fG45qS+TdyZ0=
X-Received: by 2002:adf:fe07:: with SMTP id n7mr8642170wrr.90.1568292147139;
 Thu, 12 Sep 2019 05:42:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCS/yiyuydIXkWQuhcOEu932lLmpiSTxE+yMrSVR44Rbz0y2t3Oh2Y5go3u+NkuTbqJPUGLQ==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr8642152wrr.90.1568292146888;
 Thu, 12 Sep 2019 05:42:26 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q25sm7627498wmq.27.2019.09.12.05.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2019 05:42:26 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
 <20190321082555.21118-3-richardw.yang@linux.intel.com>
 <d5fb9e01-acb9-06ab-edf9-57e2b80bd880@redhat.com>
 <20190823010750.GA21179@richard> <20190912025150.GA25169@richard>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c9f18d8e-b7cc-b9d1-1e10-ddbbb4cfd43a@redhat.com>
Date: Thu, 12 Sep 2019 14:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912025150.GA25169@richard>
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
Cc: rth@twiddle.net, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/19 04:51, Wei Yang wrote:
> On Fri, Aug 23, 2019 at 09:07:50AM +0800, Wei Yang wrote:
>> On Thu, Aug 22, 2019 at 12:24:32PM +0200, Paolo Bonzini wrote:
>>> On 21/03/19 09:25, Wei Yang wrote:
>>>> PHYS_MAP_NODE_NIL is assigned to PhysPageEntry.ptr in case this is not a
>>>> leaf entry, while map->nodes_nb range in [0, nodes_nb_alloc).
>>>>
>>>> Seems we are asserting on two different things, just remove it.
>>>
>>> The assertion checks that this "if" is not entered incorrectly:
>>>
>>>    if (lp->skip && lp->ptr == PHYS_MAP_NODE_NIL) {
>>>        lp->ptr = phys_map_node_alloc(map, level == 0);
>>>    }
>>>
>>
>> Hmm... I may not get your point.
>>
>> phys_map_node_alloc() will get an available PhysPageEntry and return its
>> index, which will be assigned to its parent's ptr.
>>
>> The "if" checks on the parent's ptr, while the assertion asserts the index for
>> the new child. I may miss something?
>>
> 
> Hi, Paolo,
> 
> Do I miss something?

Sorry, I was on vacation.  phys_page_set_level can be called multiple
times, with the same lp.  The assertion checks that only the first call
will reach phys_map_node_alloc.

Paolo

