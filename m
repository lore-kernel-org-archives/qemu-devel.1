Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D8FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168352071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh06wm2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168352071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVY6Q-000513-8R
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVY5l-0004H0-PZ; Mon, 04 May 2020 06:12:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVY5l-0004dP-5v; Mon, 04 May 2020 06:12:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so1184236wrt.1;
 Mon, 04 May 2020 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c1RJHnLwGnOHA1qprnfYYlQHbL15pxYDC9M3A/Cja3c=;
 b=Fh06wm2mHu3/IA+GJkS6TJs+DN93yySBsWpMaxhfITyeuhc8PdAJmsfjoBu/vUSgB+
 DKdE7ULkSERxxaB9ifn/5wVRBznWcqF1BfjcmJ+Z1XgYg3qDcy/RJDb7D8zmNheBA7DO
 zzF9MvoppzyCsZLnZZ2cPq06ZVy86K0mNtXcUIxPAOHS7HEUB3DA2qwfhAkuLLhNe+8X
 DKAdku2+UnNF4N9A4hdBY2AB5TUY1ufwxd2N9sWfZLdyjcpgKkvEZeKs4KHAzpTp0xbU
 PDNG2CHcKwwm1YJGofLjdfRkOwIVe8HeQwzIufvS16DcqyiHKFKq2X+sh0BeoN+5gYrG
 hm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c1RJHnLwGnOHA1qprnfYYlQHbL15pxYDC9M3A/Cja3c=;
 b=mgkDALnc0uvySvIYxtZUpZLnSoo6yjTx2t/GWJAkXTtMLoScy49TngfldjahbYi5GO
 VCvDceibwQ7KJ5VX/y/DiD0jQVTcK9eUWjoxMkRz7WreDVQk1dXAB/+lJB6OhJAeFt5d
 vS8r55GkcnZ3EFwOiIUbFxOROLRqf8ix32Gg7yGDFEAwTroEkvfx1k74+PI5CQYjq2/a
 dOuhzEcMCzZ9WP23muZAz1VZ0waca+rt2m8L79wh4jnESLpvUdvsuI4Q/iEBwtNvketd
 nuW/BOfeSp3s1MGAHPh/Y5nlKLwEvgGEco0RSdTuTo5R3KKj9WW9mqTBMyl1NfGD2Kqz
 Tv5A==
X-Gm-Message-State: AGi0PuYzWywjT1RTesnIeI4e6XFYMJNCE41iksTlHR7aFnnbI+UiqWmo
 /lsZiMdCc+4Zl7cMkCEcQOY=
X-Google-Smtp-Source: APiQypI/g48kjG3SpI4QJTNqKqDlbjvJoJsvr9wv4jvaiDIeZkUgzklwJarsKurqwygAVu7DGZ212g==
X-Received: by 2002:adf:f004:: with SMTP id j4mr18026230wro.123.1588587170753; 
 Mon, 04 May 2020 03:12:50 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id f12sm15785894wrg.77.2020.05.04.03.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 03:12:49 -0700 (PDT)
Subject: Re: [PATCH] hw/usb: Make "hcd-ehci.h" header public
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200504082238.16655-1-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2005041044550.59496@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0de65ed7-37b0-8916-2ccb-bbb524934351@amsat.org>
Date: Mon, 4 May 2020 12:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005041044550.59496@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-trivial@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 10:48 AM, BALATON Zoltan wrote:
> On Mon, 4 May 2020, Philippe Mathieu-Daudé wrote:
>> As target-specific code use this header, move it to the publicly
>> accessible include/ folder.
>>
>>  $ git grep hw/usb/hcd-ehci.h
>>  hw/arm/allwinner-h3.c:31:#include "hw/usb/hcd-ehci.h"
>>  hw/arm/exynos4210.c:38:#include "hw/usb/hcd-ehci.h"
>>  hw/ppc/sam460ex.c:38:#include "hw/usb/hcd-ehci.h"
>>  include/hw/arm/allwinner-a10.h:13:#include "hw/usb/hcd-ehci.h"
>>  include/hw/arm/aspeed_soc.h:29:#include "hw/usb/hcd-ehci.h"
> 
> All of these only need either the type #define or EHCISysBusState so 
> splitting only those off to a public header should be enough and better 
> than making public all of ehci's internal header.

Ah you mean forward-declare EHCISysBusState in "qemu/typedefs.h", OK.

> 
> Regards,
> BALATON Zoltan

