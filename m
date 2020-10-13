Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BC7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 02:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C8B2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 02:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="Q+OtYkwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C8B2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS9mn-00074M-Q4
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 22:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1kS9m8-0006Nz-AJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 22:10:52 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1kS9m5-00085a-Hg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 22:10:51 -0400
Received: by mail-pg1-x543.google.com with SMTP id n9so2919824pgt.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 19:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yZNUj5w8v2J34qk2HH8rGe29bK/A42RaWhEQ0FAq/fM=;
 b=Q+OtYkwXxeo6+NP7HvN0q6guvYUx7SLI1dLUUgeVYckAxSh78us2P+qMpEPJqllgUn
 VuTVEdYLLnSaiLsE3qqUlNWuniAOd8HmkPZbXIBLhAMzidGQ24YRxQQf7EggR5SPcM15
 2KkCREzbp8Slq1H+7v/NvUSCScl/slu9jucyGG5GgrZxYQIjKkG6LECBYesjsIUR3sQC
 Lz5JleJrdVP3ewp1BkgWDT3hQpPDRtH1dJKqGEeKWm5/vq6g2NhSpl1fRv2miItr7rE7
 lDug9axHHf6NVC+cSEyJ3CVCHUICidSGFNALyvfEavBuPior/GbByUZPyyxjjs6gfUKV
 UupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yZNUj5w8v2J34qk2HH8rGe29bK/A42RaWhEQ0FAq/fM=;
 b=XyI+hswOHNP58TfCXDtIljJzJMNm1VXv0hNlVH0cWycEPd8WqsK6ohLRO5oKVZ80T+
 u9Ak/vlYUBQV6j2XumVqGT4/yvY0+Tntdy0bgUAdCXNP++YmCACpv31MrD6ziCCvTgTp
 K4eVzR3a/JmnfZM1S32csbGQeZ+LKDSS1KweHsADc+rPdhLIJNT2cHIBskO+fUPUCrtU
 EBVND/zbM6ceJ0Aft/7HMCDQuqu+AX/QR0ptbqort2R1BE3wvSM5Pf81BmnDWPP6+p5x
 O0kOsrcw17M/yGW4vNeOGndqunp0RWXE25xfE6ZonhokhCRspV+gfh0uM5ecYm9liPZi
 IJyA==
X-Gm-Message-State: AOAM533oQP6LdsO02al6wHHTytYZ/meSoDuKk8R0Dg59dJdnBWP+yVG8
 BERYJGSETODlPyaS12FvGOkRUePgiCglrw2N
X-Google-Smtp-Source: ABdhPJxsmBntPb16SAjDrbrTJiV0KrVKmEeoi+eVl2d5CnGJHqZSg/Hwc7V2y8IRF7/eu4gWchYtGA==
X-Received: by 2002:a17:90b:310a:: with SMTP id
 gc10mr22604743pjb.164.1602555046279; 
 Mon, 12 Oct 2020 19:10:46 -0700 (PDT)
Received: from [192.168.10.88] (124-171-83-152.dyn.iinet.net.au.
 [124.171.83.152])
 by smtp.gmail.com with UTF8SMTPSA id b5sm20902114pfo.64.2020.10.12.19.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 19:10:44 -0700 (PDT)
Subject: Re: [PATCH qemu v9] spapr: Implement Open Firmware client interface
To: Greg Kurz <groug@kaod.org>, BALATON Zoltan via <qemu-ppc@nongnu.org>
References: <20200513035826.14205-1-aik@ozlabs.ru>
 <e5ddf04a-0d68-3cb8-2b84-47a43e234a59@ozlabs.ru>
 <f7e9ff41-de7a-c0d5-f004-51a2046ce0a0@ozlabs.ru>
 <434cdf49-5b80-5620-2635-079ee4b4ebad@ozlabs.ru>
 <86e79b6a-0032-56da-a066-9f02df361298@ozlabs.ru>
 <20200716132249.GB5607@umbus.fritz.box>
 <24e83a34-6788-d9ee-ca07-6833778d81df@ozlabs.ru>
 <35aeefc4-bdfc-65c5-afe5-1cd2579db3e4@ozlabs.ru>
 <3a81d5-9553-9a9a-ec4a-5c47607f54c0@eik.bme.hu>
 <20201012135124.214ccc11@bahia.lan>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <52fa619b-f385-2d20-1ac2-991296fe1e08@ozlabs.ru>
Date: Tue, 13 Oct 2020 13:10:40 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201012135124.214ccc11@bahia.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=aik@ozlabs.ru; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/10/2020 22:51, Greg Kurz wrote:
> On Mon, 12 Oct 2020 13:40:33 +0200
> BALATON Zoltan via <qemu-ppc@nongnu.org> wrote:
> 
>> On Mon, 12 Oct 2020, Alexey Kardashevskiy wrote:
>>> On 29/09/2020 20:35, Alexey Kardashevskiy wrote:
>>>>
>>>> On 16/07/2020 23:22, David Gibson wrote:
>>>>> On Thu, Jul 16, 2020 at 07:04:56PM +1000, Alexey Kardashevskiy wrote:
>>>>>> Ping? I kinda realize it is not going to replace SLOF any time soon but
>>>>>> still...
>>>>>
>>>>> Yeah, I know.   I just haven't had time to consider it.  Priority
>>>>> starvation.
>>>>
>>>>
>>>> Still? :)
>>>
>>> Ping?
>>
>> +1, I'd like to see this merged and experiment with it to emulate firmware
>> for pegasos2 but I'd rather use the final version than something off-tree
>> which may end up different when gets upstream. Is there a way I could help
>> with this?
>>
> 
> This patch is a bit _old_ ;) 

Nope, not really, the only change is meson and it is minor really ;)

> I haven't checked the details but it might
> need some rebasing. Especially it should be ported to using meson if
> someone wants to experiment with it.

Right. I am posting v10 because of that but otherwise there were no 
conflicts (well, tracepoints but also minor).


-- 
Alexey

