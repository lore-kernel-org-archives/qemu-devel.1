Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB8DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913922064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4nT9MqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913922064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPM7M-0005qM-IM
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1kPM6C-0004oU-Jm
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:44:00 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:56202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1kPM6A-0001iB-EZ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:44:00 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ds1so2386350pjb.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9HVQz0vUL3Qwr86mz47pLEK+fDOjf+/ReppJ+VL5hhc=;
 b=b4nT9MqIBrYNMyAyJ/RiAcEz0bXJGPs5cEudaUF8QJk42n7eKXH9vMAItcUS2qx6Ob
 zInYd+hWYhcV1YoiNr+xF5gacSlcrAu7Fz9a5gXmjVrNhbZ6IxtCb17q+gtnYbsY+9KS
 w+HeZ2KNKJ1uk3kSN85KcmXkHPwg0Q+E2s9Vpy6pmjsOseVwj+y5IEbPaDdOsmMgi8ab
 /UQJVQWXElneH54tM2C3o43eCP/lCInLtiwpOcUNKXEb56PDI+qQIn9V8LOJsXYR8Em+
 BsSu/rhPul+qWT/SModuOd1mRv1BVwIixkcPVfNDfLhLVg36tFlRx6WtuHf7I32OifmR
 ngWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9HVQz0vUL3Qwr86mz47pLEK+fDOjf+/ReppJ+VL5hhc=;
 b=lRs8cTfyoYmsO5rJMbUvl0TOPRoeWThrPsgLN+Tgefi3X6h44dJnddZIxdX3UPc8Z1
 jiQ3XbGLNIQuvoaIql+VvsrDiVC4Ue63sbcct6KGwgsLGVrcrj6trNkrfREzZdw8NI6e
 5RRumu4fGH/gdP+B1aeSXvICs4GQRIACuKeJTsWakjjDW8sHaysdDW6fHaVvRHPMn2NB
 KXDsn7fWirbHozwBE5SjTEKzUn8EsmPehCxwlKOs44PsRGFb/TLFLzk3YVI/1LxBMA8x
 B4Ci+wg/DOGyIkquY+ZZiU/h2VgSVBMOYlCXCJGmNPiAw3k1wTbSCeH/nrAXR2lv6QkE
 AArA==
X-Gm-Message-State: AOAM532aD+9HhZS345o9EVe2wJrrwzZ6gryr+o8Ue1NU4itraIncYFy9
 WEoRNyG8yPZOOz0BPNqSg+JfkwgBqJKGEgLP7ak=
X-Google-Smtp-Source: ABdhPJytJI3e5fuOE9GH1wHZa3MA01lIRluxJlcfeR8PCiFS1Te4J/s88JyUBDce7s5wg47l4KRGtReazKrjMx1MivM=
X-Received: by 2002:a17:90a:cb86:: with SMTP id
 a6mr6106241pju.161.1601887436834; 
 Mon, 05 Oct 2020 01:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-14-f4bug@amsat.org>
 <CAHt6W4fAsxiNx11x53Q6BE_oCs9RwZtL8gg4dPHpfa7sQfp9AQ@mail.gmail.com>
 <CAAdtpL6dbNh4+YQhj7WnfenBdVNFncQq2K7Z-FKRXn4n96OPXQ@mail.gmail.com>
In-Reply-To: <CAAdtpL6dbNh4+YQhj7WnfenBdVNFncQq2K7Z-FKRXn4n96OPXQ@mail.gmail.com>
From: Frediano Ziglio <freddy77@gmail.com>
Date: Mon, 5 Oct 2020 09:43:45 +0100
Message-ID: <CAHt6W4cFv=upFUXH+UCjNFP6XwMVx1w7BvzRqb1FrUAYZOmR8w@mail.gmail.com>
Subject: Re: [RFC PATCH 13/21] contrib/gitdm: Add more entries to the Red Hat
 domain
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000a48a6105b0e87ba1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=freddy77@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Nir Soffer <nsoffer@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a48a6105b0e87ba1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno lun 5 ott 2020 alle ore 09:39 Philippe Mathieu-Daud=C3=A9 <
f4bug@amsat.org> ha scritto:

> On Mon, Oct 5, 2020 at 10:05 AM Frediano Ziglio <freddy77@gmail.com>
> wrote:
> >
> > Hi,
> >   can I disagree? If the contribution is personal I use my personal
> address, if the contribution is from the job in the company I'm using the
> company address.
>
> Certainly! Can I add your personal address to the "individual
> contributor" list instead?
>
>
Sure

>
> > Regards,
> >    Frediano
> >
> >
> > Il giorno dom 4 ott 2020 alle ore 19:05 Philippe Mathieu-Daud=C3=A9 <
> f4bug@amsat.org> ha scritto:
> >>
> >> Cc: Frediano Ziglio <freddy77@gmail.com>
> >> Cc: Frediano Ziglio <fziglio@redhat.com>
> >> Cc: Nir Soffer <nirsof@gmail.com>
> >> Cc: Nir Soffer <nsoffer@redhat.com>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >> To the developers Cc'ed: If you agree with your entry, please
> >> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> >> care, please either reply with Nack-by or ignore this patch.
> >> I'll repost in 2 weeks as formal patch (not RFC) with only the
> >> entries acked by their author.
> >> ---
> >>  contrib/gitdm/group-map-redhat | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/contrib/gitdm/group-map-redhat
> b/contrib/gitdm/group-map-redhat
> >> index d15db2d35e..0419e82795 100644
> >> --- a/contrib/gitdm/group-map-redhat
> >> +++ b/contrib/gitdm/group-map-redhat
> >> @@ -6,3 +6,5 @@ david@gibson.dropbear.id.au
> >>  laurent@vivier.eu
> >>  pjp@fedoraproject.org
> >>  armbru@pond.sub.org
> >> +freddy77@gmail.com
> >> +nirsof@gmail.com
> >> --
> >> 2.26.2
> >>
>

--000000000000a48a6105b0e87ba1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">Il giorno lun 5 ott 2020 alle ore 09:39 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; ha scritto:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Oct 5, 2=
020 at 10:05 AM Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com" t=
arget=3D"_blank">freddy77@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;=C2=A0 =C2=A0can I disagree? If the contribution is personal I use my p=
ersonal address, if the contribution is from the job in the company I&#39;m=
 using the company address.<br>
<br>
Certainly! Can I add your personal address to the &quot;individual<br>
contributor&quot; list instead?<br>
<br></blockquote><div><br></div><div>Sure</div><div> <br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Regards,<br>
&gt;=C2=A0 =C2=A0 Frediano<br>
&gt;<br>
&gt;<br>
&gt; Il giorno dom 4 ott 2020 alle ore 19:05 Philippe Mathieu-Daud=C3=A9 &l=
t;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&=
gt; ha scritto:<br>
&gt;&gt;<br>
&gt;&gt; Cc: Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com" targ=
et=3D"_blank">freddy77@gmail.com</a>&gt;<br>
&gt;&gt; Cc: Frediano Ziglio &lt;<a href=3D"mailto:fziglio@redhat.com" targ=
et=3D"_blank">fziglio@redhat.com</a>&gt;<br>
&gt;&gt; Cc: Nir Soffer &lt;<a href=3D"mailto:nirsof@gmail.com" target=3D"_=
blank">nirsof@gmail.com</a>&gt;<br>
&gt;&gt; Cc: Nir Soffer &lt;<a href=3D"mailto:nsoffer@redhat.com" target=3D=
"_blank">nsoffer@redhat.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f=
4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; To the developers Cc&#39;ed: If you agree with your entry, please<=
br>
&gt;&gt; reply with a Reviewed-by/Acked-by tag. If you disagree or doesn&#3=
9;t<br>
&gt;&gt; care, please either reply with Nack-by or ignore this patch.<br>
&gt;&gt; I&#39;ll repost in 2 weeks as formal patch (not RFC) with only the=
<br>
&gt;&gt; entries acked by their author.<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 contrib/gitdm/group-map-redhat | 2 ++<br>
&gt;&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-=
map-redhat<br>
&gt;&gt; index d15db2d35e..0419e82795 100644<br>
&gt;&gt; --- a/contrib/gitdm/group-map-redhat<br>
&gt;&gt; +++ b/contrib/gitdm/group-map-redhat<br>
&gt;&gt; @@ -6,3 +6,5 @@ <a href=3D"mailto:david@gibson.dropbear.id.au" tar=
get=3D"_blank">david@gibson.dropbear.id.au</a><br>
&gt;&gt;=C2=A0 <a href=3D"mailto:laurent@vivier.eu" target=3D"_blank">laure=
nt@vivier.eu</a><br>
&gt;&gt;=C2=A0 <a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank">p=
jp@fedoraproject.org</a><br>
&gt;&gt;=C2=A0 <a href=3D"mailto:armbru@pond.sub.org" target=3D"_blank">arm=
bru@pond.sub.org</a><br>
&gt;&gt; +<a href=3D"mailto:freddy77@gmail.com" target=3D"_blank">freddy77@=
gmail.com</a><br>
&gt;&gt; +<a href=3D"mailto:nirsof@gmail.com" target=3D"_blank">nirsof@gmai=
l.com</a><br>
&gt;&gt; --<br>
&gt;&gt; 2.26.2<br>
&gt;&gt;<br>
</blockquote></div></div>

--000000000000a48a6105b0e87ba1--

