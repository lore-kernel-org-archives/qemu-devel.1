Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8824AC43467
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B450722282
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vE/lpvvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B450722282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXNC-0004au-Gb
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUXLG-0003di-P8; Mon, 19 Oct 2020 11:44:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUXLF-00072f-5k; Mon, 19 Oct 2020 11:44:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so210327wru.12;
 Mon, 19 Oct 2020 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FDO0Fpq9dLfWvRB7q6PlAIftQwMQiLAYD0HLGsECdoc=;
 b=vE/lpvvQW6Cw7UAavR5+i13alYOuAK3JsofK739Q+9LIQjDwTtje4yBwYIxivGuFWo
 aSc1vIPqtljc43rgX686zqJEOkBYdO2ay/v7l+SItbP9H8PqbP4CMMJDU1EbeNaGlkNs
 +a+y1k4L9L1DN/6oknrEFNtVylWEa4JPWQ1zqjJTpeMOryeZqlK6q+ZJN+qMMzpud9E/
 RvfLS5jCpoZvmEQ3p+KDKSvPDxx3UDf8AxuN5va8Ir921piF/GB8d9DP7Kxq2QG6fkld
 zSRzjyMeoxYiHYXUBxPU55iYaM16+TG8EQYCp8W7SRbmhSn4BsEueD2yCDelZZM8IVW6
 0Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FDO0Fpq9dLfWvRB7q6PlAIftQwMQiLAYD0HLGsECdoc=;
 b=MnZC+5tvHDWInpb3YMiZ6dG2dIMQ3NNuc/uXwYagZwokwa78Eg1t0IpHO9qJlVbgjf
 k9IdFlCPGUrgLJblPoHs2NGPMkcGDImfkYZxOuYr23rp48n5D1Z3Q+0r2+MezZiSxHp2
 cK//m/p/Ai1FPup20rHRniGsXCBknHTUgmIZ+/Kp0W/sEZdp0a4ucYSSwvZ9cHyv8nKY
 45JBx699zcKF2T0kRoKngILNvs6TWzpj8700dbWIyyzn7gi3sB2quO+LDA9yFPh92kB/
 tUsh++uZzVv9agif4SKT1Refdtx8BDduy5cMbh5N/rzRA/+QKyYMgbOvZmzP9q+Hie4C
 qRLA==
X-Gm-Message-State: AOAM531p6tsq6g3tNDOmO877jVmYl1HTwsT6xNgMQTSmQI03V3zk63DU
 xSgnT6ycjL3wGeCMSiONLJ8=
X-Google-Smtp-Source: ABdhPJxkrMGow4MZGqEp0+HqC2m0rwpxW62tZY2aVrVe29WMAo/3HB87lCKyvIoJebeulC9AfsOObw==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr125369wrt.183.1603122294462; 
 Mon, 19 Oct 2020 08:44:54 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j13sm103319wru.86.2020.10.19.08.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 08:44:53 -0700 (PDT)
Subject: Re: [PATCH v3 13/15] hw/misc/bcm2835_cprman: add sane reset values to
 the registers
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Luc Michel <luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
 <20201010135759.437903-14-luc@lmichel.fr>
 <48280560-3642-5367-a46e-53548e77c748@amsat.org>
 <20201011182608.gfmfvdioiyyaxrfq@sekoia-pc.home.lmichel.fr>
 <473818a2-b267-881f-b827-425a384a27bd@amsat.org>
Message-ID: <98d573dc-1e43-17e8-97b6-6f8a869f65e2@amsat.org>
Date: Mon, 19 Oct 2020 17:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <473818a2-b267-881f-b827-425a384a27bd@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 7:10 PM, Philippe Mathieu-Daudé wrote:
> On 10/11/20 8:26 PM, Luc Michel wrote:
>> On 18:18 Sat 10 Oct     , Philippe Mathieu-Daudé wrote:
>>> On 10/10/20 3:57 PM, Luc Michel wrote:
>>>> Those reset values have been extracted from a Raspberry Pi 3 model B
>>>> v1.2, using the 2020-08-20 version of raspios. The dump was done using
>>>> the debugfs interface of the CPRMAN driver in Linux (under
>>>> '/sys/kernel/debug/clk'). Each exposed clock tree stage (PLLs, channels
>>>> and muxes) can be observed by reading the 'regdump' file (e.g.
>>>> 'plla/regdump').
>>>>
>>>> Those values are set by the Raspberry Pi firmware at boot time (Linux
>>>> expects them to be set when it boots up).
>>>>
>>>> Some stages are not exposed by the Linux driver (e.g. the PLL B). For
>>>> those, the reset values are unknown and left to 0 which implies a
>>>> disabled output.
>>>>
>>>> Once booted in QEMU, the final clock tree is very similar to the one
>>>> visible on real hardware. The differences come from some unimplemented
>>>> devices for which the driver simply disable the corresponding clock.
>>>>
>>>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> Signed-off-by: Luc Michel <luc@lmichel.fr>
>>>> ---
>>>>    include/hw/misc/bcm2835_cprman_internals.h | 269 
>>>> +++++++++++++++++++++
>>>>    hw/misc/bcm2835_cprman.c                   |  31 +++
>>>>    2 files changed, 300 insertions(+)
[...]

I haven't verified the dumped values with real hardware,
but for the rest this patch shouldn't introduce regression,
and it helps to boot up to Linux kernel 5.7, so:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

