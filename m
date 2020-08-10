Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB9BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01FB2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic6WQMbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01FB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CHc-0001d4-4B
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5BU7-0003GM-9z
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:21:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5BU5-0004Jg-C9
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:21:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id 88so8928592wrh.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:cc:references:autocrypt:to:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AXkGkvh+c2hcusRu6D3sTDTF9g3ce8ZIs15PYjugQ2o=;
 b=Ic6WQMbFOg9zV2VePT3gMXcJWG8j5o8iXWdb7/WJcnbWO92tHttSHgS4HTq7Zfh2Nt
 31wwChPlmolJaDnR3NU/saCqVABajDxApcwwhrkFbxUMwUppnRLHldLwbEDtS0KY0nzh
 yA5lBj6zmK+dsSYSuH7WIlse0QvSIt1qZPZU4xSPNM+0C8cxDCDkWqGaxkk/ejdudpKT
 QUpDYK9p361bp7MpK6YltO1MdE9LWJlY0aItudC16Q4N+T5Ucy6RhVuplaCvehHLWY4D
 HJRzCwEnh+KGDug4fthoBVaf4ZPv5P0ddYiHh0kyP+XgdHNd7xjZBCBs6L1OHj6Mns/q
 Y1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:cc:references:autocrypt:to
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=AXkGkvh+c2hcusRu6D3sTDTF9g3ce8ZIs15PYjugQ2o=;
 b=uMalqHQphFxH3HA5nLS2ctsVl34D0Hem+ms6G+R7EcT3Kg5Yol/SzgjSHZFxABAn0H
 /xXpJz/bs4ABIqTS0x0+p7QTZspxTuSM/GqWSJC8OekRiPqgz9zPwzYgaI981XNuFnAb
 x6GJuL1Uju6kO91TA6uV1kXy5DehHXn7UCNIGIuaLdM0/CilJbZc/zfj8tMJLFmx7+Rs
 +gPaGCHqrQtOnacDdeOLrhCS+hJJAS3OPQU3FQHnBAlrr2WuNMJzJxypRIotuJq3p9v9
 hkGpwggM8WXMiA3m7fcypQNRHIyh5EDQ5artW7+S8RhiID9h1wzwEEiQrh/P9wt1dv5v
 7P+w==
X-Gm-Message-State: AOAM5326JJYqKL4IiqvPrShQkFyNsIgwipPsclAvEF/8L7NB6HOtbzzz
 BzmrEbuNat1PYryPle1pd7s=
X-Google-Smtp-Source: ABdhPJxcmXyvfTp5hSg083jnyXJSvDKYm6dytU2P7NLjmfdY4bvNCCQY2z0XQ0TDbWP1gg4UtCZ8uw==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr2278329wro.233.1597080074319; 
 Mon, 10 Aug 2020 10:21:14 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id e4sm21627699wru.55.2020.08.10.10.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 10:21:13 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] target/mips: Report unimplemented cache()
 operations
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200806122612.17167-1-f4bug@amsat.org>
 <e55da0ff-e88c-f2f4-0430-32255f7e58fe@flygoat.com>
 <ec0ff553-a5e7-6c93-5ab3-093721b044a6@amsat.org>
 <CAFEAcA8iXXW=eD+w-UdPqdjtbfc45Qu+DyfZBmaVe0TgMt_jmg@mail.gmail.com>
 <a620f323-e42a-e75e-0491-228c480fa55b@amsat.org>
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
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <6cecb59e-3a78-907c-cf63-225b4efbca01@amsat.org>
Date: Mon, 10 Aug 2020 19:21:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a620f323-e42a-e75e-0491-228c480fa55b@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 11:37 PM, Philippe Mathieu-Daudé wrote:
> On 8/6/20 10:51 PM, Peter Maydell wrote:
>> On Thu, 6 Aug 2020 at 21:31, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>
>>> On 8/6/20 8:01 PM, Jiaxun Yang wrote:
>>>> 在 2020/8/6 下午8:26, Philippe Mathieu-Daudé 写道:
>>>>> We only implement the Index[Store/Load]Tag from the 'cache' opcode.
>>>>> Instead of ignoring the other cache operations, report them as
>>>>> unimplemented.
>>>>
>>>> Hmm, I don't think we have anything to do with Invalidate/Writeback etc.
>>>> opcodes
>>>> in QEMU. Why do we log this?
>>>
>>> I'm noticed this code is run on Linux 3.3.8 (4KEc):
>>>
>>>     8880:       3082000f        andi    v0,a0,0xf
>>>     8884:       10800008        beqz    a0,88a8
>>>     8888:       00a21021        addu    v0,a1,v0
>>>     888c:       08002227        j       889c
>>>     8890:       00001821        move    v1,zero
>>>     8894:       bcf90000        cache   0x19,0(a3)
>>>     8898:       24630010        addiu   v1,v1,16
>>>     889c:       0062302b        sltu    a2,v1,v0
>>>     88a0:       14c0fffc        bnez    a2,8894
>>>     88a4:       00833821        addu    a3,a0,v1
>>>     88a8:       03e00008        jr      ra
>>>     88ac:       00000000        nop
>>>
>>> Why silently ignore the opcode is not implemented instead of logging it?
>>
>> I think the question is whether the opcode is supposed to have
>> some behaviour which we're not implementing, or whether "no-op"
>> is the correct behaviour for it (which it usually is for
>> cache invalidate type operations; compare the way the Arm
>> cache ops like IC_IALLU are just ARM_CP_NOP ops).
> 
> OK now I understand better, thanks.
> 
> I haven't found useful information about this 0x19=25 opcode value.

Just to close this thread, some findings from last WE:

- I couldn't find where Linux 3.3.8 use that op
- I eventually figured out it comes from a kernel module called 'tiatm'.
- This kmod is released by OpenWRT in packages named kmod-sangam-atm-annex
- Googling for strings from the object, this file has been added in [1]
based on the file included in [2]
- Someone imported these files in a git repo and published
- There is a commented reference [4] as:

#define        DataCacheHitInvalidate(a)     {__asm__(" cache  17, (%0)"
:   : "r" (a));}
#define        DataCacheHitWriteback(a)      {__asm__(" cache  25, (%0)"
:   : "r" (a));}

- Also referenced (not commented) in [5] "Linux atm module implementation".

For my use I'm happy using a trace event:

-- >8 --
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 7f87e57c8e..71b28ede2d 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -30,2 +30,3 @@
 #include "sysemu/kvm.h"
+#include "trace.h"

@@ -1577,2 +1578,4 @@ void helper_cache(CPUMIPSState *env, target_ulong
addr, uint32_t op)
     target_ulong index = addr & 0x1fffffff;
+
+    trace_cache_op(op, addr);
     if (op == 9) {
diff --git a/target/mips/trace-events b/target/mips/trace-events
index ba87fe6062..8a60f23bbd 100644
--- a/target/mips/trace-events
+++ b/target/mips/trace-events
@@ -2,2 +2,5 @@

+# op_helper.c
+cache_op(uint32_t op, uint64_t addr) "cache op:%u paddr:0x%" PRIx64
+
 # translate.c
---

[1]
https://git.openwrt.org/?p=openwrt/svn-archive/archive.git;a=commit;h=5a8a8f35c5a356f7167c3b3a3ca00f0780d86473
[2] https://dev.archive.openwrt.org/ticket/1411.html
[3] https://github.com/wolfhechel/ar7-atm
[4] https://github.com/wolfhechel/ar7-atm/blob/master/cpswhal_cpsar.h#L84
[5] https://github.com/wolfhechel/ar7-atm/blob/master/tn7atm.c#L479

> 
> On a r10k core it is listed as 'Hit Writeback Invalidate (D)' but here
> this is a 4kEc. The address used is a SRAM shared with a embedded DSP
> on the same SoC. From a RevEng PoV it is helpful to see there is a such
> cache access, as I can separate better the peripheral involved.
> I'm happy using a trace event instead.
> 
> Jiaxun, can you list me the list of opcodes QEMU can safely ignore from
> the TCG emulation PoV? That way we can comment them in the code such:
> 
>     switch (op) {
>     case 9:
>         /* Index Store Tag */
>         ...
>         break;
>     case 5:
>         /* Index Load Tag */
>         ...
>         break;
>     case X:
>     case Y:
>     case Z:
>         /* No-Op for QEMU */
>         ...
>         break;
>     default:
>         qemu_log_mask(LOG_UNIMP, "cache %u\n", op);
>     }
> 
> Thanks,
> 
> Phil.
> 
>>
>> thanks
>> -- PMM
>>
> 

