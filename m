Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42947C4332E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2972076F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrEwuN1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2972076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfXp-0001Wx-5Q
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEfWp-0000mR-57
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEfWm-0004SB-KI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:43:02 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:34668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEfWm-0004IJ-D1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:43:00 -0400
Received: by mail-pl1-x635.google.com with SMTP id a23so29550plm.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QMlGyf6XU8H/aF/j5XakScQRHR+DuK9n0raQudfFQvQ=;
 b=YrEwuN1xWidcZTBVwMlsIdNooUepEDnytUJUljON85lAHZ9xxpnOJf6J3uBmVBi2Rq
 mT1w5Wmti2xUPj/5qNqQ4+SUOZUJkAwzX96yazz03t4VkJjSsmhJ8AnXtislDHhWcQmb
 N3DMtsY/ziPJONTH7I4yZ154uqFlajL4ix3M4/hLBOHarU1lAXrVGp4U08kO1PufrPiB
 j85pHfwxsgJHAK6u0a4q55zZuAdS8ebYvY+mQYyCtC59UiqbKQGwtX8FPqcNTUUPDMoc
 2PRDJbGOdLPwNrHJToWM9lIk7+2O0K8u2MkMi6z4rtCgk64PWhEsNDa0Q2Zh+I6mxKFv
 88fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QMlGyf6XU8H/aF/j5XakScQRHR+DuK9n0raQudfFQvQ=;
 b=rWa+CnmaHUPBiza0+1yyoIrHdq1WMO94ZdpS5FdLDRktT1jmdfjGX02NDPsXViXLgT
 hNOauLUayyHkogQFfREK+VLK3OT+VqJy7OVdi1GNuvm72v6GgdxIavRAmnKauLXtQUdp
 3mdesWe9qNXewc+0ypq/zYoYbxZMr4a1HJG0VxzzU2gRS75/evj8MexgywsBjlXyGMpf
 dCUbNcnqFakpLEn/H3q6J0kbKf+7RD8SkKIRd2QCR5aZmmfGSbcP1S2FmcmroMuLSljL
 gZQOFnK/DmIb1CChE9Jpoabfenvyd6iYcJHn77GqNFtzaQKb+EyeLTkL1kQwG9sedLN9
 T62A==
X-Gm-Message-State: ANhLgQ3fYxR+2t4OHmON867ugZgJDd2jKpx79j0t1CT5aFGjuAV8duSa
 lJ+ULzrbz4wjCGKqPZ5u3zNO2wgKv30=
X-Google-Smtp-Source: ADFU+vtGL4RcKeSrwinOnJ7x07q0vRWrMvanv2buYQ1IULYD5GOFpeyj4HDHFvoYS2rA+pu13OoYZQ==
X-Received: by 2002:a17:902:59dd:: with SMTP id
 d29mr26487plj.246.1584564174198; 
 Wed, 18 Mar 2020 13:42:54 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t11sm3148629pjo.21.2020.03.18.13.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 13:42:53 -0700 (PDT)
Subject: Re: [PULL v2 00/37] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200317155116.1227513-1-laurent@vivier.eu>
 <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
 <610f250b-64b8-1cf4-00fe-5bf2f2eba864@linaro.org>
 <b0055b37-a381-095a-a7c9-8b1327be3cce@vivier.eu>
 <95ebdfda-de48-8a44-ec86-8dd384fc98a3@linaro.org>
 <b77a5bd0-46b6-3345-d070-a998890efff2@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ba1e895-9f0d-49e0-d654-2663a5a858e3@linaro.org>
Date: Wed, 18 Mar 2020 13:42:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b77a5bd0-46b6-3345-d070-a998890efff2@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 1:23 PM, Laurent Vivier wrote:
> Le 18/03/2020 à 21:17, Richard Henderson a écrit :
>> On 3/18/20 12:58 PM, Laurent Vivier wrote:
>>>> However, from the error message above, it's clear that cpu_loop.o has not been
>>>> rebuilt properly.
>>>>
>>>
>>> In the series merged here syscall_nr.h are moved from source directory
>>> to build directory.
>>>
>>> The include path of the files is based on the dependecy files (*.d), and
>>> to force the update of this path PATCH 13 removes all the .d files that
>>> have a dependecy on the syscall_nr.h file in the source path.
>>>
>>> This is added in configure:
>>>
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1887,6 +1887,17 @@ fi
>>>  # Remove old dependency files to make sure that they get properly
>>> regenerated
>>>  rm -f */config-devices.mak.d
>>>
>>> +# Remove syscall_nr.h to be sure they will be regenerated in the build
>>> +# directory, not in the source directory
>>> +for arch in ; do
>>> +    # remove the file if it has been generated in the source directory
>>> +    rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
>>> +    # remove the dependency files
>>> +    find . -name "*.d" \
>>> +           -exec grep -q
>>> "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
>>> +           -exec rm {} \;
>>> +done
>> ...
>>> Perhaps it removes a dependency that should trigger the rebuild of
>>> cpu_loop.o?
>>
>> Ah, yes indeed. It removes *all* dependencies for cpu_loop.o, so unless we
>> touch the cpu_loop.c source file, nothing gets done.
>>
>> I think you're trying to be too fine grained here, since the *.o file has to go
>> away with the *.d file.  Why not just
>>
>>   make ${arch}-linux-user/clean
>>
>> ?
> 
> The idea was to be able to bisect the series as the syscall_nr.h were
> added incrementally without rebuilding all the files.
> 
> If I remove the loop in the configure where to add the "make
> ${arch}-linux-user/clean"?

I don't know.  Can you get an exit status out of the find?

Another option might be

for f in $(find ${arch}-linux-user -name '*.d' \
           -exec grep -q ${arch_syscall} \
           -print); do
  rm -f $(basename $f .d).*
done

But frankly I don't care if all of every file gets rebuilt while bisecting, it
just needs to work.


r~

