Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74784C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B7D20661
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZ6sqdnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B7D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3e8-0002nF-CY
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3dE-0002OJ-0d
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3dC-0006jq-4y
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:00:59 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3dB-0006fm-Qx
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:00:58 -0500
Received: by mail-pj1-x1041.google.com with SMTP id gv17so4747825pjb.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=acayOEiz98KMQ83HMxCwmwylsHiwSLDRlX/edYOELcA=;
 b=iZ6sqdnbbc5d1hD6/mAechlHoOjz19rpK4vmKuF2kl69lkVYzrysBKVDEBpJ3qJkFK
 x9zQBTcC8ERg8qvm06HaxpeKkeCUDV5IzxneYoAHDLkPVHhWFFFg1jDlnjjiFY+Z0Wbk
 J/BuVSHe1R8sYLjZvbYafL7rpXKuyEF+Vy9iVgTwwJW3vYzoaLEFgxhxKhvk/7gr1eoh
 UCPzfS1OBHS8dOhDdjeGYf9JkQTCUoLXIm5QLNDX+lqS9ubG7/OB/VfGqZNtYG83S80v
 3AnGrrnd8RggbYKJU4fTiPpXA2MNdzP6Tot6EkQDixvloLOdnR9p5XjKxIZLgmXIKZot
 ZDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=acayOEiz98KMQ83HMxCwmwylsHiwSLDRlX/edYOELcA=;
 b=Bzfm6Eae7rE02azA7QdmWTE4rJelbatswpA8aeHIEYKcknT0fMPZNBkRUa90QcJ8UA
 IC/ZVDq2uIev8/9aCU0qCfk+e5LJfOPS+QnzKVivZE1MknF0Ko9v1hfee4tqOYDu3WyL
 +vAbrTqmZZCjwnSkBvblutJ1NW6A1+X9dcmp0PvbgrOYd9MioMuoF8Fmu+L4Qh/RhZG2
 eAPqnkmL6q+kwCNzH/jooNloukDCPOi3X1+SmDUo/8Kt9C9/0hf2IgEf3ByhtnWx5938
 6rx7/mYKqSZldN5oyQCTBJ4XAxpTiz5O8PUvKuk5uhLHPOG79LS30M8ZhymvjCuGnrMg
 jaAg==
X-Gm-Message-State: APjAAAVIOU21DolXYQGAJVR2dd+KMWQwiTq2PvFImB5ZtM55Puway6Dn
 V9xC6rySiGxi19U38TYPRKuofU6dLSc=
X-Google-Smtp-Source: APXvYqxUMSFOSykz76wus5E7ZuF0qGn5U9kzgR3Sfa9XtqXQkNSsfRqHdqJpQcLxADa9cfQZuNNxcQ==
X-Received: by 2002:a17:902:8c98:: with SMTP id
 t24mr16170382plo.51.1580605255987; 
 Sat, 01 Feb 2020 17:00:55 -0800 (PST)
Received: from [10.1.1.100] (h210.212.133.40.static.ip.windstream.net.
 [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id z16sm14894494pff.125.2020.02.01.17.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 17:00:55 -0800 (PST)
Subject: Re: [PATCH 2/4] target/arm: Update MSR access to UAO
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203234244.9124-1-richard.henderson@linaro.org>
 <20191203234244.9124-3-richard.henderson@linaro.org>
 <CAFEAcA914CO2vfMAkr4aeEA_FV0Vub6S9eF43qN=14e7nU1uHg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2871294a-0577-9390-1887-a2e81c1a35e6@linaro.org>
Date: Sat, 1 Feb 2020 17:00:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA914CO2vfMAkr4aeEA_FV0Vub6S9eF43qN=14e7nU1uHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 10:30 AM, Peter Maydell wrote:
>> +    if (cpu_isar_feature(aa64_uao, cpu)) {
>> +        static const ARMCPRegInfo uao_reginfo[] = {
>> +            { .name = "UAO", .state = ARM_CP_STATE_AA64,
>> +              .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 4,
>> +              .type = ARM_CP_NO_RAW, .access = PL1_RW,
>> +              .readfn = aa64_uao_read, .writefn = aa64_uao_write, },
>> +            REGINFO_SENTINEL
>> +        };
> 
> This could just be a file-scope global, right?
> Also, you can just use define_one_arm_cp_reg() rather
> than having a list with one entry. (cf zcr_el1_reginfo).

Done.

>> +    case 0x03: /* UAO */
>> +        if (!dc_isar_feature(aa64_uao, s) || s->current_el == 0) {
>> +            goto do_unallocated;
>> +        }
>> +        if (crm & 1) {
>> +            set_pstate_bits(PSTATE_UAO);
>> +        } else {
>> +            clear_pstate_bits(PSTATE_UAO);
>> +        }
>> +        t1 = tcg_const_i32(s->current_el);
>> +        gen_helper_rebuild_hflags_a64(cpu_env, t1);
>> +        tcg_temp_free_i32(t1);
>> +        break;
> 
> Do we also need to end the TB since we've messed with
> the hflags, or is some bit of code not in the patch
> context handling that?

This is done by default.  We would have to do something special to avoid ending
the TB here.

> Does the "on exception entry PSTATE.UAO is zeroed" behaviour
> fall out automatically for us?

Yes, aarch64_pstate_mode() returns a clean PSTATE.

> How about "on exception entry
> from aarch32 to aarch64 SPSR_ELx.UAO is set to zero" ?

This follows the same path as above, as far as I can see.

> I think we may also want a minor code change so that an exception
> return from aarch64 to aarch32 doesn't copy a bogus SPSR UAO==1
> into the pstate/cpsr.

Well, there is no CPSR UAO bit, so there's no aarch32 bit to clear.  But I did
add a clearing of PSTATE UAO on the exception return to aarch64 path, to
prevent the guest from playing games with SPSR.


r~

