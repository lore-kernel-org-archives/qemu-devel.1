Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A503C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D48C21BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D48C21BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8P9-0004vl-Jo
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kL8JI-0006Dx-9D; Wed, 23 Sep 2020 13:12:04 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kL8JF-0007jl-T6; Wed, 23 Sep 2020 13:12:03 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mq2rM-1kpISs0xNq-00n76b; Wed, 23 Sep 2020 19:11:56 +0200
Subject: Re: [PATCH] vhost-vdpa: remove useless variable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200920152024.860172-1-lvivier@redhat.com>
 <8793d489-3961-f53a-df69-21a7eda85f22@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eef04a11-7c32-45d0-bbc8-ee9eff4c02b1@vivier.eu>
Date: Wed, 23 Sep 2020 19:11:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8793d489-3961-f53a-df69-21a7eda85f22@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:stFfRJz8uXAOqVndLOwK9Fzm4+KC7e5zLfWEb8U1rbuW0bRAy0b
 nzAcXL6rW9J+X6UdSHslCoL8MTqttYTl7O+KiEN8iho/PIS7VCHbnmDVeHthM86REBcO90A
 eUbiEoM5F6vda24L5zzDmNEoZV4CqSog6AJuujhyRVIcYEjHxuK5KhFF3NutEzV/56HhoTR
 e3L470OKdLwDWD50OE4mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Eb1zGyHL10=:0jsE3dFdaOz2A6zjChtcrm
 FxQKwctxXADq3LGZF3ybvoWFboJb90LNpajaPx//cD2Qqp2nC838pmlzGpihxYa6i1HBMwwqB
 5pz83WgbF3qUIDYKd5RcBG02s+vDrff1aEAPPdHNSNiRjCSfs/4c0BFe25tWarBPOLraIeBr3
 KS2ikKrQnFIRVx1wnQ1/+xXHgHUCSDFyZU8tzXW6pr147B2QQuG1ErZtGyXNyWYJuCQ72nUBV
 wFnhCuY6fB/vQv9GYo3CDBn+q+py4Jt/xt8YjyxW0bFxfrSxvBWKQv8FDwucNLx5P/rM3GGds
 cx+1oOKoVnPHgHB21vwOOlUHC7Uu5vohzvcbiDlSz1AD0XtPtkeiu0MGimLjRBkxHolYm5quF
 o4GIr0EXjNGbb0OSiYElwxKaqgW3XdpZ2IuR5ITOCfNbzNx539Bn7uhzgSIrtetB5BglzBZaT
 63eRt4MDtEXHi00VqG0KPA/7oBb/8OBWlSLBVGNAnRYWT986sU8sV2QjNIBYV7f2sI7hmFKa0
 ZLhh2o8KRafqlBR/h4pk3dBZvosnFbtFOV4mx3WCLGUQn8BVnP+4YiemD4J9/vjUx4rYgaMyy
 dD17biosMDIu9t1HWsUwHzQ089z2I57pIeYZgLbtKnXVWF0RQouTXUOPs8qjWNuxwjrmgotjf
 ayV7Gj7wIw+srkvaocLnJ0F0qV6UQ0omfsYYgn8zuWRwiaAX21NJldAybahqyqgLMnnY09K9o
 a8qN01OsNxhNtGRRAl3v+qc8hmD3JDE3sJG8pqEK2zdcQw0e/aStsMNeyK3C2LMd1UDJnFiW/
 JbogJVIdlYF+2rrSNxhHbCm8mWWxcPJwjQEItXmtW6njd551uqM6Q+qDH/JHFwdtjjgc0px
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 13:10:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/09/2020 à 17:59, Philippe Mathieu-Daudé a écrit :
> Cc'ing qemu-trivial@
> 
> On 9/20/20 5:20 PM, Laurent Vivier wrote:
>> in vhost_vdpa_listener_region_del(), try_unmap is always true and so,
>> vhost_vdpa_dma_unmap() is always called. We can remove the variable
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> ---
>>  hw/virtio/vhost-vdpa.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 4580f3efd8a2..c6cae6a6cabf 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -153,7 +153,6 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>      hwaddr iova;
>>      Int128 llend, llsize;
>>      int ret;
>> -    bool try_unmap = true;
>>  
>>      if (vhost_vdpa_listener_skipped_section(section)) {
>>          return;
>> @@ -176,11 +175,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>  
>>      llsize = int128_sub(llend, int128_make64(iova));
>>  
>> -    if (try_unmap) {
>> -        ret = vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
>> -        if (ret) {
>> -            error_report("vhost_vdpa dma unmap error!");
>> -        }
>> +    ret = vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
>> +    if (ret) {
>> +        error_report("vhost_vdpa dma unmap error!");
>>      }
>>  
>>      memory_region_unref(section->mr);
>>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


