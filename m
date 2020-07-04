Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B44C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151DD20723
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u78XpHEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151DD20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlRy-0006bp-Cp
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrlRF-0005lc-H1; Sat, 04 Jul 2020 12:54:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrlRD-0008R0-Vl; Sat, 04 Jul 2020 12:54:53 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so34927895wmg.1;
 Sat, 04 Jul 2020 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ay3o947DDGRs2EpYLYg0NZ+LjCsZf66MHmQtgsLIESg=;
 b=u78XpHEpZpPCbzFitL5CMAcB0SwjdbTyMkcIuOpfhr5a67eyk9L6fhXdesTfvG1ZNP
 qHrlT1ntstFOhtb0qzXnJ2tDq83co09zvvDzP4E8Q4h1moqMTwUeeuBg9ub4EWHLWfVe
 jH3zOgeUnDrzEw5NK3NjZ0Hb3YM8/TNwyUh770O1JAI8SYHlLNj9OhQX/km+SdtlOG4u
 kOSplIkzF0z8F19fq/ZjAPcpr0Eo4e5Wz0xf+dR+gI4fQzkdiFeueslsiA/l+/9cBmy9
 1YgXa/uNs1gsUTad53D1yqOVD2BNv5mRZugJQPA/+tAqV4Ak1lqvP/GUKMfVKzkND3qL
 NMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ay3o947DDGRs2EpYLYg0NZ+LjCsZf66MHmQtgsLIESg=;
 b=K1aZjSxrykE+GznPLgWtNH0Z7Br3ta/jqapOaH8HppnvMt5VrvOzjOIpv0NDTrVS1+
 u34Eg9mSvEhsR3F/ADwQmeJuNF9xzpu7ivUb/jJqsjt6f3nz6xdf3fOXYyG1+bxvjnVU
 /pNP/teiAF+zIT+pUgQqWNlA8yo3+bA0gk0AiWzZkVzM0X8pMXlSKonCioa2b/K4mWvh
 XNAPhkp79DNoSOvaHaluWGqUx1zFoNyHp/p6FSnzkfkB7ssSVaOdS2Bn92z843HaN4Yd
 dD3uAOS6E1mscmLjoqa/6MknCtnmMwBHMaTjRuT132GxvdLpfpjYY2MbglqpsbKfeA9b
 w5mw==
X-Gm-Message-State: AOAM532HS9yI3ouV7Z2GCuvKiwan8Mspt/j9A/zAfSenKZcLUzlS1MVi
 UZwIcwON/IPwhIInDIVG5Dg=
X-Google-Smtp-Source: ABdhPJz31ESlYPHAnKJbDASCL+NkPUxlEvDo9R27j806QFOou0AZ4hFLlhR4ss5dzG2QOZY3Xu3HIg==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr39679826wmk.127.1593881690310; 
 Sat, 04 Jul 2020 09:54:50 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u2sm16382697wml.16.2020.07.04.09.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 09:54:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] i2c: Match parameters of i2c_start_transfer and
 i2c_send_recv
To: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
References: <20200623063123.20776-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48d29173-0a58-5fa9-1186-28ffb1a4b131@amsat.org>
Date: Sat, 4 Jul 2020 18:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623063123.20776-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 6/23/20 8:31 AM, Philippe Mathieu-Daudé wrote:
> This is v2 of Zoltan's patch:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg714711.html
> 
> - rebased
> - added docstring
> - include hw/misc/auxbus.c fix
> 
> Supersedes: <20200621145235.9E241745712@zero.eik.bme.hu>
> 
> BALATON Zoltan (2):
>   i2c: Match parameters of i2c_start_transfer and i2c_send_recv
>   i2c: Make i2c_start_transfer() direction argument a boolean
> 
> Philippe Mathieu-Daudé (1):
>   hw/misc/auxbus: Fix MOT/classic I2C mode
> 
>  include/hw/i2c/i2c.h | 22 ++++++++++++++++++++--
>  hw/display/sm501.c   |  4 ++--
>  hw/i2c/core.c        | 36 ++++++++++++++++++------------------
>  hw/i2c/ppc4xx_i2c.c  |  2 +-
>  hw/misc/auxbus.c     | 10 +++++-----
>  5 files changed, 46 insertions(+), 28 deletions(-)
> 

