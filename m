Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC00AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41DC20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muDdva6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41DC20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYSV-0002Sg-OE
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYRw-00023W-9Z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:29:40 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b]:43386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYRu-00027b-I4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:29:40 -0400
Received: by mail-lf1-x12b.google.com with SMTP id y2so422419lfy.10
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=2rZKy1CDDJafjaKikIQq0raYI4Unph1Fs6n/KSoB26o=;
 b=muDdva6Q8QFxEx3GqOFtcwmrkge2/nPuKiknkZA529UhjDxo/w+ipi9CLGOoca7uUK
 CIel1EdZi/7BgHow+IguL7/BZt8vuki4ZKIghVl+YSg7G0Tvk39B7Lb7O6Ewqpp5Nui2
 EUg5eZ+WyI+0I4S9sf3BsZ6+0A1MTMRGwATztsn9XqCcZjKHnT2Cno5gpJgdGD1ELVk9
 yYAHotvYG+/LQ7/JBmlftI+zpPfDnYoCi/iVoTgn1bWxO8fahveSL5wvSh+n6PMDzlZ+
 Msac8r+IqeVAx3cvj9//yNfNvrfpSdg/+zXCpUclqr4DGaaJKsKErE1jS8JUZzmK+QSF
 Ld8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=2rZKy1CDDJafjaKikIQq0raYI4Unph1Fs6n/KSoB26o=;
 b=dEdVF2DCPhoVV3ql18R+xzW5CUFb5UUKspbaD5lQq1NorkyfBN/VQ37qhU+XpBcR/5
 HrFIY+s5mUKqwdoeMVYpuPmUhFCSS/NPQf/yBtp+I7QAl4bOkSbl/JnPaRI4QK6vDGbS
 ABpyFQMBaHZaU+TyKJnH0iygVda0bH6AkJgf73Sa2EpSSIA6UWyNQBH21HwlViz7Z50J
 Y4pVyehku/dQ+zYrqhym+aojUITARW1jqc7GYss+PNDsz2snI7CfaPxcaiIfybAw3J87
 Qui3RqIIlQlYeQm84LV9DR1iCn01JjEJL4waAOiksKufGtT9/53C/eUatPms/WaxVhoG
 MYow==
X-Gm-Message-State: AOAM5333oirKd/PyszaJjZmq29WkobqKNqiBL2aCJaiGbF87qyNd3DBT
 Ff/O0//eur10FpAGz8gPWKhdvLS8xlnZEIYn1jY=
X-Google-Smtp-Source: ABdhPJx6QtF7GMV+Eq6miIrJ4FetHEWGadgJNpv1etraVje3I6Xmv2ACD5as4JXN/B9jo04nrxBgZkq6K1CIUcpJ4Dg=
X-Received: by 2002:ac2:42c2:: with SMTP id n2mr4050678lfl.117.1599074976399; 
 Wed, 02 Sep 2020 12:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE8d2m7deMgEf1v37FHKqxMegQAc4BbjOwcjOd_-BQH2Zg@mail.gmail.com>
 <eefda25a-f9da-2e2c-1147-3ff03380d68f@redhat.com>
In-Reply-To: <eefda25a-f9da-2e2c-1147-3ff03380d68f@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 03:29:24 +0800
Message-ID: <CAE2XoE-kOohdeu7edAvbHXX_z7okcqEd0PgRK2RjY7EuB4if7A@mail.gmail.com>
Subject: Re: QAPI, The msys2 CI check are compiled sucess,
 but qapi tests are failing
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f0050505ae59a7ac"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: Stefan Weil <sw@weilnetz.de>, qemu-level <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f0050505ae59a7ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 3:27 AM Thomas Huth <thuth@redhat.com> wrote:

> On 02/09/2020 20.33, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > https://cirrus-ci.com/task/5708273301061632?command=3Dmain#L6792
> >
> > make: *** [Makefile.mtest:63: check-qapi-schema] Error 1
>
> I think nobody really ever cared about getting "make check" running on
> Windows... So as a first step, I think you could submit your patches
> without the "make check" at the end of the build script.
>
For this, I've already done.
Now I am trying to getting make check to be success

>
> Now looking at the error at above URL, this looks like a problem with
> the CR-LF vs. LF endings here. Could you try to add --strip-trailing-cr
> to the invocation of "diff" in tests/qapi-schema/meson.build ?
>
OK, I'll give a try

>
>  Thomas
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000f0050505ae59a7ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 3:27 AM Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 02/09/2020=
 20.33, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; <a href=3D"https://cirrus-ci.com/task/5708273301061632?command=3Dmain#=
L6792" rel=3D"noreferrer" target=3D"_blank">https://cirrus-ci.com/task/5708=
273301061632?command=3Dmain#L6792</a><br>
&gt; <br>
&gt; make: *** [Makefile.mtest:63: check-qapi-schema] Error 1<br>
<br>
I think nobody really ever cared about getting &quot;make check&quot; runni=
ng on<br>
Windows... So as a first step, I think you could submit your patches<br>
without the &quot;make check&quot; at the end of the build script.<br></blo=
ckquote><div>For this, I&#39;ve already done.</div><div>Now I am trying to =
getting make check to be success=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
Now looking at the error at above URL, this looks like a problem with<br>
the CR-LF vs. LF endings here. Could you try to add --strip-trailing-cr<br>
to the invocation of &quot;diff&quot; in tests/qapi-schema/meson.build ?<br=
></blockquote><div>OK, I&#39;ll give a try=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000f0050505ae59a7ac--

