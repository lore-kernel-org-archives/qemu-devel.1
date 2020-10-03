Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD978C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 18:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7ED206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaFmkKmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7ED206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOltX-0002dh-7R
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 14:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlsP-0001tT-Rt
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 14:03:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlsK-0005uh-Sb
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 14:03:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id s12so5216420wrw.11
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KDXSolx0PSGDUHmVSunRx3i8Isx5Fv3tlDruXZhT/VQ=;
 b=vaFmkKmvZkf+os2X3Pzry7f6aNrMoQwBt0GMYMYgjHCRJyJL+Lqd0jdyH4Fi3wfxaZ
 bAvA+k+Qb2AQAZ/mJP0P/mSGfcKWFpdgXJH0LdMGQq1MC12UHkvki4pVmEH3fVTg3sQT
 VFoq2k8JqVewnuje0HFs445hY0/pJkS4j1qu9mQeEoOvAnB4bRWfftky/vTo5lzNuKzI
 l3x/cClqc3PeCbZdDmY4BdvQV/82gIPP7Qa8/qTfZ4SkJ7KJqc8G8zu4NGZImBGsLp/z
 ZW0Khq5o3R8mciP7na55/ipsXU4Kumpb48uKznYO5Ww1eTIPdssSHEdnJwKSL3wV0zLI
 8MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KDXSolx0PSGDUHmVSunRx3i8Isx5Fv3tlDruXZhT/VQ=;
 b=fkXFer25y9AKJabicfIdJqnza59ajBgrsMDQYe3ql8sPfLDwGTvKZmZTv8WtS1Sojs
 ccxZCtCI8yDWIwEcCMduZdxbpaXqIodCrm+JRg/OgvfhYfcKjVc4auQKgUm5hZdZH1im
 gt6KOg/smOR2MDj15Yvs/ZPDU3qJUH9+UcCvyaxhdJkS7gkwT6O4JJ5xEbqD/Nb2WPuz
 P6+SroH74C+N0lWUTEFi5mu9aAQhyFwf0OW3OrH1P7KeMcqxUIg4rcQ0R+n9kV26sq9t
 eRUFbj2iLbCB/9wWA9gtst4Vk1Hn1Q/n74UM9UHB7OjInKxMfsRYObXnxYl5a2Zb9Pi8
 eEBQ==
X-Gm-Message-State: AOAM531p5LkOfa+Nlm90ykXOAYqlXZIUE6Jst8+0+IXpDQLWrhylYASm
 VLBHmhVhM97cHH34o4KdYP8=
X-Google-Smtp-Source: ABdhPJyrL4DvSeKz/vOYAmZARCwbtkZakw/q06ssT1n0FoaEVaeeWM63VKLfO7VDyHrHEWKb6zrT4Q==
X-Received: by 2002:adf:f207:: with SMTP id p7mr9761602wro.152.1601748195305; 
 Sat, 03 Oct 2020 11:03:15 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id j10sm6069230wrn.2.2020.10.03.11.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 11:03:14 -0700 (PDT)
Subject: Re: [PATCH v2] hw/avr: Add limited support for avr gpio registers
To: Heecheol Yang <heecheol.yang@outlook.com>, qemu-devel@nongnu.org
References: <DM6PR16MB2473C5A77E009CA2FEF3D8ECE60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <77f59e9a-861e-f580-57f4-72912ba2566a@amsat.org>
Date: Sat, 3 Oct 2020 20:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR16MB2473C5A77E009CA2FEF3D8ECE60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 2:38 PM, Heecheol Yang wrote:
> Add some of these features for avr gpio:
> 
>   - GPIO I/O : PORTx registers
>   - Data Direction : DDRx registers
> 
> Following things are not supported yet:
>   - PINx registers
>   - MCUR registers
>   - Even though read/write for DDRx registers are
>     implemented, actual direction controls are not
>     supported yet.
> 
> Signed-off-by: Heecheol Yang <heecheol.yang@outlook.com>
> ---
>  hw/avr/Kconfig             |   1 +
>  hw/avr/atmega.c            |   7 ++-
>  hw/avr/atmega.h            |   2 +
>  hw/gpio/Kconfig            |   3 +
>  hw/gpio/avr_gpio.c         | 112 +++++++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build        |   2 +
>  include/hw/gpio/avr_gpio.h |  46 +++++++++++++++
>  7 files changed, 171 insertions(+), 2 deletions(-)
>  create mode 100644 hw/gpio/avr_gpio.c
>  create mode 100644 include/hw/gpio/avr_gpio.h

FYI this one is posted correctly, I can read it and patchew
successfully applied it:
https://patchew.org/QEMU/DM6PR16MB2473C5A77E009CA2FEF3D8ECE60E0@DM6PR16MB2473.namprd16.prod.outlook.com/

But v3 is broken again...

