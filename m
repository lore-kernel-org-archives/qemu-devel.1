Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B7BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27B820738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPm+V8T/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27B820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoZW-0003ch-Uc
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgoYf-0002Mi-Vo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:01:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41622
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgoYe-0008Rx-M5
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591272075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/HD7LwIrMVeahN99LnKiqtXp8sgJMKBeWCgL1aq3/k=;
 b=IPm+V8T/0sjqRY8FH6x45A0kzGTKPO3dDZ7In0eUFC/Eaip8N4U2GeDX5lKrY1r2UfNgQF
 5XXHe/q8XeiHnEqqKqKAcYXS5d0EfB74BZeMdORgJlbbdh8djnZacTXCW8ItLDP6gXJ9D6
 FphRQ0azMcueR/qqoNKQBUKLNM6PjF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-SAQIGOPMPY-FVOmgfS0WJw-1; Thu, 04 Jun 2020 08:01:13 -0400
X-MC-Unique: SAQIGOPMPY-FVOmgfS0WJw-1
Received: by mail-wr1-f69.google.com with SMTP id e1so2355017wrm.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 05:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z/HD7LwIrMVeahN99LnKiqtXp8sgJMKBeWCgL1aq3/k=;
 b=r1Vk9ejB5BFdl3Pt2nNx6mnyLDIfhqh5XLCU5JaknBiczx2UFblP0JPo74fkLaY3tb
 E1EHbeFG0a8uVDsB1hc1Cfuvc/LftLK0vxkALa5cKNG5qfNFukNSD4zXl8mcNxtkHP6/
 PDwuxXts+LqhSBUXmpmzLeFPZpEu5B1EEjvgWzywN5KiU7OAer/NG2eJCaT+A3OQL9Fb
 BDJyFp73P3i6q40cZpCtuuqjsxRBlYtGgjrCWCtKpEu/zmt3SRzCn+WRb1Aiu0jbv35H
 1uD0/UeqnndQBtQrXlttNz93dR+DenPAKMzxkdpEGpKhBnhHDpGdlgh8a090gLE1zBX6
 kOXQ==
X-Gm-Message-State: AOAM533AeEgBZyz/uNGf4udjSsdjzZCNAJp9ttVEJXiRnCUE6gQZM4Lb
 3BHpFnjrhcbd8vJyXxQcLNiU2KEiL8RxkCBjic2o8rI8wUUdDt5sQPJzChv9tHHDeo+HdhN4SOV
 WRA7ckeUyuiMUzbM=
X-Received: by 2002:adf:cf06:: with SMTP id o6mr4021867wrj.163.1591272072368; 
 Thu, 04 Jun 2020 05:01:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6FCnNxh6PzsdjjpBVjMwtXRhtdSAFb7KJSRu7JrEYBb2GsnaW0Xk+nxdcIsOhYQeQAN+nUg==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr4021843wrj.163.1591272072105; 
 Thu, 04 Jun 2020 05:01:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id x18sm6807456wmi.35.2020.06.04.05.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 05:01:11 -0700 (PDT)
Subject: Re: [PATCH v3] ati-vga: check address before reading configuration
 bytes (CVE-2020-13791)
To: "Michael S. Tsirkin" <mst@redhat.com>, P J P <ppandit@redhat.com>
References: <20200604105524.46158-1-ppandit@redhat.com>
 <20200604074539-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ff41723-e973-085c-2ed7-41478f15bdbc@redhat.com>
Date: Thu, 4 Jun 2020 14:01:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604074539-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/20 13:49, Michael S. Tsirkin wrote:
> On Thu, Jun 04, 2020 at 04:25:24PM +0530, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While reading PCI configuration bytes, a guest may send an
>> address towards the end of the configuration space. It may lead
>> to an OOB access issue. Add check to ensure 'address + size' is
>> within PCI configuration space.
>>
>> Reported-by: Ren Ding <rding@gatech.edu>
>> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
>> Reported-by: Yi Ren <c4tren@gmail.com>
>> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> 
> BTW, this only happens on unaligned accesses.
> And the IO memory region in question does not set valid.unaligned
> or .impl.unaligned.
> 
> And the documentation says:
> 
> - .valid.unaligned specifies that the *device being modelled* supports
>   unaligned accesses; if false, unaligned accesses will invoke the
>   appropriate bus or CPU specific behaviour.
> 
> and
> 
> - .impl.unaligned specifies that the *implementation* supports unaligned
>   accesses; if false, unaligned accesses will be emulated by two aligned
>   accesses.
> 
> Is this then another case of a memory core bug which should have either
> failed the access or split it?

In this case the path should be

  address_space_stl_le
    address_space_stl_internal
      memory_region_dispatch_write
        memory_region_access_valid

and then it does check valid.unaligned.  Is there a testcase?

Paolo

> 
>> ---
>>  hw/display/ati.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Update v3: avoid modifying 'addr' variable
>>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00834.html
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index 67604e68de..b4d0fd88b7 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -387,7 +387,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>>          val = s->regs.crtc_pitch;
>>          break;
>>      case 0xf00 ... 0xfff:
>> -        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
>> +        if ((addr - 0xf00) + size <= pci_config_size(&s->dev)) {
>> +            val = pci_default_read_config(&s->dev, addr - 0xf00, size);
>> +        }
>>          break;
>>      case CUR_OFFSET:
>>          val = s->regs.cur_offset;
>> -- 
>> 2.26.2
> 


