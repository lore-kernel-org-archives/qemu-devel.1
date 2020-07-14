Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A88C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE73320663
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5d1c5mI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE73320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMZ2-0008TP-6j
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 11:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvMYP-0007vx-P2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 11:09:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvMYO-0007yf-Ar
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 11:09:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so22304616wrm.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yspaqFLqjx+oHSHyQpjJ/X/MhJXPPWCOIyWnxFW+Od4=;
 b=b5d1c5mIKA5/Krr9L8Ifpj9Oph1mSajc9Km1yRSrVgICTH+H5OQww3Nevma5gEIx85
 jC1rgqiEVKNRwx3ABLmDeWmM4cURhACSKY9KVp68LTXTVeEEbl0RxfsB6JkaaUptTp3y
 WWnQHtoLJFj5VjBVP5S76ci8vMLHS3BuQUHlUqBgzcCKYe1xaW/LnWoVQD5+bGAUjwev
 Zur6tOF5IAQzWlEghxOreVfmCTp7s6qpjx47iTC0TTa7wqOXCX1x20e8mEieZyfg8cwO
 RJEW+qNm2+BJhorZC1PWpjgj/WJBP3hbrskgGJj6/UpCKU0YDggHDm+TUnDuS8eaKf77
 ZOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yspaqFLqjx+oHSHyQpjJ/X/MhJXPPWCOIyWnxFW+Od4=;
 b=T/WdEKu1juCArxMhosEvNcDVZfZvwbwEujQEpXdEtC0ss/+ABGQeCpoLmkejR3Sn63
 WFYA4V9AsvMLb87xRAsKwKG19xA8GrxCrZOrnj2aQn1jM+wXHzH/49XRRU1VnIsbirMe
 GaXMA3xwnACBp0cJ+OpOXyz5ICqpULAHo3Df/UT4cpdziQrDk0NPK/QOVxWr2XMokXE+
 fbz0kDF+kNakyb5qFnIfJfzdZcXFysPmjiowy76W32qVX2DTR8dmPOPwO9vceDiixzAm
 eqAUbVl0wTi3RpcbWcFT5siooL98Xq20vE3Y1bRt9ClTyulfpJiWG20ZEaQjs2PYzOkL
 ZePg==
X-Gm-Message-State: AOAM5332PjVqX2gETjgL+g3vlfsvmjK4zTzCkoyac0Tlezr37Bpg2DLf
 jKoE14bAbDzZExmFmDkKyy0=
X-Google-Smtp-Source: ABdhPJx2jU+SseCk5udxm2vdP4a2N2pIasqbjt5cI67HtfNSurx9sUEFTIplwtc3Ob2CQ9l8ZJOt4g==
X-Received: by 2002:adf:9307:: with SMTP id 7mr6196544wro.414.1594739346713;
 Tue, 14 Jul 2020 08:09:06 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id e23sm4726665wme.35.2020.07.14.08.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 08:09:05 -0700 (PDT)
Subject: Re: [PULL 24/32] hw/avr: Add support for loading ELF/raw binaries
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
 <20200707181710.30950-25-f4bug@amsat.org>
 <CAFEAcA9Wx_gqSfuJkrf4GxEy4N5m5TQmNOe65vZzx5LjUmrWUQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <87e9229a-91e1-45ad-e0ef-983aeb4da500@amsat.org>
Date: Tue, 14 Jul 2020 17:09:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Wx_gqSfuJkrf4GxEy4N5m5TQmNOe65vZzx5LjUmrWUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 2:40 PM, Peter Maydell wrote:
> On Tue, 7 Jul 2020 at 19:31, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Add avr_load_firmware() function to load firmware in ELF or
>> raw binary format.
> 
> Hi; Coverity points out a memory leak (CID 1430449) in this function:
> 
>> +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
>> +                       MemoryRegion *program_mr, const char *firmware)
>> +{
>> +    const char *filename;
>> +    int bytes_loaded;
>> +    uint64_t entry;
>> +    uint32_t e_flags;
>> +
>> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> 
> qemu_find_file() allocates and returns memory, but we don't
> pass this to any function that takes ownership of it,
> and none of the exit paths from the function (either error-exit
> or success-exit cases) call g_free() on it.

Ah I didn't know it was allocated, I looked at the declaration
in the header then quickly if there was a comment in the source,
but didn't read the implementation (now I see the obvious g_strdup()
call... Neither have I looked at the other callers.

I'll send a patch.

Thanks for following the Coverity reports,

Phil.

> 
> thanks
> -- PMM
> 

