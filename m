Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21230C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55B721479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/MI9kfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55B721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7kIy-0006O1-SC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 13:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7kHo-0005o2-1S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7kHm-0001gT-27
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:50:39 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i7kHk-0001ee-3P
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:50:36 -0400
Received: by mail-oi1-x242.google.com with SMTP id x7so11841546oie.13
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Y9TLubNb3Ha2bbz66ftc7rERo3hncbx4M1jAgpexu7s=;
 b=b/MI9kfLg+TqRuBJ5XLCgG4L/9QpHeJSFwRUtHf8qMKmQFeZOpOsVD2Oq5hlDG12nn
 XrZ/+SljWwl061gg2CfWbCTwJubYVb4/Ao9vXxTTj727ZCPXIRp5qrSEObm5GW4nyvoM
 ufJLYUjNn/cS3lgVo8hsmjcxPIDELHCZyK42ZmAsrBs78LcwC/CeVSyqzgUet9MhZr81
 QKkowcz7jjJBYhJe8hmvQtX+DxU4v73q3O7l02G0htZlDAlvoHnV6CWOJBq90358Mi4G
 r6Vuh4uYwMUxut9opSnMVIKUlL4NnVFlgHkqiWVpYKax1i0SS3zSRAjO8xQYEChOeWs6
 Xc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Y9TLubNb3Ha2bbz66ftc7rERo3hncbx4M1jAgpexu7s=;
 b=ZR7Z4ANXh2KehAzFJqGzDefI5w4Q5CyzW2W7U89XbkqUXeNgeLv+Z/BTvbn7MQPR46
 L4iyjea8xEtfteF/WCDrxbcbhzzZJcSPsJuCCKBZVCfP343y6hoWvocaycCbaX3i6Ns9
 seWydyC/Byd+7sxCjr/nkXBtaL6jkteEXgg8v0n+lSBdv7TSaC/NeiNlsmyX2XGa8Nns
 590qpHqgm807dEOFXZj5yJbBbx8RapopdTwhyNAXO+sOEGW5y6iu7dgl81vt88gKMGzQ
 5ApAJ0N47AHnrGEb+KMKvie6ZO4UMO7XUqPgzawPeATPdBCHvhwJdxOpkkvpWWyuvX2d
 7m1A==
X-Gm-Message-State: APjAAAWi3YhoZOTUScjlPVlscO++hKZfl6kVdSIJoRnJrBFy2JALVmEr
 0YrQw39Udf4H7vPK8ez/m2M04WRvny5RRHd+r4M=
X-Google-Smtp-Source: APXvYqx8hC9+Y66zA3B9GQwVYVahENCx6IUEQeZYIQN8y/B5svgX3QaJT1fqzPmSl+pLoPzx8/yQP/isYPNXaIiO6Co=
X-Received: by 2002:a05:6808:7:: with SMTP id u7mr681370oic.136.1568137835051; 
 Tue, 10 Sep 2019 10:50:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 10:50:33
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 10:50:33
 -0700 (PDT)
In-Reply-To: <CAL1e-=gpYhsrhb1B8UPNhd-uTo-B60jtdxEZSFTauS_+HYee9w@mail.gmail.com>
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com> <87blvy99y9.fsf@linaro.org>
 <tencent_541F04AB1A100DF25C334D8C@qq.com> <87zhjh7pf0.fsf@linaro.org>
 <tencent_479D109A5BEC536D64AE43BF@qq.com>
 <CAL1e-=gpYhsrhb1B8UPNhd-uTo-B60jtdxEZSFTauS_+HYee9w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 10 Sep 2019 19:50:33 +0200
Message-ID: <CAL1e-=jb5qrtikifPoqUdc0_rgqXPfnUMMhafmXXw62x+ANu1Q@mail.gmail.com>
To: Libo Zhou <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

10.09.2019. 19.26, aleksandar.m.mail@gmail.com =D1=98=D0=B5 =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 10.09.2019. 11.57, "Libo Zhou" <zhlb29@foxmail.com> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > Hi Alex,
> >
> > gdb says remote 'g' packet reply is too long, and then prints out a
long string of zeros and some other digits sparsely.
> >
> > I have tried a lot of combinations of flags but I just can't get it
running properly. Do you know what is causing this error?
> >
>
> This is a known bug, actually in gdb, but there is a workaround is to
rollback a commit made  around a year ago in QEMU, about 64-bit FPU Mips
registers.

More previsely, reverting
https://github.com/qemu/qemu/commit/8e0b373f8aa4b9feec7b44029455587e2e3d2b0=
f
would most likely rrmove your problem.

Aleksandar

> Or you can fix the buffer size in gdb.
>
> Aleksandar
>
> > Cheers,
> > Libo
> >
> >
> > ------------------ Original ------------------
> > From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
> > Send time: Friday, Sep 6, 2019 5:19 PM
> > To: "Libo Zhou"<zhlb29@foxmail.com>;
> > Cc: "qemu-devel"<qemu-devel@nongnu.org>; "Aleksandar Markovic"<
aleksandar.m.mail@gmail.com>;
> > Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> >
> >
> > Libo Zhou <zhlb29@foxmail.com> writes:
> >
> > > Hi Alex,
> > >
> > >
> > > I just need to log the registers and memory after the program finishe=
s
> > > its execution. Is it possible to add this functionality myself?
> >
> > You'll need to set some sort of breakpoint on the last instruction so
> > gdb can inspect things before the program is unloaded. I think it's
> > possible to wire poweroff events to the gdbstub but I haven't looked
> > into that myself.
> >
> > > As for the GDB option, can you tell me the specific steps to do that?
I've tried it myself but I had no luck getting it running due to me being
new to all this.
> > >
> >
> > For linux-user:
> >
> >   $QEMU -g 1234 $PRG
> >
> > for system emulation
> >
> >   $QEMU -s -S
> >
> > and then on the gdb end:
> >
> >   gdb $BIN -ex "target remote localhost:1234"
> >
> > and then you can operate as you normally do with a gdb session. GDB has
> > two scripting interfaces. The command mode is basically a list of gdb
> > commands but might work for what you want. If you want to be a bit more
> > programatic you can use python. See the example in
> > tests/guest-debug/test-gdbstub.py
> >
> > >
> > > Thanks,
> > > Libo
> > >
> > >
> > >
> > > ------------------ Original ------------------
> > > From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
> > > Send time: Thursday, Sep 5, 2019 8:58 PM
> > > To: "qemu-devel"<qemu-devel@nongnu.org>;
> > > Cc: "Aleksandar Markovic"<aleksandar.m.mail@gmail.com>;
> > > Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> > >
> > >
> > >
> > >
> > > Libo Zhou <zhlb29@foxmail.com> writes:
> > >
> > >> Do you know where in the source file I should look into to add my
custom logging functionality?
> > >>
> > >>
> > >> Or, would you suggest using gdb to look at my target register and
memory contents? The answer in this link below looks really promising. I'm
gonna give it a try first.
> > >>
> > >>
https://stackoverflow.com/questions/39503997/how-to-run-a-single-line-of-as=
sembly-then-see-r1-and-condition-flags
> > >
> > > The gdbstub should allow you do full introspection and adding
> > > additional registers is fairly easy, see FOO_gdb_[set|get]_reg helper=
s
> > > in the appropriate target/FOO directories.
> > >
> > >> However, if I am able to customize log, it will be super convenient.
> > >
> > > So you want something above what -d cpu will show you?
> > >
> > >>
> > >>
> > >>
> > >> Cheers,
> > >>
> > >> Libo
> > >>
> > >>
> > >>
> > >> ------------------ Original ------------------
> > >> From:  "Aleksandar Markovic";<aleksandar.m.mail@gmail.com>;
> > >> Send time: Thursday, Sep 5, 2019 6:54 PM
> > >> To: "Libo Zhou"<zhlb29@foxmail.com>;
> > >> Cc: "qemu-devel"<qemu-devel@nongnu.org>;
> > >> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> > >>
> > >>
> > >>
> > >> 04.09.2019. 05.23, "Libo Zhou" <zhlb29@foxmail.com> ?=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >>>
> > >>> Hi Aleksandar,
> > >>>
> > >>> I have spent some time looking at your MXU ASE patch. It's super
helpful.
> > >> I need to do exactly the same thing as you did.
> > >>>
> > >>> Now I just need a way to observe the memory and register file
contents to
> > >> debug my instruction set simulator. I played with the "-d" switch to
log a
> > >> bunch of information, but it seems that none of the items is of my
> > >> interest. The "-d cpu_reset" option displays all zeros in the GPR
log.
> > >>>
> > >>
> > >> It looks you need a custom logging tailored to your needs, based on
> > >> intercepting the instructions you added.
> > >>
> > >> Aleksandar
> > >>
> > >>> Please take your time, as I fully understand you need to work on
Qemu
> > >> while answering all my questions. Again, thank you very much for
your help!
> > >>>
> > >>> Cheers,
> > >>> Libo
> > >>>
> >
> >
> > --
> > Alex Benn=C3=A9e
