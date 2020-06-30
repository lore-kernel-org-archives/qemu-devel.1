Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BD5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BE7206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvIRpCJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BE7206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJQi-0007vq-R8
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJPB-0006Ag-Uu
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:46:45 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:41480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJPA-0007vI-DI
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:46:45 -0400
Received: by mail-ej1-x642.google.com with SMTP id dp18so21346715ejc.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Kk42tX8GUX7lMkBOGjY+O1Hz9l62f4JEfvdJj/0Iub8=;
 b=hvIRpCJIIG0kffIJXJVPmE6W81swc/THwHYUG9H1uHN5oUqtHZtu8BBT4lyaKlpWLY
 F7XNDmlfUxtaUhcIY+sdcjSkwzveyS/rGAJtvU9GV46ZxSukYGuJ6P0lJPSBQdmkLqTV
 n+yHn+SO75j4rmz42wMoIUu7aB8uOvDRuaLnldZ5YrSK6ktqkRxzTxHqLaqAWopbdNts
 i5Uj1QHuWMs5Y2RhShVT5nH6or0TQeIFzwArYHTtzrtDlCt3/VhT9z8Gkh2f9qF5C6iJ
 iIiIl5a61mTOl3P1laaCopDNgy7LGydKm8/DS4eALGrA9t3Hm772thWl5XXmbJ5560KN
 hvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kk42tX8GUX7lMkBOGjY+O1Hz9l62f4JEfvdJj/0Iub8=;
 b=A2c+tHCeGe4tbvkKA45YLc5fYsRZoxkIolFVOVwhGyICmQW4w4jZ7C670cEyF2F145
 lf1MKta9Jc43uZ5iEuLPcA7Kz1vnw56TYGaoAZdI0bFkfoYiea3IWt1ymOz1sBf3ysRO
 ugKO4Ofa9OFDFOUrjLowtjMCbhlGlcozcZ5NVp1vRV5mwiEy1Fhh4/LIYpLj3SJjaDv4
 lhwaGKVcRYw95SAG5lXwsHNbrBTUWwGgro2KnEwJHWTaoBYGkE7ssUVGBcC4WggDBMZT
 6hRhsmvvztC3Fgj+/W0SZeOIl7nrppkX/VobgBGmsNreYMFXSi2cM2LOFbFLIfo2HHuF
 hTJQ==
X-Gm-Message-State: AOAM5314T9+cxQ5wVzztM6w+m2rs7Dwlaq2pgfjzlNupQtGTWUOehq2u
 7ugJTyOZYs4OXO6XZBCH1T4=
X-Google-Smtp-Source: ABdhPJwx2cjOM/99PjvZ5DrhSWW3tHF14r63BHXkBjDie50FmRIGsb1OOncnHn+sc5w1jwKtxWuI7g==
X-Received: by 2002:a17:906:90c1:: with SMTP id
 v1mr18766650ejw.481.1593535602750; 
 Tue, 30 Jun 2020 09:46:42 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z8sm2406346eju.106.2020.06.30.09.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 09:46:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200630145236.27529-1-f4bug@amsat.org>
 <CAHiYmc4=pmzEyhVTHaqxBnCotE8V+vaptMFincyurvAyDHNn6g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5725b99b-b524-ab40-c74d-a615bb28d363@amsat.org>
Date: Tue, 30 Jun 2020 18:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4=pmzEyhVTHaqxBnCotE8V+vaptMFincyurvAyDHNn6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 5:38 PM, Aleksandar Markovic wrote:
> уто, 30. јун 2020. у 16:52 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> Hi,
>>
>> This series add a new 'malta-strict' machine, that aims to properly
>> model the real hardware (which is not what the current 'malta'
>> machine models).
>>
>> As a bonus for Debian builders, a 'malta-unleashed' machine RFC
>> patch is included. This might start another endless discussion
>> upstream, but this is not the point of, so I still include it
>> for people to test. The rest of the series is candidate for merging
>> in mainstream QEMU.
>>
>> Philippe Mathieu-Daudé (6):
>>   hw/mips/malta: Trivial code movement
>>   hw/mips/malta: Register the machine as a TypeInfo
>>   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>>   hw/mips/malta: Introduce the 'malta-strict' machine
>>   hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
>>   hw/mips/malta: Introduce the 'malta-unleashed' 64-bit machine
>>
>>  hw/mips/malta.c | 125 ++++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 111 insertions(+), 14 deletions(-)
>>
>> --
> 
> This whole series is based on idea of emulating physically
> non-existing feature, and as such violates the fundamental principles
> of QEMU.
> 
> As such, not acceptable for upstreaming.
> 
> I don't see the point of sending again the same series, in just
> cosmetically different form, if it was said to you that the concept is
> wrong.

Have you looked at the patches? What "violates the fundamental
principles of QEMU" is the code currently in mainstream. Should
we remove it? I can send a patch for it if it pleases you, but
you will make QEMU unuseful for many distribution users.

What this series does is emulate the physically existing feature
that are not yet emulated in QEMU.

Please refer to the datasheet 'MIPS Document Number: MD00051
Revision 01.07' before rejecting this series, and find the
correct arguments.

Thanks.

> 
> Regards,
> Aleksandar
> 
> 
>> 2.21.3
>>
> 

