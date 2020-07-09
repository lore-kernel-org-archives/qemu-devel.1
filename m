Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD7E20767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6lf57UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD7E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZ4I-000152-31
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jtZ0G-00054A-SG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:02:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jtZ0B-0000Qg-E7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:02:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id f139so2386400wmf.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UkEzIs/2mGlssaRdFH3mLGeknEVjmlMoUHWypue5+QU=;
 b=m6lf57UAGGJYA4sbgoftRnHRBxDNEYZeX0ZjhxbEHexuDJEXbQLpaWwW7/zBYkcwsQ
 C8bA/GX5JIaoa0yPe8UGL1NJhrvZcHAWShB3JOJYEQh+fTInFK9ed4/9sU6lc5QE3BJ4
 DGLeCgJ/XqwBYAj3NcPOsov1aIA5ha0s3WD5Bg5dCYPlvzygFvSugEXNtTDVHBXDzJFl
 WzohEJ4xGtXh0ZP1X4vbmfnkL0evfc7SB9EvFyNpzcLRls3RCcRRxqyw/iWD0kV8Nc8u
 DPa9FI2bxsfGVMSSu3jLh/rXiFLFD7MPD9jvjM6/6j3w48dv0Hu4CKHn7XR64nWdhnSf
 qYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UkEzIs/2mGlssaRdFH3mLGeknEVjmlMoUHWypue5+QU=;
 b=a1AFK85cK6EO+E1rjIzIeCx4T/JgzmDSsvIGFy/PS5Jqj86vCE3rn5OSwkMqi6EaGz
 +x1fyL1GQ2TdhvpjSmYijr46v1D1JbnJwgb550Lz84zvcWde/gEegDev6/qetGApIyfo
 58Jf97X/vqVVCu4uiXjZFj334L1339Eyl+Yd2Gd5nXzTV+PkO4QQ/nVpwox9ALNPmi4V
 1DWh1BWMwIjWQAuw65WV3GEADsTSeLiX2T6bL+ulK3ZRAZLcmorKrsxqCzuIx7X+mfs9
 PG3yOa2oCEcEU6pNfJzwtyv6piaPNWv+9VnaJgsdkqj6J19k69aEVTE7jLdAl/ExUWl2
 k41g==
X-Gm-Message-State: AOAM530tHurCkMpc7h6rGo6ZpaEqz0U8h6pfbqlCdsCh+4NnQuUixcR0
 kMwkcYoLZlN27yZxlZ5Ny8EAxTnXr796odZIuPg=
X-Google-Smtp-Source: ABdhPJzyf1v1lQTHlQqfOpmmuaNVIJrrRKFdEzGINWfz3UxlvZQdEonLJi9fF16mtoout+5QaANZlUlW/whI7w0Me/Y=
X-Received: by 2002:a1c:2982:: with SMTP id p124mr787743wmp.26.1594310541668; 
 Thu, 09 Jul 2020 09:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+o7mcb8B9dy_F3w08i7XLrO71qWyqYNaJrjv0j3DhnSg@mail.gmail.com>
 <2666aec2-9872-6af6-7705-d7ce553f611c@redhat.com>
 <20200709152630.GW3753300@redhat.com>
 <CAFEAcA_9NUeMJQWuzbmm9raW4zBgu3FFhgCabxBD_RhKMo9GxQ@mail.gmail.com>
 <CAJ+F1C+MK0tEyHS_xSD6bBWJZFALF6jOwFAU2zYoJimnyGRdAw@mail.gmail.com>
 <874kqgn0vj.fsf@linaro.org>
 <CAFEAcA_nk_EjsR59BGkBzYo_Gvkuqi_3AyODOxBm1Ec2gfxKww@mail.gmail.com>
In-Reply-To: <CAFEAcA_nk_EjsR59BGkBzYo_Gvkuqi_3AyODOxBm1Ec2gfxKww@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Jul 2020 20:02:09 +0400
Message-ID: <CAJ+F1CJBuNvsUDkFVM2CgwjZjCeAztrVTsoo3tSVT90GR5rDNQ@mail.gmail.com>
Subject: Re: Is VXHS actually maintained?
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007f75da05aa045964"
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x32c.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, ashmit602@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007f75da05aa045964
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 9, 2020 at 7:52 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 9 Jul 2020 at 16:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> > That looks more like it got missed in a clean-up series because we don'=
t
> > have coverage in our typical builds and CI?
>
> Yes, very likely. But there's no point in fixing and then adding CI
> for a config that our users have demonstrated that they do not use;
> better to just remove it.
>

Agree, I'll send a patch then.


--=20
Marc-Andr=C3=A9 Lureau

--0000000000007f75da05aa045964
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div><div><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 9, 2020 at 7:52 PM Pete=
r Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lin=
aro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Thu, 9 Jul 2020 at 16:50, Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; wr=
ote:<br>
&gt; That looks more like it got missed in a clean-up series because we don=
&#39;t<br>
&gt; have coverage in our typical builds and CI?<br>
<br>
Yes, very likely. But there&#39;s no point in fixing and then adding CI<br>
for a config that our users have demonstrated that they do not use;<br>
better to just remove it.<br></blockquote><div><br></div><div>Agree, I&#39;=
ll send a patch then.<br></div><br clear=3D"all"></div><br>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div></=
div>

--0000000000007f75da05aa045964--

