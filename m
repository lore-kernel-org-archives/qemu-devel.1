Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF6CC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E0B2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnARXzPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E0B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuIO-0000tm-Az
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyuHb-0000S5-To
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:46:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyuHa-0001OW-Gr
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:46:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id r12so7681801wrj.13
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bg/P8S5COpS2jkrOxdXx4kcF6QFlQwpf0sQ2e1ValAg=;
 b=QnARXzPk3/i1um1d6eTcDTe+RcGy/8EhNwK0R4sdW4atSaBkugslQrNBn/MHHIItCc
 DWYpsMWG7JIeLTqGOEfjCaDphNNdDEdGBf1pd6Qsvm/DGI90RbnTU3YEAkEs+2GXKtgH
 /483t89jFMa7JCnj+Z7qs9W2Cjs1Wug2Ffa966uGxRSvWO/6QeaoH+fWmO5mkmR7wvvT
 owg952OmtOI1o1PhLVOU3iE/Ad/Yhk6vihNfVsOTI0iEROzeSqJ52jO4RNnSl3TQG5P3
 wzM/oq8SsUcgljDGZ34KBODAPrh7THINPAWb6E2Hilx4JwAsxQ1/M1J5fJSeznugT6OY
 REqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bg/P8S5COpS2jkrOxdXx4kcF6QFlQwpf0sQ2e1ValAg=;
 b=A7Y+w7sWbdHg0eojxkXVz+5kjWFo/+rO2zkoj/mcEGncSpHgVHjlMkx9fOfEb+cj/d
 Z3kixzM8hcLM7gAzxM7H0s5X6rXy9ZcaaIdGtVhnViGtUpEdCpTZ7Dr7xJ81CVVAJk1V
 y0e81ImG0b1IM72O28TicpXmgLfhtCEFehHcye7nwQ2Fhv00aqYKsEN/3GkCoVoKIPDV
 uj+JKq1/2bOBOH58vTZgfROUAMd/vE1xbYjYLOuTbYCs325KypxG7YCwcUi2SolfJhsQ
 r1TO1qUDsdz9y7sle9c2t8RfvR34sQEpGzaYErWbrhkKC0cVtGi4EdBF6u/0n+B07rrM
 Cmew==
X-Gm-Message-State: AOAM5329azj7qGOnzBntvSHAd0KCCr8Qc83f699zaGglJz8/mHjRw5jD
 7S4dxNoVnhnynup5NsASK3g=
X-Google-Smtp-Source: ABdhPJy1ybvbRy8kQ4SxjLdy/PrwI4T6ez+6X4J8W5mqMF+/h+ATxxg7sV732GimSO6r4S8WLrtYsA==
X-Received: by 2002:adf:fa09:: with SMTP id m9mr7713261wrr.130.1595583984868; 
 Fri, 24 Jul 2020 02:46:24 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o30sm745318wra.67.2020.07.24.02.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 02:46:24 -0700 (PDT)
Subject: Re: [RFC PATCH] buildsys: Only build capstone if softmmu/user mode is
 enabled
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
References: <20200724071657.21508-1-f4bug@amsat.org>
 <5d8ade29-c085-9f6d-b896-fda48c1f5666@redhat.com>
 <0ce8f279-1ef0-6d93-5fff-032783fba2b6@amsat.org>
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
Message-ID: <45942406-2ee2-150a-fb11-d485a12ca290@amsat.org>
Date: Fri, 24 Jul 2020 11:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0ce8f279-1ef0-6d93-5fff-032783fba2b6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 11:38 AM, Philippe Mathieu-Daudé wrote:
> On 7/24/20 9:56 AM, Thomas Huth wrote:
>> On 24/07/2020 09.16, Philippe Mathieu-Daudé wrote:
>>> At least one of softmmu or user mode has to be enabled to use
>>> capstone. If not, don't clone/built it.
>>>
>>> This save CI time for the tools/documentation-only build jobs.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  configure | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index 4bd80ed507..bc5757159a 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -5381,6 +5381,10 @@ fi
>>>  ##########################################
>>>  # capstone
>>>  
>>> +if test -z "$capstone" && test $tcg = 'no' ; then # !tcg implies !softmmu
>>> +  capstone="no"
>>> +fi
>>
>> I don't think this is right. You could have a KVM-only build where you
>> still want to use the disassembler for the human monitor.
> 
> I had the same question with KVM, I agree this is unclear, this is why
> I added RFC.
> 
> Don't we have !softmmu implies !kvm?

It works because it falls back to the old disas.c (if capstone is
here, use it, else fall-back).

Does this means we can directly remove the capstone experiment &
submodule without waiting for the libllvm integration?

> 
>>
>> But maybe it could be disabled if softmmu="no", linux_user="no" and
>> bsd_user="no" ?
>>
>>  Thomas
>>
>>
> 

