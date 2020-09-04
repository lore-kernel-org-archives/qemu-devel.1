Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDB8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129A320791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIpHP1sT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129A320791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE7z4-0002i3-TQ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kE7xl-0001un-0L; Fri, 04 Sep 2020 05:24:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kE7xj-0004U1-Fu; Fri, 04 Sep 2020 05:24:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5so6010732wrp.8;
 Fri, 04 Sep 2020 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L62gDycH2jfiJTmi/B6DChJ2nvGaA1pOjRrC62xMfHM=;
 b=dIpHP1sTezsXOwwHfyvgCzbEcVTv3qzn39lNiufn2wA/sQrYjrNhnNPhyCAWlqHKgu
 Cq5xY/OemNL83qL8p2uxw6CVUfhd+/z1w7hmlbcdz9qZcUDLmpFkvhtiULK+vrkEnxOC
 HpuwNLz2jpQuEtT6IYOcUQV+e6C/t9OOT9ZQ7+C9lwhlpL3YghcmeLZCXKNubek/PJq5
 Wwrg0XRSuS5slxIC7H63MXkGxUhV72rvFjHBO4AsbwsK9xIH/If+M9BW8o7Of29f9u17
 jy1hdW0Z+xXrFswRHDUi0jA8ouielDzz/4Kufj8Xgn5wV7Y6TfE38ZHvpQVNdNFKpJR8
 mAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L62gDycH2jfiJTmi/B6DChJ2nvGaA1pOjRrC62xMfHM=;
 b=Q7jUiZ/EkOG+Dp+K3X9N1QhuoPqFnRqGhzdhg3GquIuym5L7btcKi8KtcP+5vTuOOj
 bZC6lTCEYPE1SOGX7IZtxT2MjLiJhQblSVl6IYR3QUdPcC4MOuttXfFxwt5kT/x7aZHd
 JA/a8/eRKjy+0mEg38g+Y0OSS82XkULwltW4BaVuyZwED0SAEB4rzxaahuNimezbxmPb
 S+0N6DdUQB+/G/KMCEAu4Iv/4Boju8hcg5Gr60I1BJRwyQhF7zjSg7KdIiR+4xzelbWZ
 nM81v4IyIPpfjNQHnp7EDcu9KSfUKzvUhcRDa0vhBTwJVNbjvuaNFu9KF8ttRksDSNtE
 cP1A==
X-Gm-Message-State: AOAM530oaPI7VAEOWbxQcXLuI7PQ+S08JOlHhojRw4Zk7IyAHhqbyqvq
 J/uYq+0HosKTjgmyOzu1E6k=
X-Google-Smtp-Source: ABdhPJyIlOdMLuM2ALTwAXT8kHQVouv0Qt4Wj70MD2gro8mVBTat5UwUFM2P1aaGwEm7qMd/nIbZcQ==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr7181604wrf.77.1599211489694; 
 Fri, 04 Sep 2020 02:24:49 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id j10sm10105728wrn.2.2020.09.04.02.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 02:24:48 -0700 (PDT)
Subject: Re: [PATCH v8 06/14] roms: Add virtual Boot ROM for NPCM7xx SoCs
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200825001711.1340443-7-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8a427b01-a02b-df53-9179-ec733b1cfa1d@amsat.org>
Date: Fri, 4 Sep 2020 11:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825001711.1340443-7-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 2:17 AM, Havard Skinnemoen via wrote:
> This is a minimalistic boot ROM written specifically for use with QEMU.
> It supports loading the second-stage loader from SPI flash into RAM, SMP
> boot, and not much else.
> 
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  Makefile                    |   1 +
>  .gitmodules                 |   3 +++
>  MAINTAINERS                 |   2 ++
>  pc-bios/README              |   6 ++++++
>  pc-bios/npcm7xx_bootrom.bin | Bin 0 -> 768 bytes
>  roms/Makefile               |   7 +++++++
>  roms/vbootrom               |   1 +
>  7 files changed, 20 insertions(+)
>  create mode 100644 pc-bios/npcm7xx_bootrom.bin
>  create mode 160000 roms/vbootrom

This seems to need yet another rebase...

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

