Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB3EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0182320715
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6O/x+u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0182320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwIR-0004pV-0W
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZwHq-0004OA-RT
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:23:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZwHp-0006M3-4M
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:23:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id x7so18569099wrl.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 05:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1FwjCa82Tdvz+cWcIxz1XDYedLeG35UKV/s9INW4R80=;
 b=t6O/x+u0O2EQk4GWmhW32q8ZVv8Ljk+HEG/Gg1wYo1Y2Q4daX64PcgrTvkJd4Er8BL
 Ddl32TDfDBw8FKGX9o36ky3AEYcuAI1Yx+3qQDNd2Cih/y54uWXIuw7IzdLjRleKBGJd
 /ZuTrZo7vkW7/IjFMLY/j+eua3kOZgDMXj3Vx5tnOqNckX4cQMvNooOBUAfEsFIQGUOM
 6H2CnB5F2kxbsAm47MQRpZsfT6/wY2clhzvnNM/0WmOEQGMPzwYqk1DhAIayqeet2Ef/
 PwuCbJu1X0C9b6W3D3qQ7wGv+/Zmxs/qjmLbEAlHduJDnxzyrmz1kxxClQg1LdF84uhP
 ORJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1FwjCa82Tdvz+cWcIxz1XDYedLeG35UKV/s9INW4R80=;
 b=AOQ0FFb+RgveeJNOzhorFRvalkmPaR9URlQwm9TwfrOiA3uoVHEn3kR72BuXUhxwi2
 NYRZK1WkQ5SQkfP1uvRwwNXHjMAijlnnGK45ele56a+Z7veoOhYSrK62u1Yp17KRW0zs
 8FQhRKqjsXKTQmI4Q0xji0nd21wmdb1X5oZyd9bwU4LHi9ZmwydCKXup1eyhvsJL55DG
 eEt3eJ+09JbXabfn+4Oq28ZTGCzayChWPQmwMHfz8aH7k2qRfmVaZS8ixkOU8hznM4ml
 UDRV7WbtwFwIQH98oes0lycxOt2o8NV1V9sor41HZUhepcNTYEHYGbRcVU8AE7W+p7AT
 exAQ==
X-Gm-Message-State: AOAM530gEogA56As/UyEJJ6miIvqalxhB+061A6q+7pyuSsRObep1GlV
 juadpPrFIaVdCF4VM+2a/Gc=
X-Google-Smtp-Source: ABdhPJw//EliuyFhNLxibcnA4Ty9WiluftdC9SZXX1LMDpm7RJuVrars2qi598xNU+oJU8ptT5F/Ag==
X-Received: by 2002:a5d:51d0:: with SMTP id n16mr25633468wrv.43.1604409822748; 
 Tue, 03 Nov 2020 05:23:42 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m12sm2729389wmi.33.2020.11.03.05.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 05:23:42 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v3] hw/mips: Remove the 'r4k' machine
To: qemu-devel@nongnu.org
References: <20201102201311.2220005-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b69dd40d-af97-2922-52a2-2fd411a07127@amsat.org>
Date: Tue, 3 Nov 2020 14:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102201311.2220005-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 9:13 PM, Philippe Mathieu-Daudé wrote:
> We deprecated the support for the 'r4k' machine for the 5.0 release
> (commit d32dc61421), which means that our deprecation policy allows
> us to drop it in release 5.2. Remove the code.
> 
> To repeat the rationale from the deprecation note:
> - this virtual machine has no specification
> - the Linux kernel dropped support for it 10 years ago
> 
> Users are recommended to use the Malta board instead.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v3: Move to "Recently removed features" section
> ---
>  docs/system/deprecated.rst                    |  12 +-
>  .../devices/mips-softmmu-common.mak           |   1 -
>  hw/mips/r4k.c                                 | 318 ------------------
>  MAINTAINERS                                   |   6 -
>  hw/mips/Kconfig                               |  13 -
>  hw/mips/meson.build                           |   1 -
>  6 files changed, 6 insertions(+), 345 deletions(-)
>  delete mode 100644 hw/mips/r4k.c

Applied to mips-next (with the change requested by Thomas).

