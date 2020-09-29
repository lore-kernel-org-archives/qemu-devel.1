Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D039C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F4E2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aate0ZpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F4E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMag-0002Jj-V5
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNMR5-0004Gu-Gd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:41:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNMR3-0006ix-SG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:41:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id e11so7427536wme.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u9H1fSzVtMxPpbKi7nN6bSDOvbsl5VKzvLjQqZopdSA=;
 b=Aate0ZpW1pggKt3XeoEZHc0MuKaB3XXDDIvHv9YsNmtJw2y60svHQlj+yXqsCY/2wI
 BVylWwMKVikBQcOy7MKV+ENFLbyY1XvnaKvX5858hyd24UTXOr8q7Jz7Q/YnfeRBHHqM
 +2US94+OWvrs/piXWbLXr4K7kRkGb2/KhsAFJyXDFIYT88COiNZMC9yPqpUrU72s9Fs1
 Ev1SfES2SrLABEOSiOq9nu/r8cMTv9Jz+Tm0moXjFrblKIof4Dyv7WiLR7gc0pg9EVN8
 FR0IToFGoMP/ngEOmAfeVEKy0FQGwctJGIMzT2wghRQEhSH3FwFBHSwWNqtqopZvSasD
 dHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u9H1fSzVtMxPpbKi7nN6bSDOvbsl5VKzvLjQqZopdSA=;
 b=H9sQn7fsCQHNDC5pgJdbbbNtR//9jXPhjF/Ur3SM1ZtZpI9wQNZno8W00Ce1Nb0/k5
 0fF1UDpOlhcAA+f9l9Tr5MpFKUS2v/psGh+1vPpzs41KCd8vT+g8C20qdJ9ZxZeoH0Oj
 5u1AzGsZpNfFAV9bsscn7ujSSBxJP+mlpyv56Zmeur1f9ZJU8M8towcb1JqCIIUJzFe0
 8AAd+sxsrPQNhajqWApuMBJJ+nEXDd48PAm0eE99W+OguI85MLR7gH54WnSM/8VHSkFk
 D5d1fm45u/FhLW2APl5viFgyPu5/kAogq33dCDvBrKLpjYpK0NcvtdkHi503nEwRCvH3
 3gDw==
X-Gm-Message-State: AOAM530u9i7ftVVIGvqT7J+8UFBFZgilU38tnK+GBMscDix/wJLY8/9K
 w/Y0ZUUKCapYW+tNqgOZEDI=
X-Google-Smtp-Source: ABdhPJweWZOQVFTbQrvkK/SdVQ+5w1U4r8HERfjb6qHmAyRArVhQnY1n3+6dC6nHU4bjddypLh9jMw==
X-Received: by 2002:a1c:9893:: with SMTP id a141mr6421967wme.188.1601412076086; 
 Tue, 29 Sep 2020 13:41:16 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id g18sm5476229wmh.25.2020.09.29.13.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 13:41:15 -0700 (PDT)
Subject: Re: [RFC PATCH v4 00/29] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <c4307aa4-f194-a02f-a4db-90b546a6024a@amsat.org>
 <BYAPR02MB4886C5014B1012371DE0DCDFDE320@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8f684258-8b41-ee3b-8921-41693113c1f1@amsat.org>
 <BYAPR02MB4886C114AAC9DDEF70300D23DE320@BYAPR02MB4886.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae64a974-ad55-72b8-e484-ab9cb1f78a66@amsat.org>
Date: Tue, 29 Sep 2020 22:41:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886C114AAC9DDEF70300D23DE320@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, Thomas Huth <thuth@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Eric/Thomas...

On 9/29/20 10:11 PM, Taylor Simpson wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com> On
>> Behalf Of Philippe Mathieu-Daudé
>> Sent: Tuesday, September 29, 2020 11:02 AM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: ale@rev.ng; riku.voipio@iki.fi; richard.henderson@linaro.org;
>> laurent@vivier.eu; aleksandar.m.mail@gmail.com
>> Subject: Re: [RFC PATCH v4 00/29] Hexagon patch series
>>
>> QEMU aims to support the 2 latest releases of supported distributions.
>> From time to time a brave developer look at the different versions
>> packaged and make some cleanup in the code base. It used to be tedious,
>> now that repology.org exists it is a bit easier.
>>
>> The last effort is from Thomas, see commit efc6c070aca:
>>
>>     The supported distributions use the following version
>>     of GCC:
>>
>>           RHEL-7: 4.8.5
>>           Debian (Stretch): 6.3.0
>>           Debian (Jessie): 4.8.4
>>           OpenBSD (ports): 4.9.4
>>           FreeBSD (ports): 8.2.0
>>           OpenSUSE Leap 15: 7.3.1
>>           Ubuntu (Xenial): 5.3.1
>>           macOS (Homebrew): 8.2.0
>>
>>     So we can safely assume GCC 4.8 these days.
>>
>> This is the "mandated" compiler version.
> 
> Ouch!  4.8 is old enough that it doesn't support C11 _Generic which I am using.  That needs at least GCC 4.9.
> 
> Here are a couple of examples.  As you can see, _Generic is used to dispatch to slightly different TCG generation functions depending on the type of the operands.  I will scratch my head and figure out a different way to do this.
> 
> #define MEM_STORE1_FUNC(X) \
>     _Generic((X), int : gen_store1i, TCGv_i32 : gen_store1)
> #define MEM_STORE1(VA, DATA, SLOT) \
>     MEM_STORE1_FUNC(DATA)(cpu_env, VA, DATA, ctx, SLOT)
> 
> #define GETBYTE_FUNC(X) \
>     _Generic((X), TCGv_i32 : gen_get_byte, TCGv_i64 : gen_get_byte_i64)
> #define fGETBYTE(N, SRC) GETBYTE_FUNC(SRC)(BYTE, N, SRC, true)
> #define fGETUBYTE(N, SRC) GETBYTE_FUNC(SRC)(BYTE, N, SRC, false)
> 
> 
> FWIW, I have been using 5.5.
> 
> The errors you saw started around 7.5 and are easy to fix.
> 
> 
> Taylor
> 

