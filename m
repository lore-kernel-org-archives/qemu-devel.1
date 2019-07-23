Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A8EC76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E472239E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="DjiCQUSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E472239E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnfQ-0008ST-Pr
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45696)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hpnfF-00082o-KO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hpnfE-0000Yj-Lo
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:48:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hpnfE-0000Y4-FY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:48:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id i189so18542422pfg.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 22:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z1FX/1RBevNZKl99oheBgF3rXXm9n3HQibJvvLzsb6c=;
 b=DjiCQUSq8a31O6ejjTUkCt+cGnyHhmLxzky3sptNZ8Rdmw6VXVA3mZWyibkEoaFHY3
 t+TaeE0y1/sMf5FQ5GX6MGiVVaDHadiPUIjjRUIBPJ6+WltMuZYcIye1mUQPT55cjCBR
 Em76Xsa7G0m2RRkEgr1IG4b+9ahL2j5xQLAk00VnV/Cl9XugmyfyJaUnZtF+TBMTccSN
 7NTw6XG/iVqHMVd6G+WoZTTO067tuMdNMMow5P2lxNmdHo3cLVqdZo+c2std5ZvUgtRR
 x8UTGR2FLlR1bs4f1EeMuMVBuhQMdkRfORAhaWXZgLxrzbX4rTvOC6YtdGjJVWx3WeEg
 r4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z1FX/1RBevNZKl99oheBgF3rXXm9n3HQibJvvLzsb6c=;
 b=fc444FggcKnTPmfpC/cXhJ/h7LN7Tt52pdCEg1tRbHVhCPyPrANOC4u+cdQ1H9+DHB
 alB1+xPJpusNQbmIRh6C5/4Ek/uQP0SNvxIzuquMGY+0h4YZuHMoZuaV9so8uEBFU8z5
 /pic2xAqm3JVOg2C00RwJ5YwahgAx3PhI8YbE/VWF36IQDTGzm3L991bWV/nWfRCYXg9
 CWNmAv+blD2D+ElLEV4K7Sz2hXUnC+aEsV9F/hm9hkQGZIeK1QD/IwO5lTsbiCBzWHWV
 46lNV99m0W5VuVML287tovreVHYqEMBN/lH0edC3pC8BCtYMHsdpqiDbKvdzjTIhZ6d6
 5zsA==
X-Gm-Message-State: APjAAAVUb5kEhOLPvSYDOvmgSy+N4vnAIogL/r6qco3e/k9SYvHQL6Pc
 VGbAH1HI8FyyjWSrXOeWXeM=
X-Google-Smtp-Source: APXvYqzxp/79JIAMqGFwYShbKqdVjZNT4zMxxaH2PaSmCGfgUMHdv1zK9KuyY6rzHeVXi2rKO3V9cg==
X-Received: by 2002:a63:e907:: with SMTP id i7mr73832913pgh.84.1563860919288; 
 Mon, 22 Jul 2019 22:48:39 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e124sm65159798pfh.181.2019.07.22.22.48.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 22:48:38 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-4-aik@ozlabs.ru>
 <20190723035330.GQ25073@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <181b65ae-866f-7e0b-1042-7695e7c2ddda@ozlabs.ru>
Date: Tue, 23 Jul 2019 15:48:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723035330.GQ25073@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH qemu RFC 3/4] spapr: Advertise H_RTAS to
 the guest
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 23/07/2019 13:53, David Gibson wrote:
> On Sat, Jul 20, 2019 at 11:28:49AM +1000, Alexey Kardashevskiy wrote:
>> Since day 1 QEMU implemented RTAS as a custom hypercall wrapped into
>> a small 20 bytes blob which guest would call to enter RTAS. Although
>> it works fine, it is still a separate binary image which requires signing
>> at no additional benefit.
>>
>> This adds a flag into /chosen to tell a modified guest that if the flag
>> is there, it can call H_RTAS directly and avoid calling into the RTAS
>> blob.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   hw/ppc/spapr.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 81ad6a6f28de..b097a99951f1 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1230,6 +1230,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>           _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
>>       }
>>   
>> +    /* We always implemented RTAS as hcall, tell guests to call it directly */
>> +    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_rtas", 1));
> 
> Rather than creating a new property for this we could use the
> qemu,hypertas-functions property which is already used to advertise
> some KVM specific hcalls.

True, this is another way of doing it. We will also need a proper number 
for it rather that custom 0xf000, Paul suggested we could tell the guest 
this number via the "qemu,h_rtas" property.


> 
>>       spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>>   
>>       g_free(stdout_path);
> 

-- 
Alexey

