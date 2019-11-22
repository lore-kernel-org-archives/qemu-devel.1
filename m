Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB04C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 09:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DAA20714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 09:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkiauVWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DAA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY5KH-0006UJ-BP
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 04:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iY5Ja-00065s-Ht
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iY5JX-0003Is-Sl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:33:22 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:40244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iY5JX-0003IQ-LT
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:33:19 -0500
Received: by mail-ot1-x32c.google.com with SMTP id m15so5616295otq.7
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=u4bcIQE1qteXmEhvkoOi9g208Si5XaC858z1CQmR0X4=;
 b=bkiauVWg5u4ZDtYTe3IMGaD7cbxVCNPE12QfmFSRAlGoEXPJUoWtwmSzXR0RxC7+Lk
 pgLG02hZ3lHZtMYmD7JZ5Xxp/q/I3w7N1rqRznfMKdSj9nsG3J9FB7nWiTssPo2PQ4ja
 0ryHgsi1x9GmM7fb/LVpvJXe/nWShr74tMaUThSzdz70tUoVmXmdAPvstx5Ebr0sBOSR
 B1YRwxHwb3OKb9yzurNE72ZuN9Ze0gOtADJNLA8PgbISiLFwNa+C5QCiG8Uej6nmPRyK
 JZHvo8cmyoUCOapWr50/IE1M5lcSKPkDcGm0wHQpwhwRL52gz7amCpCdLEOVmh8cxzdy
 ZHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=u4bcIQE1qteXmEhvkoOi9g208Si5XaC858z1CQmR0X4=;
 b=L2/NueAg2VfEN1mQbaDyUaTgHtWNHSQlh1QqlTNGGefQ6tGGjjRc1Sv9NmmwUkMH33
 byZeHogqQiUAlUl1kweibjWnrPIeMcbuETr33JebEMXun5bc+Eb4I63rpPGA7OEhrBg9
 RPuixpZvo0I7mH0hm007wTpjOGYPAmOsPwJXJIDZ/LF0G4c1duqbAfmwEaOG2Pwm+Cwd
 Fcbdk8VffG2W9nCPOOlrl+vOWp6Ei4fxIBp/W0HIe1O/ZPmBRDlUFErNg03WArQJql3X
 34o1NccMIaMj+7NkYXfEonAEEyRJhwpBGeq0F7MdfPmuUb47r62wOq/CjSjGLil9lUPP
 SMtg==
X-Gm-Message-State: APjAAAW4K9ZfuysRN3Uqk9C/Xw2zKmJm92uMySuxco4lAuJJTio77MsR
 YpIzEKBF6Mc6BsygBXfPbNoykAiyMYtjYPpisPA=
X-Google-Smtp-Source: APXvYqzGDMtbf3h9Mn6FDlfB7CJz9H46USRSp+45bbXj+nyTynUQiIXd24F/vK8cTmcYAz5APSgl1Ck432boN1RDPuA=
X-Received: by 2002:a9d:1b3:: with SMTP id e48mr10399721ote.341.1574415198638; 
 Fri, 22 Nov 2019 01:33:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Fri, 22 Nov 2019 01:33:17
 -0800 (PST)
In-Reply-To: <BYAPR02MB4886A045E76443674DA0F198DE4E0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <CAL1e-=gFBMPj938nrPYjvkOPuMQZTEP9OFiitwLLjekgCxRaKA@mail.gmail.com>
 <BYAPR02MB48868819DDB0818111D4E972DE4E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=gMvf-gx0WJ+xH0e8J84_JOkaACGA93B2XehuCAgiEyeQ@mail.gmail.com>
 <BYAPR02MB4886A045E76443674DA0F198DE4E0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 22 Nov 2019 10:33:17 +0100
Message-ID: <CAL1e-=irit+P_H2pQA40aju5AZTD2UFv-Z6Z_Z3HXEU2Pzjb-w@mail.gmail.com>
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000a4d5770597ec1aec"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a4d5770597ec1aec
Content-Type: text/plain; charset="UTF-8"

On Friday, November 22, 2019, Taylor Simpson <tsimpson@quicinc.com> wrote:

> Hi Aleksandar,
>
> The complete qemu-hexagon implementation can be found here
> https://github.com/quic/qemu
>
> From the beginning, I knew I would have to divide it up into smaller
> patches for review.  The discussion on how divide it was here
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg01971.html
>
I'll summarize the proposal
>     1) linux-user changes + linux-user/hexagon + skeleton of target/hexagon
>     2) Add the code this imported from the Hexagon simulator and the qemu
> helper generator
>     3) Add support for packet semantics
>     4) Add support for wide vector extensions
>     5) Add the helper overrides for performance optimization
>
>
I think you, for some reason, mix and keep mixing two really different
things:

- outline of your changes (as seen as points 1-5 above)

- a patch

None of points 1-5 could be a patch. All of them should be patch series, or
part of patch series.

I am surprised that it seems as if you did not take a look at the previous
cases of platform introductions to QEMU. Or you did, but decided you don't
need to bother creating patch series, you don't need to follow QEMU
submission guidelines - you apparently think you can simply send the
changes as several huge patches.


> My assumption in the proposal was that each phase of the submission should
> compile and execute, and each phase should expand the capabilities of the
> Hexagon target.  I apologize that it wasn't clear how large each of the
> patches would be.
>
> I greatly appreciate all of the feedback on the proposal and the patch,
> and I am making the revisions.  In several cases, the feedback also applies
> to the remainder of the code.  So, I am making the changes there as well.
> From that perspective, I think it will reduce the overall burden on the
> reviewers.
>
> As far as what might change in the imported files goes, the current
> simulator (hexagon-sim) has been used in production as part of the
> toolchain for over a decade and has been used to verify every version of
> the core that we have shipped.  Since it is used in verification, it is
> considered the gold standard - more so than the PDF manual.  Any changes to
> that code, including reformatting, would put qemu at risk of not accurately
> emulating the processor.
>
>
We in MIPS also have ISA verification software that can be viewed as "gold
standard", but we don't burden QEMU with any imported files - and we
certainly could, using the same rationale as you do.

I am opposed to considering the output (or a part) of an internally
developed simulator more important than (or on the same level as)
documentation, and calling it a "gold standard".

A gold-standard-related question arises here:

If something is called a "gold standard", should it be a constant, by its
very definition?

Also, you did not answer my question from my previous resoonse, which was:

What do you expect to be changing in imported-from-another-simulator code?

And I add another one:

What exactly components of QEMU for Hexagon are contained in
imported-from-another-simulator code?

Thanks,
Aleksandar


> Taylor
>
>
> -----Original Message-----
> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Sent: Thursday, November 21, 2019 2:45 PM
> To: Taylor Simpson <tsimpson@quicinc.com>
> Cc: Laurent Vivier <laurent@vivier.eu>; Riku Voipio <riku.voipio@iki.fi>;
> QEMU Developers <qemu-devel@nongnu.org>
> Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of
> patches - linux-user changes + linux-user/hexagon + skeleton of
> target/hexagon - Files in target/hexagon/imported are from another project
> and therefore do not conform to qemu coding standards
>
> On Thu, Nov 21, 2019 at 8:52 PM Taylor Simpson <tsimpson@quicinc.com>
> wrote:
> >
> > They are imported from the existing Hexagon simulator.  Please
> understand that this patch is the first in a series.  Later patches will
> contain more elaborate contents in that directory.  The reason I don't want
> to reformat them is to stay in sync with the other simulator in the
> future.  When the other team makes changes to the code (either to fix bugs
> or add features), it will be easier to identify the changes and bring them
> into qemu.
> >
> > Taylor
> >
>
> Taylor,
>
> Please understand that this patch can't remain a single patch. It can't
> remain even a set of 2 or 3 patches as others suggested. A patch is a
> logically connected unit of code whose typical size is less than
> 200 lines. There are lots of such logical units in this single path that
> you sent, and you should not have sent it in its present form, even if you
> wanted just comments to it. You should have submitted a series rather than
> a single patch. And you should have said this is v1 of my series that I
> will expand later on. Guidelines for submissions are here:
>
> https://wiki.qemu.org/Contribute/SubmitAPatch
>
> As far as "imported" files, frankly, I dislike the fact that you are
> willing to sacrifice our coding style guidelines in favor to your
> convenience. But, more than this, I also find very problematic that you
> practically create a dependency between QEMU and another simulator. QEMU
> implementation should rely on specifications, and only on specifications,
> and certainly should not depend on another simulator. Currently, in QEMU,
> there are some cases of imported disassemblers or similar relatively
> unimportant tools, but those imports change very rarely, and are modified
> to comply to QEMU coding style. I am not aware on dependency of QEMU on
> another simulator in the form you want to do for Hexagon. My strong
> impression is that you will create more problems than benefits with such
> dependency, both for you and for QEMU in general.
>
> Once a CPU or any other device is specified though documentation, these
> specs don't change. Consequently, their emulation does not change too, in
> functional sense. The fact that you anticipate changes in these files
> imported from another simulator, leaves me with a (possibly wrong)
> perception that neither Hexagon internal simulator nor QEMU implementation
> you are trying to integrate are complete. If that is not true, can you
> explain what exactly you expect to be changing in imported files?
>
> Yours,
> Aleksandar
>
>
> > -----Original Message-----
> > From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> > Sent: Thursday, November 21, 2019 1:20 PM
> > To: Taylor Simpson <tsimpson@quicinc.com>
> > Cc: Laurent Vivier <laurent@vivier.eu>; Riku Voipio
> > <riku.voipio@iki.fi>; QEMU Developers <qemu-devel@nongnu.org>
> > Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of
> > patches - linux-user changes + linux-user/hexagon + skeleton of
> > target/hexagon - Files in target/hexagon/imported are from another
> > project and therefore do not conform to qemu coding standards
> >
> >
> > >  create mode 100644 target/hexagon/imported/global_types.h
> > >  create mode 100644 target/hexagon/imported/iss_ver_registers.h
> > >  create mode 100644 target/hexagon/imported/max.h  create mode
> > > 100644 target/hexagon/imported/regs.h
> >
> > Taylor, if I understood you well, these files don't confirm to QEMU
> coding standard, because they are imported. But, from where? And what is
> the reason they need to be imported (and not created independently by you
> or somebody else, but within QEMU code style guidelines) ?
> > Their content looks fairly simple to me.
> >
> > Thanks,
> > Aleksandar
>

--000000000000a4d5770597ec1aec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, November 22, 2019, Taylor Simpson &lt;<a href=3D"mailto:=
tsimpson@quicinc.com">tsimpson@quicinc.com</a>&gt; wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">Hi Aleksandar,<br>
<br>
The complete qemu-hexagon implementation can be found here<br>
<a href=3D"https://github.com/quic/qemu" target=3D"_blank">https://github.c=
om/quic/qemu</a><br>
<br>
From the beginning, I knew I would have to divide it up into smaller patche=
s for review.=C2=A0 The discussion on how divide it was here<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg01971.h=
tml" target=3D"_blank">https://lists.gnu.org/archive/<wbr>html/qemu-devel/2=
019-11/<wbr>msg01971.html</a><br></blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
I&#39;ll summarize the proposal<br>
=C2=A0 =C2=A0 1) linux-user changes + linux-user/hexagon + skeleton of targ=
et/hexagon<br>
=C2=A0 =C2=A0 2) Add the code this imported from the Hexagon simulator and =
the qemu helper generator<br>
=C2=A0 =C2=A0 3) Add support for packet semantics<br>
=C2=A0 =C2=A0 4) Add support for wide vector extensions<br>
=C2=A0 =C2=A0 5) Add the helper overrides for performance optimization<br>
<br></blockquote><div><br></div><div>I think you, for some reason, mix and =
keep mixing two really different things:</div><div><br></div><div>- outline=
 of your changes (as seen as points 1-5 above)</div><div><br></div><div>- a=
 patch</div><div><br></div><div>None of points 1-5 could be a patch. All of=
 them should be patch series, or part of patch series.</div><div><br></div>=
<div>I am surprised that it seems as if you did not take a look at the prev=
ious cases of platform introductions to QEMU. Or you did, but decided you d=
on&#39;t need to bother creating patch series, you don&#39;t need to follow=
 QEMU submission guidelines - you apparently think you can simply send the =
changes as several huge patches.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
My assumption in the proposal was that each phase of the submission should =
compile and execute, and each phase should expand the capabilities of the H=
exagon target.=C2=A0 I apologize that it wasn&#39;t clear how large each of=
 the patches would be.<br>
<br>
I greatly appreciate all of the feedback on the proposal and the patch, and=
 I am making the revisions.=C2=A0 In several cases, the feedback also appli=
es to the remainder of the code.=C2=A0 So, I am making the changes there as=
 well.=C2=A0 From that perspective, I think it will reduce the overall burd=
en on the reviewers.<br>
<br>
As far as what might change in the imported files goes, the current simulat=
or (hexagon-sim) has been used in production as part of the toolchain for o=
ver a decade and has been used to verify every version of the core that we =
have shipped.=C2=A0 Since it is used in verification, it is considered the =
gold standard - more so than the PDF manual.=C2=A0 Any changes to that code=
, including reformatting, would put qemu at risk of not accurately emulatin=
g the processor.<br>
<br></blockquote><div><br></div><div>We in MIPS also have ISA verification =
software that can be viewed as &quot;gold standard&quot;, but we don&#39;t =
burden QEMU with any imported files - and we certainly could, using the sam=
e rationale as you do.</div><div><br></div><div>I am opposed to considering=
 the output (or a part) of an internally developed simulator more important=
 than (or on the same level as) documentation, and calling it a &quot;gold =
standard&quot;.</div><div><br></div><div>A gold-standard-related question a=
rises here:</div><div><br></div><div>If something is called a &quot;gold st=
andard&quot;, should it be a constant, by its very definition?</div><div><b=
r></div><div>Also, you did not answer my question from my previous resoonse=
, which was:</div><div><br></div><div>What do you expect to be changing in =
imported-from-another-simulator code?</div><div><br></div><div>And I add an=
other one:</div><div><br></div><div>What exactly components of QEMU for Hex=
agon are contained in imported-from-another-simulator code?</div><div><br><=
/div><div>Thanks,</div><div>Aleksandar</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
Taylor<br>
<br>
<br>
-----Original Message-----<br>
From: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com=
">aleksandar.m.mail@gmail.com</a>&gt;<br>
Sent: Thursday, November 21, 2019 2:45 PM<br>
To: Taylor Simpson &lt;<a href=3D"mailto:tsimpson@quicinc.com">tsimpson@qui=
cinc.com</a>&gt;<br>
Cc: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.=
eu</a>&gt;; Riku Voipio &lt;<a href=3D"mailto:riku.voipio@iki.fi">riku.voip=
io@iki.fi</a>&gt;; QEMU Developers &lt;<a href=3D"mailto:qemu-devel@nongnu.=
org">qemu-devel@nongnu.org</a>&gt;<br>
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patc=
hes - linux-user changes + linux-user/hexagon + skeleton of target/hexagon =
- Files in target/hexagon/imported are from another project and therefore d=
o not conform to qemu coding standards<br>
<br>
On Thu, Nov 21, 2019 at 8:52 PM Taylor Simpson &lt;<a href=3D"mailto:tsimps=
on@quicinc.com">tsimpson@quicinc.com</a>&gt; wrote:<br>
&gt;<br>
&gt; They are imported from the existing Hexagon simulator.=C2=A0 Please un=
derstand that this patch is the first in a series.=C2=A0 Later patches will=
 contain more elaborate contents in that directory.=C2=A0 The reason I don&=
#39;t want to reformat them is to stay in sync with the other simulator in =
the future.=C2=A0 When the other team makes changes to the code (either to =
fix bugs or add features), it will be easier to identify the changes and br=
ing them into qemu.<br>
&gt;<br>
&gt; Taylor<br>
&gt;<br>
<br>
Taylor,<br>
<br>
Please understand that this patch can&#39;t remain a single patch. It can&#=
39;t remain even a set of 2 or 3 patches as others suggested. A patch is a =
logically connected unit of code whose typical size is less than<br>
200 lines. There are lots of such logical units in this single path that yo=
u sent, and you should not have sent it in its present form, even if you wa=
nted just comments to it. You should have submitted a series rather than a =
single patch. And you should have said this is v1 of my series that I will =
expand later on. Guidelines for submissions are here:<br>
<br>
<a href=3D"https://wiki.qemu.org/Contribute/SubmitAPatch" target=3D"_blank"=
>https://wiki.qemu.org/<wbr>Contribute/SubmitAPatch</a><br>
<br>
As far as &quot;imported&quot; files, frankly, I dislike the fact that you =
are willing to sacrifice our coding style guidelines in favor to your conve=
nience. But, more than this, I also find very problematic that you practica=
lly create a dependency between QEMU and another simulator. QEMU implementa=
tion should rely on specifications, and only on specifications, and certain=
ly should not depend on another simulator. Currently, in QEMU, there are so=
me cases of imported disassemblers or similar relatively unimportant tools,=
 but those imports change very rarely, and are modified to comply to QEMU c=
oding style. I am not aware on dependency of QEMU on another simulator in t=
he form you want to do for Hexagon. My strong impression is that you will c=
reate more problems than benefits with such dependency, both for you and fo=
r QEMU in general.<br>
<br>
Once a CPU or any other device is specified though documentation, these spe=
cs don&#39;t change. Consequently, their emulation does not change too, in =
functional sense. The fact that you anticipate changes in these files impor=
ted from another simulator, leaves me with a (possibly wrong) perception th=
at neither Hexagon internal simulator nor QEMU implementation you are tryin=
g to integrate are complete. If that is not true, can you explain what exac=
tly you expect to be changing in imported files?<br>
<br>
Yours,<br>
Aleksandar<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmai=
l.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
&gt; Sent: Thursday, November 21, 2019 1:20 PM<br>
&gt; To: Taylor Simpson &lt;<a href=3D"mailto:tsimpson@quicinc.com">tsimpso=
n@quicinc.com</a>&gt;<br>
&gt; Cc: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vi=
vier.eu</a>&gt;; Riku Voipio<br>
&gt; &lt;<a href=3D"mailto:riku.voipio@iki.fi">riku.voipio@iki.fi</a>&gt;; =
QEMU Developers &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@non=
gnu.org</a>&gt;<br>
&gt; Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of=
<br>
&gt; patches - linux-user changes + linux-user/hexagon + skeleton of<br>
&gt; target/hexagon - Files in target/hexagon/imported are from another<br>
&gt; project and therefore do not conform to qemu coding standards<br>
&gt;<br>
&gt;<br>
&gt; &gt;=C2=A0 create mode 100644 target/hexagon/imported/<wbr>global_type=
s.h<br>
&gt; &gt;=C2=A0 create mode 100644 target/hexagon/imported/iss_<wbr>ver_reg=
isters.h<br>
&gt; &gt;=C2=A0 create mode 100644 target/hexagon/imported/max.h=C2=A0 crea=
te mode<br>
&gt; &gt; 100644 target/hexagon/imported/regs.h<br>
&gt;<br>
&gt; Taylor, if I understood you well, these files don&#39;t confirm to QEM=
U coding standard, because they are imported. But, from where? And what is =
the reason they need to be imported (and not created independently by you o=
r somebody else, but within QEMU code style guidelines) ?<br>
&gt; Their content looks fairly simple to me.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Aleksandar<br>
</blockquote>

--000000000000a4d5770597ec1aec--

