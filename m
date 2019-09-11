Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4CCC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B042075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHjFcZEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B042075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82Q6-0008Al-4T
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i82Nl-0005bB-0o
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i82Ni-0001Ed-R3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:10:00 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i82Ni-0001DO-Kn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:09:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id t6so9240932otp.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jbhftcGdleJfkNdlhVjlUhgCm9GDPMmRbP+wLI60ZDI=;
 b=KHjFcZEgCJeIGtamudrPjnmX1ilcCHvZ+Ad1ZZ/91XElvC+llUJa1GLNTca1y1ULoZ
 spwkMJLx5pdH9Pu5Uu0ieGOl4DCacd8/uqR2cZUqyQnD6iCEuZAjVuri2/uLJr7VUj4C
 oh5PC9ODa3B/IoLmx5fMrHJVHANunGXhG2SECEZDNKF/P+Zswr4P4ch5kdMCfN5FI3VR
 x5unHOq8Z3WmBrCTghRtL7twtuFiR2S6qCzfEtEq9aTe/mb2/GXWncIplHmv54GHxtvT
 GUtdGd6Pd1ygX2I2QNgchHqO9K44LkvxsNNKvvLf3VFylBqf6dIFR89mxqxZvooDCBif
 sEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jbhftcGdleJfkNdlhVjlUhgCm9GDPMmRbP+wLI60ZDI=;
 b=H/16rH5w9D9k7B4rX7cfyYTujWwyQhFS+NV8xpRn97Sc0ZlfOUNHA5Fzv6KoO7WYqf
 MxQBKc/7ImAt3k8yHcVydNhg4t0pkgT3GJsCckvQvRksb7d6ZYTkIaspMNscxgsE1rsH
 dhVqeXBE82WP2q9OUs7cu+qWqH2OPSNys3YPStIHVADASTA5tr19BJiM7W5bZDKXAFQA
 79ER/dXi43RbqcD794+1kN28ix/VPUQPwUgSDUCWWUbjU8OF4ODO2hB/YkqFUs+10sWn
 oHqZUZ7tQ4BD8477Qk6pDRLZWqbxMBCVHcLlMppzoTxRQN1atnPNmU+kVqeEVOVuVzw4
 sAPw==
X-Gm-Message-State: APjAAAVXNzA3VnAgvhC7q5fBo/nfYZA6qn898jYnJ7Dv0gAiaKxOSlRm
 VbFu03g4arJYUf3yJ6NJhQf9qvxNyGyuUEvTdnA=
X-Google-Smtp-Source: APXvYqy8JfAd/AUGTAyd7bDa9fcK34B+DxHGekG+noQvge8USV9KSDj+vH1W8fjYep4vYaV2jhVf9lppZC69Ads4shA=
X-Received: by 2002:a9d:7989:: with SMTP id h9mr6532232otm.295.1568207397457; 
 Wed, 11 Sep 2019 06:09:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Wed, 11 Sep 2019 06:09:56
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Wed, 11 Sep 2019 06:09:56
 -0700 (PDT)
In-Reply-To: <CAL1e-=jb5qrtikifPoqUdc0_rgqXPfnUMMhafmXXw62x+ANu1Q@mail.gmail.com>
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com> <87blvy99y9.fsf@linaro.org>
 <tencent_541F04AB1A100DF25C334D8C@qq.com> <87zhjh7pf0.fsf@linaro.org>
 <tencent_479D109A5BEC536D64AE43BF@qq.com>
 <CAL1e-=gpYhsrhb1B8UPNhd-uTo-B60jtdxEZSFTauS_+HYee9w@mail.gmail.com>
 <CAL1e-=jb5qrtikifPoqUdc0_rgqXPfnUMMhafmXXw62x+ANu1Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 11 Sep 2019 15:09:56 +0200
Message-ID: <CAL1e-=gjVD7aEgLNto2Fy4Az9=RQEVV+RibgQRYvjWfpHYSd-g@mail.gmail.com>
To: Libo Zhou <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.09.2019. 19.50, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 10.09.2019. 19.26, aleksandar.m.mail@gmail.com =D1=98=D0=B5 =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >
> > 10.09.2019. 11.57, "Libo Zhou" <zhlb29@foxmail.com> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > Hi Alex,
> > >
> > > gdb says remote 'g' packet reply is too long, and then prints out a
long string of zeros and some other digits sparsely.
> > >
> > > I have tried a lot of combinations of flags but I just can't get it
running properly. Do you know what is causing this error?
> > >
> >
> > This is a known bug, actually in gdb, but there is a workaround is to
rollback a commit made  around a year ago in QEMU, about 64-bit FPU Mips
registers.
>
> More previsely, reverting
https://github.com/qemu/qemu/commit/8e0b373f8aa4b9feec7b44029455587e2e3d2b0=
f
would most likely rrmove your problem.
>
> Aleksandar
>

I am going to submit reverting of this commit to the list, since it created
problems for multiple users.

Aleksandar

> > Or you can fix the buffer size in gdb.
> >
> > Aleksandar
> >
> > > Cheers,
> > > Libo
> > >
> > >
> > > ------------------ Original ------------------
> > > From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
> > > Send time: Friday, Sep 6, 2019 5:19 PM
> > > To: "Libo Zhou"<zhlb29@foxmail.com>;
> > > Cc: "qemu-devel"<qemu-devel@nongnu.org>; "Aleksandar Markovic"<
aleksandar.m.mail@gmail.com>;
> > > Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> > >
> > >
> > > Libo Zhou <zhlb29@foxmail.com> writes:
> > >
> > > > Hi Alex,
> > > >
> > > >
> > > > I just need to log the registers and memory after the program
finishes
> > > > its execution. Is it possible to add this functionality myself?
> > >
> > > You'll need to set some sort of breakpoint on the last instruction so
> > > gdb can inspect things before the program is unloaded. I think it's
> > > possible to wire poweroff events to the gdbstub but I haven't looked
> > > into that myself.
> > >
> > > > As for the GDB option, can you tell me the specific steps to do
that? I've tried it myself but I had no luck getting it running due to me
being new to all this.
> > > >
> > >
> > > For linux-user:
> > >
> > >   $QEMU -g 1234 $PRG
> > >
> > > for system emulation
> > >
> > >   $QEMU -s -S
> > >
> > > and then on the gdb end:
> > >
> > >   gdb $BIN -ex "target remote localhost:1234"
> > >
> > > and then you can operate as you normally do with a gdb session. GDB
has
> > > two scripting interfaces. The command mode is basically a list of gdb
> > > commands but might work for what you want. If you want to be a bit
more
> > > programatic you can use python. See the example in
> > > tests/guest-debug/test-gdbstub.py
> > >
> > > >
> > > > Thanks,
> > > > Libo
> > > >
> > > >
> > > >
> > > > ------------------ Original ------------------
> > > > From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
> > > > Send time: Thursday, Sep 5, 2019 8:58 PM
> > > > To: "qemu-devel"<qemu-devel@nongnu.org>;
> > > > Cc: "Aleksandar Markovic"<aleksandar.m.mail@gmail.com>;
> > > > Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> > > >
> > > >
> > > >
> > > >
> > > > Libo Zhou <zhlb29@foxmail.com> writes:
> > > >
> > > >> Do you know where in the source file I should look into to add my
custom logging functionality?
> > > >>
> > > >>
> > > >> Or, would you suggest using gdb to look at my target register and
memory contents? The answer in this link below looks really promising. I'm
gonna give it a try first.
> > > >>
> > > >>
https://stackoverflow.com/questions/39503997/how-to-run-a-single-line-of-as=
sembly-then-see-r1-and-condition-flags
> > > >
> > > > The gdbstub should allow you do full introspection and adding
> > > > additional registers is fairly easy, see FOO_gdb_[set|get]_reg
helpers
> > > > in the appropriate target/FOO directories.
> > > >
> > > >> However, if I am able to customize log, it will be super
convenient.
> > > >
> > > > So you want something above what -d cpu will show you?
> > > >
> > > >>
> > > >>
> > > >>
> > > >> Cheers,
> > > >>
> > > >> Libo
> > > >>
> > > >>
> > > >>
> > > >> ------------------ Original ------------------
> > > >> From:  "Aleksandar Markovic";<aleksandar.m.mail@gmail.com>;
> > > >> Send time: Thursday, Sep 5, 2019 6:54 PM
> > > >> To: "Libo Zhou"<zhlb29@foxmail.com>;
> > > >> Cc: "qemu-devel"<qemu-devel@nongnu.org>;
> > > >> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> > > >>
> > > >>
> > > >>
> > > >> 04.09.2019. 05.23, "Libo Zhou" <zhlb29@foxmail.com> ?=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > > >>>
> > > >>> Hi Aleksandar,
> > > >>>
> > > >>> I have spent some time looking at your MXU ASE patch. It's super
helpful.
> > > >> I need to do exactly the same thing as you did.
> > > >>>
> > > >>> Now I just need a way to observe the memory and register file
contents to
> > > >> debug my instruction set simulator. I played with the "-d" switch
to log a
> > > >> bunch of information, but it seems that none of the items is of my
> > > >> interest. The "-d cpu_reset" option displays all zeros in the GPR
log.
> > > >>>
> > > >>
> > > >> It looks you need a custom logging tailored to your needs, based o=
n
> > > >> intercepting the instructions you added.
> > > >>
> > > >> Aleksandar
> > > >>
> > > >>> Please take your time, as I fully understand you need to work on
Qemu
> > > >> while answering all my questions. Again, thank you very much for
your help!
> > > >>>
> > > >>> Cheers,
> > > >>> Libo
> > > >>>
> > >
> > >
> > > --
> > > Alex Benn=C3=A9e
