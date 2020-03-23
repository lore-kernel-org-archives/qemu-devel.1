Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B22C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCE920663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzLUw42Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCE920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGL8w-0003LT-J9
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jGL89-0002S4-Hi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jGL88-0002E5-0b
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:20:29 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jGL87-0002Cw-BG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:20:27 -0400
Received: by mail-lj1-x241.google.com with SMTP id g12so14087484ljj.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6Tga+mZkqjLvWewULPqrCxv3McdVWlg5QoahwkvIJjs=;
 b=pzLUw42ZPEeGQt7nBXeyZ2/cJqBYwdZhKrmYsBhKQrAAAv2ZawwKfjpcdfE/XOHs3p
 H1YKw567zavhrwTSIgMxYHr4s6WMVDnfi7X16cgUQjIJ9yixSKSQ7rznfJKJF0nL5O1b
 OzVAzma63Z0ppptA/WJ8ZJl/X2dmKa+CdNtvmFcTqGEt+QGyESBdP4H1B2VxTMQA8k8E
 IGFJNcEE4UtDwPRxS8Bm5N9os/bYngH7l+dzEFBeszY409RAwGannZKPXZwX5NzEFi0W
 QpxMgmPwyKGToeYcWbWw3vYKvC+24v2SgAuUNKpZYeGYl3r5DoIjrVOeJ0IiHLG1aZNV
 sl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Tga+mZkqjLvWewULPqrCxv3McdVWlg5QoahwkvIJjs=;
 b=aCDnHfe+I4CF5KGfra/6+8aKNe4RotaqPgKOv605mK5n2YXMNeo+CK76F7kcvL6i8Y
 4XijZDE4Rk8PGoFsBcE2mRnsSvxLXECZcVKxKpCS0uTsahei1WT+6c5V0OSBBzdMHEUr
 VrMs85CyyakZ83n1P7v2psa5dDVSnbQypoj3l+zUiktt7QuVMz4c6OaYG4JU2/270fym
 KZJK8T+9EMeXOUyBDQuxKUNopKSkzh4HBp6Zrpk58e8EyTdn3wqnRAeSGe/QUlG4NLch
 LswWb/RIaRAHlwgprZq3imk0zrmzOa2Q8KS0sCYSEdOdUbO4XwNG4p7SNGQnXJXemq+i
 LQOg==
X-Gm-Message-State: ANhLgQ2UUhqEI8qDzOgdKo+9aSTh+OfRc6fgn1rPjSvQbpcSic/rAR9G
 WQndq0CVk6iVFYGWfL3/8IsdBbBThbDydITMlPI=
X-Google-Smtp-Source: ADFU+vvRymmbxI10y5bWPrDcysNV/6lFTv1AX9gqvRNnB81eBAUqGPUw154SXtGoHricSS0LcOnLUCgQ3LVPDQk7Qno=
X-Received: by 2002:a2e:9dc4:: with SMTP id x4mr6370232ljj.263.1584962423727; 
 Mon, 23 Mar 2020 04:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPV47zcqvNekcUN=fKu1-dN=Sip3XR3+ohaG22-oNDm1dceJkQ@mail.gmail.com>
 <CAFEAcA_CeGozr3MUA6N=cMQVXLjoLD0ca-gywm+MLU4unfgwGg@mail.gmail.com>
 <39f82991-6d80-ba42-c7e8-4f6120a196ac@redhat.com>
 <CAPV47zfQKCaKS3BQ4+zbFJ1KyATqgOZvtaY9n-Gh_wtFCn4trQ@mail.gmail.com>
 <871rpojto4.fsf@linaro.org>
 <CAPV47zeQFEUhFmE6jgsehUUQKrYqjtqnfUfBdaKqaEy_e=fM=g@mail.gmail.com>
 <87lfnviez6.fsf@linaro.org>
 <CAPV47ze8XU6RceSrM9LUO58tdvP8mwShM4=_hee467n23eqn9w@mail.gmail.com>
 <87d097i8c6.fsf@linaro.org>
In-Reply-To: <87d097i8c6.fsf@linaro.org>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Mon, 23 Mar 2020 16:50:11 +0530
Message-ID: <CAPV47zd5etSKnS1=AZM5adw-c_zhVxmNnGB1OjNHWZ=QE=URDA@mail.gmail.com>
Subject: Re: Qemu API documentation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003fa72405a183d2d8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003fa72405a183d2d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the information.

On Fri, 20 Mar 2020 at 16:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

>
> Priyamvad Acharya <priyamvad.agnisys@gmail.com> writes:
>
> > Thansk, I will check it out.
> >
> > To make my device I have used following link as reference
> >
> >
> https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-devi=
ce-in-qemu/
> >
> > Also I have shared all the necessary files
> > in previous mails involved in the development and testing process of
> device.
> >
> > Please check the files and let me know if needed more details.
>
> I'm sorry but I don't have time to dig through your email and re-assemble=
 a
> working tree.
>
> If you want people to review your code you need to submit a proper patch
> series which applies to the current master or provide a git branch that
> can be checked out. The former is preferred as it's easier to review
> patches with inline comments. You can tag the series as RFC if you want.
>
> --
> Alex Benn=C3=A9e
>

--0000000000003fa72405a183d2d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the information. <br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 20 Mar 2020 at 16:=
47, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.ben=
nee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><br>
Priyamvad Acharya &lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=
=3D"_blank">priyamvad.agnisys@gmail.com</a>&gt; writes:<br>
<br>
&gt; Thansk, I will check it out.<br>
&gt;<br>
&gt; To make my device I have used following link as reference<br>
&gt;<br>
&gt; <a href=3D"https://devkail.wordpress.com/2014/12/16/emulation-of-des-e=
ncryption-device-in-qemu/" rel=3D"noreferrer" target=3D"_blank">https://dev=
kail.wordpress.com/2014/12/16/emulation-of-des-encryption-device-in-qemu/</=
a><br>
&gt;<br>
&gt; Also I have shared all the necessary files<br>
&gt; in previous mails involved in the development and testing process of d=
evice.<br>
&gt;<br>
&gt; Please check the files and let me know if needed more details.<br>
<br>
I&#39;m sorry but I don&#39;t have time to dig through your email and re-as=
semble a<br>
working tree.<br>
<br>
If you want people to review your code you need to submit a proper patch<br=
>
series which applies to the current master or provide a git branch that<br>
can be checked out. The former is preferred as it&#39;s easier to review<br=
>
patches with inline comments. You can tag the series as RFC if you want.<br=
>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div>

--0000000000003fa72405a183d2d8--

