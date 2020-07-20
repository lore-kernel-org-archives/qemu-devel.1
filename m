Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561E6C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2493D22B4E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1QgfKq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2493D22B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaqq-0006sQ-CA
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxaq4-0006R2-3C
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:48:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxaq1-0007Ou-LS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:48:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id o2so519234wmh.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JQm0K31MZJouqsJl6ZLuXhcu8K9f379VaOClUICnFm4=;
 b=B1QgfKq3I8ye/chrGvA9Y9XP/ftFfxLbhypmyMVcPhWMIM1fqd2vdcSWP6QuAIuF1H
 9+ALvYdGPROO5ebiVv/UF01j20rrIx4Nk7RkctdCMpSQHHdxqCDccoVp3eS5BvRNCfxg
 F33EsUBzEF3fMEo7GhgQdRXXZeROqmsIonE1sJ2o1LRtiypPqEIEUJtYAO0qBvqabUYb
 51dYhiB0gcMWt28tHrRq1QRQmPa7bsjtS7JmdcW+ZaGtzEw1E86qK9s4X7cap4uV5gI6
 eEBIp70W8UyYfLmzZP4aG6hxZJ6uzM6j0TUt+pDCrvXJV/l1jRNHN+rrICUm9zLVb+j7
 YuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JQm0K31MZJouqsJl6ZLuXhcu8K9f379VaOClUICnFm4=;
 b=bsS4KxU2WpeGpG5IYoGbeL1yQHR6JYxULPyjI6zCSWj704dVi2dXIfEVUDngO0yExm
 Tmy7Apy9TxDRpgcSRT/xBkjOXimDy+U9qvFKvCi6C+twn/hgbxqtOvCRRS9Q2QDmhCAJ
 q4fnQknkVl2hifIRyTTQhXOVxENYZV7XtBFYf+hMPoS54b10p0kuK3kC1sMuKjqsuINI
 A/YF/ZY42j245hNfzHOBd/d+figum79piZvY2dy0FeaWab/00kuZU3A8CFP6Vs70YA32
 4o8jP3eGSl3pJTB/BBxojaVGjBlBVrAiZNTePvAS7tY5KkJ1qUocX/zMvAGhmuGM5dPm
 PVNA==
X-Gm-Message-State: AOAM531oYcnUxwOyXK1MsN3KrfedItRozNlK8jKpSs0hl2FLv8sFZPMq
 fPkV+t27sbkvOmoyjdhcnXY=
X-Google-Smtp-Source: ABdhPJz8zYCwyxe9Ue2B3Unvru0Jrd+7Vn1g26ZLVd0Z/T6uxhgxFTwdhewkAOZm+xlj8mwA0tLAbg==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr606150wmb.108.1595270911995; 
 Mon, 20 Jul 2020 11:48:31 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v15sm14442759wrm.23.2020.07.20.11.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 11:48:31 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 0/4] misc: Document qemu_find_file and fix memory
 leak in avr_load_firmware
To: qemu-devel@nongnu.org
References: <20200714164257.23330-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1ce0d86-c1bb-2f49-b8bc-00f299ed7424@amsat.org>
Date: Mon, 20 Jul 2020 20:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714164257.23330-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 6:42 PM, Philippe Mathieu-Daudé wrote:
> Fix the memory leak reported by Coverity (CID 1430449).
> 
> Philippe Mathieu-Daudé (4):
>   qemu/osdep: Document os_find_datadir() return value
>   qemu/osdep: Reword qemu_get_exec_dir() documentation
>   qemu-common: Document qemu_find_file()
>   hw/avr/boot: Fix memory leak in avr_load_firmware()
> 
>  include/qemu-common.h | 14 ++++++++++++++
>  include/qemu/osdep.h  |  5 ++++-
>  hw/avr/boot.c         |  2 +-
>  os-posix.c            |  3 +++
>  os-win32.c            |  7 ++++++-
>  5 files changed, 28 insertions(+), 3 deletions(-)
> 

Thanks to the reviewers.

I addressed Daniel's review comments and will send a pull
request once the testing succeeds.

Phil.

