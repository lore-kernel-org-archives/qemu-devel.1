Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE11C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BB520855
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/6X+L1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BB520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6HW4-0003LA-Ku
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HVS-0002vR-KJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:59:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6HVR-0003EB-3Q
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:59:14 -0400
Received: by mail-wm1-x343.google.com with SMTP id x5so5429203wmi.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5xjQXocnPSo4yiHt4GOz8eSvpAc5sdt3zdgoZnKJVBc=;
 b=a/6X+L1isactn1BVAWOTBcUreFtcWAAAkoYCwadw1eubfRBsYHqNA4jD/QyuRA0DPo
 RxKapnxJTNeDardVSFdQelKv1UzvsqFz3JwYncH3FO6IQ92vHBvH/C4uDiGOpt6KSSkv
 daB7SEnt8sWomud92eqTqr1XOFKZO4+VxCnB1mgHJxVdTB4fbvvMaoPd4+nUwVl4hYVS
 3mhhWe3gXxAWZnTpZ3NHBczuUYYwtRzvPCbQ5m1QUUoYiLLIbXH270AulNL3Hlv7O1q2
 StsY4b2dQ9+vJ6kOvU25UjzBq1rxTv2YXiQmMAumAEhpZZs0Dz39x2+4qdWknIE87fu3
 /N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5xjQXocnPSo4yiHt4GOz8eSvpAc5sdt3zdgoZnKJVBc=;
 b=YeAAeBvL25f7fqDzQAGLWEIqWV+RoVR0coejM3YUOf4UFm0aMWkRHc+zFbVRoUa9GJ
 ZsNtyUj/oFLwFC4ditQ4Lzw6RGt7t7LCNcfW5CrOeWu900gNHXuOEZVMmaeHG+siK/74
 pzdlsgCKAvC/Dxe2ozmpiouwjdDd3hBnrCSkZbZTKei6VvAoIlZV3JJvgJo409vweuyJ
 ozhSf910tTLweH+BR4WfmPQva8AyKA2iAnWkTD1rb6cl3+IkZGUHyv5WLzvHM/St9izC
 t9v24Gr8iJv9Dv3gCeRvH+Zzy9L7tJmbexnzQATZyN3occNERLHPJFE/bSfEWFjhl+Jy
 Nv9w==
X-Gm-Message-State: AOAM530YyhbDyBbQnprrhIDXlBjWCDL/ri1ED4T7aRL/W6ETKLWfkfaJ
 K2y+QVaSi2/pOBhwmBS75waa/zug
X-Google-Smtp-Source: ABdhPJx9DhzBGcJ8s/Pt824eq6EjQ4W/xQCLNPj7a2Dxb6n1ntOiXy+iGkic/HMFGPR9AQm4LHKQJw==
X-Received: by 2002:a1c:e107:: with SMTP id y7mr5079703wmg.99.1597341551141;
 Thu, 13 Aug 2020 10:59:11 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m8sm10666368wro.75.2020.08.13.10.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 10:59:10 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] target/mips: Report unimplemented cache()
 operations
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20200806122612.17167-1-f4bug@amsat.org>
 <e55da0ff-e88c-f2f4-0430-32255f7e58fe@flygoat.com>
 <ec0ff553-a5e7-6c93-5ab3-093721b044a6@amsat.org>
 <CAFEAcA8iXXW=eD+w-UdPqdjtbfc45Qu+DyfZBmaVe0TgMt_jmg@mail.gmail.com>
 <a620f323-e42a-e75e-0491-228c480fa55b@amsat.org>
 <6cecb59e-3a78-907c-cf63-225b4efbca01@amsat.org>
 <39ad849e-c1fb-5031-7a30-f920bcee4cbe@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4ff41f95-2a22-a42e-4ddd-461b31b21da3@amsat.org>
Date: Thu, 13 Aug 2020 19:59:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <39ad849e-c1fb-5031-7a30-f920bcee4cbe@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 5:23 PM, Jiaxun Yang wrote:
> 在 2020/8/11 上午1:21, Philippe Mathieu-Daudé 写道:
>> On 8/6/20 11:37 PM, Philippe Mathieu-Daudé wrote:
>>> On 8/6/20 10:51 PM, Peter Maydell wrote:
>>>> On Thu, 6 Aug 2020 at 21:31, Philippe Mathieu-Daudé
>>>> <f4bug@amsat.org> wrote:
>>>>> On 8/6/20 8:01 PM, Jiaxun Yang wrote:
>>>>>> 在 2020/8/6 下午8:26, Philippe Mathieu-Daudé 写道:
>>>>>>> We only implement the Index[Store/Load]Tag from the 'cache' opcode.
>>>>>>> Instead of ignoring the other cache operations, report them as
>>>>>>> unimplemented.
>>>>>> Hmm, I don't think we have anything to do with
>>>>>> Invalidate/Writeback etc.
>>>>>> opcodes
>>>>>> in QEMU. Why do we log this?
>>>>> I'm noticed this code is run on Linux 3.3.8 (4KEc):
>>>>>
>>>>>      8880:       3082000f        andi    v0,a0,0xf
>>>>>      8884:       10800008        beqz    a0,88a8
>>>>>      8888:       00a21021        addu    v0,a1,v0
>>>>>      888c:       08002227        j       889c
>>>>>      8890:       00001821        move    v1,zero
>>>>>      8894:       bcf90000        cache   0x19,0(a3)
>>>>>      8898:       24630010        addiu   v1,v1,16
>>>>>      889c:       0062302b        sltu    a2,v1,v0
>>>>>      88a0:       14c0fffc        bnez    a2,8894
>>>>>      88a4:       00833821        addu    a3,a0,v1
>>>>>      88a8:       03e00008        jr      ra
>>>>>      88ac:       00000000        nop
>>>>>
>>>>> Why silently ignore the opcode is not implemented instead of
>>>>> logging it?
>>>> I think the question is whether the opcode is supposed to have
>>>> some behaviour which we're not implementing, or whether "no-op"
>>>> is the correct behaviour for it (which it usually is for
>>>> cache invalidate type operations; compare the way the Arm
>>>> cache ops like IC_IALLU are just ARM_CP_NOP ops).
>>> OK now I understand better, thanks.
>>>
>>> I haven't found useful information about this 0x19=25 opcode value.
>> Just to close this thread, some findings from last WE:
>>
>> - I couldn't find where Linux 3.3.8 use that op
>> - I eventually figured out it comes from a kernel module called 'tiatm'.
>> - This kmod is released by OpenWRT in packages named
>> kmod-sangam-atm-annex
>> - Googling for strings from the object, this file has been added in [1]
>> based on the file included in [2]
>> - Someone imported these files in a git repo and published
>> - There is a commented reference [4] as:
>>
>> #define        DataCacheHitInvalidate(a)     {__asm__(" cache  17, (%0)"
>> :   : "r" (a));}
>> #define        DataCacheHitWriteback(a)      {__asm__(" cache  25, (%0)"
>> :   : "r" (a));}
>>
>> - Also referenced (not commented) in [5] "Linux atm module
>> implementation".
>>
>> For my use I'm happy using a trace event:
>>
>> -- >8 --
> 
> FYI, I took a look at MIPS M14K (interAptiv) RTL from MIPSOpen project,
> HitInvalidate and HitWriteback cache Ops to L2/L3 Cache will also act
> on L1 Cache. So probably that's kinda... Undocumented trick...

Uh... Thanks for having a look!

> 
> Thanks.
> 
> - Jiaxun
> 

