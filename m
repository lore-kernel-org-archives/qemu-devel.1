Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66564C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368742087D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368742087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD0FQ-0007wG-BC
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD0Et-0007Ov-0S; Tue, 01 Sep 2020 02:57:55 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD0Eq-0005JP-Ts; Tue, 01 Sep 2020 02:57:54 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N3bCH-1kdRCk1Wh1-010ZTr; Tue, 01 Sep 2020 08:57:45 +0200
Subject: Re: [PATCH-for-5.1] hw/misc/milkymist-pfpu: Fix pFPU region size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200718093705.7271-1-f4bug@amsat.org>
 <b0eb3028f61e6eaaf9c1f4aedefeaa20@walle.cc>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1819668f-4747-0cb7-69c0-e167af71e8ba@vivier.eu>
Date: Tue, 1 Sep 2020 08:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b0eb3028f61e6eaaf9c1f4aedefeaa20@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WbBYeDt31EDzWW7GWgeMzrTTqE78DYwFEW7weg4lMLWY7yh5jTU
 yBTA+F98y5CTgC5NI8VvKgjhivrT3yUd+iBpLuH57acVp7MqCnK1teFoa9S2qTRCqdVVBxD
 dPDEtfawXBtXffvq9yalmgl+jnLXfs8S3TMDf8aziRwMQNLd1Vl5ryls2xBF/E+91FADICS
 5P1dS/GiBk7+bNrq2jcjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zVM9PVMOVs4=:HeP7MtS29aILNkTVEtZrsU
 RoT6pz1yHR9S2pmQUI/j3FBvHdeWuFthB1itDzfls7QtYcaxoQHQfFCIyi2i62Q4j8NcP13LB
 FjVNq6EI3RdPYhnbg4jm9p8quMF4ZoN+RWg3+9qkt0jRkK/e2YA4sAeDmEYWNXrXh6/aws1WA
 sg1AeUrsDkJ2cCF1u2+bn0xR+DViReQGGXLwb9Jsy9A9/+fLhSzzEpblWilKM/Do++9JkbdGJ
 13CBLeGdndakVIn9O5FK9s+7SMb4CLdWDuYRsH1pt1steNoO9TYT2IakxHULedehEQcdBu3cN
 OOs4o+ABIUq5nuWqqyAP6pCftacy8qM7fqnsQeVOgQfJZWJtMz59XC4grIKKgLEIrGGJElBbv
 Dpsk+VeaS0ONemhZfmY6x4NbpTTNHfNMD2DaiziNv8qjEBHM8FZnoHLpF70Y0uRtJFPp42LMM
 6BvoP1sUv3d31Mt+NXVwiPaBLxktgCNRC0+lSZB7wrtgVGJOvtDQvdtJlamJY1LnS+xqxY+ZL
 yFWhMSEc/0hYPV1wpI6Ved+Zlxa70GqUmMqeHkknCm7UjGL+bqDtE62/SEyCyax6B4upfpcmK
 qGnNtnYECVSvk1N3zGRAlgA4AEWYezwgo8tT97JH4J9NRvhlstkscI4blK5umydHMV48kKYFq
 MlYa00BqWCckHlIIqlnUwlmVyK7vMsxWEsyteT1stDrYYWPNTwMTpAHBj/eGRLLC//YgKcBgv
 8BRDXodq/0uEgQyvxiZdqvTxcFOuIqLWqUeml6IYdXeXPo2y4BmSnkpbF8sxIlxUSgdiVVWv3
 Rlpo4C7E3qSI8jYsmeySu6DmVGjPbe+jSq02VcN+sk8aoreFW/p/5xlrKcsHdF/tLndWsCD
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:33:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Michael Walle <michael@walle.cc>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/07/2020 à 19:23, Michael Walle a écrit :
> Hi Philippe,
> 
> Am 2020-07-18 11:37, schrieb Philippe Mathieu-Daudé:
>> The last microcode word (address 0x6000.6ffc) is not reachable.
>> Correct the programmable FPU I/O size (which is 4 KiB) to be
>> able to use all the microcode area.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/misc/milkymist-pfpu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
>> index 516825e83d..4fbe3e8971 100644
>> --- a/hw/misc/milkymist-pfpu.c
>> +++ b/hw/misc/milkymist-pfpu.c
>> @@ -507,7 +507,7 @@ static void milkymist_pfpu_realize(DeviceState
>> *dev, Error **errp)
>>      sysbus_init_irq(sbd, &s->irq);
>>
>>      memory_region_init_io(&s->regs_region, OBJECT(dev),
>> &pfpu_mmio_ops, s,
>> -            "milkymist-pfpu", MICROCODE_END * 4);
>> +                          "milkymist-pfpu", 0x1000);
> 
> Could you use one of the MICROCODE_ macros instead? maybe
> (MICROCODE_WORDS * 2)?
> 
> With that fixed:
> Reviewed-by: Michael Walle <michael@walle.cc>
> 

Philippe,

do you plan to repost with the change suggested by Michael?

Thanks,
Laurent

