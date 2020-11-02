Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48EBC4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1EA22280
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1/WqL6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1EA22280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeuo-0005Ck-Ss
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZetk-0004i8-7B
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:49:45 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:36883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZeti-00024H-0o
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:49:43 -0500
Received: by mail-ed1-x533.google.com with SMTP id o18so15434663edq.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kQKiyPhUHSMBwGBU4BH3AFV42DrSlNDw+/Q/zvNl9Xk=;
 b=W1/WqL6x4gtotZzMmyKdtZAP5ouU23CshrdX/Bdwuq0z4tZt+cKzCT8gjnqCAfApE3
 ErBnrVpfpZ3dBJrcM/PpHbSUYHq2oEnwXXMmS0qlpQfMrZ9F4jNzy0t13TcZYAaBxBjk
 yjmRWHzi4XO4KD492dM8onK1g1RZe1cOJRQLMciEZL60ogZ1z4JBkG9Z+sA1jrz9lI1U
 ZcgUElb4hBtlVoRX/MJ2PKclLyFkWO3/Qow66uT+vq17gWR3RPcHrWRW95fJpo6nPu6a
 0VWUrDm8OlYTIXIwUIRPJdY7+oI0rRPygXtTMWpfQi65XO2tJfpluNmo3ZDFgo8OmmWb
 6aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kQKiyPhUHSMBwGBU4BH3AFV42DrSlNDw+/Q/zvNl9Xk=;
 b=nD5zDAbWXmRN0xRxDfc+bLSmHlfGs9veApH6HIKTSrTh2oDS5mKLJVXYsr9yMkNJWU
 hKyykK2scfTL1WV2VSZt64SIccpa0OG+gebtsIRB2JTIZMjRsGRUC7zDvkhlBtOfjZrz
 5v0JIMP52KFXYO4+AiBlKXpbB8zaF5EvIBJhKEDqmEIIpU/WBTWKLaYkb7Q2/u2bPadU
 neKjuGjrng1bz4xl8gsdJ5WEHIuuzjTQW2gnGOjSkXLD6rcix9lG8LIuagLLqBB7wFtl
 cMmU6i4nrs/Al/JFwPNDzjrCYTfVNaiHdUwqQ+wU83ZAYD9I57bGdC92a+U+yy1uD+Fj
 Eftg==
X-Gm-Message-State: AOAM5303pk8GS092W3KDvTkQbztfk/aFmB4PJwddKACrhQw1YtjLMbpl
 HPjS8Maev3z0VcXa+4zHoVw=
X-Google-Smtp-Source: ABdhPJyCJmirH6Gc2lvT+Tyk+fBCzb7W4GBB9QkgbZeZCl8u4aEj0DN65t09mMSqHb4t9P7bDjgPrw==
X-Received: by 2002:a05:6402:142c:: with SMTP id
 c12mr18616620edx.41.1604342980241; 
 Mon, 02 Nov 2020 10:49:40 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v2sm9729632ejh.57.2020.11.02.10.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 10:49:39 -0800 (PST)
Subject: Re: [PATCH-for-5.2] hw/mips: Remove the 'r4k' machine
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201102102631.2058219-1-f4bug@amsat.org>
 <f505244d-2433-2032-a90f-5d2a5ee024a2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ed0dfe21-2eaa-2035-aa0c-b53e6ad4080d@amsat.org>
Date: Mon, 2 Nov 2020 19:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f505244d-2433-2032-a90f-5d2a5ee024a2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: libvir-list@redhat.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 5:00 PM, Richard Henderson wrote:
> On 11/2/20 2:26 AM, Philippe Mathieu-Daudé wrote:
>> -mips ``r4k`` platform (since 5.0)
>> +mips ``r4k`` platform (removed in 5.2)
>>  '''''''''''''''''''''''''''''''''
> 
> Header underline needs adjustment.  Otherwise,

Indeed:

Warning, treated as error:
docs/system/deprecated.rst:331:Title underline too short.

> Acked-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

