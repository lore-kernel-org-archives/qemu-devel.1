Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919CCC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A85221E5
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVAOqzSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A85221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMZWC-00082f-6T
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 12:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZVI-0007dE-9e
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 12:26:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZVG-0003Wp-4y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 12:26:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id y15so4289857wmi.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GNfW4oAKjRhyM/aTs3ggZZgwZkoHnX0RB5M3yq/L2bs=;
 b=kVAOqzSIHbl2Bm9NnxcIN5b3oIzhgAdhURcr0Q+JSUWupBHjV4U14Suwi+fljaWPkb
 cyWvuvi6vOYO5RKPGDQFF+GgY40ZIUhj+j5ImccFVv9QpRlk6cFN7cZXJW9wXWN7Gwj4
 1ZXii9MfrDFRH4DXzo8T5LaWpJ89CEMiU15Vm1PU3XJW63sCsoGSNG/zKZYmmvo1aS17
 2GLERV9RTmhkSaE5q5MKBnU7a8b7Iv/aeM8zH42kYpxnGTZ1PUVVOu45iqLGexaz218o
 LUydNOTj4FEQs6oj9dwBBrr0zdNtcEUSb48DvKu2MOnMf5sDQ0T6Ky7Ogmu/hIJoivRX
 x+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GNfW4oAKjRhyM/aTs3ggZZgwZkoHnX0RB5M3yq/L2bs=;
 b=uGQITplMvC6mFRSSPbgSMG963AVO1CLXnemW9sUpLxelbbgCZwLa+vmSGLDZ/K5Ffk
 UQyXj7whzQLT9EYAn5uDo3DpgGS8bfUodTzssW0xNEkOLS91RaZYGj7960uz/S0u7UZe
 b/fXvLAO8Re3Lc5+d7VOAZMJcSKAhOrGVIYv/b7fjsccmNeU/KSscN0Tbd0yA3U+dZYm
 9TB9a6RxsUdL8HOeYIPXdCpd25sHtHCi0LmwYtSzXhv1b9IMeK6QCcsDodSOBIpHzobX
 Vp/sgHsybiLo/T8brNaHOCOCVQLqHcLP0DTiyI8ksMFP8YBwbMHN3vylIPVP9iXVKWW5
 XkcA==
X-Gm-Message-State: AOAM530fGuBU2CPaUgTCeYPnJnRdrlsgeeDhkrT8LgH/59aDofFRhVzm
 SOtojXTaSiE3UB4X/rbUoLM=
X-Google-Smtp-Source: ABdhPJx+3kPfQNd9v3zd1uNeqAvYB8zTpqVIiInhlZEk1CBUhBRgf79p2nmcIR/jxr8XHRgBLxlDtg==
X-Received: by 2002:a05:600c:414e:: with SMTP id
 h14mr7445202wmm.2.1601223980295; 
 Sun, 27 Sep 2020 09:26:20 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k22sm10426116wrd.29.2020.09.27.09.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 09:26:19 -0700 (PDT)
Subject: Re: [PATCH] hw/mips/malta: Fix FPGA I/O region size
To: qemu-devel@nongnu.org
References: <20200905213049.761949-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3a222af6-593e-559c-0239-40099bb03feb@amsat.org>
Date: Sun, 27 Sep 2020 18:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200905213049.761949-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.078, NICE_REPLY_A=-0.011,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/5/20 11:30 PM, Philippe Mathieu-Daudé wrote:
> The FPGA present on the CoreCard has an I/O region 1MiB wide.
> 
> Refs:
> - Atlas User’s Manual (Document Number: MD00005)
> - Malta User’s Manual (Document Number: MD00048)
> 
> Fixes: ea85df72b60 ("mips_malta: convert to memory API")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/mips/malta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my mips-hw-next tree.

