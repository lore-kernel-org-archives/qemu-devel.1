Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2631EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E380820706
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFNz7CsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E380820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHiP-0000tg-8D
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnHhU-00007F-Ee
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:21:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnHhS-0007jT-P4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:21:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so3958428wmm.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MPTdR40MF9gBuRoNiMJX/TTc5NWZetG5ylpGIemnDx8=;
 b=GFNz7CsS0jicscNMofxMxfi4pCf0yPMsEl+VpEiuUlSNgnboqlihSpo0FDahznaDTr
 ueSMvuke2qqh4XNkYU/iT+yJIYr7Pw2JrhOna2qaFA699AB/h2ay9tVnWv2ftRE942p+
 uiqgEPr4zFammqqTRV49OLoUbWfZk/HPJWAk3a0LLBDQUSzzRRkCCs62qy7ExKG8L8Wu
 NC50JZaOBwiyFxi2LyFfjFpCvZZTwa2x2F9q1OAsoMNaYtXWCa9wNxS1rnKVcivVX6yv
 4GBXyMQL0t0IbRQwX6EDePZc2t/fuDhJDIZeU8Xk8tVSobFNaapfpf2MIJGVYNo9MoMr
 Pcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MPTdR40MF9gBuRoNiMJX/TTc5NWZetG5ylpGIemnDx8=;
 b=ouUnins6GSt/YEWgfrLyPkIxFFh/+epgOmYF4Fnps0yb2QKHM9mJ2Xg7pwak+95us3
 6Aqkuvc8L+FMqTEDpMeyP5Q9fz25Iok0yxrWH4wefDBuRCCx5TmV8Jj0wdBaQmMVvuib
 J/KOuesEOjFsyJLn/7enf3nxNAkRRiO+ojydTLO9vdUKjvyxNmvSfBSNcca82tjF4ihc
 huWebYfcAM+uW7vL+yU5TGw5IrWjtmrMwTtiZqZrvw7TK9MeCzjmHV3HbyB9FHUy1PG2
 Wq2sonWsk7yWDqHtMphJ1fbQjPaC2aeE8ch/wrzm3E0dEKWi8JoChJvi9l6r75o9LxLi
 QCwA==
X-Gm-Message-State: AOAM533ECkYx/njwDaowMjJssAKD+YMMLz/taAOTy6MNGn4d3OQofbC0
 A3SOh1NTm5/Kv+wxnC/avNf3Nie4
X-Google-Smtp-Source: ABdhPJwN4e5iQgRzQj+NLtqVJ0c9biaaTcnF1YY6wGcCnijsDqB+HDTezEHKgsVvh3VPvheJ707BTg==
X-Received: by 2002:a1c:63c2:: with SMTP id x185mr17454276wmb.68.1592814064447; 
 Mon, 22 Jun 2020 01:21:04 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h27sm19153802wrb.18.2020.06.22.01.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 01:21:03 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: Build acceptance tests with -O2 compiler
 optimization
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200620232947.17895-1-f4bug@amsat.org>
 <6ec17c5e-a7a2-ec47-cc30-807405cd39c0@amsat.org> <874kr4bn71.fsf@linaro.org>
 <be1726dd-c84e-b874-e2b2-7fe2cee92b8a@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <cbc53e3b-63c4-680b-7d60-eb54df7fc139@amsat.org>
Date: Mon, 22 Jun 2020 10:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <be1726dd-c84e-b874-e2b2-7fe2cee92b8a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 8:05 PM, Philippe Mathieu-Daudé wrote:
> On 6/21/20 2:47 PM, Alex Bennée wrote:
>>
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>
>>> On 6/21/20 1:29 AM, Philippe Mathieu-Daudé wrote:
>>>> As we just want the tests to succeed, build them with compiler
>>>> optimizations enabled to run the tests faster.
>>>
>>> Maybe it is a good opportunity to test -O3 instead...
>>> Since this configuration is not covered.
>>
>> Don't know if -O3 is worth it - even Gentoo developers warn against
>> cranking it up too much.
>>
>> In fact I'm surprised we don't build -O2 by default.
> 
> Do you mean in Travis or directly in ./configure?

Indeed ./configure uses -O2 is by default since 2005 :)

(commits c326e0afec0 / 6f30fa853b7 / ce278618b08).

> 
>>
>>>
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  .travis.yml | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/.travis.yml b/.travis.yml
>>>> index 74158f741b..61b247db9f 100644
>>>> --- a/.travis.yml
>>>> +++ b/.travis.yml
>>>> @@ -293,7 +293,7 @@ jobs:
>>>>      - name: "GCC check-acceptance"
>>>>        dist: bionic
>>>>        env:
>>>> -        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>>>> +        - CONFIG="--extra-cflags=-O2 --enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>>>>          - TEST_CMD="make check-acceptance"
>>>>          - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
>>>>        after_script:
>>>>
>>
>>
> 

