Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26814C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329FD20848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYLXnCKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329FD20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQAx-0006LC-Vn
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQAK-0005e6-Ey
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:53:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQAI-000462-9v
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:53:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id n6so2990951wrm.13
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xMK0t6TeyEe4Qw1+W+q10+gx11+GUXy7AA96Roe5+lg=;
 b=eYLXnCKpnCb9ExOsOSvl2Ru+R8LLxQPzgOTns4KBVd8mTtdGv6MZjsmtFxJ8Bh2iwC
 svZWVb8aNz1YNKW+51Rt+WXSGV3SyXjezNa//DthsS7CndYl6hYNfOlUe/bCq4ZjZ6dS
 nZTN91kJ2vcGNF13WSWKe8230v/6vqtHIJWz02Bv0nvcsOqBCzLLZkxGpym1Ubk6JyRT
 oH081eQ+IZI2LLh6+QDD+OWCPG2dZXbZuhGQEKZcSvDJVF84VwhYHbmasMAqj8LRrHQz
 TaC8UhrK7tn8szdFKOOXnvygCziTtTM2z275wYUopZMxrdXjCNIzrbXIlpm3VkL/sZ7n
 J/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xMK0t6TeyEe4Qw1+W+q10+gx11+GUXy7AA96Roe5+lg=;
 b=i+SS99ZLuuehZLUoPJUqhIpwf3jJJ6qH1ACaF8+ZPklkkleCP0nzFeMXui7a2Ppr5J
 ZgT7lKrUGsAROi1YBH/t4HZUPNtDojvtl433G6+yIP1R20dI3tzuE3y4OrGyMTP8ehmd
 x7xhaGxLtRFH2aN5Yi9D49kk7UMZrBas5evXjnONbSaner8sHMHd1Eay5hHT3B0S1S/q
 mfPlxAOgf9fAx4ETnSQR7biS7K57alu3+E5+vY2jFA0Miew2q6kvfjnX4LCznSK7OKaF
 4A9zNPViLonx0ry7VS1BNk5Hk14Am17pg3jkRxhe6uotPtQvfWZIXJd3T1qEi79lCUX7
 Lc0A==
X-Gm-Message-State: AOAM53304z6D7Xjm6zi29ObVadn5swdaa0Of7A5sXBziVkNwW47hHYI1
 VWukteTElqfhSzXgwhtuQAY=
X-Google-Smtp-Source: ABdhPJw3NkN7/SGxknYksjCBgNEMM6mn5ebTXt7qwCxmCKh0WM86H3lRbl7Kc7cZQF+kdRJesBUtaA==
X-Received: by 2002:adf:d84e:: with SMTP id k14mr4368091wrl.251.1602856380901; 
 Fri, 16 Oct 2020 06:53:00 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id e25sm3967616wra.71.2020.10.16.06.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 06:52:59 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/mips/malta: Minor housekeeping in mips_malta_init()
To: qemu-devel@nongnu.org
References: <20201012160503.3472140-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af2d6e60-d191-65b4-b799-ce9c63e0a16c@amsat.org>
Date: Fri, 16 Oct 2020 15:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012160503.3472140-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 6:05 PM, Philippe Mathieu-Daudé wrote:
> Move some code around to make this big function
> easier to review.
> 
> Philippe Mathieu-Daudé (2):
>    hw/mips/malta: Move gt64120 related code together
>    hw/mips/malta: Use clearer qdev style
> 
>   hw/mips/malta.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 

Thanks, applied to mips-next.

