Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83414C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5222E208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ3NE6bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5222E208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNS8-0004QP-Ir
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrNQz-0002vq-BU; Fri, 03 Jul 2020 11:17:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrNQx-0003yR-CV; Fri, 03 Jul 2020 11:17:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id s10so33049011wrw.12;
 Fri, 03 Jul 2020 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ABszV2EUaB2rVUVFpcH0yaIcSb1i+8h4JFVHHy+zLig=;
 b=mZ3NE6bIFkgOdAqAjAd2gNouwrPP6lg+HvICQpOisNuAf65l69dOSuePiId7Vq969g
 6pHO1yQrVH0FfMWx2sFZOWxvqDHI58W7HzpnYHl7jbpB/sFTPgecbcTJ9Rt7FNvDLlkB
 uyvIg0mul7pOq0gY3tzm6mivTSd3Qco1Fl4/hT52Zdc3tjehuyafwI8/opskSAWXrGIy
 zeOLYQiOMCpXVbZEB9U3tfO3Atlnzzae/qZitfpLK2GevJGI9A1zxbh/cYvdWOYcF/R5
 OPHUzjpWHVtanEQGlj+Zv5WN+ZrbOrqylpnx4nb4wg885Argbrmwz4Vd4QZI/HtT63Gk
 mNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ABszV2EUaB2rVUVFpcH0yaIcSb1i+8h4JFVHHy+zLig=;
 b=fW8kZLsU4eXtjTk9g3VyG4OMsg9UzIAMr5CQy5YFq3Qwfz8auNLinvNTY5JKgly8OX
 u+ICq15x6eoGnERPuKWNtcFpDfYmecGHHCY8vZRRhmUAk0RTg+H0qeLQaBu9Tb5ZVIpV
 1VUlCYip3JgSkvyeRCqs1U0+QjsO6wmBhDqQ06yy+34xpX8gorRt3g5IWRaNf4Dr+XTy
 rJ+KjURH9BAn6RdHfxSRPFQiYejS4vBRv2aVggmjquAuMpvU0HFdu5YI1vmsyIUHTJ/d
 b+WukotO1YPK25CqvyYCy5t/hYnahpin2yrmisZpkpxL69ENQL+OgEtm6VBVtxHyY1nx
 ghxQ==
X-Gm-Message-State: AOAM533FQwjmhX7srg51gtkhYBH2Bon/53Y/mD5zeGMdnWQ5k1aeS/v5
 0ckwzb7Ia1Fd59V12w6Xutw6z0IlgAQ=
X-Google-Smtp-Source: ABdhPJyhLI8pFtQarCvxUGIXy+qdFn6yod8CqpgMSfE0MpNEFhVThYkQg0MLgb2jC8RyvuWlKe3d7w==
X-Received: by 2002:a05:6000:1290:: with SMTP id
 f16mr9374856wrx.66.1593789416959; 
 Fri, 03 Jul 2020 08:16:56 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id q4sm13399830wmc.1.2020.07.03.08.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 08:16:56 -0700 (PDT)
Subject: Re: [PATCH v7 09/17] hw/sd/sdcard: Special case the -ENOMEDIUM error
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-10-f4bug@amsat.org>
 <CAFEAcA_dhbr6cjK40H0=e39sD2r8ERTZYrY5nhJtx81Rk+RmUg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2c77e134-4762-89b2-b60d-aabde740f25f@amsat.org>
Date: Fri, 3 Jul 2020 17:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_dhbr6cjK40H0=e39sD2r8ERTZYrY5nhJtx81Rk+RmUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 3:23 PM, Peter Maydell wrote:
> On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> As we have no interest in the underlying block geometry,
>> directly call blk_getlength(). We have to care about machines
>> creating SD card with not drive attached (probably incorrect
>> API use). Simply emit a warning when such Frankenstein cards
>> of zero size are reset.
> 
> Which machines create SD cards without a backing block device?

The Aspeed machines:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg718116.html

> I have a feeling that also the monitor "change" and "eject"
> commands can remove the backing block device from the SD card
> object.

This is what I wanted to talk about on IRC. This seems wrong to me,
we should eject the card and destroy it, and recreate a new card
when plugging in another backing block device.

Keep the reparenting on the bus layer, not on the card.

