Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302D6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2BE23E24
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sggrn/cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2BE23E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvEa-0006J3-91
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpvDg-0005kR-PA; Mon, 29 Jun 2020 10:57:16 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:43905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpvDf-00040a-Ai; Mon, 29 Jun 2020 10:57:16 -0400
Received: by mail-ej1-x643.google.com with SMTP id l12so16851284ejn.10;
 Mon, 29 Jun 2020 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JSy1xaQbw0L8ARiM5VBYS1D7X0v2qiWg8jPvKnzhMt0=;
 b=sggrn/cElpuSF011BeOT6VQrdxmVewce/xmQ6+4CpPKYEczOeGfQFVEx53hydi6w/H
 TKZwshd6rcRwinsJ7TwYx78umu6y7z+Eib8uVnN0G5DcKmCnCSVKKfzFqHfuf2eRCESQ
 KWMe1QNgCP97/aA157nDouH3yyxnrCeyhl4DGneqgDfaknjN2moZNOzPMJN9YyhB2QBo
 g9+PxTC3i8QsahdR4x5vTt+JgtCswA2/wJHl5b2juYwwDORYXgZOTVWfpYt3h3PUxKDg
 ZIPrge4TKXlHoUGfSLf6+59W/BKAj0FEvIYIroPq4ZDGtwkJFUlKxxVg1wjqt7st/vGn
 Rn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JSy1xaQbw0L8ARiM5VBYS1D7X0v2qiWg8jPvKnzhMt0=;
 b=EfaddoGPZrCOHuEypZHYEm7BYkP14Rbq33xRBVHVvuS5IxCG/PiqK5eYLsDhHCe/VY
 tYPXtjPCPsXiURDwpk54+xtBTs2OUm3EGyhOIHxFPbrRjkwMnMYM1p034xYX/XzVtIC8
 QPmwQAOnlT8PQ2ii7Gr2jh+LWZrbe1g+thn7t6mEusBb+zyCa3vSvZNn8mGkt3eiY8uD
 meKp0GpiyDm4Us1dS5dfsNpfYWct0O6vrVJENC0WSP4yXTunBxb6bOgUUZL1QxZd4U08
 cSSVIrSR3cIHBp3balrl9tgp48qdMPSPTR+mFttOzbzaGf8y6nBcWYORWWkSJ2YMtGfu
 8W8w==
X-Gm-Message-State: AOAM533mE1g5IZImZDdISeQ3V0wY1fq5dE3SkVUoqJojzA8K9rd2rAE7
 DjR8dHu7fXyyikKhxBoB/XTEXAeOHvg=
X-Google-Smtp-Source: ABdhPJwF55oildBnVYssfYweFizOfb9NUxG0DEM8pJpWpc9myWB2SBh63LNZaG2UPtWtUmoVtmgTVg==
X-Received: by 2002:a17:907:395:: with SMTP id
 ss21mr14203042ejb.181.1593442633574; 
 Mon, 29 Jun 2020 07:57:13 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d13sm98900edv.12.2020.06.29.07.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 07:57:12 -0700 (PDT)
Subject: Re: [PATCH 11/17] hw/misc/max111x: Create header file for
 documentation, TYPE_ macros
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-12-peter.maydell@linaro.org>
 <b1a56ac5-f2a7-ec88-0191-5324821f4916@amsat.org>
 <CAFEAcA83LqH0dUZfk-yjmdEX_o4VNuDqAgSxe2hj9nGmAxs9Xw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <128760db-266b-092b-297c-d7c766174ced@amsat.org>
Date: Mon, 29 Jun 2020 16:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83LqH0dUZfk-yjmdEX_o4VNuDqAgSxe2hj9nGmAxs9Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 2:07 PM, Peter Maydell wrote:
> On Mon, 29 Jun 2020 at 09:29, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 6/28/20 4:24 PM, Peter Maydell wrote:
>>> Create a header file for the hw/misc/max111x device, in the
>>> usual modern style for QOM devices:
>>>  * definition of the TYPE_ constants and macros
>>>  * definition of the device's state struct so that it can
>>>    be embedded in other structs if desired

Ah, fine.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>>  * documentation of the interface
>>>
>>> This allows us to use TYPE_MAX_1111 in the spitz.c code rather
>>> than the string "max1111".
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
> 
>> Nitpick, we can keep MAX_111X() + MAX111xState in "hw/misc/max111x.c"
>> until we get a consumer.
> 
> This is deliberate, as noted in the commit message.
> 
> thanks
> -- PMM
> 

