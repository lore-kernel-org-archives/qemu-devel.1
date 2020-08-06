Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF525221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg16maN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF525221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3nb4-0000Tq-2R
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3naC-0008RS-Gu
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:37:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3naB-0007Rc-1V
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:37:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id a14so45386331wra.5
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fBxvvlC37pPeDsRlTaA29QNcZkLbhDMohAa1v+BwemI=;
 b=Bg16maN75XaaAp/GOeRc3n+8jmMuAHlA92Ap8QfG2t2Rlgn1Ej21H2RigdWdzZIoif
 +VaJlijyDxzJxmW7OxxOmQGSCpHqX2xJNht6EUeO2snW6hFS5S38UJpAebL7MtYDKwR+
 JRvX+TtIrH0oWZxmjkFDR9gM2NVqEo65r5RXgswA+cESgC+BzL5Pd+RwclLxoRBjF6ow
 XbE4SPMlyS9020HKwgzRfWZfXS80agOS9JSO2EAZ8eK8qNiihEL1tqiN9E+9JiSHc3CE
 gb8nImZYJiSun80g0XTQwMrCQ4Y0hHmoD7rW1+ipLD15f99MaGliKeS5//BM2VZIzUzg
 5X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fBxvvlC37pPeDsRlTaA29QNcZkLbhDMohAa1v+BwemI=;
 b=XV3Gnq0DFqp+eL/2QnnZmn1Boh19t4ySTtaKi49wUrYsYE04A/caXIaA+So6OU7W4Y
 LlHOHDKBt+LKUWXT4xrEtBKW0NlI8coJJedLH12Orlj4JU/aRPy3CD/ls7HJppLRYrjv
 tH5GUh44Z1s0aiJBH8Cxenm3TjUwQ4+2BzNCuRCpNsebl9e7qI04ULXL4NfqAZM8W5UH
 ZfBUrYwtb50Dzwmw2C6U1ekJLArwCpBzttpQLabeom2rXDreT1jcr9SL6xY2QR7XlIwz
 7ZRJ9tg4/ITtWgRsi2f6HrUJScxHjS5by/TsxALkuq5f1iR7m2qpGBxvHuADrgulsZ0C
 9xCg==
X-Gm-Message-State: AOAM531fiGzbzooNxgfPlXq4KYDiFikAv2VVvH+CMjIWkKKwLJqs16ty
 /doEndPS9adtZ4DGurmZ0Z0=
X-Google-Smtp-Source: ABdhPJzvqOo95cJ8KTTRYSh5K8D3aaXcvNly1OCiceQQPm+Bas9gxEBComaGsClyVMfXSVMJwobY0A==
X-Received: by 2002:a5d:550e:: with SMTP id b14mr9734853wrv.392.1596749867751; 
 Thu, 06 Aug 2020 14:37:47 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 130sm7681018wme.26.2020.08.06.14.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 14:37:47 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] target/mips: Report unimplemented cache()
 operations
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200806122612.17167-1-f4bug@amsat.org>
 <e55da0ff-e88c-f2f4-0430-32255f7e58fe@flygoat.com>
 <ec0ff553-a5e7-6c93-5ab3-093721b044a6@amsat.org>
 <CAFEAcA8iXXW=eD+w-UdPqdjtbfc45Qu+DyfZBmaVe0TgMt_jmg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a620f323-e42a-e75e-0491-228c480fa55b@amsat.org>
Date: Thu, 6 Aug 2020 23:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8iXXW=eD+w-UdPqdjtbfc45Qu+DyfZBmaVe0TgMt_jmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
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
Cc: Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 10:51 PM, Peter Maydell wrote:
> On Thu, 6 Aug 2020 at 21:31, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 8/6/20 8:01 PM, Jiaxun Yang wrote:
>>> 在 2020/8/6 下午8:26, Philippe Mathieu-Daudé 写道:
>>>> We only implement the Index[Store/Load]Tag from the 'cache' opcode.
>>>> Instead of ignoring the other cache operations, report them as
>>>> unimplemented.
>>>
>>> Hmm, I don't think we have anything to do with Invalidate/Writeback etc.
>>> opcodes
>>> in QEMU. Why do we log this?
>>
>> I'm noticed this code is run on Linux 3.3.8 (4KEc):
>>
>>     8880:       3082000f        andi    v0,a0,0xf
>>     8884:       10800008        beqz    a0,88a8
>>     8888:       00a21021        addu    v0,a1,v0
>>     888c:       08002227        j       889c
>>     8890:       00001821        move    v1,zero
>>     8894:       bcf90000        cache   0x19,0(a3)
>>     8898:       24630010        addiu   v1,v1,16
>>     889c:       0062302b        sltu    a2,v1,v0
>>     88a0:       14c0fffc        bnez    a2,8894
>>     88a4:       00833821        addu    a3,a0,v1
>>     88a8:       03e00008        jr      ra
>>     88ac:       00000000        nop
>>
>> Why silently ignore the opcode is not implemented instead of logging it?
> 
> I think the question is whether the opcode is supposed to have
> some behaviour which we're not implementing, or whether "no-op"
> is the correct behaviour for it (which it usually is for
> cache invalidate type operations; compare the way the Arm
> cache ops like IC_IALLU are just ARM_CP_NOP ops).

OK now I understand better, thanks.

I haven't found useful information about this 0x19=25 opcode value.

On a r10k core it is listed as 'Hit Writeback Invalidate (D)' but here
this is a 4kEc. The address used is a SRAM shared with a embedded DSP
on the same SoC. From a RevEng PoV it is helpful to see there is a such
cache access, as I can separate better the peripheral involved.
I'm happy using a trace event instead.

Jiaxun, can you list me the list of opcodes QEMU can safely ignore from
the TCG emulation PoV? That way we can comment them in the code such:

    switch (op) {
    case 9:
        /* Index Store Tag */
        ...
        break;
    case 5:
        /* Index Load Tag */
        ...
        break;
    case X:
    case Y:
    case Z:
        /* No-Op for QEMU */
        ...
        break;
    default:
        qemu_log_mask(LOG_UNIMP, "cache %u\n", op);
    }

Thanks,

Phil.

> 
> thanks
> -- PMM
> 

