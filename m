Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A8C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46BB218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXwiQ1qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46BB218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiItx-0004rW-A4
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luis.machado@linaro.org>) id 1iiGiq-0008Tr-4B
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luis.machado@linaro.org>) id 1iiGio-0002zQ-N0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:45:31 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luis.machado@linaro.org>)
 id 1iiGio-0002rA-7y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:45:30 -0500
Received: by mail-pl1-x642.google.com with SMTP id g6so1044154plp.6
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=crfuNxBVCngqn0yvcbXKI5joADyERlYsV08zUGbPnBM=;
 b=mXwiQ1qUCvgaJHQLSrLD2pyQ+Or67gNf9z6ByTLgw5V7NT5OdsG7SqJWbAdDh4DHjy
 lgWGn6vrRy5AiocNZdYdwW1G3ftJ/bz9vKyeTJApnhMGB+MU6ahImZv6v9yxDxs2us6U
 ViOOkcbBd+KUSNpFuIjqMxcmBiZQEwFUJ0iK1EXKE/gXPjaSJE+eh9BOD6xbZ7sPaeUn
 3e/tUTg1inb0qChDmsLvo6CvHUC6+XhE1pV4NkzJPGYIdslH30p/woiYJHJoL2IkVWkz
 4+ZpOSqNLnXxC38q5PcfqaORoSkB5ZCccriOPnJ4btqXNA6aGnIeHgzdf6wA8KOi1Yoy
 IpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=crfuNxBVCngqn0yvcbXKI5joADyERlYsV08zUGbPnBM=;
 b=EpVOUVfYNleIyI6oHPReCGAwmBmFp4oQX4/gLUEbc6p/2x8av/Qs974eOGrR6CDyJE
 BXAR27mVvcrbkLkewR7lqmi4vzn0vnGYH/HejsBSGqHPWvXMof004mOwTX0eeoCgRvdE
 AVS3y/tvYtiAEjh7FZlk8xEa5uuUFqCED9trHMf+/1NbqcS8Xu4jaT0fgKPCeGA7AfsE
 5YVDG6GwvJK/uileNjBkySB6jXYyiQQXTXRDgJWplzjBt86A9pQjYBKF47gRJoY+AOct
 c8SXaHrHJXmAXi+UyyRIr835rzX70M6edowzcnkXLo6MZTFDIMJmQilkw2JNJZQ47C+N
 V3Vw==
X-Gm-Message-State: APjAAAWbVY8zb6rQ4IwQueGX2Uu/hUcrtKDOrdDirFd7jsLSWlGGUcot
 FggDtawZ1rm50mW9r3JhYmccNA==
X-Google-Smtp-Source: APXvYqy2A+HB4lsHrr0ctuBOSy+8/zDyRdZHtoUdoS1b73lFX1aPoTFty7SFmks11dVvkQCssWYh9g==
X-Received: by 2002:a17:90a:26ab:: with SMTP id
 m40mr15812980pje.42.1576842328163; 
 Fri, 20 Dec 2019 03:45:28 -0800 (PST)
Received: from ?IPv6:2804:7f0:8282:d06:e0aa:310d:b742:862f?
 ([2804:7f0:8282:d06:e0aa:310d:b742:862f])
 by smtp.gmail.com with ESMTPSA id h6sm10822686pgq.61.2019.12.20.03.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 03:45:27 -0800 (PST)
Subject: Re: [PATCH v3 12/20] target/arm: generate xml description of our SVE
 registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-13-alex.bennee@linaro.org>
 <69e10c48-8bdf-cbe0-3372-815b647f8312@linaro.org> <87k16sdt4d.fsf@linaro.org>
From: Luis Machado <luis.machado@linaro.org>
Message-ID: <5c6dd0a9-23ba-63ff-5738-8bac11aad810@linaro.org>
Date: Fri, 20 Dec 2019 08:45:22 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87k16sdt4d.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/19/19 4:15 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 12/11/19 9:05 AM, Alex Bennée wrote:
>>> +static struct TypeSize vec_lanes[] = {
>>
>> const.
>>
>>> +    case 51:
>>> +        return gdb_get_reg64(buf, (cpu->env.vfp.zcr_el[1] & 0xf) + 1);
>>
>> You need to use sve_zcr_len_for_el to get the effective vq.
>> Also, I thought vg == 2 * vq.
>>   > +    case 51:
>>> +    {
>>> +        uint64_t val = *(uint64_t *) buf;
>>> +        cpu->env.vfp.zcr_el[1] = (val - 1) & 0xf;
>>
>> You cannot hard-code EL1 without ifdef CONFIG_USER_ONLY.  If the effective vq
>> decreases, you must call aarch64_sve_narrow_vq.  You must call arm_rebuild_hflags.
> 
> I'm just going to drop vg (and therefor the ability to set it) from the
> regset. It was only meant to be an indicator and gdb doesn't actually
> look to it to size it's output. The likely dynamic extension will just
> re-transmit the whole XML when a change occurs.
> 

I'd verify with GDB first if vg isn't actually required.

 From looking at GDB's code, it does set vg as one of the register 
names, and this is regardless of any XML input. It does reference VG 
here and there in the code, even though it may not use it to size its 
output.

