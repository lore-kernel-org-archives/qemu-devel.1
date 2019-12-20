Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF75DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADE2206EC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6IlTDNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADE2206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIwK-00011a-Re
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luis.machado@linaro.org>) id 1iiIBL-00062I-Ox
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luis.machado@linaro.org>) id 1iiIBK-0000Ms-7m
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:19:03 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luis.machado@linaro.org>)
 id 1iiIBJ-0000G2-QE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:19:02 -0500
Received: by mail-pj1-x1042.google.com with SMTP id n96so4101255pjc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4aK/ve40XlXyED/AEPJ4m4wmtwjR1LdUmhAHwiSmLJo=;
 b=l6IlTDNsvGyoB0tXXWQHti/s95zZOjKD7QSM/iiqgWQHlu/BNJKjy77573eoZHiRi1
 UyU2sc9LkhbSxqBYipLylqXs1qrcfzErjz/wKniNoOZl8UgQKTd6A/VomCu5IOBsM3df
 lR8pGwT0Np5uEp4ZIwaractOxLEN5EMloX02ENBokjLaT4dN9CpRYcRiMWvyo444hcAA
 7PjuDbvkMtY5RhbpJGeZMrMROIS10rmFSKNjldTmt608Q6wOTYS8mbFaAhZFGL8f3mW+
 NqXtJ7M5S7ld3WmWIOlJYMuYNuyx15LsUqWJei9hloiV5lW+9965EcoOCmzmTDuRkqt+
 tYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4aK/ve40XlXyED/AEPJ4m4wmtwjR1LdUmhAHwiSmLJo=;
 b=cIAdxFnUzyn+mSRJp7Q7w8lrIgbesdrDGinokPqxm570XeBLsGIgHlYGJCCYbri2bV
 H1UjFl4BH1t6Nw5e7z2vLFmJKPq/IELwLgbmgcLDIJAX7ykYUWv+0SSbq0Hi3vCViluY
 4m3+QyESA4mib0QE3y72vXJJHYApvo6uZnsceaG/WbvxaagODt5H8HUD9hfiwD1OTq58
 WqAjXU9GehM6hF15oGUiRoZdaP5RqABmJc5V2gLfWPpCrDIDaHOooVuOI4RYUJHWspmb
 CKitWfLoJ/jAfNw4zi0d9If8zj64kCDFCEfZmcnxwbulOMQLEpnwKQaRgM+FH86gS2nA
 QwQw==
X-Gm-Message-State: APjAAAV4oKsap4L9wYlc35h2rWRtmzMnjhUw92aX/UNA8dWFMnNBJqb7
 8EWh6SJ9kPZQS+bMViXbzf6XQQ==
X-Google-Smtp-Source: APXvYqyWN9m1C/V/VpQl/BKNVN/sNfLzvNeD66xVzRfevTHKsRReemtDQ6psnbh0PHz+NZi9wIDdyg==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id
 w14mr16312526pjn.51.1576847940320; 
 Fri, 20 Dec 2019 05:19:00 -0800 (PST)
Received: from ?IPv6:2804:7f0:8282:d06:e0aa:310d:b742:862f?
 ([2804:7f0:8282:d06:e0aa:310d:b742:862f])
 by smtp.gmail.com with ESMTPSA id 199sm13643132pfv.81.2019.12.20.05.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 05:18:59 -0800 (PST)
Subject: Re: [PATCH v3 12/20] target/arm: generate xml description of our SVE
 registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-13-alex.bennee@linaro.org>
 <69e10c48-8bdf-cbe0-3372-815b647f8312@linaro.org> <87k16sdt4d.fsf@linaro.org>
 <5c6dd0a9-23ba-63ff-5738-8bac11aad810@linaro.org> <87eewzdtqg.fsf@linaro.org>
From: Luis Machado <luis.machado@linaro.org>
Message-ID: <81e43d43-29f8-ec56-5270-bb90dd1bc077@linaro.org>
Date: Fri, 20 Dec 2019 10:18:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87eewzdtqg.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
X-Mailman-Approved-At: Fri, 20 Dec 2019 09:01:13 -0500
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:14 AM, Alex Bennée wrote:
> 
> Luis Machado <luis.machado@linaro.org> writes:
> 
>> On 12/19/19 4:15 PM, Alex Bennée wrote:
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> On 12/11/19 9:05 AM, Alex Bennée wrote:
>>>>> +static struct TypeSize vec_lanes[] = {
>>>>
>>>> const.
>>>>
>>>>> +    case 51:
>>>>> +        return gdb_get_reg64(buf, (cpu->env.vfp.zcr_el[1] & 0xf) + 1);
>>>>
>>>> You need to use sve_zcr_len_for_el to get the effective vq.
>>>> Also, I thought vg == 2 * vq.
>>>>    > +    case 51:
>>>>> +    {
>>>>> +        uint64_t val = *(uint64_t *) buf;
>>>>> +        cpu->env.vfp.zcr_el[1] = (val - 1) & 0xf;
>>>>
>>>> You cannot hard-code EL1 without ifdef CONFIG_USER_ONLY.  If the effective vq
>>>> decreases, you must call aarch64_sve_narrow_vq.  You must call arm_rebuild_hflags.
>>> I'm just going to drop vg (and therefor the ability to set it) from
>>> the
>>> regset. It was only meant to be an indicator and gdb doesn't actually
>>> look to it to size it's output. The likely dynamic extension will just
>>> re-transmit the whole XML when a change occurs.
>>>
>>
>> I'd verify with GDB first if vg isn't actually required.
> 
> It works with my tests but perhaps we use our own namespaced XML rather
> than the gdbstub XML.
> 
>>  From looking at GDB's code, it does set vg as one of the register
>> names, and this is regardless of any XML input. It does reference VG
>> here and there in the code, even though it may not use it to size its
>> output.
> 
> But this is all special casing for feature
> name="org.gnu.gdb.aarch64.sve" right?
> 

Yes, vg is only available if feature org.gnu.gdb.aarch64.sve is available.

