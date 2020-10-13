Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED45C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB56D208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmBVmPKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB56D208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQEl-0002Q4-Gk
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQDW-0001U5-7H; Tue, 13 Oct 2020 15:44:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQDU-0002jL-Pm; Tue, 13 Oct 2020 15:44:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so810800wrq.2;
 Tue, 13 Oct 2020 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=peOSRy93Mv6U4byq/ZpWobOwLNLsQC4CFYx7g0Hz+es=;
 b=fmBVmPKeQXK7fVDkz8KPDOC2alKPa9qSnuOn1nirfPN7pK5hjiVoNf1uVgHuLSB7SQ
 e0NkRYu9JYn/Z4U3s53rZMDgdIey1Jp0UJt1ONVwcmEz2QTXynocKLMZeu/SVrZFftXW
 SRVcquOVEoGh5UFAaBlspkpRBz9+ev9ypzh59BVoYFccu2kGih0A1T2R2xYfxbdl+msP
 jmZffGi56arFhz2tIphcoUozHLSXQS7n5GRYHoohOgMoGXI2TNr1zcfDg3xa9pPtqCvV
 q78KfMqy2d6HCDyWPJddW7HALQHBGFRQddEQiIMfejY440WSU5PJSziisiAYKMpxMGcp
 YhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=peOSRy93Mv6U4byq/ZpWobOwLNLsQC4CFYx7g0Hz+es=;
 b=W2k2+GFcia0KEHApt2H3KXZ/utRcwEXqKs1koRgGozwxUgHFbSfRzOL75XWHdavAF7
 XNKcryk9zuuhZTrhkQC3ISw3bN/codjmf/TArgbXujaWoCo8QGTMePWhAUrD16NsSVjm
 +NEFpshI+ovkdXwy4sQnhjKINzchPwS9uYhTTKwPF/hqhLKCpLarbfkIorSG8h9nZMh3
 PWFOOK4rNBf+BS07lk2OnfwKN/eqmRuCH7EmPZlcuO5njDEU78nXA5+1AD7Ks7V1dlS2
 cJENma627Ep9haWLtasQcycQ2tOudD7BgbRfl3RmoqsDNnPn207IFv5jhujEvpSxWBxB
 VB+w==
X-Gm-Message-State: AOAM532iq5sLRaIJXtFtqBhUNr6Ff+NdQ9Jff5rzkcCtA50P4SPl1w2N
 z6yicQd73YpykaYG3vDkmyA=
X-Google-Smtp-Source: ABdhPJwCHq/qnjE4fn6KFfxUc2cvvbzwA2Twr3oZt70shGiB3v5JC/G5ABnufpx3KDn1UqbIc+Zcwg==
X-Received: by 2002:adf:ff86:: with SMTP id j6mr1385090wrr.184.1602618250578; 
 Tue, 13 Oct 2020 12:44:10 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x18sm866324wrg.4.2020.10.13.12.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 12:44:09 -0700 (PDT)
Subject: Re: [PATCH v7 3/8] mac_oldworld: Drop a variable, use
 get_system_memory() directly
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <8ece4381702aa5d5f004616e1818dd9b33dab620.1593456926.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c93fe382-9e68-a1ff-110b-f26a707b1247@amsat.org>
Date: Tue, 13 Oct 2020 21:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8ece4381702aa5d5f004616e1818dd9b33dab620.1593456926.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 8:55 PM, BALATON Zoltan wrote:
> Half of the occurances already use get_system_memory() directly
> instead of sysmem variable, convert the two other uses to
> get_system_memory() too which seems to be more common and drop the
> variable.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ppc/mac_oldworld.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

