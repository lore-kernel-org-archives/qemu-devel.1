Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F07C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADAC2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj8kHuoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADAC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTihE-0004Nl-HE
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTigI-0003k5-Cl; Sat, 17 Oct 2020 05:39:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTigG-00083z-Rp; Sat, 17 Oct 2020 05:39:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id p15so5661619wmi.4;
 Sat, 17 Oct 2020 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DG/mHxFy72iLh7lV6DZxizL3gBRPOusXWa/XxHmKS7w=;
 b=jj8kHuoVjMGhq6YVYJAuJwBtCm4BuDiV6FgiwTqqA2si6U/sKet8H9uOxEj7zzgyFV
 AfN191xy6Tv9oN9JmvghxhwQdi3UW/VSbptpNtWZyuw6DYzKwUX41NnWgirxhY0ayjz+
 mCSxfjeVshoRVq6whIIjmEnHYy3/uEAUmtgtmuRJAUrxhbofmBZ+VIfCmOzP9vpziUMH
 wBq9thKH7LLRO7DWSlvc0pFtUHlW15jIGrXAgRSy3x0nDcZ9vrVSrFt8cXexFSUy1dh/
 8h7Luk2NY9LOy/ffXqx1N6xm7FZ1HrHDQhg50VP4fj6N5dVk4F27sBfbjMCp5H5NhpwX
 9fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DG/mHxFy72iLh7lV6DZxizL3gBRPOusXWa/XxHmKS7w=;
 b=ZUn/69zkPWjZ4/lZQMoK0WjaPRPutSqUH3jtZTMQAceY6htri8CfXOPwKZOkas3tqa
 bFMpokaSj+nLpFhMLkotaQ8eejlehoj0KtsRRP8AZXKoS/lhtgyJsBWmBrhhP1W2Iqv5
 LH1bMxTHd924PPTa/+Ag9wkSY3rHVxbQbYS8NoWJ/w2vigO0EdM5afFPysyf0fLKngiZ
 C5xPZiJNPSmHhZcrku2hJrVfK/5cjd0CSUQctBwA1DPBZ0nr8/NjuUaj9TqbpsJtc7nI
 Ml5pGbMa6RWpAeFWKpwnrz+SAEIMw6rZTvwFjRgRM4NelGQFwitzlweXJw1b4hlCN6jy
 l/1g==
X-Gm-Message-State: AOAM531ozM46JC2Hwj2bgE/ZwSEGX5vBM/j7Cx8gMoS1QDUPJpenKUC3
 z7m7kIAuWpW7rv0o41oNiVo=
X-Google-Smtp-Source: ABdhPJydVarcofMBIfKNxApw/2r5V1yYNY4CWLfhcigsQIBsBmSzCdv8f2Qw4ttfJiCHoY2EibDOkQ==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr8170810wmi.73.1602927554445; 
 Sat, 17 Oct 2020 02:39:14 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id w1sm7400564wrp.95.2020.10.17.02.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:39:13 -0700 (PDT)
Subject: Re: [PATCH 1/5] m48t59-isa: remove legacy m48t59_init_isa() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, hpoussin@reactos.org, qemu-ppc@nongnu.org,
 atar4qemu@gmail.com, david@gibson.dropbear.id.au
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b49c1654-cb13-281d-cad9-b476da60635b@amsat.org>
Date: Sat, 17 Oct 2020 11:39:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016182739.22875-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:27 PM, Mark Cave-Ayland wrote:
> This function is no longer used within the codebase.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/rtc/m48t59-isa.c     | 25 -------------------------
>   include/hw/rtc/m48t59.h |  2 --
>   2 files changed, 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

