Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5106C43140
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 09:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2202082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 09:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGDr3fwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2202082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6APR-0000RL-H0
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 05:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6AOm-0008RO-KZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6AOl-0005nd-2V
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:19:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6AOk-0005mL-Rj
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:19:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id c10so5724934wmc.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=XtTovzpRzpVjkfn+un6kPDttKdycrUBPIIyrlSd0KZs=;
 b=dGDr3fwee6tOhk5HYVU8AUFRZHUl7EhC8RrE4g1buW4og8rh7yh1cTsbp1jJwhu8yz
 G7PFbMx01jRqIL4HuxjkwYsAIdQselK45vmjEcDFO60+b9RPcvNXewwKtCGvRvTGN7bY
 SNJ5uZBwUjfeeGfoZGZu9S2ct+SLTrQLVt8cySVDRwanjkBY+pGlaZraSSKwQ8y5L47X
 4VXdcGKvwuibOzATNfEo5JJy9e475o17kCmawFBzuw+Q5bM23aFe4kI4YXlQ6/8PdDPb
 p3ybq743ZkCQMR3JuNKIcDza0/0vIPME61fve9/pciMG3Iz/e6JctVX2FxIbY8lXOCP0
 eSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=XtTovzpRzpVjkfn+un6kPDttKdycrUBPIIyrlSd0KZs=;
 b=DVV/2n+7ROzV9gj0W+7uLnaBiptlUvFV48vST+i/RYjKRY1xyU2YU382GbmOaHM0cR
 gF8rhWqqDu7WrxIxmqi8MQotBbR7daffkwib7NxtT0vMfu8q2coHdrEHkwSgiggWUUqR
 SdUP606QFoJt949hTZpr19Q84ELCoNcdGscEe6i93XEya3Tq4cfgX9rJJbli1mUp2j4k
 W6loqFVAFDS5PWcQNtf6N3vCU+ccIdz42hhxxJ+CYYbG5w8T5FoeIxM1herEDRUNmifk
 y3cR/wMZAy310Uq5M0Oki8VlLYmp3VppkkxhylUG7kKfbBY/4mTI0tbAAccg9LVxGoj9
 fsCQ==
X-Gm-Message-State: APjAAAWqiUK8Af3iHqdFThBqs0lWVI4WJnuoxat9586OwIF+X2aM7LP3
 ZmZNuukZwPAh2OkY8yVYBTVivA==
X-Google-Smtp-Source: APXvYqzX1way/wqQfoTzBM/WKPztJ5BTW/zvTKz+JTuMrEyUndvqcy6Uae6pRVp9wPPYYGWlK6jCDg==
X-Received: by 2002:a05:600c:214:: with SMTP id
 20mr6816732wmi.112.1567761557381; 
 Fri, 06 Sep 2019 02:19:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d28sm6212798wrb.95.2019.09.06.02.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 02:19:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99F911FF87;
 Fri,  6 Sep 2019 10:19:15 +0100 (BST)
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com> <87blvy99y9.fsf@linaro.org>
 <tencent_541F04AB1A100DF25C334D8C@qq.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Libo Zhou <zhlb29@foxmail.com>
In-reply-to: <tencent_541F04AB1A100DF25C334D8C@qq.com>
Date: Fri, 06 Sep 2019 10:19:15 +0100
Message-ID: <87zhjh7pf0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Libo Zhou <zhlb29@foxmail.com> writes:

> Hi Alex,
>
>
> I just need to log the registers and memory after the program finishes
> its execution. Is it possible to add this functionality myself?

You'll need to set some sort of breakpoint on the last instruction so
gdb can inspect things before the program is unloaded. I think it's
possible to wire poweroff events to the gdbstub but I haven't looked
into that myself.

> As for the GDB option, can you tell me the specific steps to do that? I'v=
e tried it myself but I had no luck getting it running due to me being new =
to all this.
>

For linux-user:

  $QEMU -g 1234 $PRG

for system emulation

  $QEMU -s -S

and then on the gdb end:

  gdb $BIN -ex "target remote localhost:1234"

and then you can operate as you normally do with a gdb session. GDB has
two scripting interfaces. The command mode is basically a list of gdb
commands but might work for what you want. If you want to be a bit more
programatic you can use python. See the example in
tests/guest-debug/test-gdbstub.py

>
> Thanks,
> Libo
>
>
>
> ------------------ Original ------------------
> From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
> Send time: Thursday, Sep 5, 2019 8:58 PM
> To: "qemu-devel"<qemu-devel@nongnu.org>;
> Cc: "Aleksandar Markovic"<aleksandar.m.mail@gmail.com>;
> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>
>
>
>
> Libo Zhou <zhlb29@foxmail.com> writes:
>
>> Do you know where in the source file I should look into to add my custom=
 logging functionality?
>>
>>
>> Or, would you suggest using gdb to look at my target register and memory=
 contents? The answer in this link below looks really promising. I'm gonna =
give it a try first.
>>
>> https://stackoverflow.com/questions/39503997/how-to-run-a-single-line-of=
-assembly-then-see-r1-and-condition-flags
>
> The gdbstub should allow you do full introspection and adding
> additional registers is fairly easy, see FOO_gdb_[set|get]_reg helpers
> in the appropriate target/FOO directories.
>
>> However, if I am able to customize log, it will be super convenient.
>
> So you want something above what -d cpu will show you?
>
>>
>>
>>
>> Cheers,
>>
>> Libo
>>
>>
>>
>> ------------------ Original ------------------
>> From:  "Aleksandar Markovic";<aleksandar.m.mail@gmail.com>;
>> Send time: Thursday, Sep 5, 2019 6:54 PM
>> To: "Libo Zhou"<zhlb29@foxmail.com>;
>> Cc: "qemu-devel"<qemu-devel@nongnu.org>;
>> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>>
>>
>>
>> 04.09.2019. 05.23, "Libo Zhou" <zhlb29@foxmail.com> ?=D0=B5 =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>>
>>> Hi Aleksandar,
>>>
>>> I have spent some time looking at your MXU ASE patch. It's super helpfu=
l.
>> I need to do exactly the same thing as you did.
>>>
>>> Now I just need a way to observe the memory and register file contents =
to
>> debug my instruction set simulator. I played with the "-d" switch to log=
 a
>> bunch of information, but it seems that none of the items is of my
>> interest. The "-d cpu_reset" option displays all zeros in the GPR log.
>>>
>>
>> It looks you need a custom logging tailored to your needs, based on
>> intercepting the instructions you added.
>>
>> Aleksandar
>>
>>> Please take your time, as I fully understand you need to work on Qemu
>> while answering all my questions. Again, thank you very much for your he=
lp!
>>>
>>> Cheers,
>>> Libo
>>>


--
Alex Benn=C3=A9e

