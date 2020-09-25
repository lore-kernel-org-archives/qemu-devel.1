Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B85C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFA0208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoCGkRZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFA0208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLr6W-0003qn-Ts
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLr4P-0002h9-Nw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:59:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLr4K-0003Z3-M0
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:59:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id b79so4080773wmb.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ocFR1vFpQnO6sDycrA/dHjW7Bm2Ik7MrR8R4wsuL298=;
 b=PoCGkRZcuOwW+1AnGh7wJkUh232XPInvZZDsQ9rBjNzwYrAW564JyeyJKIOTtjSqDX
 hZb2mhBWCOL0mc3DLZihHDX55nHiVOWT+hQ004ka31CJBY4fe9TJKkudYAVExbXB4/LU
 2J2kPgkBGH81tOeUF4oGofRZmOFlEUDLrgN/dRKVYsytr6AePkHsg9AFkQmJy1kbT4iO
 wufia/hpPyAymV0PX5U30hp6nUzOtxVozTaq8MBjZpjzqaWxT2lOHOT0BjyPWsoAb95h
 52oZsi9/dCO7xo+pVIsXZAs5jv1p5CNcLJZiJ3/l+KdLlndxSz9ZXuuTRFMogQC/qMbE
 74NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ocFR1vFpQnO6sDycrA/dHjW7Bm2Ik7MrR8R4wsuL298=;
 b=smALPMCg3ld8DADQJj6qFLJRqZe90sy9m9d7rVonnvei3tvx9WOKkrnwsjmDdVnuOi
 fcoS2OtOQsKpfPADeEFxEFDt7dbqcTKTvGSeXRHUgan/0Rgb5WdgWLQsuyjcvYb1zAJC
 KWEZQhY5lC/zD3K+Jp9/WM4rRdisKXEINn42LPgNmzY3sfaP5VFFtYzlS0IFHsst32eW
 iWmr/8GQa91G7NVgGWD1LeeDqa2cjnmLo3ydhA/G8KEsBvl91047IpKgbGQTqpl/e5nr
 IADiSAge8UvImdxL71spiooDPW0hMpG9UO2bxnDqWUX1OVAqz5ZiTHUy5Fdu32TkK/Uu
 7NLQ==
X-Gm-Message-State: AOAM531yKoOAKV15UREb2/3fQWHEImhT2c5Mqu13VruM5pVFTjThIYc9
 S8i+qntDA4BDv/hHD3Y/eVs=
X-Google-Smtp-Source: ABdhPJyPFakpcbpVlJGFh/C9HidelUPNi66y618WzbnwN4jVmZBCkkiS3JpVcbJiHH5dGlx3tQOmdg==
X-Received: by 2002:a1c:9a0c:: with SMTP id c12mr4232942wme.85.1601053172365; 
 Fri, 25 Sep 2020 09:59:32 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id t1sm3300930wmi.16.2020.09.25.09.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 09:59:31 -0700 (PDT)
Subject: Re: [RFC PATCH v3 34/34] Hexagon build infrastructure
To: Taylor Simpson <tsimpson@quicinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-35-git-send-email-tsimpson@quicinc.com>
 <bf3c6520-b64c-f977-d20f-a1718455b44b@linaro.org>
 <BYAPR02MB48860076D3E65C99C4D7396EDE390@BYAPR02MB4886.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <37c1b753-b505-c226-d883-466cf3be88f1@amsat.org>
Date: Fri, 25 Sep 2020 18:59:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48860076D3E65C99C4D7396EDE390@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Taylor,

On 9/24/20 4:35 AM, Taylor Simpson wrote:
>> -----Original Message-----
>> From: Richard Henderson <richard.henderson@linaro.org>
>> Sent: Friday, August 28, 2020 9:20 PM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: philmd@redhat.com; laurent@vivier.eu; riku.voipio@iki.fi;
>> aleksandar.m.mail@gmail.com; ale@rev.ng
>> Subject: Re: [RFC PATCH v3 34/34] Hexagon build infrastructure
>>
>> This will have to be updated for the meson conversion.
>>
>> I don't understand it all myself, and all of those generated files will need
>> special attention.
>>
> 
> I've made the changes for meson, including converting target/hexagon/Makefile.objs to target/hexagon/meson.build, and I can build qemu-hexagon with
>     mkdir build
>     cd build
>     configure --target-list=hexagon-linux-user
>     make
> 
> However, when I run "make check-tcg", nothing actually happens.
>       BUILD   TCG tests for hexagon-linux-user
>     Generating qemu-version.h with a meson_exe.py custom command
>       RUN     TCG tests for hexagon-linux-user
> 
> What am I missing?  Has some other command replaced "make check-tcg"?

Maybe that patch from Paolo fixes it:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg742912.html

> 
> Thanks,
> Taylor
> 
> 


