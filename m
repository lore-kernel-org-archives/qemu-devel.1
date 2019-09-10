Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DEAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E310C20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxrDA76f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E310C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7f6t-0002YD-Ra
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7ez2-0006rs-61
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7ez0-0006br-Im
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:10:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7ez0-0006bW-Bj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:10:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id l16so19645935wrv.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FNkprozFWA/t33fefFE6+Hin4xa5HD7FxxY1lfUMouw=;
 b=mxrDA76fQ1YNsFrSvgIlpShaZE4FgPOnoyJVV/KyGhWaAbnXqZYeHvZ3Inx3eorobQ
 HqrcaXRwVimthVqj34QRMrkGvijg4teFzPAoq/bbR47MBKtAqneLhs04FLzZoANn6lOQ
 Uhvr+TTZwKnvno/Wq+5YGCGyRwupIkxxCMBwULqQxQPRuVdOCnxVd4rip87Nsm4dHxs+
 mdO1LuwhX8IyieMrTVOomfQOcwhrGxQqh971oo/Adaow14l0k2DnS9KKkHgXw1GtkhTL
 gXydGYnoRNmq7u1pFg96J9YMTBsUO9eIiYw7M28FRLU/4uci4uL3bMMe3npafTVSsQoS
 6Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FNkprozFWA/t33fefFE6+Hin4xa5HD7FxxY1lfUMouw=;
 b=ndRnNQzeEIr3ZiZy5G8FW5rwujTUS1fhsQGv9Vltd6BLKppttLsis9qg4l2gfPsFhZ
 lWw9Lclb5dFeX+JxLvu/ZvBgkOIhfyoDdGp0q7hbsekeKQ1yfWipuKrelI7bXbZgE9et
 KIOvCLK/X/n/ba/+XPVbNs462Eqd4Fa0T5rth5Seq8Nsgh1Ngs7SQE5XSOpLt+8L7hi6
 AI7Hi+kmBUvMCmMF7c/hvHYATac/P7qUfwWGAKi/PWCiCLYsPApOHGbcJQSmuoUwkA+c
 K8VDD2Y0ova9yiv8iPveb+GTSa33RM8RT9WUC8r5u7RwZjrg0eHJJZFEh5kkGtBR2qMF
 n7wA==
X-Gm-Message-State: APjAAAUjgv59aR2/uJT/+RHCqpuUvVLG9KE9dc3XftgNNkzpOaokRkPM
 C5cQpb5c/Nl4kLU9n9XDUu63MQ==
X-Google-Smtp-Source: APXvYqzP6O1IOiME8YhwxB/X8zY7J9te1zKit9ZSZS4U2HyldmP/ZjIRhWfMVRVcpwS6lNm9hsFpLA==
X-Received: by 2002:adf:ea8f:: with SMTP id s15mr25059893wrm.222.1568117452970; 
 Tue, 10 Sep 2019 05:10:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c1sm2727393wmk.20.2019.09.10.05.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 05:10:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8906F1FF87;
 Tue, 10 Sep 2019 13:10:51 +0100 (BST)
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com> <87blvy99y9.fsf@linaro.org>
 <tencent_541F04AB1A100DF25C334D8C@qq.com> <87zhjh7pf0.fsf@linaro.org>
 <tencent_479D109A5BEC536D64AE43BF@qq.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Libo Zhou <zhlb29@foxmail.com>
In-reply-to: <tencent_479D109A5BEC536D64AE43BF@qq.com>
Date: Tue, 10 Sep 2019 13:10:51 +0100
Message-ID: <87k1ag1hdg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
> gdb says remote 'g' packet reply is too long, and then prints out a
> long string of zeros and some other digits sparsely.

Sounds like your gdb isn't multiarch aware. Debian/Ubuntu have multiarch
binutils which are aware of more than just the host architecture.

>
>
> I have tried a lot of combinations of flags but I just can't get it runni=
ng properly. Do you know what is causing this error?
>
>
> Cheers,
>
> Libo
>
>
>
>
>
> ------------------ Original ------------------
> From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
> Send time: Friday, Sep 6, 2019 5:19 PM
> To: "Libo Zhou"<zhlb29@foxmail.com>;
> Cc: "qemu-devel"<qemu-devel@nongnu.org>; "Aleksandar Markovic"<aleksandar=
.m.mail@gmail.com>;
> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>
>
>
>
> Libo Zhou <zhlb29@foxmail.com> writes:
>
>> Hi Alex,
>>
>>
>> I just need to log the registers and memory after the program finishes
>> its execution. Is it possible to add this functionality myself?
>
> You'll need to set some sort of breakpoint on the last instruction so
> gdb can inspect things before the program is unloaded. I think it's
> possible to wire poweroff events to the gdbstub but I haven't looked
> into that myself.
>
>> As for the GDB option, can you tell me the specific steps to do that? I'=
ve tried it myself but I had no luck getting it running due to me being new=
 to all this.
>>
>
> For linux-user:
>
>   $QEMU -g 1234 $PRG
>
> for system emulation
>
>   $QEMU -s -S
>
> and then on the gdb end:
>
>   gdb $BIN -ex "target remote localhost:1234"
>
> and then you can operate as you normally do with a gdb session. GDB has
> two scripting interfaces. The command mode is basically a list of gdb
> commands but might work for what you want. If you want to be a bit more
> programatic you can use python. See the example in
> tests/guest-debug/test-gdbstub.py
>
>>
>> Thanks,
>> Libo
>>
>>
>>
>> ------------------ Original ------------------
>> From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
>> Send time: Thursday, Sep 5, 2019 8:58 PM
>> To: "qemu-devel"<qemu-devel@nongnu.org>;
>> Cc: "Aleksandar Markovic"<aleksandar.m.mail@gmail.com>;
>> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>>
>>
>>
>>
>> Libo Zhou <zhlb29@foxmail.com> writes:
>>
>>> Do you know where in the source file I should look into to add my custo=
m logging functionality?
>>>
>>>
>>> Or, would you suggest using gdb to look at my target register and memor=
y contents? The answer in this link below looks really promising. I'm gonna=
 give it a try first.
>>>
>>> https://stackoverflow.com/questions/39503997/how-to-run-a-single-line-o=
f-assembly-then-see-r1-and-condition-flags
>>
>> The gdbstub should allow you do full introspection and adding
>> additional registers is fairly easy, see FOO_gdb_[set|get]_reg helpers
>> in the appropriate target/FOO directories.
>>
>>> However, if I am able to customize log, it will be super convenient.
>>
>> So you want something above what -d cpu will show you?
>>
>>>
>>>
>>>
>>> Cheers,
>>>
>>> Libo
>>>
>>>
>>>
>>> ------------------ Original ------------------
>>> From:  "Aleksandar Markovic";<aleksandar.m.mail@gmail.com>;
>>> Send time: Thursday, Sep 5, 2019 6:54 PM
>>> To: "Libo Zhou"<zhlb29@foxmail.com>;
>>> Cc: "qemu-devel"<qemu-devel@nongnu.org>;
>>> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>>>
>>>
>>>
>>> 04.09.2019. 05.23, "Libo Zhou" <zhlb29@foxmail.com> ?=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>>>
>>>> Hi Aleksandar,
>>>>
>>>> I have spent some time looking at your MXU ASE patch. It's super helpf=
ul.
>>> I need to do exactly the same thing as you did.
>>>>
>>>> Now I just need a way to observe the memory and register file contents=
 to
>>> debug my instruction set simulator. I played with the "-d" switch to lo=
g a
>>> bunch of information, but it seems that none of the items is of my
>>> interest. The "-d cpu_reset" option displays all zeros in the GPR log.
>>>>
>>>
>>> It looks you need a custom logging tailored to your needs, based on
>>> intercepting the instructions you added.
>>>
>>> Aleksandar
>>>
>>>> Please take your time, as I fully understand you need to work on Qemu
>>> while answering all my questions. Again, thank you very much for your h=
elp!
>>>>
>>>> Cheers,
>>>> Libo
>>>>


--
Alex Benn=C3=A9e

