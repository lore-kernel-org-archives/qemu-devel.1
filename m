Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB2C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3B520714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMhI/NkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3B520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEf9x-0002yh-W3
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEf8Z-0001Jf-RV
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEf8X-0007r9-N3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:17:59 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:43295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEf8X-0007oG-Ek
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:17:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id f206so66281pfa.10
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PtD+Ytj03L6FatBW9ZOnhIlPXUPpkuk4Dbn0wPchRg0=;
 b=iMhI/NkO/twmkgmC5N/LVfEefn0Rp0xCUEVt0DjntyG5XaArYm5CldqcfG/jAtsocR
 371kbphvNJBdyf/L8gOypv9cHOwITrCiWvgJbONH3QJszi/zm9zvHdaHpbPJFnJWnwhh
 E1fbKeafulUVf89ARrhOpOQUwnEwFsOJMUD5VryOTqYLMbhPnGWkA+pUKRZjT2JnGOGu
 KJL/+C87tW0/dPstomE22z8JCI5NMPsRB2PnQma82zyRdjnIHyb1SGtytLzLZqJOt7Vo
 UiDneoxleeaHa15wD32+SDlSKJE1nJmilZH4W5nHdZxqbhx6Mg0ZWh9FsCzITn7+wF8K
 +8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PtD+Ytj03L6FatBW9ZOnhIlPXUPpkuk4Dbn0wPchRg0=;
 b=pB5m3CoX02dUgoRmj5sayN/OQ1zqoxyoF7h55yBz2XX8VuTWc9TgwKVG0xkyVpKCSf
 Hao/Ch3LwBr2Dr40yGftxN3UNFPHqGZUB7i/47xoesKni8v04uj2lRVoiuaXr+6Bd/WL
 7nF9ksj7YcSNsDOUztEMo9zFpImgOgvGfqLgJtuFRWWtiLcFeXUMEzdHrfyRVDXMIury
 mLjSlY0lAZwJcU3CTiSbrKAQVbmlX8njfpOEzuA7nQwGbFvSI8SisPCkMMj5xiol7HSY
 LVHqqOLfpYGPil41uij3LFuRZjcigRMNWZex8zZiCv/ur608MeL9iGPLlhZ0FAIrJaed
 F4Ag==
X-Gm-Message-State: ANhLgQ2P3FVyewDh21bS4Staw4FcUj05GJ4xr9cassGnJIwqTesiWSLA
 TrYdH+30G+V5X6ZbFYZICRrJnim/Sj0=
X-Google-Smtp-Source: ADFU+vt43mWtzVFMliiJumGojwVE3t+kvSIamgxPXNMkfLfyPpJFMCHTGbyagVsWl9DJuAzerAFqJQ==
X-Received: by 2002:a63:5549:: with SMTP id f9mr6290574pgm.118.1584562675553; 
 Wed, 18 Mar 2020 13:17:55 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w6sm7334323pfn.104.2020.03.18.13.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 13:17:54 -0700 (PDT)
Subject: Re: [PULL v2 00/37] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200317155116.1227513-1-laurent@vivier.eu>
 <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
 <610f250b-64b8-1cf4-00fe-5bf2f2eba864@linaro.org>
 <b0055b37-a381-095a-a7c9-8b1327be3cce@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <95ebdfda-de48-8a44-ec86-8dd384fc98a3@linaro.org>
Date: Wed, 18 Mar 2020 13:17:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b0055b37-a381-095a-a7c9-8b1327be3cce@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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

On 3/18/20 12:58 PM, Laurent Vivier wrote:
>> However, from the error message above, it's clear that cpu_loop.o has not been
>> rebuilt properly.
>>
> 
> In the series merged here syscall_nr.h are moved from source directory
> to build directory.
> 
> The include path of the files is based on the dependecy files (*.d), and
> to force the update of this path PATCH 13 removes all the .d files that
> have a dependecy on the syscall_nr.h file in the source path.
> 
> This is added in configure:
> 
> --- a/configure
> +++ b/configure
> @@ -1887,6 +1887,17 @@ fi
>  # Remove old dependency files to make sure that they get properly
> regenerated
>  rm -f */config-devices.mak.d
> 
> +# Remove syscall_nr.h to be sure they will be regenerated in the build
> +# directory, not in the source directory
> +for arch in ; do
> +    # remove the file if it has been generated in the source directory
> +    rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
> +    # remove the dependency files
> +    find . -name "*.d" \
> +           -exec grep -q
> "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
> +           -exec rm {} \;
> +done
...
> Perhaps it removes a dependency that should trigger the rebuild of
> cpu_loop.o?

Ah, yes indeed. It removes *all* dependencies for cpu_loop.o, so unless we
touch the cpu_loop.c source file, nothing gets done.

I think you're trying to be too fine grained here, since the *.o file has to go
away with the *.d file.  Why not just

  make ${arch}-linux-user/clean

?

r~

