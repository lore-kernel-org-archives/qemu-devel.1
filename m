Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F3FC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137482078E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwH3vcfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137482078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPix8-0002TF-3r
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPiwQ-0001uN-Pt; Tue, 06 Oct 2020 05:07:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPiwP-0006HK-Bj; Tue, 06 Oct 2020 05:07:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id o5so12550549wrn.13;
 Tue, 06 Oct 2020 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PyxQtSv2w2q7ELER+Rv4ydmaKuPujU4mv1JYlTOYOs0=;
 b=XwH3vcfh1V55hBdhMxPx8UZzMqic6zD3Lwy2tvcYwi6TXMSFoRfFMJqgRQ6cMdlHYJ
 MCByY85QCrr7u1MtShvaagnZ5D43+2hj28Utiq0fV88EB2x6CPtGIXdYBPRqFlImhmEB
 Kcdm+vv+BU+I8ioOcCUnCHivDqIPJoyoszbpk46mK2LAhfO6yqJIK0ym1XdiZxL/kTkp
 tg/mzR0c8h1/6G/AvjPq1sO4zXOFWQBBEfcAbHJWFYevC+MPkaRIAJTAAxf6ZXMREzdt
 vvagZ7kPXIoFQD8Za3kUyMxmForU235mgfpjfRu9fTcn5+ug05RyZezkmfTDvHUQhLOo
 cT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PyxQtSv2w2q7ELER+Rv4ydmaKuPujU4mv1JYlTOYOs0=;
 b=Z1ldNkfrOrK0efb0VAJw75olQ0tGpYgWvTAQskVqHkG7yHItSlrqJVd1RlLhTm+M47
 +OYUq77pyc0uYCRLbldGJ43ijB2GdZvk8wWFfDz7VGOoCMmSzleOJMAOoO+9+Xe7ZLUA
 /hlZfy+u0TXl6XhjVNsI533WUhOl5zm0Y/gG07oL4fGs5eFbWh5PtfNlfp16j+h27do7
 B5+jr1LN5/gqbDZILbq62c++HYU5VmM0iQhJuIt0fTZWFCjBe6hVZZYm7RrgceljryLl
 zQKoTosWBWlVrATviDKCg0MADbUTW5y/7+fh5fWrjbfnnI/Y3cVKgxZdTePlGz3b32iB
 gNtg==
X-Gm-Message-State: AOAM533fyO0aIWwGnBKGC04vWBYRxmYu1bpqiq6vcBkF248PmGRDCg5/
 IIp5+UDEpFhHWfGUymrVn7M=
X-Google-Smtp-Source: ABdhPJypGT+n6rxlkc7Vw2fKIVHQ5rDDJAqmKfDGFKo3LbkmwrzpBtthKLWqQoeYNFtxoyjbMsJwug==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr3784125wrn.228.1601975243843; 
 Tue, 06 Oct 2020 02:07:23 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i1sm3361075wrx.44.2020.10.06.02.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:07:23 -0700 (PDT)
Subject: Re: [PATCH v2 09/15] hw/misc/bcm2835_cprman: implement PLL channels
 behaviour
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201005195612.1999165-1-luc@lmichel.fr>
 <20201005195612.1999165-10-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3f1034d3-0ad7-e947-5bce-a54a95420606@amsat.org>
Date: Tue, 6 Oct 2020 11:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005195612.1999165-10-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:56 PM, Luc Michel wrote:
> A PLL channel is able to further divide the generated PLL frequency.
> The divider is given in the CTRL_A2W register. Some channels have an
> additional fixed divider which is always applied to the signal.
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  hw/misc/bcm2835_cprman.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

