Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF78206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5PvWZok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF78206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYEk-000344-J5
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVYE1-0002A7-Tt; Mon, 04 May 2020 06:21:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVYE1-00039D-88; Mon, 04 May 2020 06:21:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id u16so8380979wmc.5;
 Mon, 04 May 2020 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bAay7sHF5UAuLC5K3PGUp3iLEXMVE/Vr87IM8AUWwC4=;
 b=P5PvWZoksifcRarY1/qYOt2Rte/DxXJYwem5h8yr/OEelyXIB+UN8plufsDUTj0yIk
 Hqrs5zMz2g1vZDJtwQjN9unM2ma5jlBiu4wyaLRzMTpJYfgehaDg3K7aX9qAvs7hVSUG
 ywJ7vyZkLrkGAIPicQmYtBmV1shqAV102pW30i7ox48WUcsNJrvqXRBvcQKsfmOCBfWO
 7u9UYldlNPP35PZyVprWIswBOM1QlUbuTzWElTdX6Cw74skrcS4B5U3mJKBRaGjTlhjm
 cQJSyEQABM6PO3ivDSM9f5wXEW8Q9/DZxMJ11bjU/ph6DmQy9UK4FFai5Enx8Xp9USd7
 RYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bAay7sHF5UAuLC5K3PGUp3iLEXMVE/Vr87IM8AUWwC4=;
 b=gFOvZLCH4ouq5GrhZze0M7ZkXO13AsHLRs1Ls8Y+idGJAB9lOX/AY+Fbs5ibuI0U+s
 4/oxuo8y/qBmLct2i7oJfrJ3SIMapKZXJVV1ADMCPt9cgA/9oNBJvASfytp1ql0GSONi
 1n3Fq8aiSQt1q9dScrA4KGvedIjBQYZSHTzpuhrpTQEJpDLClxAxKlQLDyYZsG/WXL4J
 0PD2xd0104DI5eJinvaSsDN+mGyELHNH5/+j8eMoSZFCBlBlWDheNvBb38xDTd3ctiDg
 +kkjFqppLde/SUyHLyT+bP46B0KKbnKpWQEU2gOCbhKFQdttHDWQVHGGVcwUGhvr/zUD
 ovDA==
X-Gm-Message-State: AGi0PuZpQEbyfGtfgfTV7FkkmOMczqPo35TSS8u0/28G+1BC8ytVi75d
 QrEFBXjX2d/kEBLTkwIJliI=
X-Google-Smtp-Source: APiQypKwE29coJzDx/DvE2mi7+aO95YAF5ZlP6zWvsF42kGDWUpuMahBhlZC5l5WVQi+a0zjITQmvg==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr14683203wma.66.1588587682879; 
 Mon, 04 May 2020 03:21:22 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 17sm12247523wmo.2.2020.05.04.03.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 03:21:22 -0700 (PDT)
Subject: Re: [PATCH] hw/usb: Make "hcd-ehci.h" header public
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200504082238.16655-1-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2005041044550.59496@zero.eik.bme.hu>
 <0de65ed7-37b0-8916-2ccb-bbb524934351@amsat.org>
Message-ID: <0ffd398d-5585-e7f4-85f7-20e9c001428e@amsat.org>
Date: Mon, 4 May 2020 12:21:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0de65ed7-37b0-8916-2ccb-bbb524934351@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org,
 Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 12:12 PM, Philippe Mathieu-Daudé wrote:
> On 5/4/20 10:48 AM, BALATON Zoltan wrote:
>> On Mon, 4 May 2020, Philippe Mathieu-Daudé wrote:
>>> As target-specific code use this header, move it to the publicly
>>> accessible include/ folder.
>>>
>>>  $ git grep hw/usb/hcd-ehci.h
>>>  hw/arm/allwinner-h3.c:31:#include "hw/usb/hcd-ehci.h"
>>>  hw/arm/exynos4210.c:38:#include "hw/usb/hcd-ehci.h"
>>>  hw/ppc/sam460ex.c:38:#include "hw/usb/hcd-ehci.h"
>>>  include/hw/arm/allwinner-a10.h:13:#include "hw/usb/hcd-ehci.h"
>>>  include/hw/arm/aspeed_soc.h:29:#include "hw/usb/hcd-ehci.h"
>>
>> All of these only need either the type #define or EHCISysBusState so 
>> splitting only those off to a public header should be enough and 
>> better than making public all of ehci's internal header.
> 
> Ah you mean forward-declare EHCISysBusState in "qemu/typedefs.h", OK.

It won't work because AspeedSoCState and AwA10State use the full 
structure (not a pointer to it).

>>
>> Regards,
>> BALATON Zoltan
> 

