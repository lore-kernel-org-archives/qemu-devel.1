Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6629C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13875218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0exluPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13875218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5rLg-0001de-Nb
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 08:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5rL1-0001CU-8J
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5rKz-0000hA-N1
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:58:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5rKz-0000gX-Ex
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:58:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q12so2908891wmj.4
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=b0hkXbgDxU0NHGZx5PeJfquTqSsKvpRhMY6ZbddLuMM=;
 b=Q0exluPUmaGR8oNoa/hh3vmTGhtAUnyPd68qmdaLAcoYt1L2OExZVkYpgqJSdXUrej
 fsoLLd8WzMM+9sJrhk5SZ9Otg5hx9825O+8Da6TqanXVfe7Reo3VsaZOQ7jinlZvDR60
 NSP9hA1sAsWkX02shDC18hNIhmFosq5W29uCecABwd5mR9Hgxb5Pu0+Dy1XqQ/DIQUN0
 Zf3zMjGeli2ub5xW8jfTJOcGkQhVtRF9EY7iZd24h/EgXApvxizgF5XPrm5b5qY0aKs0
 xEkBdlaQzfE9xqBKN5WrCAT/WDJoWN1YmaPkXelY/AzvK0SEk2FDpjOYIpVceqs49izZ
 i+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=b0hkXbgDxU0NHGZx5PeJfquTqSsKvpRhMY6ZbddLuMM=;
 b=MXZCq2eeEDrZNeiw9b/b3Yd5gBAhUOk1psw8+XlcJT5CcxACP6WrVIh8aSNJ1uc7wL
 Whmmc+z2T3Stn/LaX2S/eOsELG4UXRAcXdgF9uUpfymYwudJ8lSZfgKHSRQmPBJCbLYQ
 hfZEJQ8suQXyyKKW/rxCd2cFKuUqObfOac7g7SAHn9xcuMXBwiC3dXhkPrgwH2atn6Y3
 3NePfnXHNWGOP6SvTe5sWv4J+jxjZTM+hvglPKU7ZYJECBHTwjkJO7jxciL0zqyhHZOl
 HE1ZW8oDMlZ3P+wJz2H+uRCDA0S2AscePDnli91IcfnVHW1ddYknSTqxQcG09zC0jQMG
 kkqA==
X-Gm-Message-State: APjAAAVDEPolWpAamj/SgFv5zSH4ljwsvMkDJ3j0EqVtP/p8oHwkNMJm
 jJfL6TcQEYM5HY72iGCz33vQrg==
X-Google-Smtp-Source: APXvYqy+IT6fusHSXGtzEvr+MoAWj5+rUE4nnvBRwnxrBOOpf022UkSjdnibYRzXcMdwKO6BDnmlew==
X-Received: by 2002:a1c:80ca:: with SMTP id b193mr2572076wmd.171.1567688287625; 
 Thu, 05 Sep 2019 05:58:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u68sm3909155wmu.12.2019.09.05.05.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 05:58:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 465721FF87;
 Thu,  5 Sep 2019 13:58:06 +0100 (BST)
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <tencent_23ACCA1A48AFB09124C52E70@qq.com>
Date: Thu, 05 Sep 2019 13:58:06 +0100
Message-ID: <87blvy99y9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Libo Zhou <zhlb29@foxmail.com> writes:

> Do you know where in the source file I should look into to add my custom =
logging functionality?
>
>
> Or, would you suggest using gdb to look at my target register and memory =
contents? The answer in this link below looks really promising. I'm gonna g=
ive it a try first.
>
> https://stackoverflow.com/questions/39503997/how-to-run-a-single-line-of-=
assembly-then-see-r1-and-condition-flags

The gdbstub should allow you do full introspection and adding
additional registers is fairly easy, see FOO_gdb_[set|get]_reg helpers
in the appropriate target/FOO directories.

> However, if I am able to customize log, it will be super convenient.

So you want something above what -d cpu will show you?

>
>
>
> Cheers,
>
> Libo
>
>
>
> ------------------ Original ------------------
> From:  "Aleksandar Markovic";<aleksandar.m.mail@gmail.com>;
> Send time: Thursday, Sep 5, 2019 6:54 PM
> To: "Libo Zhou"<zhlb29@foxmail.com>;
> Cc: "qemu-devel"<qemu-devel@nongnu.org>;
> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>
>
>
> 04.09.2019. 05.23, "Libo Zhou" <zhlb29@foxmail.com> ?=D0=B5 =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> Hi Aleksandar,
>>
>> I have spent some time looking at your MXU ASE patch. It's super helpful.
> I need to do exactly the same thing as you did.
>>
>> Now I just need a way to observe the memory and register file contents to
> debug my instruction set simulator. I played with the "-d" switch to log a
> bunch of information, but it seems that none of the items is of my
> interest. The "-d cpu_reset" option displays all zeros in the GPR log.
>>
>
> It looks you need a custom logging tailored to your needs, based on
> intercepting the instructions you added.
>
> Aleksandar
>
>> Please take your time, as I fully understand you need to work on Qemu
> while answering all my questions. Again, thank you very much for your hel=
p!
>>
>> Cheers,
>> Libo
>>


--
Alex Benn=C3=A9e

