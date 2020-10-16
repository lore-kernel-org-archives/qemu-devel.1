Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C395CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C7C2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrbDsP9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C7C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSuY-0008RD-TT
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTStH-0007t9-Op
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:47:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTStF-00048j-Sl
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:47:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id s9so3655702wro.8
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=twldNaDua8LrmQLu3cQqBb257P9KbU/NYFzcG0b9h3w=;
 b=HrbDsP9Nj2uMm34NnKPZKoDjsUv6KaY9yYeOyoSuZVX7d7lhjnTjBI3AxwhVfQT+zK
 aY/gv834vww+AFytXh3clgjq8ih9+AVaU87pEsl04uOpmKZA9hCCjk81UaLF37VDXrmM
 DaRVipkORJXj0TneBgYHiW2Kn5Br+5R9fH2cO2z0xHifg/Jpg/2KzyhA+I2unE5SVY55
 xR15BVmt5tx/BMgT3VrtB1bRalJmsIOcO1fSpPvjlgM2nH/cuM+o/ogb9DviwtegT95l
 xtWIk9Ifl+xnYrrk1AZx6lJQ2gGRwt2PUgdevb5uoHjpcNuWq8qxKB0fdtrxiKntyT3A
 ke0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=twldNaDua8LrmQLu3cQqBb257P9KbU/NYFzcG0b9h3w=;
 b=nZhVEb/fmv+W0h3Q/u31zaQneBNA6OtjybVTBW3x2odsO3UXrroyWTQ4sZfSygeTK4
 MVpbIfdUmcsygkIM11M8dlLWcTyJ+3F8eI4jNvZ9xStHJjwXCZ7ww8xVY1Qua4ry8M/q
 FFIKDoDlZdeiD76CUgA9ZgkWR8Ma2SGlW3Hs/50iR57eDOCz3MMUy3cCHYMT4gE7o4mg
 VW/VfqfLv4itmHtcUcCXSSHBO8MGavzmtcVyU9YJsupAqtR0zOWWN4M5ntuewfWvx8Jh
 6B+uAaMObBWjwgy7iXOVftPil4egMadtggylan2HOGKmPfs4fIZ8PtdFP2jBC0tuHEjO
 OTYA==
X-Gm-Message-State: AOAM532xgRGhfqr21RzhPKjfYEQrFCasuRpjK15xjk+F3AY+KNLOWUCH
 uKqzwPXShMYgpHwU9CPjiN8=
X-Google-Smtp-Source: ABdhPJy1lby50QtZwNVcCQTrDJMlPxQ2y9FleTp4FdgLzQL3DYEl94hE+TpK8aL13GFAt1heOAW8Ww==
X-Received: by 2002:adf:d841:: with SMTP id k1mr4928980wrl.227.1602866855976; 
 Fri, 16 Oct 2020 09:47:35 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q8sm4022934wro.32.2020.10.16.09.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 09:47:35 -0700 (PDT)
Subject: Re: [PATCH V14 0/8] mips: Add Loongson-3 machine support
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b7c64761-9d13-72ac-7b2f-8e33b235507b@amsat.org>
Date: Fri, 16 Oct 2020 18:47:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:51 AM, Huacai Chen wrote:
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, in QEMU we just define two CPU types:
> 
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>     suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>     suitable for KVM because Loongson-3A R4 has the VZ ASE.
> 
> Loongson-3 lacks English documents. I've tried to translated them with
> translate.google.com, and the machine translated documents (together
> with their original Chinese versions) are available here.
> 
> Loongson-3A R1 (Loongson-3A1000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pdf (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pdf (Chinese Version)
> 
> Loongson-3A R2 (Loongson-3A2000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Version)
> 
> Loongson-3A R3 (Loongson-3A3000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf (Chinese Version)
> 
> Loongson-3A R4 (Loongson-3A4000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> User Manual Part 2:
> I'm sorry that it is unavailable now.
> 
> And human-translated documents (W.I.P) are available here now:
> https://github.com/loongson-community/docs/tree/master/English-translation-of-Loongson-manual

Patches 2-4 applied to mips-next (fixing the
bisectability build failure in patch 2 & 3).

