Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672EFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3314B20723
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk4764nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3314B20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVZa-0001Yh-Eg
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsVYt-0000zi-Rz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:09:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsVYs-0002L2-Bl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:09:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so40283023wmg.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Zngs2aG2ld+DTQgWkdW/qyxjZ8VzVKq0MX9d8BTI+ns=;
 b=jk4764nwNruCaL0gjPeE9rFOvaV8EDnZNYWZciPMZycXBheoNLsXAT6Xd9PjcF/kUJ
 X6qi5NlbLRNR7WAqRyWGPou1LCRtwMn2Ay0EmKillAvL9rmhKZ+ApDH4RmMnLsCXtcb5
 lBtzdwGlPWXlAY2JCmsVH0CuS/xVBNz4odVwGH6jCRsov8/Ac9hIr4t2oNqFcaLj/J7B
 Q1JPPWJZc9dJO95qazKfMzoT7WeF5d6I7QtJ+Srqe0DcVaV68Ivqs4rfmZ5xI73KwCw3
 yVHpM7AkAteqq6K15dLI+g3wqZuMkPfsB8jTQwwEg1D3U7EzKlrO7tSBJwzvwCJwpRnl
 A6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zngs2aG2ld+DTQgWkdW/qyxjZ8VzVKq0MX9d8BTI+ns=;
 b=jax9fyL1aq5zAFRV1Yw5373Gzsu+eCHVZO332cQwe5Ag6pe7Se64yHlMY/kSU8QFQL
 0h04+J0s3Ih33VJ+khgDGQLXQV4F/z0zEnaGnwQt60csYbm5a2bMAj+sQhjw9xIjQY81
 0BSsJmZhhU/APDAz6fTqiKHGupUTdnTvbIOwNaW73GQw8e/pCHXyCxicgtne4tFQU8WJ
 34RawaKaChAzMlMoRUPGrG/M6FCiMRYx7DQ6TqGh4XfvNwJGPjMxxY5PrrygJnP4qhJA
 Qr5ynY7vpq3kMgI9CnvegDDOwImvXFKy1phsyIqEiqH2mBXXTi3eVctTCAss51jYW/dk
 lFiw==
X-Gm-Message-State: AOAM532ArxKU2IwuOllgmG4Zj/xYGOR0W3ndu8jTCoGfwlEIURNDExRp
 PxOYgcZNawIfiM5qOpUlbgo=
X-Google-Smtp-Source: ABdhPJx4ZYdhmBrScy7y1cmkezOj+7zwjU06yup0Zsri52+ft6rFpDuQnKXBB+4lZauT27LQQZNeEg==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr418351wma.13.1594058988961; 
 Mon, 06 Jul 2020 11:09:48 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a123sm294369wmd.28.2020.07.06.11.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 11:09:48 -0700 (PDT)
Subject: Re: [PATCH 0/7] audio: Spring cleaning
To: qemu-devel@nongnu.org
References: <20200505132603.8575-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f516d99c-1816-674d-3f83-ad8b6a55bfb8@amsat.org>
Date: Mon, 6 Jul 2020 20:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/5/20 3:25 PM, Philippe Mathieu-Daudé wrote:
> Cleaning old branches, salvaging what seems worthwhile...
> This series is from the time I wanted cleaner buffer handling
> to avoid abuses, started with chardev/ but got lost with reviews.
> audio/ is smaller, so easier.
> 
> - Convert various prototypes to use const buffers
> - Expose 'audio/audio.h' via public include directory.

You didn't commented on this series.

We might use a LPVOID in dsound_get_buffer_in() as suggested
by Volker but I don't like it much. What do you think otherwise?

> 
> Philippe Mathieu-Daudé (7):
>   audio: Let audio_sample_to_uint64() use const samples argument
>   audio: Let capture_callback handler use const buffer argument
>   audio: Move advance() helper to 'audio_int.h'
>   audio: Split advance() helper as in() and out()
>   audio: Let HWVoice write() handlers take a const buffer
>   audio: Let AUD_write() use a const buffer argument
>   audio: Expose 'audio/audio.h' under the include/ directory

