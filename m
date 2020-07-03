Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0F320826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYkx/D7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0F320826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrTex-00024d-UQ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 17:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrTeG-0001Z1-Pr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:55:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrTeF-00052V-4N
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:55:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id b6so34129098wrs.11
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6YIT3RKmpZrkqlld6A+YVdaaspcVoaFL5lR2gPMdUIw=;
 b=sYkx/D7pUMMOoAxG9Io9/+MUJQlOWSilu/H19s5BrrL5BYjChCbPt72yAXBkuoql7a
 u3nTxcxVqEJjGEHP6wTWWgwRbi0h6EPHjmN+8WuRDY4BwlLxtAS0uhOSRo4NRGDu6qFK
 XbrPBf/aUq7FxUNUxtNzwqjHYEJsbAR9ROzn3CiWFpp1PDElOgRQtLpwh0NTbIZiucIF
 clq0HAuzit7HnfRzSl07jo5IcoeZozp+q7F57Ds6F+/mNRCdgkZLuQgUTeYPMJBzjkhc
 28YQHMTecLb4YfgmwymUqB7/zDKknPH3QtYldCbCMgHJpNl6dtDQJjrVoILjU0qZR25e
 pKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6YIT3RKmpZrkqlld6A+YVdaaspcVoaFL5lR2gPMdUIw=;
 b=fo4/eyass+V0pqm/Sn/hw/lqlZaR3MlZ23l+F/tz4yldCrPc43Xo1CqnLos7B1W/XM
 T+VWRR6Dl2Y3cz2mZKVkKAE1gcy+8UnLu6ItFIM3fvHYNFqXjQ63kBSMvRd+pfgHvXQz
 6r2WDJJQNxXNqMFv+yn8ooTFDS0HuqAHE1zu4BHGpffI+lErhDDVpaUqfYWFVMP2BnJA
 MOY24C4VLvt9FpGBP0vqUyuN8BGPd3n4ypFWZdpSGAsBDAGX2fV5fPiSy/zv1aAgt+BC
 n75wzeo02ttZXKH01GjsWgN6p+2OlkipOCGQ/YrzAE1r8AjZzFl2/gsP+kUZgxjRzHlb
 rWyw==
X-Gm-Message-State: AOAM533M+XJ7+1pPrkfNOnOe+qIYnewLUEklgghau2sKhCrMG8XC1gNc
 YKjucEwXuuc7TnDAo2B4reB2IV1h+3A=
X-Google-Smtp-Source: ABdhPJwmcqEqivXQxHrb3JfPMbYaQ57f28pBqkkfnOibAH2l2VQ4fhQdTOqqHqomjCOyNxTUj4PAfw==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr37717292wrt.174.1593813305476; 
 Fri, 03 Jul 2020 14:55:05 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a4sm16344833wrg.80.2020.07.03.14.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 14:55:04 -0700 (PDT)
Subject: Re: gmake in Solaris 11.4: TFR missing
To: Michele Denber <denber@mindspring.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <601a18a7-d564-b9d7-7187-53a05d819551@amsat.org>
Date: Fri, 3 Jul 2020 23:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5EFFA499.7050008@mindspring.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 11:35 PM, Michele Denber wrote:
> 
>>
>> It appears that _IOR & friends are defined in
>> /usr/include/sys/ioccom.h, but I can't figure out how to point gmake
>> to that.  Do I need some sort of "-I" in the Makefile?
>>
>>
>> When I built QEMU 2.12, I ran into this too and ended up just
>> commenting out all the references to _IOR, etc. in hw/tpm/tpm_ioctl.h
>> but maybe we can do something more elegant this time.  Thanks.
> 
> OK, I fixed this by adding the line
> 
> #include </usr/include/sys/ioccom.h>
> 
> to hw/tpm/tpm_ioctl.h.
> 
> gmake now went to the end but threw a bunch of errors all complaining
> about something called TFR.  This is the tail:
> 
>  ...
> CC      aarch64-softmmu/trace/generated-helpers.o
> Undefined                       first referenced
>  symbol                             in file
> TFR                                 ../net/tap-solaris.o
> ld: fatal: symbol referencing errors
> collect2: error: ld returned 1 exit status
> gmake[1]: *** [Makefile:208: qemu-system-mipsel] Error 1
> gmake: *** [Makefile:527: mipsel-softmmu/all] Error 2
>   LINK    mips-softmmu/qemu-system-mips
> Undefined                       first referenced
>  symbol                             in file
> TFR                                 ../net/tap-solaris.o
> ld: fatal: symbol referencing errors
> collect2: error: ld returned 1 exit status
> gmake[1]: *** [Makefile:208: qemu-system-mips] Error 1
> gmake: *** [Makefile:527: mips-softmmu/all] Error 2
>   LINK    arm-softmmu/qemu-system-arm
> Undefined                       first referenced
>  symbol                             in file
> TFR                                 ../net/tap-solaris.o
> ld: fatal: symbol referencing errors
> collect2: error: ld returned 1 exit status
> gmake[1]: *** [Makefile:208: qemu-system-arm] Error 1
> gmake: *** [Makefile:527: arm-softmmu/all] Error 2
>   LINK    aarch64-softmmu/qemu-system-aarch64
> Undefined                       first referenced
>  symbol                             in file
> TFR                                 ../net/tap-solaris.o
> ld: fatal: symbol referencing errors
> collect2: error: ld returned 1 exit status
> gmake[1]: *** [Makefile:208: qemu-system-aarch64] Error 1
> gmake: *** [Makefile:527: aarch64-softmmu/all] Error 2
> root@hemlock:~/qemu-5.0.0#
> 
> A web search for "solaris undefined symbol TFR" turned up nothing and
> I'm not seeing it on the machine.  man TFR returns nothing.  I didn't
> encounter this error while building 2.12.  Here's an example of its use
> (in tap-solaris.c):
> 
>  TFR(ip_fd = open("/dev/udp", O_RDWR, 0));
> 
>   What is TFR?

TFR() is defined in include/qemu-common.h:

#define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)

> 
>             - Michele
> 
> 


