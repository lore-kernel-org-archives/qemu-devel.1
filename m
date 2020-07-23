Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E83C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FCE207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPjQKRWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FCE207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySz7-0002cJ-3G
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 00:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jySyX-00026o-8t; Thu, 23 Jul 2020 00:36:57 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:41408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jySyV-0002Av-Jw; Thu, 23 Jul 2020 00:36:56 -0400
Received: by mail-io1-xd43.google.com with SMTP id p205so4920222iod.8;
 Wed, 22 Jul 2020 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z8fl/7YsgneJANp4iWKHOjjq1nhsX4GMTPR/R/t/H00=;
 b=oPjQKRWdt2F9UoEvyaAU4JqC/ewgT1fwb1bkpDwEmg56bTx4Wg7FnwxUbTjLKFLFuE
 EpkDUblDcmwemQf0mhi538t7kf7VpJD0jtGobP4FVrWd57FhDGsXxw7w4eewnJ1LT1IX
 UReiLojcX7CP2EFCncME/xEBq/D96D55WiNTV/bfWW6qVn/RWJo/vIStsyw3swVFeMzR
 OyClPtg/595AM7CTNg+Bj+rxvSxvn177W/B1E21o9u8YMX45ZWggI2PZPWjyl2F72p4n
 9LRyPAyZO0LK5o7WuyydD4o6GtRojqOEMh4rSmeUabEIO9wFsyKxKJyZCrZys0xtXjU/
 W2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z8fl/7YsgneJANp4iWKHOjjq1nhsX4GMTPR/R/t/H00=;
 b=a2hz0ridvy9PCZdFj4FV7VoIKax4e2IOQtW4LBnfAtAe9qVWFjJG7MO7kG+FsmfEUX
 kuM8y6gQybK37lXCNcYILiLvyZ4ejBSllSBRGXqRyEeTvdSKxv6xqgfFqvr480HethpF
 xTL7KClzVCHiQQVKrffiELm3XvdNymp+5zMqhlDlCsOa1a0UxZ+yml44zGqzr9s/EFUG
 WYqE6rpi8SNZUeigkXib+w6By2pEYENzTc/CcamyTT/zs3NmTARrStqERiV7teKVQ/lQ
 Z9I5g+7RFALUfhiAR27N/hdFqOoWGY5UROYUBw7aSd1ulItJgV6v2Er0BA/VW6Mqu+CF
 73FQ==
X-Gm-Message-State: AOAM533qBJ29Z7YD1yLrZeJVdrgj/I1423lmKF0Xf9tB0AktV91P91mP
 BXCkucuPHv7mPckw3WhcrHhilRr8PrzwIuj8WMM=
X-Google-Smtp-Source: ABdhPJzXD+6I2gMKoThBU3I1DlTbA2YC54IVkvh/9cfqgiHZXbq4hw2k/y3hYFHwfHimPdtEMKY5HQcQwZ2dXLuqZkk=
X-Received: by 2002:a05:6602:2f89:: with SMTP id
 u9mr3169064iow.126.1595479013641; 
 Wed, 22 Jul 2020 21:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200722154719.10130-1-thuth@redhat.com>
 <d77052d1-6203-d54a-0c36-edfafaa34922@amsat.org>
 <1aa53dfa-92a0-3866-2117-a7ce450d278f@redhat.com>
In-Reply-To: <1aa53dfa-92a0-3866-2117-a7ce450d278f@redhat.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 22 Jul 2020 21:36:27 -0700
Message-ID: <CADBGO79TMy+-hM3qUKBrE5U9OY6Pq+2LVe6iozDTzrWFYVhQoQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1] hw: Only compile the usb-dwc2 controller if it is
 really needed
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000dad55b05ab14677d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dad55b05ab14677d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gerd, it's OK by me if you take Thomas's patch instead, I agree the
changelog is better. It also has a fixes tag.

Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>


On Wed, Jul 22, 2020 at 9:29 PM Thomas Huth <thuth@redhat.com> wrote:

> On 22/07/2020 19.23, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 7/22/20 5:47 PM, Thomas Huth wrote:
> >> The USB_DWC2 switch is currently "default y", so it is included in all
> >> qemu-system-* builds, even if it is not needed. Even worse, it does a
> >> "select USB", so USB devices are now showing up as available on target=
s
> >> that do not support USB at all. This sysbus device should only be
> >> included by the boards that need it, i.e. by the Raspi machines.
> >
> > Paul already sent that patch (your description is better although):
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg723681.html
>
> Oh, thanks for the pointer, I should have checked my qemu-devel folder
> first... Please disregard my patch!
>
>  Thomas
>
>

--000000000000dad55b05ab14677d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e">Gerd, it&#39;s OK by me if you take Thomas&#39;s patch instead, I agree =
the</div><div class=3D"gmail_default" style=3D"font-family:monospace">chang=
elog is better. It also has a fixes tag.</div><div class=3D"gmail_default" =
style=3D"font-family:monospace"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace">Reviewed-by: Paul Zimmerman &lt;<a href=3D"mail=
to:pauldzim@gmail.com">pauldzim@gmail.com</a>&gt;</div><div class=3D"gmail_=
default" style=3D"font-family:monospace"><br></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 22, 2020 at =
9:29 PM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On 22/07/2020 19.23, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; On 7/22/20 5:47 PM, Thomas Huth wrote:<br>
&gt;&gt; The USB_DWC2 switch is currently &quot;default y&quot;, so it is i=
ncluded in all<br>
&gt;&gt; qemu-system-* builds, even if it is not needed. Even worse, it doe=
s a<br>
&gt;&gt; &quot;select USB&quot;, so USB devices are now showing up as avail=
able on targets<br>
&gt;&gt; that do not support USB at all. This sysbus device should only be<=
br>
&gt;&gt; included by the boards that need it, i.e. by the Raspi machines.<b=
r>
&gt; <br>
&gt; Paul already sent that patch (your description is better although):<br=
>
&gt; <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg72368=
1.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/q=
emu-devel@nongnu.org/msg723681.html</a><br>
<br>
Oh, thanks for the pointer, I should have checked my qemu-devel folder<br>
first... Please disregard my patch!<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div>

--000000000000dad55b05ab14677d--

