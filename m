Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA19C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F382051A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkebMvK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F382051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEwF-0004EB-M9
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jFEvB-0003d1-Pd
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1jFEvA-0000gB-Mr
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:30:33 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:46276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jFEvA-0000eV-F5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:30:32 -0400
Received: by mail-lf1-x143.google.com with SMTP id a28so4070151lfr.13
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rRYB1JeR3kd0cq7K9QTAd3112ttNTNYwkZDEfFSWsgk=;
 b=DkebMvK4wYv6/BOCsuTKj4viyZaY0Ql1qstzwVYeFK7j05YSDb3ILFd3yS1hFlm5cy
 iRG8Yx5pzQUHpzFFHLzectxuds4ZAm0/hCRlg2BaYj1WQ4BzK4otosfRT+iCw/qBy/Bx
 ksosi8PTXI5YjC+cCw3ywM4sabV6EPgCQpY/J4DGliK3weZGqAVuTxrXg9KQoRiJRUxY
 ks1Hqc1Pz7pJStykDljsSGr5AM2UXEvntzguYfu2Iw6hghIgElDwplwb9DJsWCbXaqw9
 EzeP62YW7m7fZ4aTPfNt9uPzQf0PGileRXuy90zczCzwmrSHb+SaD24zhp86/XQpsHwL
 0PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rRYB1JeR3kd0cq7K9QTAd3112ttNTNYwkZDEfFSWsgk=;
 b=UYICXwht+XKbltHXflMOJSWX7359li79tv06MnEBfYQvEKqkL07SrrnEiXulfVJatC
 6qAIPcdu+CJYxNEe75AKXaK2wqToQ/I0WhFFVkjx0EdLvfZfansReGbmcIY/9z4mkRbW
 sB5ZoEncoGyx4sx5ym8kOWwZb3VLjFD5kKD59y2aXLlNys8CVtqP6osGHv4/CxMaWT1L
 LFniWO+14iIL9Vn6lISlt2lnN4cwo0cjeDa+0KUIxdY4IROxNbMT+vgAi3NBr+pElWqE
 tckbcxxlZKuuvPDISnRHAInP7ldiy5Udo7giplNKgrDREIFzmPHOgc21am70Med8NUBV
 piQA==
X-Gm-Message-State: ANhLgQ0UJj+YSqA2HSvnb6tgZ3yNsvN1nngOxZy+1vhVJVxgIdDIGJzr
 4W3Xha/CXZydZJ48L6SqWU0CPTWppucHN/YGuvg=
X-Google-Smtp-Source: ADFU+vsZexKmaBIDBbi/y87XJSB86ViuK+jLboI5iuAAQrRhnIHDLolW2iOjQBctUNFxe+7e0nJIuzVJNUgpF1ekEQ8=
X-Received: by 2002:a19:6f44:: with SMTP id n4mr4964230lfk.59.1584700230677;
 Fri, 20 Mar 2020 03:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPV47zcqvNekcUN=fKu1-dN=Sip3XR3+ohaG22-oNDm1dceJkQ@mail.gmail.com>
 <CAFEAcA_CeGozr3MUA6N=cMQVXLjoLD0ca-gywm+MLU4unfgwGg@mail.gmail.com>
 <39f82991-6d80-ba42-c7e8-4f6120a196ac@redhat.com>
 <CAPV47zfQKCaKS3BQ4+zbFJ1KyATqgOZvtaY9n-Gh_wtFCn4trQ@mail.gmail.com>
 <871rpojto4.fsf@linaro.org>
 <CAPV47zeQFEUhFmE6jgsehUUQKrYqjtqnfUfBdaKqaEy_e=fM=g@mail.gmail.com>
 <87lfnviez6.fsf@linaro.org>
 <CAPV47ze8XU6RceSrM9LUO58tdvP8mwShM4=_hee467n23eqn9w@mail.gmail.com>
 <CAFEAcA8JVkreT3zGSuHpHQUmmshw9xmqaMVmbWeRECGPGHc4_g@mail.gmail.com>
In-Reply-To: <CAFEAcA8JVkreT3zGSuHpHQUmmshw9xmqaMVmbWeRECGPGHc4_g@mail.gmail.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Fri, 20 Mar 2020 16:00:19 +0530
Message-ID: <CAPV47ze5eaAp-qUq5OYgTnb+0uNsEB6jqB3tCRu7EgL4bk3_EQ@mail.gmail.com>
Subject: Re: Qemu API documentation
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005336ad05a146c60f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005336ad05a146c60f
Content-Type: text/plain; charset="UTF-8"

So, is there any up to date blog from where I can get a reference about
device modelling development

On Fri, 20 Mar 2020 at 15:46, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Fri, 20 Mar 2020 at 09:39, Priyamvad Acharya
> <priyamvad.agnisys@gmail.com> wrote:
> >
> > Thansk, I will check it out.
> >
> > To make my device I have used following link as reference
> >
> >
> https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-device-in-qemu/
>
> Watch out, because that blog is six years old. Much of QEMU's
> internals have evolved over that time and so a lot of the
> details in the blog post will be out of date.
>
> -- PMM
>

--0000000000005336ad05a146c60f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So, is there any up to date blog from where I can get a re=
ference about device modelling development<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 20 Mar 2020 at 15:46,=
 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydel=
l@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On Fri, 20 Mar 2020 at 09:39, Priyamvad Acharya<br>
&lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=3D"_blank">priyam=
vad.agnisys@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Thansk, I will check it out.<br>
&gt;<br>
&gt; To make my device I have used following link as reference<br>
&gt;<br>
&gt; <a href=3D"https://devkail.wordpress.com/2014/12/16/emulation-of-des-e=
ncryption-device-in-qemu/" rel=3D"noreferrer" target=3D"_blank">https://dev=
kail.wordpress.com/2014/12/16/emulation-of-des-encryption-device-in-qemu/</=
a><br>
<br>
Watch out, because that blog is six years old. Much of QEMU&#39;s<br>
internals have evolved over that time and so a lot of the<br>
details in the blog post will be out of date.<br>
<br>
-- PMM<br>
</blockquote></div>

--0000000000005336ad05a146c60f--

