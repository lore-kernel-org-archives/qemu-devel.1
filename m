Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0578FC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E3F206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJnDdVRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E3F206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkYY-0007n3-2Y
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrkXg-0006gi-Sc
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:57:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrkXf-0003yA-6l
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:57:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id g75so34821735wme.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=08z4qlPQzjCeE3BAnQjuZ41XADdXtoD+RXDn53FVtw8=;
 b=oJnDdVRVHqNo+xl3aXfVoyorKOKqat+UadlU1z4aLNKmEKhBPeA/nSv+Dt9brQrUY4
 6BBSyXtBLmjShiAQJHISPoZpJmvjfqpyTfm9RbazBSE5pMEXBG53WlIh+CdA8lG5aCov
 /clMWgAwHUNof0J2YHksYsZz9Jdk4BpXGYB14P2ORvN5d9Il4NPjE3res9Syw2e0+FzQ
 hS1h0H802Ult2/nqgl91+INXsqeGJLrqOOVQU0ZdxmDSqsC28QKAwZnk9IPeWnI+f6JI
 v1jNh+5v3hbmlih8EulsuSXuVlzQVcNRkDvw4Dmyaa/WHFgG6d7ONq/rEsspb8f01QmU
 u7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=08z4qlPQzjCeE3BAnQjuZ41XADdXtoD+RXDn53FVtw8=;
 b=RRL0fpXWXvbhwYJv5ZbUcemLAr+cCxm16NhrRE6yw8P2FXVd8nRlZcOOVhNFnnVmNg
 S8YSCRAIPGHh0wzsOcokLyGtqBBfi8q7pHdcljueHTcML+IS06Y0j8BK8afHEojc6WTt
 wfcAK/m+OLG87cz5RgBnSvgbfeZWSukymXS/B2pcvhw3qi3kLN1U9Tn3kxqXYH9Hy6li
 Tcj6LoElkM1fC2TsBJij3YiOqeXjKNQ+sH9JE0ot/S1l8ovH7d/67SAbzMBpOd9cxs6v
 xyKloGiJPQIPrRP4EfI0PkwBEJXri8BtfSzlBPsV76/E2/CZgccRWGKWTBIN6STSPW5A
 sZsQ==
X-Gm-Message-State: AOAM533YwxaIY/xJNVJ5QNSUkt3fnV5uISWUZFmeb9Vb+85ZmetgCfcl
 S1Ef6O43CtJJgoWyIVd2bVoQhCVFFSg=
X-Google-Smtp-Source: ABdhPJxYjIDktrVmjdh4ywCgIi5REV4drF7SQ8fEpikIDQ7LDtQcZ0YU71+i0P6uCvg8UdE7Hidm6w==
X-Received: by 2002:a1c:9911:: with SMTP id b17mr37411153wme.135.1593878245300; 
 Sat, 04 Jul 2020 08:57:25 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l3sm1161134wrx.22.2020.07.04.08.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 08:57:24 -0700 (PDT)
Subject: Re: gmake in Solaris 11.4: TFR missing
To: Michele Denber <denber@mindspring.com>, Thomas Huth <thuth@redhat.com>
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
 <3474053c-12d7-cf4a-5470-62845c166127@redhat.com>
 <5F00A1ED.6040909@mindspring.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <69adae2a-8c3c-ec17-08f4-c2109b1d0993@amsat.org>
Date: Sat, 4 Jul 2020 17:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5F00A1ED.6040909@mindspring.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/20 5:36 PM, Michele Denber wrote:
> On 07/04/20 08:02, Thomas Huth wrote:
>> TFR is a macro that is defined in our qemu-common.h header ... does it
>> work if you add a #include "qemu-common.h" somewhere at the beginning of
>> net/tap-solaris.c ?
> Yes, thank you, that fixed it:
> 
> root@hemlock:~/qemu-5.0.0# gmake -j16
> gmake[1]: Entering directory '/export/home/denber/qemu-5.0.0/slirp'
> grep: illegal option -- m
> Usage: grep [-c|-l|-q] -bhinsvw pattern file . . .
> gmake[1]: Nothing to be done for 'all'.
> gmake[1]: Leaving directory '/export/home/denber/qemu-5.0.0/slirp'
>         CHK version_gen.h
>   CC      net/tap-solaris.o
>   LINK    moxie-softmmu/qemu-system-moxie
>   LINK    cris-softmmu/qemu-system-cris
>   LINK    microblaze-softmmu/qemu-system-microblaze
>   LINK    microblazeel-softmmu/qemu-system-microblazeel
>   LINK    nios2-softmmu/qemu-system-nios2
>   LINK    lm32-softmmu/qemu-system-lm32
>   LINK    m68k-softmmu/qemu-system-m68k
>   LINK    hppa-softmmu/qemu-system-hppa
>   LINK    alpha-softmmu/qemu-system-alpha
>   LINK    mips64-softmmu/qemu-system-mips64
>   LINK    mips64el-softmmu/qemu-system-mips64el
>   LINK    mipsel-softmmu/qemu-system-mipsel
>   LINK    mips-softmmu/qemu-system-mips
>   LINK    i386-softmmu/qemu-system-i386
>   LINK    aarch64-softmmu/qemu-system-aarch64
>   LINK    arm-softmmu/qemu-system-arm
>   LINK    or1k-softmmu/qemu-system-or1k
>   CC      s390x-softmmu/gen-features
> /bin/sh: cc: not found

Odd...

Assuming you are using gcc, have you tried 'configure --host-cc=gcc'?

> gmake[1]: ***
> [/export/home/denber/qemu-5.0.0/target/s390x/Makefile.objs:25:
> /export/home/denber/qemu-5.0.0/s390x-softmmu/gen-features] Error 127
> gmake: *** [Makefile:527: s390x-softmmu/all] Error 2
> gmake: *** Waiting for unfinished jobs....
>   LINK    rx-softmmu/qemu-system-rx
>   LINK    riscv32-softmmu/qemu-system-riscv32
>   LINK    riscv64-softmmu/qemu-system-riscv64
>   LINK    ppc64-softmmu/qemu-system-ppc64
>   LINK    ppc-softmmu/qemu-system-ppc
> root@hemlock:~/qemu-5.0.0#
> 
> I still have one grep/ggrep issue and one "wrong sh" issue.  And it
> doesn't look like it really completed correctly because for example I see:
> 
> root@hemlock:~/qemu-5.0.0# cd x86_64-softmmu
> root@hemlock:~/qemu-5.0.0/x86_64-softmmu# ls
> config-devices.mak      config-devices.mak.old  Makefile
> config-devices.mak.d    config-target.mak
> root@hemlock:~/qemu-5.0.0/x86_64-softmmu#
> 
> So even though gmake finished, it didn't make at least one VM.  Is that
> because of the two remaining errors?

From the LINK error message you pasted, you successfully built various
QEMU, but the s390x-softmmu one failed.

Try running for example the QEMU targetting ppc64-softmmu, by listing
the available machines:

$ ppc64-softmmu/qemu-system-ppc64 -machine help
Supported machines are:
40p                  IBM RS/6000 7020 (40p)
bamboo               bamboo
g3beige              Heathrow based PowerMAC
mac99                Mac99 based PowerMAC
mpc8544ds            mpc8544ds
...

> 
>             - Michele
> 


