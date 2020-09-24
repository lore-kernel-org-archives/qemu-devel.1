Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED51C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7E42395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF/n9sQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7E42395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPMf-0004LI-0Q
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPJY-0008Q7-GS; Thu, 24 Sep 2020 07:21:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPJW-0004KH-Fo; Thu, 24 Sep 2020 07:21:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id y15so3210698wmi.0;
 Thu, 24 Sep 2020 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5yo252NP5gBDkXbN6/NBxZR9g3mZ/MmbyKBXikp+NFI=;
 b=cF/n9sQOZvDjqggC0chbJQEu3M6YCOssqdDQr66p7QU0BGDPhAQoGq7+h0H5BCuhrb
 KsPPpy6tp26JXyzReSOyJfkFlWaaAb090ekTWt/+YWof0tWdbYEiwh4VAlVPJAArknIP
 /jRWkLSxg3XEvIMd+54WBuurNktXz78q5XFD8NDWiS862BUcdXDQhPcsUqvbqWZn3Jxd
 AWlfvbHYEcijs1172Nb9ZmLGbP5DzTG+YlLrrs/D0hBX9AKMBTOV3yjt8DQvM2h+KFFi
 k7jufQX0dhPAiVICiXnZKVvDhTbyg3QWL2t8Y+lALzQV+5fhbremYUMbAIv3Ml/05mJB
 VnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5yo252NP5gBDkXbN6/NBxZR9g3mZ/MmbyKBXikp+NFI=;
 b=ndpusKQdgS3tfEToUMKB5LeJXr14vj1TGKXVtRo/HeaBDYN07hTFYklF9nyUevPfHZ
 6Xcr6RTTNdEIQNzn2at4J2TOGIBANEesgnuD32qcLvTEQ4OfRIbtxgITAkhwA86NlAYj
 Qz/coC5UHXr5XcdlB02Fip2kpAV7MSRNzRqSN+5Mpy+xttx3h7VYJPzLANphE/CTTSIk
 JJSK6j5lhV76O2H3MWpIUPvSye8OYSQLV40SRu+xLdJP6vQLGbAOQg48dDPGMMZ6XCQ+
 OxT5mc/0Gs2ADNvPgQS7/x09hqQvQvVAasm99d3MPdbYzV5gSO44KyfYTZT5xU2RZJoR
 7aDg==
X-Gm-Message-State: AOAM531V/oBJKEkMAqY/55Q9D4+xnL55DfhcFX+nLl0HbALmBfgz8xKR
 0+ItT4lu4sCq8L7hpSiVJ/g=
X-Google-Smtp-Source: ABdhPJxrC8iNMR34XLwGhS+CM52uP9Yt0PjY2Du0Lk4wHjzY4GliWRO5D4wTokgnl2/1DjF9osyIeA==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr4096204wmk.97.1600946484941; 
 Thu, 24 Sep 2020 04:21:24 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id t203sm3230662wmg.43.2020.09.24.04.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 04:21:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] hw/arm/raspi: Fix SYS_timer to unbrick Linux
 kernels v3.7+
To: qemu-devel@nongnu.org
References: <20200921035257.434532-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <80c32945-a83a-1c8d-d2df-5d8c832bf0b9@amsat.org>
Date: Thu, 24 Sep 2020 13:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921035257.434532-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 5:52 AM, Philippe Mathieu-Daudé wrote:
> In this series we implement the COMPARE registers of the
> SYS_timer, since they are used by Linux.
> 
> This fixes the hang reported by Niek here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg682090.html
> 
> Since v1:
> - Extracted unrelated patches to previous series
>   (which happened to be mis-rebased)
> 
> Based-on: <20200921034729.432931-1-f4bug@amsat.org>
> Supersedes: <20200920175825.417680-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (5):
>   hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
>   hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT definition
>   hw/timer/bcm2835: Rename variable holding CTRL_STATUS register
>   hw/timer/bcm2835: Support the timer COMPARE registers

I'll respin this series trying to address Luc's comments on patch 4.

