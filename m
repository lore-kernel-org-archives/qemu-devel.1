Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C7DC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7E3208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvhcQeqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7E3208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNuMU-0007xH-Vn
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNuLB-0006tY-Gu
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:53:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNuL9-0005Vz-Ta
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:53:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id k10so4700132wru.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sAWjsS8jt9ogWt8DvM6cPCUuaYsXhcCxkcDLIT4dmK8=;
 b=XvhcQeqdGlxClC1JanHg8FPwjXl+wfq1qNLZyDfFyjiYLf3prg5diO1OgRzkANRhEM
 asRdzu1z1j4GZu7cS+7TQ/UR7DFByBH3HyrwCndbGLZUb1z9qwgF7qSQS+1XR69OUVzv
 O8tMziarc2q95B4oea/ZdQRb4UXhMNBGcCWrdZ2hhIpDUYEyxutEGOu3fC3d34nGXws4
 tvuVT4BvfDfU3dhavPhSPpxRb51Ob/B5Xwzp+5OMOztWZtV2Rt8R99Eqq2G6Cb5X26sN
 Gk/OtqjPXbxq2j55UizOIM3Pi1RNKvrmGKXI+cz0qlzRsptAGGL+KlPioZXQ5KxZqtg1
 fCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sAWjsS8jt9ogWt8DvM6cPCUuaYsXhcCxkcDLIT4dmK8=;
 b=nUleziQ9frK4+ulGKVroMK8vtJAc/mtu8cFEB0ckB1Id3gdRWSOj7wjmsfsniZ2bOh
 H0N6T5B2GbqbIEPB4oCKZuUhXKg5D/e75zqf6vtEPfY7swR1RRk1KwJD4TsTTci+3s3u
 fY0JusW6HCUBH6CW9GbD7eaWWg9DA6ahB6O7SFqz6WbNvCT0MS2Id+fSTj/7fJUckdUN
 HVrkJVvRrm3Hg8XKHEF2yWSJC14xy5yRnMwKY+kLHSnlgy57ebfLrlkVvBoV9wwxRiEv
 hF3pX423BD8BZJ+nzjUueUgKiuMQCXHU5/iH1KQOAsnJ7Pn4NCeP9rJrEnDcWeAz06d2
 YxiA==
X-Gm-Message-State: AOAM533GbfotZM1TGJcMGh5ExJnMBMdmVpWouFCjOjsE8U7Xcj0P8ozr
 YK02vVFSASswhquM2XCoraA=
X-Google-Smtp-Source: ABdhPJyjTog0dtMS3Jdsft4XKFDvY2eNsniop6I9Cfx9/vySchfZPYeBthXYlLCylUrwFTg5Go3NjQ==
X-Received: by 2002:adf:e289:: with SMTP id v9mr7723603wri.14.1601542406681;
 Thu, 01 Oct 2020 01:53:26 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id i33sm8522151wri.79.2020.10.01.01.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 01:53:25 -0700 (PDT)
Subject: Re: [RFC PATCH v4 22/29] Hexagon (target/hexagon) macros
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-23-git-send-email-tsimpson@quicinc.com>
 <36baca58-2129-7875-7a58-52454d8f2d0b@amsat.org>
 <BYAPR02MB4886E8D18707EAB35CF9EEE1DE330@BYAPR02MB4886.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b5dc35f9-bd17-ad57-8fde-d5d9cf92a078@amsat.org>
Date: Thu, 1 Oct 2020 10:53:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886E8D18707EAB35CF9EEE1DE330@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.001,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 11:22 PM, Taylor Simpson wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com> On
>> Behalf Of Philippe Mathieu-Daudé
>> Sent: Tuesday, September 29, 2020 6:34 AM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; laurent@vivier.eu; riku.voipio@iki.fi;
>> aleksandar.m.mail@gmail.com; ale@rev.ng
>> Subject: Re: [RFC PATCH v4 22/29] Hexagon (target/hexagon) macros
>>
>> On 9/28/20 7:28 PM, Taylor Simpson wrote:
>>> macros to interface with the generator
>>> macros referenced in instruction semantics
>>>
>>> +#ifndef HEXAGON_MACROS_H
>>> +#define HEXAGON_MACROS_H
>>> +
>>> +#include "qemu/osdep.h"
>>
>> Please do not include "qemu/osdep.h" in header.
>>
>>> +#include "qemu/host-utils.h"
>>
>> "qemu/host-utils.h" doesn't seem used.
>>
>>> +#include "cpu.h"
>>> +#include "hex_regs.h"
>>> +#include "reg_fields.h"
>>> +
>> [...]
> 
> To clarify, does the "[...]" mean I should remove all the includes (and include them in the .c files that include this header file)?

No! No further comment on the rest of this patch, so to avoid you
looking for any comment, I simply stripped the rest. ;)

> 
> Thanks,
> Taylor
> 
> 

