Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF99C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F78208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F78208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLrHx-0001Yj-Cz
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:36:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLrGc-0000gm-Mg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLrGY-0006dc-DX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:35:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLrGY-0006d1-7Q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:35:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so16485698wrs.2
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1N1cRdmZ3JMC/ufMiUPBMh2QUAsuMmLb8Ofy6IZ1/Ro=;
	b=fMMnkv5flNP52yiC5uTDK9TJ+uGnxgooh6h5PkT0QwVdx+WzSSRhT/mJVKV/21mfJB
	uKc0NW27MTI6cGPOjjXmns5nG2Zrx6Bti0ECLrxYI/24Kack9KAsaRID+s2D2/Kxmt/i
	6QzwOKlq+3Gnqc3W80NJSw3OSEPgKF8ofXpyvGXer7qSD/RNblYGakBfdktnKhherRtX
	X63/BHQM4TKcS4mSnA3CgOhpudAC73a+SMAYFMSuSIhBPvB3LliWfMTXSzwr8z4pT9+C
	8PytikINCDEG0T7mLFnt4cxWG505DGI8rqpII0JVufTSoLcW64CYQFF4DSlVdoqF8DAH
	D6dQ==
X-Gm-Message-State: APjAAAX99kgj3mh4LaDvTjHdVG80W4gIUFEyP6FhI780CGLQiOieWPX+
	AlkHumqQx3qriAgXENE9Trrm3A==
X-Google-Smtp-Source: APXvYqzZLw5p1+d12H7RJTLGKU988Ow+wTh9iXq/as5lJ72b0cQz6Gvn3cdfEUhm80ER+eMIiQdCWA==
X-Received: by 2002:a05:6000:104:: with SMTP id
	o4mr8803478wrx.106.1556724925347; 
	Wed, 01 May 2019 08:35:25 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	r8sm18136564wrg.22.2019.05.01.08.35.24
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 08:35:24 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org,
	qemu-arm <qemu-arm@nongnu.org>
References: <20190430181326.1314-1-driver1998@foxmail.com>
	<c794f5a4-470a-3f49-c5df-bd37d97d711a@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4c1ceb10-4dfa-7173-0a7e-1af919154fbd@redhat.com>
Date: Wed, 1 May 2019 17:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c794f5a4-470a-3f49-c5df-bd37d97d711a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 3/4] util/cacheinfo.c: Use uintptr_t
 instead of unsigned long in AArch64 arch_cache_info()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501153523.sp2oWSxysLCvFKjZxTFq0aU595RRMYXi6h0ePgCu-pc@z>

On 4/30/19 9:12 PM, Philippe Mathieu-Daudé wrote:
> On 4/30/19 8:13 PM, Cao Jiaxi wrote:
>> Windows ARM64 uses LLP64 model, which breaks current assumptions.
>>
>> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
>> ---
>>  util/cacheinfo.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
>> index 3cd080b83d..ce6f0dbf6a 100644
>> --- a/util/cacheinfo.c
>> +++ b/util/cacheinfo.c
>> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>>  static void arch_cache_info(int *isize, int *dsize)
>>  {
>>      if (*isize == 0 || *dsize == 0) {
>> -        unsigned long ctr;
>> +        uintptr_t ctr;
>>  
>>          /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
>>             but (at least under Linux) these are marked protected by the
>>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Maybe you can use a shorter commit subject, such "util/cacheinfo: Use
uintptr_t on LLP64 model to satisfy Windows ARM64" (or better), so it
won't be cut in git log (limited to 72 chars).

