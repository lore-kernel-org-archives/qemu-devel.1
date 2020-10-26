Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024CF206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnWBcbAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024CF206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5zt-00048W-RB
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX5wd-0000Nw-I1; Mon, 26 Oct 2020 13:06:07 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX5wa-0006cO-8d; Mon, 26 Oct 2020 13:06:07 -0400
Received: by mail-ej1-x644.google.com with SMTP id dt13so14661808ejb.12;
 Mon, 26 Oct 2020 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YtILxrTiQyFvjXojSK8Xu46NkvXLNpokkJRzWpf6lec=;
 b=DnWBcbAYi2O6L7inVEEY8MywOdFVWOHIR5v0A08RcjkjEv7Bbntqulm1x+bL1ES9FP
 3R0Py4thBhXkesc++TLxMoff2O68YFlUTIpUOpbicBVb1EmIrcBEM75ej4izL7YDNgwA
 SIW4I/rFhtIY+84LpgYT6JJKcrSbwlIQfJPm6sIXJFN6idZuDjNCLB5guWzWOzWXxBiX
 9iuhMiORZkrkp2O8hKY2F76F6LAx+FpRu90dXKw5bfy2dU/6WxYF2NlwreYGolGqCHjs
 BedTNfPq2GjyP6uo0l+qKaYxCuB5fARVq4zqdxv4CvlgdHcPTp5talRLhVb8GwwH7uiA
 zBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YtILxrTiQyFvjXojSK8Xu46NkvXLNpokkJRzWpf6lec=;
 b=D+CJjNGv64b3K1e7IqJU+VFfcjL/7gUHvHK7Lwr5zQZhGX1Ak/sCK+m83zNSKW6Hao
 ThpH+u6/amdpBE7BGld2zALie48WJAX3Tb/jKC2w8nK1iH1kDFzrTITuivrAa1TfIYLq
 i1KqPd0ppjPjzFSevWOutyU4vXrp5UJHGGVTooKHHwokKF5mNTA5d/LJRSM7rzIchk1I
 dJeV6e4WDffJK3N6gkI9IWTnXuMy8GH4efMHOXF6kohPmMoJqCLrShehM2WOMSVt+t0U
 yZYZknk4UnIOKcgO9IqyD9VXXg0Y3Kbw6GC72HIEq1R4N/lHtU9jCOeGjzbSBnOFLpdw
 H3oQ==
X-Gm-Message-State: AOAM530qbEfe3mEdpMBxK8KuZ4tTo4EwlNYqrupOG04HJZ4lqOIhOR7P
 frgWJjJd7nAOYwnBBQTBbTM=
X-Google-Smtp-Source: ABdhPJz0tgPtwE36f1bMGOr9nlHHawF3eOATHJNCVv8lS7vIT2K0yQxCPlusFOXXEpFgWXLDwThk6A==
X-Received: by 2002:a17:906:aecf:: with SMTP id
 me15mr17433570ejb.423.1603731958795; 
 Mon, 26 Oct 2020 10:05:58 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id cw15sm6202168ejb.47.2020.10.26.10.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 10:05:57 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hw/ssi: Rename SSI 'slave' as 'peripheral'
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
References: <20201012124955.3409127-1-f4bug@amsat.org>
 <e15493bf-f31e-daf2-d216-b9d67ea638b1@amsat.org>
Message-ID: <11aef83d-64ae-8954-e61f-911282896455@amsat.org>
Date: Mon, 26 Oct 2020 18:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e15493bf-f31e-daf2-d216-b9d67ea638b1@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping^2?

On 10/19/20 6:04 PM, Philippe Mathieu-Daudé wrote:
> Ping for review?
> 
> On 10/12/20 2:49 PM, Philippe Mathieu-Daudé wrote:
>> Since v1:
>> - Fixed patch #1 subject (Kevin)
>>
>> In order to use inclusive terminology, rename SSI 'slave' as
>> 'peripheral', following the resolution Paolo pointed in [*]:
>> https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/
>>
>> Candidate to be merged via the ARM or Trivial trees.
>>
>> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg739108.html
>>
>> Philippe Mathieu-Daudé (3):
>>    hw/ssi/aspeed_smc: Rename 'max_slaves' variable as 'max_peripherals'
>>    hw/ssi: Update coding style to make checkpatch.pl happy
>>    hw/ssi: Rename SSI 'slave' as 'peripheral'
>>
>>   include/hw/misc/max111x.h   |  2 +-
>>   include/hw/ssi/aspeed_smc.h |  2 +-
>>   include/hw/ssi/ssi.h        | 56 +++++++++++++++++++------------------
>>   hw/arm/spitz.c              | 32 ++++++++++-----------
>>   hw/arm/stellaris.c          |  4 +--
>>   hw/arm/tosa.c               | 12 ++++----
>>   hw/arm/z2.c                 | 14 +++++-----
>>   hw/block/m25p80.c           | 14 +++++-----
>>   hw/display/ads7846.c        | 12 ++++----
>>   hw/display/ssd0323.c        | 12 ++++----
>>   hw/misc/max111x.c           | 18 ++++++------
>>   hw/sd/ssi-sd.c              | 12 ++++----
>>   hw/ssi/aspeed_smc.c         | 53 ++++++++++++++++++-----------------
>>   hw/ssi/pl022.c              |  2 +-
>>   hw/ssi/ssi.c                | 48 +++++++++++++++----------------
>>   hw/ssi/xilinx_spips.c       |  7 +++--
>>   16 files changed, 152 insertions(+), 148 deletions(-)
>>
> 

