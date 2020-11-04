Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D07C4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBAF223FD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="MlIFbEhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBAF223FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaL7i-0004CV-NJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kaL6X-0003J4-OW
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:53:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kaL6U-0004Hr-7E
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:53:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id 23so2150966wmg.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 07:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EmM11uwFlxel1TC6VuVmsoPnMMZWQGUHWg/ghcKYsrE=;
 b=MlIFbEhhAnx93cyPXzZ/xHF0kIF9m0xmHU3BupHIp0jEXZvVH3AY2vZiUdsrzYAyWi
 G01/FeFpjtLwdsCSzUs49e8DRE2Q7bwVNbbv6Dhem5Lr6FTEeT4JtzykTir+j3CwtqkP
 iwUqL93xgOFBaPY1tapU8A0CzgaTX4dd0IU6DK9UicPFqp2Du7IOSUO6H76U2+zMoegc
 oS2Aj9s3JxuWamyD41i2MOVUqHcjvHC62txX531Bmae82f8e7V6z843RcOX80l32Auvi
 zb0pxbXSpq+9xuZN1pG17dgUIaihIfnh/n24YnQOVFLSee2cOhXmA8YyCTl5GTOLwsRx
 s7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EmM11uwFlxel1TC6VuVmsoPnMMZWQGUHWg/ghcKYsrE=;
 b=Y8uYGXF0Qimrlz4mp9XdqlT7xALLcIQQW2Wm1jPoroZx8n1vcffD/mbpbkPej2ggAX
 59fEI9W50zpVcLsiO6pUUC2IiaPumtobNBHFb6lp+ARG3kyRL3SclsXZCYAViUhYJewk
 WNdFSyjAqOcoDIOl/p/TRukZPPNQMrENbOgy1D9T36DXl6zrl85FqExjbV3TNTFhBfGV
 Nkhh89ODimq/8KAML24TTSgzwmNQip28m/Pfhvmr5gb2CgTcIcNFeVRrB76gT+VZwCwA
 jstUWYCdy0IsuG76p3pvYporAHRDQwPd7Qaycc6klyPZ1EvD8J81wuAvqP8uDIAaMHU/
 xJ+g==
X-Gm-Message-State: AOAM531w8x/sHETtw4VqPmJH3AWB0ORnvizY2M8ey7Ct5uQampXzCjTo
 wKYYdjAHgAdRW5mq5SnRvtAYcbFXfd41+KbYgdTKDw==
X-Google-Smtp-Source: ABdhPJyhnaH7hu5jhjDj9tRBE1mUIgXbuM7PZiPxWHNRe0fDhkbyC7OpAAg7+5xhmpc/4VrVrq1EpdihaXLGkZcn3Wk=
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr4206653wmf.137.1604505220046; 
 Wed, 04 Nov 2020 07:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20200921093325.25617-1-ani@anisinha.ca>
 <20201015165215.GE5733@habkost.net>
 <CAARzgwwQAaJV=Mp=nB7FmCeZqmQO+gEBrkPiCWaVSESYYwGcbg@mail.gmail.com>
In-Reply-To: <CAARzgwwQAaJV=Mp=nB7FmCeZqmQO+gEBrkPiCWaVSESYYwGcbg@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 4 Nov 2020 21:23:29 +0530
Message-ID: <CAARzgwxqCg2xC2CE=yWwLokrhsNN50eZvOVM2Rks90ZbO4g4BA@mail.gmail.com>
Subject: Re: [PATCH v3] qom: code hardening - have bound checking while
 looping with integer value
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ae785105b349fbbc"
Received-SPF: none client-ip=2a00:1450:4864:20::342;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ae785105b349fbbc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping ...

On Sat, Oct 31, 2020 at 9:51 PM Ani Sinha <ani@anisinha.ca> wrote:

> On Thu, Oct 15, 2020 at 10:22 PM Eduardo Habkost <ehabkost@redhat.com>
> wrote:
> >
> > On Mon, Sep 21, 2020 at 03:03:25PM +0530, Ani Sinha wrote:
> > > Object property insertion code iterates over an integer to get an
> unused
> > > index that can be used as an unique name for an object property. This
> loop
> > > increments the integer value indefinitely. Although very unlikely,
> this can
> > > still cause an integer overflow.
> > > In this change, we fix the above code by checking against INT16_MAX
> and making
> > > sure that the interger index does not overflow beyond that value. If =
no
> > > available index is found, the code would cause an assertion failure.
> This
> > > assertion failure is necessary because the callers of the function do
> not check
> > > the return value for NULL.
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> > Queued on machine-next, thanks!  My apologies for the delay.
>
> Any idea when this will be pulled?
>

--000000000000ae785105b349fbbc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ping ...</div><div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Sat, Oct 31, 2020 at 9:51 PM Ani Sinha &l=
t;<a href=3D"mailto:ani@anisinha.ca">ani@anisinha.ca</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-color=
:rgb(204,204,204)">On Thu, Oct 15, 2020 at 10:22 PM Eduardo Habkost &lt;<a =
href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">ehabkost@redhat.com</=
a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Sep 21, 2020 at 03:03:25PM +0530, Ani Sinha wrote:<br>
&gt; &gt; Object property insertion code iterates over an integer to get an=
 unused<br>
&gt; &gt; index that can be used as an unique name for an object property. =
This loop<br>
&gt; &gt; increments the integer value indefinitely. Although very unlikely=
, this can<br>
&gt; &gt; still cause an integer overflow.<br>
&gt; &gt; In this change, we fix the above code by checking against INT16_M=
AX and making<br>
&gt; &gt; sure that the interger index does not overflow beyond that value.=
 If no<br>
&gt; &gt; available index is found, the code would cause an assertion failu=
re. This<br>
&gt; &gt; assertion failure is necessary because the callers of the functio=
n do not check<br>
&gt; &gt; the return value for NULL.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" t=
arget=3D"_blank">ani@anisinha.ca</a>&gt;<br>
&gt; &gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Queued on machine-next, thanks!=C2=A0 My apologies for the delay.<br>
<br>
Any idea when this will be pulled?<br>
</blockquote></div></div>

--000000000000ae785105b349fbbc--

