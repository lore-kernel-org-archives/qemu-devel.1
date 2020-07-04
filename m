Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD11C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1A920CC7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBpnJagM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1A920CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpiW-0001Kq-9y
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrphf-0000Ca-1a
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:28:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrphc-0003CU-JM
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K7QO6iNSuv0/9Zs2CFqwqEZWZQO+Ssq3W4uY8aLh+TI=;
 b=YBpnJagMQGVAmZff50xdfbpoChpY5MwgMZr94yNgP0fYAADb7ZlokssLaTSbI31s5hLZG4
 m3i9gsJEcKCj27uhy4zRe7KBrw+48km4GAUKG627rWNNt4LkBF+kBvxV0WN3J96qqKaqDf
 zN/gOg4w0Ojf+/ggxYo1yfgddTZbQiE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-9WeFvVM2OACwetirRls-Ew-1; Sat, 04 Jul 2020 17:28:01 -0400
X-MC-Unique: 9WeFvVM2OACwetirRls-Ew-1
Received: by mail-wm1-f69.google.com with SMTP id v6so38543696wmg.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xlEv9I3SusE9xqUs3uXEcUWJGIcD8zpkYYhaLmPnjUc=;
 b=VOk/uQduz2eAVdII/HuqDMf+P8VjE/AzBgwBWBKRcf09XiuQLxqlep9q5Pbx6eknZ8
 OA90+OiNAm+zUXKCEia9IceNU1wh+QVl42F1TPmWWxBp/m5YxPHRS9mriPbYCSbxiwaE
 Id2xXvHcFYTEBy1HeP6rzV706Cu5tHtKYyUHaEIvhE0qgGJPmNciAl40lMzIlLUrzQ3d
 OX4k+O/+5IAYUblvUJRDxGqqLNuFo/QxdWPzGp1vq3Q5rqItGlLcoGm8g54ffDsw6zdq
 HUd95mEJW2Kxoenojtl3E7pf0MwdptsQq8Yxltd/+YpsBKuqrdviH11lJjRNgozC/VlR
 K+jQ==
X-Gm-Message-State: AOAM530fxYyC+Gd6rqubeU3nmWc3svE3/Wtv+jmIJZZf8+VUlax/VfU2
 R4hiGCl+zYCDxTyMeTdzFSWCX6/AvtVHki0MsLrFq3Lm24I+IduIMUs99G1m3kwFr3MYZk7QY7H
 LBDb82eDIjwA0O9s=
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr43843044wmc.110.1593898079929; 
 Sat, 04 Jul 2020 14:27:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxauXoYzexKh/1BIwXxbFMr7AtwBFalx/+9Wln4bF/wre61Mp8W9s7DEVsO4nofgH8uYUrSfw==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr43843023wmc.110.1593898079663; 
 Sat, 04 Jul 2020 14:27:59 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g144sm48865949wme.2.2020.07.04.14.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 14:27:58 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] block/nvme: Use per-queue AIO context
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200630191318.30021-1-philmd@redhat.com>
 <20200630191318.30021-13-philmd@redhat.com>
 <20200701160328.GS126613@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <feb25dc2-95e0-cfdf-412d-df2e89044339@redhat.com>
Date: Sat, 4 Jul 2020 23:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701160328.GS126613@stefanha-x1.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 6:03 PM, Stefan Hajnoczi wrote:
> On Tue, Jun 30, 2020 at 09:13:18PM +0200, Philippe Mathieu-Daudé wrote:
>> To be able to use multiple queues on the same hardware,
>> we need to have each queue able to receive IRQ notifications
>> in the correct AIO context.
>> The AIO context and the notification handler have to be proper
>> to each queue, not to the block driver. Move aio_context and
>> irq_notifier from BDRVNVMeState to NVMeQueuePair.
> 
> If I understand correctly, after this patch:
> 
> 1. Each queue pair has an EventNotifier irq_notifier but only the admin
>    queuepair's irq_notifier is hooked up to VFIO. This means all
>    interrupts come via the admin queuepair.

Yes, but this was the behavior before this patch too.

> 
>    (This also means all queuepairs still need to be polled for
>    completions when the interrupt fires because we don't know which
>    queuepair had a completion event.)

Yes.

> 
> 2. AioContexts must be identical across all queuepairs and
>    BlockDriverStates. Although they all have their own AioContext
>    pointer there is no true support for different AioContexts yet.

I'm not sure. Maybe v3 will sort that out.

> 
>    (For example, nvme_cmd_sync() is called with a bs argument but
>    AIO_WAIT_WHILE(q->aio_context, ...) uses the queuepair aio_context so
>    the assumption is that they match.)
> 
> Please confirm and add something equivalent into the commit description
> so the assumptions/limitations are clear.

I'll do my best!

Thanks for your reviews,

Phil.


