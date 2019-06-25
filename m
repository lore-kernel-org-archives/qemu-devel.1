Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E480AC48BD7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 06:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EB4204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 06:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYvG7RPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EB4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffOv-0006WX-9M
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 02:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56866)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hffO8-000657-Qq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 02:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hffO5-0003jZ-OI
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 02:57:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hffO3-0003gh-Oa
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 02:57:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so16451741wrl.9
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 23:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9sJuLSlZHV7pA/c1XeCjbNNVA1Os9l6+wI/Pw4XZ+6s=;
 b=VYvG7RPEoJMhDYyqJyoYW0feIkH3cvObUfzXhMYqFF5LeTXoGhXuKECuSZvuRpLrSr
 1c6d9DRIjNB4KQFzBrm6MXq6jsHNuEhAwjJMILdV+TjXQkYFlasN1/Eqtr1Sa1YS4YAx
 HSFimPVpcjHtn20pQJ+Vgp3tjxJ0E3PlrUPaX1kLco1TJyGDWn7ib513F2J2GlacihwV
 M9QUs0J42ybDGGqzT9hE0MVJKCCAHpA6gwrRuoHzuUn4xpVkbYtLtapmY0W2mJSdnntq
 dm739+CU3XCN3q68O/4jB3V7pxog1uaECyXoGjNUhdnZtEX8gnreD3FOVPzGzC1jUfW4
 IpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9sJuLSlZHV7pA/c1XeCjbNNVA1Os9l6+wI/Pw4XZ+6s=;
 b=W2liQdbxgaUBrMb7jcwBTWqaNSGn60bIOReZUp/ikLhNA37vSypclEd/lu2Wt68nz5
 TmKIh2kBJdoIqqKNRtvGRb9P7kkO5f3NZBwFagpRKJPnqyiJQZFSvyTbAIigoajGDpsq
 A1ddO4WGObIZI79wn0u7kQZKIA+WG/ub54z+ROKs8WmrD+0q+Xg+LWzz6V1qvN5bmHBu
 JGTtdDPVJo9+yiwfywuY6smMKQAA25rRqa2zhKThtkmKqywBrSSBksFnB6FMQ1a2uLMb
 AlUNkcE54jx72BWlin1QpezeczgPBZEP6UYUOBBm23J3R2Uh6V+xGw1A64UMw11KBHSJ
 QsdQ==
X-Gm-Message-State: APjAAAXOVKcV6a7Ph1rzxfpbmCxF7dHUuM9ee/tMLL3BB6uMa4LIeDMf
 7Mgp3HfoofC0bNrbJRbyE8yVpw==
X-Google-Smtp-Source: APXvYqy3e48LI3t+jhb9wvTq18FBjGn1xB4T/66puYqDDdvEaYFr9432pONqyC6QDHN9yBJROQzBjw==
X-Received: by 2002:adf:b605:: with SMTP id f5mr56876511wre.305.1561445820506; 
 Mon, 24 Jun 2019 23:57:00 -0700 (PDT)
Received: from [192.168.42.31] ([62.94.96.158])
 by smtp.gmail.com with ESMTPSA id c1sm26361949wrh.1.2019.06.24.23.56.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 23:56:59 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
Date: Tue, 25 Jun 2019 08:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/19 7:10 PM, Aleksandar Markovic wrote:
> On Sat, Jun 22, 2019 at 5:02 PM Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 22/06/2019 15:20, Mark Cave-Ayland wrote:
>>
>>> I've just given your tcg-ppc-vsx branch a spin here, and like Howard I'm getting
>>> segfaults trying to launch my MacOS images :(  The segfault is weird: it doesn't get
>>> caught by an attached gdb and the qemu-system-ppc process seems to hang around like a
>>> zombie which makes me think that it's probably an illegal instruction of some kind,
>>> but the PPC kernel can't handle it as well as x86 does.
>>>
>>> With a bit more work I bisected it down to the first commit in the patchset
>>> (d8dcbb57e9: "tcg/ppc: Initial backend support for Altivec") and then as an
>>> experiment I hacked tcg_can_emit_vec_op() to always return 0 to see if that made a
>>> difference, but the segfault still appears.
>>>
>>> The commit message mentions that the load and store helpers are also improved, so I
>>> wonder if they are what is causing the error rather than the vector parts? Also in
>>> the kernel log I see the following messages appearing:
>>>
>>> [3639669.374942] qemu-system-ppc[28591]: segfault (11) at 64b8 nip f87280 lr f8723c
>>> code 1 in qemu-system-ppc[94e000+aa0000]
>>> [3639669.380015] qemu-system-ppc[28591]: code: 93c10038 91810020 90010044 7fc802a6
>>> 3fde0059 2e030000 3bde6c18 7c9d2378
>>> [3639669.385056] qemu-system-ppc[28591]: code: 813e80a0 7cbb2b78 7cda3378 7cf93b78
>>> <81428ff8> 9141001c 39400000 81290000
>>>
>>> Does that help at all? If not let me know if there are any other tests that you'd
>>> like me to try to help debug this.
>>
>> One more hint: if I try a build of d8dcbb57e9 along with my tcg_can_emit_vec_op()
>> hack and pass --enable-debug-tcg to configure then I get an assert on startup:
>>
>> qemu-system-ppc: /home/mca/src/qemu/tcg/tcg.c:2207: process_op_defs: Assertion `tdefs
>> != ((void *)0)' failed.
>> Aborted
>>
> 
> Mark, Richard, Howard, David,
> 
> I just sent v5 of the series, that is (in the sense of net-result of
> code changes) equivalent to v4, but the patch 1/7 from v4 is now split
> into ten smaller patches. This was done mainly to enable Mark to
> perhaps try v5 and bisect, in order to at least somewhat narrow down
> the culprit. Most likely it will be patch 5 from v5, that is still
> sizeable, but even if this is the case, we can eliminate other smaller
> things from consideration.

Thanks for the help on that.

I don't believe your split is actually bisectable -- there's a minimum amount
that is required to enable vector opcodes at all.  Patch 5 is the first that
enables tcg_out_{mov,ld,st}, so while patches beforehand may compile, they
certainly will not run.

I can retain your split, but for real bisectability we need to move the enable
of TCG_TARGET_HAS_v128 from patch 2 to patch 5.

Given that all this works for me on a Power9 host, I expect that there's a
simple fix for Mark's G5 host.  Given the above assertion, a missing opcode
definition, perhaps for -m32 vs -m64?


r~

