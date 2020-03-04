Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD79C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B8B2073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLLUFrJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B8B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9S6y-0001MG-AX
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j9S6L-0000ub-QX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j9S6K-0002z9-Mj
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:22:09 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:46310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1j9S6K-0002yv-EI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:22:08 -0500
Received: by mail-lf1-x142.google.com with SMTP id v6so1171530lfo.13
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 03:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ITHPvdsRCF0Ldjj++RwmPeQI1GB2rx6UwMZaEn2Ci/E=;
 b=uLLUFrJulnToIufo3xJIzpivg013baun3VWPvIWKDDRiGdrAlQkdzCSZmfohXHLHRr
 OLjKRRuEAHH5JVX/+RaGq+XYOuVYnqw6awb+KofyerZqoeiSRmBdPOMGdyWIn+18oABC
 W1TWxDjOLV4qsGamfqKSHFR6zbwvaoMQwtWJ2c/k5MG9HfYWaGy2gad8C+Yt48iwj0im
 gTITt9s8xDVz78c/Y0PtZ/AyGM+4ogx6ocVjJXYvsiCwZBBC+xgkP23P51pMFIR/+wNU
 hEF4zkRsDjXbYFrp2UF410TEU5UoFyegvL/1G53lRAZZhygJnnkHWrxalFFEWFodyr8o
 RRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ITHPvdsRCF0Ldjj++RwmPeQI1GB2rx6UwMZaEn2Ci/E=;
 b=PuXpNn4Govf5gR6U0APK1ojJvNnQ05QhgVW+/r9hyGzcOz6bLdIRxi1IOVA0m72x8L
 /P7c8JOG4kto5J1ZFMG6Kjzfu6KaBKUdQcmJN+wX+SQMBiIutxzUomnWw7nbvp82MqML
 YVtkWXjXn4Ml3CEbO1VpH0OnytApT6kRrQfQIuSVUthbvg/02RK75OE6Vl/9az0Uz3yu
 iCUeRpXklByhlamwZSWTK1AGrSV6ChdTWU6cnauCTvBrsvMHDbSx0TWPAgJJw3S5SXzW
 UJJzs17njJ7h7Feu1j4hjq7DaFllIHtmHewYcNQxED3IqDn2j5cLGQJT7dCjaLqkUIN9
 i6UA==
X-Gm-Message-State: ANhLgQ2wke8nN8IHa5hEnr83Nio6pxC7oOUEKgpsxc02KMYz1to/3oOC
 iQ5XQzpqP3iqIWMALqTLeaZBa/B3G5a57zgQuiY=
X-Google-Smtp-Source: ADFU+vtW16Xw1wEVYaKuAlaqUcTBWLWWaoU5AmNmYFmTmghMIjh/kMdK+NPrYTaov+Q6TfhO8dLGwSrJuSue+v7emx4=
X-Received: by 2002:a05:6512:33b0:: with SMTP id
 i16mr719400lfg.210.1583320927292; 
 Wed, 04 Mar 2020 03:22:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
 <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
 <CAJSP0QW2ooLK_0Hr52h8HYdmm2j6CunTAnhFxS3De=azMutUeA@mail.gmail.com>
 <CAPV47zc6R1fX_RrEzLQkQuRtjKK87HNtmkgnxazZGOESGERwxw@mail.gmail.com>
 <CAJSP0QUoqdRiQp6zCWpsPQ_iM4K-BgAFCDoqU4ca0dafd3-rNw@mail.gmail.com>
 <CAPV47zd19obqLMFKeOhvaD9AbThyii_QqtHSHE57YxLW7_8JEQ@mail.gmail.com>
In-Reply-To: <CAPV47zd19obqLMFKeOhvaD9AbThyii_QqtHSHE57YxLW7_8JEQ@mail.gmail.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Wed, 4 Mar 2020 16:51:56 +0530
Message-ID: <CAPV47zc70CZnqqXdmZmsP0p-gLV_Ko4VKQDdSUuS-3+Kd285zQ@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006fd07805a005a159"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006fd07805a005a159
Content-Type: text/plain; charset="UTF-8"

 > I have commented all the lines of other hardware models except custom
device line *" common-obj-$(CONFIG_TESTPCI) += testpci.o "*.
> But when I run *make* I get errors  similar to error shown in file which
I have shared with you in previous replies.
Above custom device I am building for Qemu ARM(32 bit architecture)

When I tried building  custom devicefor Qemu RISCV(32 bit architecture),
*make* get successfully executed and I get my custom device *.o and .d *files
in build/hw/misc directory.

I think there might be some problems with missing libraries for ARM
architecture ?




On Wed, 4 Mar 2020 at 16:45, Priyamvad Acharya <priyamvad.agnisys@gmail.com>
wrote:

> Hi,
> I have commented all the lines of other hardware models except custom
> device line *" common-obj-$(CONFIG_TESTPCI) += testpci.o "*.
> But when I run *make* I get errors  similar to error shown in file which
> I have shared with you in previous replies.
>
> Thanks,
> Priyamvad
>
> On Wed, 4 Mar 2020 at 02:05, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
>> On Tue, Mar 3, 2020 at 5:12 PM Priyamvad Acharya
>> <priyamvad.agnisys@gmail.com> wrote:
>> > > These errors are probably due to the Makefile.objs changes in your
>> commit:
>> >
>> > If I am not wrong, we need to add a rule i.e "
>> common-obj-$(CONFIG_TESTPCI) += testpci.o " in Makefile.objs to compile
>> custom device in Qemu.
>> > Shall I should remove that rule to remove the errors?
>>
>> No, keep that line.  All the other changes to Makefile.objs in that
>> commit seem spurious though and should be removed.
>>
>> Stefan
>>
>

--0000000000006fd07805a005a159
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<div><span style=3D"color:rgb(61,133,198)">&gt; I have commented all the li=
nes of other hardware models except custom device line=20
<b><span>&quot; common-obj-$(CONFIG_TESTPCI) +=3D testpci.o &quot;</span></=
b>.<br></span></div><div><span style=3D"color:rgb(61,133,198)">&gt; But whe=
n I run <b>make</b> I get errors=C2=A0 similar to error shown in file which=
 I have shared with you in previous replies.</span></div><div><span style=
=3D"color:rgb(0,0,0)">Above custom device I am building for Qemu ARM(32 bit=
 architecture)</span></div><div><span style=3D"color:rgb(0,0,0)"><br></span=
></div><div><span style=3D"color:rgb(0,0,0)">When I tried building=C2=A0 cu=
stom devicefor Qemu RISCV(32 bit architecture), <b>make</b> get successfull=
y executed and I get my custom device <b>.o and .d </b>files in build/hw/mi=
sc directory. <br></span></div><div><span style=3D"color:rgb(0,0,0)"><br></=
span></div><div><span style=3D"color:rgb(0,0,0)">I think there might be som=
e problems with missing libraries for ARM architecture ?</span></div><div><=
span style=3D"color:rgb(0,0,0)"><br></span></div><div><span style=3D"color:=
rgb(0,0,0)"><br></span></div><div><br></div>

</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Wed, 4 Mar 2020 at 16:45, Priyamvad Acharya &lt;<a href=3D"mailto:priyam=
vad.agnisys@gmail.com">priyamvad.agnisys@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi,=
</div><div>I have commented all the lines of other hardware models except c=
ustom device line=20
<b><span>&quot; common-obj-$(CONFIG_TESTPCI) +=3D testpci.o &quot;</span></=
b>.</div><div>But when I run <b>make</b> I get errors=C2=A0 similar to erro=
r shown in file which I have shared with you in previous replies.</div><div=
><br></div><div>Thanks,</div><div>Priyamvad<br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 4 Mar 2020 a=
t 02:05, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" target=
=3D"_blank">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Tue, Mar 3, 2020 at 5:12 PM Priyamvad Acha=
rya<br>
&lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=3D"_blank">priyam=
vad.agnisys@gmail.com</a>&gt; wrote:<br>
&gt; &gt; These errors are probably due to the Makefile.objs changes in you=
r commit:<br>
&gt;<br>
&gt; If I am not wrong, we need to add a rule i.e &quot; common-obj-$(CONFI=
G_TESTPCI) +=3D testpci.o &quot; in Makefile.objs to compile custom device =
in Qemu.<br>
&gt; Shall I should remove that rule to remove the errors?<br>
<br>
No, keep that line.=C2=A0 All the other changes to Makefile.objs in that<br=
>
commit seem spurious though and should be removed.<br>
<br>
Stefan<br>
</blockquote></div>
</blockquote></div>

--0000000000006fd07805a005a159--

