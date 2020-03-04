Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ADEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2D820709
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeA800XB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2D820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9S1G-0006jo-At
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j9S0b-0006HU-78
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j9S0a-0007UK-3A
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:16:13 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:41477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1j9S0Z-0007Rj-RS
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:16:12 -0500
Received: by mail-lj1-x22f.google.com with SMTP id u26so1541430ljd.8
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 03:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bCImhSWcIjOhR9qriyOnvX4LwG6gykAfiWiIIfszXAI=;
 b=JeA800XBYcUay+RMsFsPsOk26Tgu7cStdrazpLXgTFXjy58ZQU6nxd9WWFjrbkSmrh
 llw1TjeYq3AjcoIuoMipq8etby8YGMtL0AKSFrrpiC98fZrSOGAMTKzjxaqqW0xKuMHc
 7YNZjoE1/YD3q0g1/tWkTzGM6MUBQxzF5Y3xD9/Q+TT6lHAWifkDeV6wGJzToLTc7nep
 K7IGtKoKmqFIpaGkxQkX0MSu7+Oy2m82I4fR7Tv6avl5Ppo3BLiTrkj7vn1yOuHCYMyF
 i30Dk/5nN8AhEwD45B20rvL5BRCLM0dKKG4uXLtm/EwAeWV1w4XeiE+qa9n/ZR1AMemC
 Hj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bCImhSWcIjOhR9qriyOnvX4LwG6gykAfiWiIIfszXAI=;
 b=WlCOtFc7J3l6+epkcCLGbRoz0lBajxuMJHhTzZuGpB9YCnlAR+I5lzeMtbuhoE8PKg
 0XgFIGqAxjH0mImFZFrwMjcb4SMELupLJx9QnnvJLWRwlUiRrotyB+qBIXl1EVm3v47z
 +831M7OPWYwXae/C8HZ/fOqyRGarwaXVPyhSdUIQdCN6kHGz37cTFsBnSCcP69qelEaJ
 6XazZ2m6qk3vl6451S6yLVc3fcrFo1KaypHXo4zKQn3kwIr67l80SBEADERKB4MAO7nf
 VXdJlfq1k+jp5p5WJgjUW3I7SVJ6t6v/NEvob1r9jALWg+3By7v1D8RA4AFNgEFNqMgU
 sniQ==
X-Gm-Message-State: ANhLgQ1FzDz6ZWVUYwqql7pN9D+/0+hIAj+xJaUA8ddcSwMqAl1xWpWb
 T3amWCER9C6Rc5afgG2EFmyLcDKmNksMAavSYrY=
X-Google-Smtp-Source: ADFU+vvdE3aDAEM15n8PJZXXsHYHRVrnW3x1f4eIrRPBrEQ3pWJGuIFpsBUxtRQiTqvCk3olZf/yzska3/2lFXLZHaI=
X-Received: by 2002:a2e:b55c:: with SMTP id a28mr1737321ljn.108.1583320570115; 
 Wed, 04 Mar 2020 03:16:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
 <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
 <CAJSP0QW2ooLK_0Hr52h8HYdmm2j6CunTAnhFxS3De=azMutUeA@mail.gmail.com>
 <CAPV47zc6R1fX_RrEzLQkQuRtjKK87HNtmkgnxazZGOESGERwxw@mail.gmail.com>
 <CAJSP0QUoqdRiQp6zCWpsPQ_iM4K-BgAFCDoqU4ca0dafd3-rNw@mail.gmail.com>
In-Reply-To: <CAJSP0QUoqdRiQp6zCWpsPQ_iM4K-BgAFCDoqU4ca0dafd3-rNw@mail.gmail.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Wed, 4 Mar 2020 16:45:59 +0530
Message-ID: <CAPV47zd19obqLMFKeOhvaD9AbThyii_QqtHSHE57YxLW7_8JEQ@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000025ba2105a0058c1b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22f
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

--00000000000025ba2105a0058c1b
Content-Type: text/plain; charset="UTF-8"

Hi,
I have commented all the lines of other hardware models except custom
device line *" common-obj-$(CONFIG_TESTPCI) += testpci.o "*.
But when I run *make* I get errors  similar to error shown in file which I
have shared with you in previous replies.

Thanks,
Priyamvad

On Wed, 4 Mar 2020 at 02:05, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Mar 3, 2020 at 5:12 PM Priyamvad Acharya
> <priyamvad.agnisys@gmail.com> wrote:
> > > These errors are probably due to the Makefile.objs changes in your
> commit:
> >
> > If I am not wrong, we need to add a rule i.e "
> common-obj-$(CONFIG_TESTPCI) += testpci.o " in Makefile.objs to compile
> custom device in Qemu.
> > Shall I should remove that rule to remove the errors?
>
> No, keep that line.  All the other changes to Makefile.objs in that
> commit seem spurious though and should be removed.
>
> Stefan
>

--00000000000025ba2105a0058c1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I have commented all the lines of other=
 hardware models except custom device line=20
<b><span class=3D"gmail-im">&quot; common-obj-$(CONFIG_TESTPCI) +=3D testpc=
i.o &quot;</span></b>.</div><div>But when I run <b>make</b> I get errors=C2=
=A0 similar to error shown in file which I have shared with you in previous=
 replies.</div><div><br></div><div>Thanks,</div><div>Priyamvad<br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Wed, 4 Mar 2020 at 02:05, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gm=
ail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On Tue, Mar 3, 2020 at 5:12 PM Priyamvad Acharya=
<br>
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

--00000000000025ba2105a0058c1b--

