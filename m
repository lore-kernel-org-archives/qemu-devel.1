Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C911C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D50205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH0q4VNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D50205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7VxB-0008FC-Me
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 23:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k7VwU-0007W4-6j
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:36:14 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k7VwS-0003uS-Db
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:36:13 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ha11so7042530pjb.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 20:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mUierV1dAg+z/vyemFbUwCUry/g8qLX/FU5ux+FkLnY=;
 b=AH0q4VNsxMF3hxNwtInum2tGAj6OULUtiq+p3hE8LgnWZTRoJDT0dNYqCHihmO5I00
 i1KZY2GICK/rpr5d2lSkYUA/yvQHiXl3WkJxRxWs0dRumBgsCdB57RohtvIeLh4R7PhS
 vaMPob48RcJtlYalTsVghwk0O7uJxz8FVtICW9IJMfukBUw/M5IaA9DxYTigzIRAGbuI
 v0wY1QVuTJGiGMMm6qufJKNbe1EsK0eYr7EG7TtoV/d+nL/1U8nkz5+woyxvEzbIs218
 FfzMoq+/p/iBQVy5K/2bNe5/zlg33N0KWT3Biu66JyklBYTrrNCuQGGiarVevhCafyuV
 1zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mUierV1dAg+z/vyemFbUwCUry/g8qLX/FU5ux+FkLnY=;
 b=iKqA0TLN01dz0MzWn07dSbUNBaTREYSK4Q/LAzdCXox1QAx3BvfgBuxQhByHGoJTrW
 z/48f5opef7JcflHruPEMV29MssuCEpFrH1Uqbm9n7RwZRqrJ1TKYiqrclTMTSjYocOp
 xyhEZF9whazRmu6+rsHpRYoGguFIhOq8ZgTyjAFHxTIpGhrC6AQde3uajmKuCd45FIjL
 M/pc68nErmQSyKYtErKeWiiUlHZ4k5ImcGcNeLvrUNyXdRaTDwL9Vob+tiLWutIsK33f
 jAntYbj2x3SNPfrGCUdGgHJ8zEW6pOVDaa7AAEQEMEd+rtGlntQC1zPl/wJ41YmlA/A5
 lR6Q==
X-Gm-Message-State: AOAM5320n7ZN3Ur6thlN0/ELluZfBBOO8docut1nsWBAQGe/CJ2X2whC
 1nTWVT/9qHnSHK+seo1e3HyRjDwkqzqjUCVAhSA=
X-Google-Smtp-Source: ABdhPJxS3Jj9R5Wsu3rhcZcGsI6GQLVfwFsoPp8s21DlCVLPm7xJOmy5/y78T4b6g/NalB4+I+lXK+FG/aztr8UaRmA=
X-Received: by 2002:a17:90a:191a:: with SMTP id
 26mr2231338pjg.197.1597635370517; 
 Sun, 16 Aug 2020 20:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200816023127.22268-1-rohit.shinde12194@gmail.com>
 <9abbbc9d-b5d5-fdd1-e6ff-c89071189f7f@linaro.org>
 <CA+Ai=tB3QW7+vt4qSrfSBornPmPJ+1rVajvvXf=p4kg3FG2+ZA@mail.gmail.com>
 <125714a6-e441-629f-e9ab-d04ce8b0d94e@linaro.org>
 <CA+Ai=tAy1C3UwxPw26Jkbm7+DGA_mrryG8Sekm9t9Bk3ZhPTow@mail.gmail.com>
 <3824d0e6-1db2-04b4-8731-6d45a2d0f014@linaro.org>
In-Reply-To: <3824d0e6-1db2-04b4-8731-6d45a2d0f014@linaro.org>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Sun, 16 Aug 2020 23:36:00 -0400
Message-ID: <CA+Ai=tDJUVdPRT=NMbp6a5ZN4pwUe6JTtSKEZ0=LxPC2unZAqg@mail.gmail.com>
Subject: Re: [PATCH v4] qapi/opts-visitor: Fixed fallthrough compiler warning
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bd87a705ad0a7866"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pj1-x1041.google.com
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bd87a705ad0a7866
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2020 at 11:26 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/16/20 5:57 PM, Rohit Shinde wrote:
> > I misread the comment. The comment /* fallthrough */ was meant to stop
> the
> > compiler warning from occurring. I am trying to complete the bite sized
> task
> > mentioned here <https://wiki.qemu.org/Contribute/BiteSizedTasks> under
> > "Compiler driven cleanups". I wanted to take that up to get more
> familiar with
> > the codebase.
>
> Fine, but the current comment matches the compiler regexp, so this instan=
ce
> isn't part of that cleanup.
>
But when I was compiling with the -Wimplicit-fallthrough option, the
compiler gave an error at that very line. That's why I came up on that
specific line in that file first.

I am pasting the error that I got below:

home/rohit/Desktop/open-source/qemu/qapi/opts-visitor.c: In function
=E2=80=98opts_next_list=E2=80=99:
/home/rohit/Desktop/open-source/qemu/qapi/opts-visitor.c:267:23: error:
this statement may fall through [-Werror=3Dimplicit-fallthrough=3D]
  267 |         ov->list_mode =3D LM_IN_PROGRESS;
      |         ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
/home/rohit/Desktop/open-source/qemu/qapi/opts-visitor.c:270:5: note: here
  270 |     case LM_IN_PROGRESS: {
      |     ^~~~

Sending it again, because I forgot to reply all.

Thanks,
Rohit.

>
>
> r~
>
>

--000000000000bd87a705ad0a7866
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 16, 2020 at 11:26 PM Rich=
ard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.h=
enderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 8/16/20 5:57 PM, Rohit Shinde wrote:<br>
&gt; I misread the comment. The comment /* fallthrough */ was meant to stop=
 the<br>
&gt; compiler warning from occurring. I am trying to complete the bite size=
d task<br>
&gt; mentioned here &lt;<a href=3D"https://wiki.qemu.org/Contribute/BiteSiz=
edTasks" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Contrib=
ute/BiteSizedTasks</a>&gt;=C2=A0under<br>
&gt; &quot;Compiler driven cleanups&quot;. I wanted to take that up to get =
more familiar with<br>
&gt; the codebase.<br>
<br>
Fine, but the current comment matches the compiler regexp, so this instance=
<br>
isn&#39;t part of that cleanup.<br></blockquote><div>But when I was compili=
ng with the -Wimplicit-fallthrough option, the compiler gave an error at th=
at very line. That&#39;s why I came up on that specific line in that file f=
irst.=C2=A0</div><div><br></div><div>I am pasting the error that I got belo=
w:</div><div>=C2=A0<br></div>home/rohit/Desktop/open-source/qemu/qapi/opts-=
visitor.c: In function =E2=80=98opts_next_list=E2=80=99:<br>/home/rohit/Des=
ktop/open-source/qemu/qapi/opts-visitor.c:267:23: error: this statement may=
 fall through [-Werror=3Dimplicit-fallthrough=3D]<br>=C2=A0 267 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ov-&gt;list_mode =3D LM_IN_PROGRESS;<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~<br>/hom=
e/rohit/Desktop/open-source/qemu/qapi/opts-visitor.c:270:5: note: here<br>=
=C2=A0 270 | =C2=A0 =C2=A0 case LM_IN_PROGRESS: {<br>=C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A0 ^~~~<br><div><br></div><div>Sending it again, because I forg=
ot to reply all.</div><div><br></div><div>Thanks,</div><div>Rohit.=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div>

--000000000000bd87a705ad0a7866--

