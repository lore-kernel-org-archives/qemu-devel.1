Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C57CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ABB2177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1MsTmqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ABB2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xnD-0004TG-Gr
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k3xma-00042A-Mu
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:31:20 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:37071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k3xmY-0004A7-VZ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:31:20 -0400
Received: by mail-lj1-x22e.google.com with SMTP id w14so1327162ljj.4
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=p1E9ZFf1UZjoEZCLfqoSteXFNN1vgP1l5BURIYaM3e4=;
 b=Q1MsTmqEAmRgdlki0mK2a4i0kV7u4RD+gnBq6FcMfMI4AXrg4WiyczbZ19f+DiQqH1
 3OMzy28WpRVWb+QVsnCB3EX1Ij71awfyQW3yuWapY26s4Z3k4Bgbc4xYzoJTdsxFkI4J
 ygcWOMuAtnGJOiNSKKc4XWAoPCRmQwO7FcPSoL91VPSy8av07YF8mcwSW8HFXOwVju8z
 tBn9U73Jc2T6p9Ff4fCWqzWzpE5VX1mTruHg/m+H6I0Udm6tk6EGhsiF3azGiOI1LCek
 LZeE0cn0CMiGnJs6pHO6p/kWMT5Lf7xVHe6uw3WVkIfuQxl3zCod70cf3d/Eh2kbOcTA
 85bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=p1E9ZFf1UZjoEZCLfqoSteXFNN1vgP1l5BURIYaM3e4=;
 b=ZVTA1V92/2h0g9iz8QURIyotyd35PjB+dNqhMRNremh9Disgn8GIO+NQNRzSBC+ixO
 SxT8i1cBZikzFnIohbNqcLtfffvi7SBlo//5KmaYCEetF9pMClGtoA2dX/ysq4vy6/bJ
 byJIctjcY86j5/XWAyDzqkGq8hMvR7624igs+A0bxgkEceagkecPdWNf6Pe56T/Tc6IW
 jBJgwu12CVMR8Xt4+JxhSN+ZSPUWIj3LLZ/IeLEKTIMrmsUik7k6xSoAPTJad/S3MCFB
 xxgj95jmit6XuO2eQnRN+rE2qlJ+fJfxPNkTZUe+LL4ljNRWm8/S9Xz4qIjykkbNzH4F
 OZhQ==
X-Gm-Message-State: AOAM533oRr27NWVcPxFe+lHmC8tURrt5IRo4a2DnVSKmN4Po+yEr6r8u
 BzcPLVK0kih47DM6oOBFbl67zmINhmURXOn4Vv4=
X-Google-Smtp-Source: ABdhPJw/MTgQ9lUp2LMsckGhi6jtwra84LfZ/cyUVwa2J6K0H83CbBJByRxT9XTWPF1jlsbQ3iyPgS2RWwZ9KU2lkFE=
X-Received: by 2002:a2e:7215:: with SMTP id n21mr6151972ljc.242.1596789076679; 
 Fri, 07 Aug 2020 01:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <CAE2XoE_eMv_=zoEe-v1HiqcKX+FNobKSKzV=9eLkJNivnuYg-A@mail.gmail.com>
 <4e8addca-7400-f1a1-ee56-991def2959ae@redhat.com>
In-Reply-To: <4e8addca-7400-f1a1-ee56-991def2959ae@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 7 Aug 2020 16:31:05 +0800
Message-ID: <CAE2XoE9HzvHOQ8odXwiOw+nsYOkwTK+jue1i-mQ6Mo29T+9Rog@mail.gmail.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b262a405ac456da9"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22e.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b262a405ac456da9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Any IDE works with meson properly? Does meson have vs code plugin?

On Fri, Aug 7, 2020 at 4:11 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 07/08/20 10:01, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > Could meson can generate CMake file or directly using CMake?
> > cause Cmake have better IDE support.
>
> No, Meson generates ninja files.  In QEMU I am translating them to
> Makefile to aid in bisectability.
>
> Paolo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000b262a405ac456da9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Any IDE works with meson properly? Does meson have vs code=
 plugin?</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, Aug 7, 2020 at 4:11 PM Paolo Bonzini &lt;<a href=3D"mailto:=
pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On 07/08/20 10:01, =E7=BD=97=E5=8B=
=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; Could meson can generate CMake file or directly using CMake?<br>
&gt; cause Cmake have better IDE support.<br>
<br>
No, Meson generates ninja files.=C2=A0 In QEMU I am translating them to<br>
Makefile to aid in bisectability.<br>
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000b262a405ac456da9--

