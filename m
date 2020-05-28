Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B26BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E386207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+xnUVTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E386207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeITB-0001Rg-E1
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeISM-0000tc-R3
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:20:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeISL-000511-8Z
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:20:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so27932880wru.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=02OKvRwweg2GRhMvF4vmd1/6tVN3615dQuqWnN+0fkY=;
 b=C+xnUVTsOG65tC317GIWuErnCFaXSmkzwSAJx+AytB7+uzWV31/yAxM6WFIaes4RIU
 Ce9prXGWnOxvCmeymvgauiKHLiyyMhFpg2D7YQUgpikyLnPWToV7YfGa73kUHTFcUC/n
 MnRbgR59Zk0oQ4yZ4vIfzzXJtm2oRFNUI38b4qDhLTxV6zIgn1Ybwj+S2e1KVUx54sMC
 yr3Gna1JK6hKgpIrUQ+ygoH2QEkX/velvz08O8RFrfwNE8MizA2xJeaK8vpP7hjl09EM
 P3U9Ig0k8mYAKvOcD10RzpbTurfDXFQqpmngcUMHeoNpCwkpR7/UuKRbXDMVuY+Er7ti
 Yg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=02OKvRwweg2GRhMvF4vmd1/6tVN3615dQuqWnN+0fkY=;
 b=QALH1gezXdrVZvKgU3L5mVB69W57w/rCApyhsOi5uGGLaX2nyVJG7VUL+njThsJU6m
 TbFTDZR/u2/4O2kUj6kFUhtFuxviOtqeZpHNgGYmyryGKR/bs9svuecEfOPcRgBTgQnS
 8vs4K9OI+2cKIHmipNd8jcy2JHZDU0o2/l5Yg9F2qn87rMso8mXEhFFqAcihy/xD7yqQ
 7iGSvL7kP/2GG44xlTSnOrz1vqXFTID7zdV63sgNWaPHhe+zFA+/5EVOrRwaAMy4ykqw
 VIkCvBouxGHNu5d3MxGbgt/83m+rEhriOYH/OsDsZxmMRyYzmCZ0VLBNnqfq4VpF8V+2
 e6uw==
X-Gm-Message-State: AOAM531fGKANZdO/uQgTH5xiQ9YhhYXkE7aggYd5qrm20KJO6ouPZtdu
 alIeV8cP5N5+V9Okjpq+p0CU0dVB
X-Google-Smtp-Source: ABdhPJwj9LB5ni4gAcycBt36p3lAqUlhq+QxF1iu8qg7X7DJx+4pUvZfFHAOEuXqMzlwk8qCYIws3Q==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr3459538wrx.411.1590672018716; 
 Thu, 28 May 2020 06:20:18 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id 23sm5934369wmg.10.2020.05.28.06.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 06:20:17 -0700 (PDT)
Subject: Re: [PATCH 0/2] linux-user: Load a vdso for x86_64
To: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200519194452.9009-1-richard.henderson@linaro.org>
 <CAFEAcA8q-4o3yWX2kwS1inPiajP1yzc3NOLBjzQUubKzDNGhhw@mail.gmail.com>
 <e985a1cb-e4e3-6faa-f158-5e797d0b5e92@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <59072208-d680-a36d-e178-5f64accff233@amsat.org>
Date: Thu, 28 May 2020 15:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e985a1cb-e4e3-6faa-f158-5e797d0b5e92@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 12:32 PM, Laurent Vivier wrote:
> Le 28/05/2020 à 12:08, Peter Maydell a écrit :
>> On Tue, 19 May 2020 at 20:45, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>  Makefile                  |   4 +-
>>>  linux-user/elfload.c      | 203 +++++++++++++++++++++++++++++++++++++-
>>>  pc-bios/Makefile          |   5 +
>>>  pc-bios/vdso-linux-x64.S  | 115 +++++++++++++++++++++
>>>  pc-bios/vdso-linux-x64.ld |  81 +++++++++++++++
>>>  pc-bios/vdso-linux-x64.so | Bin 0 -> 7500 bytes
>>
>> I'm not really a fan of binaries in source control :-(
> 
> Can't we see that as a firmware or a ROM?
> It's only 7,4 KB and needs a cross-compilation env to be rebuilt.
> 
> Do you have another solution?

There are only 13 asm instructions, the rest is ELF structure.
Maybe we can strip the linker version ELF sections. Taking out the
alignment gap, not much left.

Nonetheless it is certainly annoying to write that using a readable
scripting language when the linker already does the job, and the patch
is already written/tested.

> 
> If you don't like this I can remove the series. Let me know.
> 
> Thanks,
> Laurent
> 
> 


