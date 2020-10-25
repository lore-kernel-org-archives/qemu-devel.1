Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCBEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D01022281
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLDNwbGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D01022281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWU4r-0005U4-3A
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 20:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWU35-0004RE-7G; Sat, 24 Oct 2020 20:38:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWU32-0004LD-6u; Sat, 24 Oct 2020 20:38:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so7935545wrp.10;
 Sat, 24 Oct 2020 17:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=awvEMETiDyhnXgiD5Vw0L0ViDi2WZ3ytfZCpSfo3mgo=;
 b=HLDNwbGPtUVWWgSAsLwti4PEvXprlNCRrs6eHpiZ7SwI3g08VhTN+WaRqXu0z+dMh+
 mPIGgRXXNjFA99PRAAECjl+teZ0dtYF4yEeW++v5+PYDmHs76kDVYbzV/uQgZY2FVJb8
 emziP0gN60Sp7jzx8Ub1r/FqQlw4H6XjaAMXqtRvHhwa7A0o5lw/1dpISFQDvjz6DjTG
 jpoT3qSH8CKEZ591+elXsEXVisHHTwwzfcZx9us/woLtM10taR7YXIsIadHRdr0uNJB0
 HyGgGnS2YTUuVT67l8Cjj193gQppYRvzKKXdcncG7/NI7/ou0qSPj2+ZUoD/asipzJpR
 ny5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=awvEMETiDyhnXgiD5Vw0L0ViDi2WZ3ytfZCpSfo3mgo=;
 b=Ooc8zzVYfAFLk30z7uyCKOtqUxVZ2kErAL3eoYOrSfyCk2XdI6FdwBHs8Pzgmz27Lz
 zIZmUwkIJfXESP/JyhHVqlZbbgJUdr4pM/LJkDt7/7nHZXIRMNmHCESvBKOR2xyu3koC
 sYHP/P2Rxdkyzb3uLOIVPJ7Epsn15st0gC1z2VNbnKcqcQLhg67u1LIlS2SBpd45BDYs
 99bhErGT4Z6ihWUTtVmSFrzIWhyhYct9Modr0hRtB0BR1DBck7dYB5bnaYKXtvHVsDMb
 i9oV9dyHGvnGuepkJzH1uKbaEZ+1hIK1FPjEo9UBHKgcygeq7D1UKdaVlFif8h/LTcBK
 VT8g==
X-Gm-Message-State: AOAM532SWPVAm36my6/vglND/kgRNDy5OIO82npB74PqUiMx/VmbrruN
 l6s7ZXzHM6JkyvaEoc61+Yai/B5T6iQ=
X-Google-Smtp-Source: ABdhPJyEgCziOtu3KRut1d7U7h7u0WDBh019VTZOok6jNKswQqJlqBqoXRF/KFhC7+mHE/dqyrYoAA==
X-Received: by 2002:adf:f1c8:: with SMTP id z8mr10886650wro.371.1603586289775; 
 Sat, 24 Oct 2020 17:38:09 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m12sm13956223wrs.92.2020.10.24.17.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 17:38:09 -0700 (PDT)
Subject: Re: [PATCH 0/3] sh4: Trivial clean-ups for sh_timer.c
To: Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20201020153935.54315-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3fd64128-b8b7-a3eb-fb53-4eb2874f88b9@amsat.org>
Date: Sun, 25 Oct 2020 02:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020153935.54315-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 5:39 PM, Thomas Huth wrote:
> Fix coding style, add fallthrough anonotations and remove superfluous
> break statements in hw/timer/sh_timer.c.
> 
> Thomas Huth (3):
>    hw/timer/sh_timer: Coding style clean-up
>    hw/timer/sh_timer: Silence warnings about missing fallthrough
>      statements
>    hw/timer/sh_timer: Remove superfluous "break" statements
> 
>   hw/timer/sh_timer.c | 90 +++++++++++++++++++++++++++++----------------
>   1 file changed, 58 insertions(+), 32 deletions(-)
> 

Thanks, applied to renesas-next.


