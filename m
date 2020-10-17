Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A52C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952C5206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okecpkY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952C5206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTiRW-0007ED-L4
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiPB-0005s5-FP; Sat, 17 Oct 2020 05:21:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiPA-0005zK-4D; Sat, 17 Oct 2020 05:21:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id y12so6100035wrp.6;
 Sat, 17 Oct 2020 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IFCxnRxJ2KVtRrrQGtS0TCnpi38BVuwKqO1E+T6rN3c=;
 b=okecpkY8gfg5fHpSRVDEDfPZ93aKBNFwrfxAOJzZbu2IuAqB+74cs7fSBc8yhqf1nH
 8DKzzxrOCO4tDyHw0Wm/XfSls5rFu2fdS2V0/pDSaDVWaGX+x2KGHuCWX2o8cxfa25Kv
 0NbCHxDW8M0ge4XnxNPTJDFev46iyvFLfQLFwDu6YqVWplj31NXP/eHifW0esF8xhC6K
 pjRwbgjyqr5k/mvKnDmLsyLt7z0VA8yjrQi3PYymF8HoLFhTJRnqRBH7JGegtjI8KUA+
 xvqqihHYn5ZhSAo/C8fsLUTDvnHUgf5xiB70pnKIUB2WyKhzB3px/bCNW+U9GesEkIEH
 DVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IFCxnRxJ2KVtRrrQGtS0TCnpi38BVuwKqO1E+T6rN3c=;
 b=um64oSPXsoxrCWZ5PgAd/itMIPVWn6nl/BaY2cdP97safy74BQIX5FlXAApd/6C93u
 eWB+NMW423vuTfb+fZhUdEbSIuUiXZtNb5SaNHJhM+0ialNtIjwDU11OLVd4HwJzpt23
 UVWur63bqGdkGSPWrfawfXQ7zpjm8Ua5G5mpkBSgHa6yMbfnXTXkV9RoOKrBboBnaWSG
 6mv8KET+v44rO5k7vRagiyvxUbaJ9FGUKH6rmkgDJaOLzpOvE0AOJAuFfFXw91RFeK4p
 kAIV43DbHGDVsOXWPQ3IVvT1GnypXkIUylpp+OCntbAGTU0Je136tE0aiifHufpvCc7/
 gW2Q==
X-Gm-Message-State: AOAM5310uUzUd6XaG+/KpO2RNUbJxaNWf0ZYRL4xmXEdTsO5PbOoywLK
 NJQyAaNz0zgRFp4xxRYVDBg=
X-Google-Smtp-Source: ABdhPJyHzMQOPPQ4QCh0uQHRWBw8HWJPd5Vi6yhCO6qmTlB8hkNFg1LkCeWq8F2b7hw2zJreA0c4dw==
X-Received: by 2002:adf:c045:: with SMTP id c5mr9066795wrf.405.1602926494437; 
 Sat, 17 Oct 2020 02:21:34 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id m14sm7781294wro.43.2020.10.17.02.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:21:33 -0700 (PDT)
Subject: Re: [PATCH v11 08/12] linux-user/elfload: Use Error for load_elf_image
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201016184207.786698-1-richard.henderson@linaro.org>
 <20201016184207.786698-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a49da314-d0e2-279c-a3cc-061d755a47c4@amsat.org>
Date: Sat, 17 Oct 2020 11:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016184207.786698-9-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:42 PM, Richard Henderson wrote:
> This is a bit clearer than open-coding some of this
> with a bare c string.

c -> C?

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

