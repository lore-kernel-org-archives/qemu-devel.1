Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7309FC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC48239E5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyaduMFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC48239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKde9-0002Sr-Fe
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKddK-00022N-EZ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:26:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKddI-0006lc-Vp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:26:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so16027664wrw.11
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1AEf+kNXVRq/SO2Wcy3V6tiKsG9pR+2q6NmJb1PMmXM=;
 b=HyaduMFPvc6z+F5RQz3OCl5uhnNhvZOzCovrdFIXLUJBSBScajgoGaMIaMv/zSnaXB
 JJS1SqqRhzdZXAtFauHA0SAY0RnZIL+TCrj9SJVLdk0q1AtOkHpDjobHHXEhpUaaaBmG
 ixoEEcC3Yv/L0ixzOxHhYvg3KezncXpBlIfk7rFAJCcesE5QYpdB6vglQkXY7lpYR/+a
 Dt0G8HeYy1AWBveC1Hqzwi/ZS0Z8LY3cEUA/1Pb8E1UJqha8en9znTNQC1t3KkZdSsNm
 Hi0zNWrAVRVfNIXRbI+5t5ghd6Kf+o6ej7AqB54cSZwq2KW76K6olS3OyjalVR93roEZ
 zyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1AEf+kNXVRq/SO2Wcy3V6tiKsG9pR+2q6NmJb1PMmXM=;
 b=uF+W/eKvF5xEN0KWN4OSkB9Qm8yHI+7Glpe4qByVD0tp6yB5jyofK6ujOE+pEmaR7j
 Sf8cJ9EPoxzR3HMd4hBVLYsQCO7CV8Cs8zFNygvcLjl2QMnFHIXmYL/Q1G4Dc9MHaQuj
 y6unD/GX9pE9S4Jrhln4BzAWZyqcgB+aZc1LBdwCXRGOAi7wlpIoA9EFFp7HHnEm5xYQ
 rk2gGDcurD0qZde6L20FTNCTqONLpDLostwvAY40VqFFWo11WHkBaV+aByCmh0PrXadh
 jIcwov56lYoh3VblOSNJGwnfcezzruo7ZKhJ1bEHBYUwmXD/jX7mYFTEa8yTmEacgn9a
 1OTg==
X-Gm-Message-State: AOAM533NnBNPkQOSAu+UpAi20VbmBoRg12i7fiDyKCZUgFc8lvMHcuGr
 Erj2QnmwqGUfoYzVhxKXOQHz9XJPIlc=
X-Google-Smtp-Source: ABdhPJy68UZG71P1jL0tXjkldL21iqO6QqcTKnT2avzdTew/xrytBjrz4PUgzWtJQaDxWdAzSA8+vw==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr4313125wrw.198.1600763199060; 
 Tue, 22 Sep 2020 01:26:39 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z19sm3298389wmi.3.2020.09.22.01.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 01:26:37 -0700 (PDT)
Subject: Re: [PATCH v4 04/11] disas: Move host asm annotations to tb_gen_code
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-5-richard.henderson@linaro.org>
 <87d02fnd1y.fsf@linaro.org> <8e1ac018-dac8-b049-aae3-059f86698f3a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d3a5ec4f-259e-2f5a-2ae9-9bbc46d24298@amsat.org>
Date: Tue, 22 Sep 2020 10:26:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8e1ac018-dac8-b049-aae3-059f86698f3a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 9:53 PM, Richard Henderson wrote:
> On 9/21/20 12:29 PM, Alex Bennée wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> Instead of creating GStrings and passing them into log_disas,
>>> just print the annotations directly in tb_gen_code.
>>>
>>> Fix the annotations for the slow paths of the TB, after the
>>> part implementing the final guest instruction.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> I guess what we loose in the inline annotation we gain in simpler code.
>> We can always grep stuff out of the logs if we need to:
> 
> What information do you think we're losing?

This in tb_gen_code()?

  note = g_string_new("[tb header & initial instruction]");

  g_string_printf(note, "[guest addr: " TARGET_FMT_lx "]",
                  tcg_ctx->gen_insn_data[insn][0]);

