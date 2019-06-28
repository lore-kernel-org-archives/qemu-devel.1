Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031DBC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05DE208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05DE208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqwV-0004JQ-LI
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43150)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgqJR-0001zg-95
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgqJN-0003VN-B9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:49:07 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgqJN-0003Cu-3v
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:49:05 -0400
Received: by mail-wm1-f46.google.com with SMTP id g135so8996260wme.4
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 05:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y4Tq7eAd0VFUmTDvp2cwUxjGoY1T5dep4YoNMMXFxA8=;
 b=YVFCjKgjIc772236pwxdQaUsSeMdVKwH3cPMT4+uRR4EOTo96ubE20lCVspoDVrAaP
 h2MhD25THaksMkGPudvi90gGsn5pmTSGmd3OKUOQ++FrxLbYrsoM3pe74F8hocnG8ryo
 Wuaty2PuZ6R8RutennyYp8pze6fHwTQgrqQyAN4RLenZzfwAWaknIpIiBL9654hCuWBZ
 wfTE2cSocnRAJvZw2XNbFhS78/H2EsIjvM9HxeSQKY73g7YpTY8pQXGc6Pi0vBniIqwP
 kfRECVBftdTeVLsJSFM/WWAwQA3pkLutIQ4/lsLzHWjUBdC34IMhBPE/j0a5+oNlwY1I
 aYhw==
X-Gm-Message-State: APjAAAWes2VljcuJzze8HwLlF7I9C0B+9WQdOmDaWmwKx1VULt+ad/xV
 oUNcCcKLLhwk/u9KbXkHToIsHsbhqdA=
X-Google-Smtp-Source: APXvYqy/PVGMfHjJkqflyhL1T4dqq5gRTlHe2ulcANZfT6qk7LGz5q798+LRKb5EQG0g5i10AJ6oag==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr7022908wma.151.1561724707638; 
 Fri, 28 Jun 2019 05:25:07 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id e7sm1857585wrt.94.2019.06.28.05.25.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 05:25:06 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190312085502.8203-1-david@gibson.dropbear.id.au>
 <20190312085502.8203-13-david@gibson.dropbear.id.au>
 <b693da29-0d2a-e739-17fb-9fd78894fd9e@redhat.com>
 <d68abe04-6cfa-6d08-4381-84686e8e610f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <88394a79-42dd-9d32-56dd-e3fcc822e952@redhat.com>
Date: Fri, 28 Jun 2019 14:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d68abe04-6cfa-6d08-4381-84686e8e610f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.46
Subject: Re: [Qemu-devel] [PULL 12/62] target/ppc/spapr: Enable mitigations
 by default for pseries-4.0 machine type
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
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 1:54 PM, Laurent Vivier wrote:
> On 28/06/2019 13:27, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 3/12/19 9:54 AM, David Gibson wrote:
>>> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>>>
>>> There are currently 3 mitigations the availability of which is controlled
>>> by the spapr-caps mechanism, cap-cfpc, cap-sbbc, and cap-ibs. Enable these
>>> mitigations by default for the pseries-4.0 machine type.
>>>
>>> By now machine firmware should have been upgraded to allow these
>>> settings.
>>>
>>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>>> Message-Id: <20190301044609.9626-3-sjitindarsingh@gmail.com>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  hw/ppc/spapr.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 37fd7a1411..946bbcf9ee 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -4307,9 +4307,9 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>>>      smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
>>>      smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
>>> -    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
>>> -    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>>> -    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>>> +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
>>> +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
>>> +    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
>>>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>> @@ -4389,6 +4389,9 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>>>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
>>>      smc->update_dt_enabled = false;
>>>      smc->dr_phb_enabled = false;
>>> +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
>>> +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>>> +    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
>>>  }
>>
> 
> What happens if you start directly qemu with:
> 
>   ... -M cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken ...
> 
> or with
> 
>   ... -M pseries-3.1.0 ...

Thanks Laurent! Both work.

