Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E846C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D26521019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaSAnodL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D26521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jvq-00053a-Ca
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 13:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7jv1-0004bd-Pz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7juz-0006c1-Me
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:27:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i7juz-0006ba-FK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:27:05 -0400
Received: by mail-ot1-x341.google.com with SMTP id 21so19713419otj.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=25hrhwGicNJyMm8CCs3Yp0jOeMd8P7h558nFEJdGIcE=;
 b=AaSAnodLf8l1bt9swTk+bKYMlqE8rEBJCQpvXT2ZNLBjlf8+HRDMGl6xHEl7zPdcak
 MelmpKLnsztSEABEmNtaBN85cmJ6AK0o85QkE/CFuSKG4FuGXs8EFmJL7/SEvjLq49aX
 eC1SpVSRSLy0bYboB71DlbSq6I9oCzp2R22ARxgumvYMxTMFJkgC6gl1dG2Ty378SRzR
 BiNgYk8UYUPdp1TsDpY9iBlxXZBAhZLT8DPFFwB16IKdvijYNlW5J0PI+FrSRgwq76pB
 ze1xQYgOyiDFSp4chxyXJb98hpjyrarbYPWRA7q+YXfRrjZI+l0ST3iZdcNoSkHESdbs
 /HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=25hrhwGicNJyMm8CCs3Yp0jOeMd8P7h558nFEJdGIcE=;
 b=jGQKpSpB6RM9ERUmtNTRBkVRs0cNmUb4tXIMeI2ovQmRbZ0NYd08Bf4b4bBKxnU7+i
 mlcPYcQnjtPrfCammo39TpKSuQCG3OOnBSDll260rVkr9L9vo0f5bJFqNTw1YH4Tsrdv
 IL7rDXyR3nPQ+L1YdLmaEFpiRxYi4MP0ikJ9/xWKFVvCLvDt8Sg5LrWKIlJ+RxNIQRXi
 F/WnVJx65X0yeRyOjY9umhSmm52Z9CpTlXVADcmkT6EvhZkLqLnCPvRWpL15ziSXAPbO
 IUnc6Z8X3rxsmVi945N2SmoMtwwMLkMsLfEdLfvu0LZ8fIuLOgZd+SCvtbm8XzSDAYOq
 0VOw==
X-Gm-Message-State: APjAAAU4Gb3khGrNMmm7+KQB86zM2odysMR/U4aHHQlDDx755zToBwLS
 LZrypJxPF1Qx8bMEX7F8yBOqHhvRz/RvOa1laIw=
X-Google-Smtp-Source: APXvYqwJ4UnkIovhGcqOJhdlTNBgi56HAPU+++cR1ir+g6fl+sdg3TXI38C6h/h+1XYDcNy6lWEBADLhSW9HAwANYvQ=
X-Received: by 2002:a9d:6014:: with SMTP id h20mr3134852otj.306.1568136424542; 
 Tue, 10 Sep 2019 10:27:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 10:27:03
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 10:27:03
 -0700 (PDT)
In-Reply-To: <tencent_479D109A5BEC536D64AE43BF@qq.com>
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com> <87blvy99y9.fsf@linaro.org>
 <tencent_541F04AB1A100DF25C334D8C@qq.com> <87zhjh7pf0.fsf@linaro.org>
 <tencent_479D109A5BEC536D64AE43BF@qq.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 10 Sep 2019 19:27:03 +0200
Message-ID: <CAL1e-=gpYhsrhb1B8UPNhd-uTo-B60jtdxEZSFTauS_+HYee9w@mail.gmail.com>
To: Libo Zhou <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

10.09.2019. 11.57, "Libo Zhou" <zhlb29@foxmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Alex,
>
> gdb says remote 'g' packet reply is too long, and then prints out a long
string of zeros and some other digits sparsely.
>
> I have tried a lot of combinations of flags but I just can't get it
running properly. Do you know what is causing this error?
>

This is a known bug, actually in gdb, but there is a workaround is to
rollback a commit made  around a year ago in QEMU, about 64-bit FPU Mips
registers. Or you can fix the buffer size in gdb.

Aleksandar

> Cheers,
> Libo
>
>
> ------------------ Original ------------------
> From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
> Send time: Friday, Sep 6, 2019 5:19 PM
> To: "Libo Zhou"<zhlb29@foxmail.com>;
> Cc: "qemu-devel"<qemu-devel@nongnu.org>; "Aleksandar Markovic"<
aleksandar.m.mail@gmail.com>;
> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>
>
> Libo Zhou <zhlb29@foxmail.com> writes:
>
> > Hi Alex,
> >
> >
> > I just need to log the registers and memory after the program finishes
> > its execution. Is it possible to add this functionality myself?
>
> You'll need to set some sort of breakpoint on the last instruction so
> gdb can inspect things before the program is unloaded. I think it's
> possible to wire poweroff events to the gdbstub but I haven't looked
> into that myself.
>
> > As for the GDB option, can you tell me the specific steps to do that?
I've tried it myself but I had no luck getting it running due to me being
new to all this.
> >
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
> >
> > Thanks,
> > Libo
> >
> >
> >
> > ------------------ Original ------------------
> > From:  "Alex Benn=C3=A9e";<alex.bennee@linaro.org>;
> > Send time: Thursday, Sep 5, 2019 8:58 PM
> > To: "qemu-devel"<qemu-devel@nongnu.org>;
> > Cc: "Aleksandar Markovic"<aleksandar.m.mail@gmail.com>;
> > Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> >
> >
> >
> >
> > Libo Zhou <zhlb29@foxmail.com> writes:
> >
> >> Do you know where in the source file I should look into to add my
custom logging functionality?
> >>
> >>
> >> Or, would you suggest using gdb to look at my target register and
memory contents? The answer in this link below looks really promising. I'm
gonna give it a try first.
> >>
> >>
https://stackoverflow.com/questions/39503997/how-to-run-a-single-line-of-as=
sembly-then-see-r1-and-condition-flags
> >
> > The gdbstub should allow you do full introspection and adding
> > additional registers is fairly easy, see FOO_gdb_[set|get]_reg helpers
> > in the appropriate target/FOO directories.
> >
> >> However, if I am able to customize log, it will be super convenient.
> >
> > So you want something above what -d cpu will show you?
> >
> >>
> >>
> >>
> >> Cheers,
> >>
> >> Libo
> >>
> >>
> >>
> >> ------------------ Original ------------------
> >> From:  "Aleksandar Markovic";<aleksandar.m.mail@gmail.com>;
> >> Send time: Thursday, Sep 5, 2019 6:54 PM
> >> To: "Libo Zhou"<zhlb29@foxmail.com>;
> >> Cc: "qemu-devel"<qemu-devel@nongnu.org>;
> >> Subject:  Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
> >>
> >>
> >>
> >> 04.09.2019. 05.23, "Libo Zhou" <zhlb29@foxmail.com> ?=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>>
> >>> Hi Aleksandar,
> >>>
> >>> I have spent some time looking at your MXU ASE patch. It's super
helpful.
> >> I need to do exactly the same thing as you did.
> >>>
> >>> Now I just need a way to observe the memory and register file
contents to
> >> debug my instruction set simulator. I played with the "-d" switch to
log a
> >> bunch of information, but it seems that none of the items is of my
> >> interest. The "-d cpu_reset" option displays all zeros in the GPR log.
> >>>
> >>
> >> It looks you need a custom logging tailored to your needs, based on
> >> intercepting the instructions you added.
> >>
> >> Aleksandar
> >>
> >>> Please take your time, as I fully understand you need to work on Qemu
> >> while answering all my questions. Again, thank you very much for your
help!
> >>>
> >>> Cheers,
> >>> Libo
> >>>
>
>
> --
> Alex Benn=C3=A9e
