Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475DA206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txrh3jKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475DA206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsu8X-0004Sr-K9
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsu7u-0003yy-Vp
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:23:39 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:44171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsu7t-00058K-3C
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:23:38 -0400
Received: by mail-io1-xd29.google.com with SMTP id i4so44544042iov.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ziYWx1Xx1YGUk5hJjypGblLR218V4SSYUHoq7OhI9og=;
 b=txrh3jKcwm1hT8n5f8WsUNnUG6hIh0QhDdea1zkTuBIn+8q2e/UY2mfKjx6ewxPMVK
 VeCMTeBW3jMYpJoxyU2WPeMUMfaI+VlAk+WAMihq62Yrq+Wq5rkd+rL/xzYKz2q9HrXP
 AnpWwJM0+KVPcJWjxExVCukQa+mz8ILOx1Xziw0xPSX5+qOcF+mm3xWA4hEN+LPJk33h
 Fx7aBqstzPq4VFs8DHo/9dRwjZLRSj6kFT7xDg+mLb/of3cPMYFuJOg0PEmaC7K0l0Vs
 QyILQRyIU04AmO7cXC6vAe8YS9ngez2kLl5czSlOmUw5BWwAP95MJU3t3+sa3M6sNWVW
 zbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ziYWx1Xx1YGUk5hJjypGblLR218V4SSYUHoq7OhI9og=;
 b=LNfVv4CgV/IVCQwhNqNFEXaU4t2xFN+b2bxtn5ih2rQWiRLoGAIXYOVgfpfUNDuCrU
 PyTk4UKztgujXYBXSJIu6E1B4bgAgiXtraD4dNHv6NIarnpCYhr0tTxFoSvuPoQjXZOX
 lZ4K2go/qQBpqUXhACC6+r3KcB7DzRcDTmwQucGPLPOyeCWj0eeeBxOcwkOIKyaWTfFD
 VrR+fMhHtaawf3S5UIb7nsmIYFcvlM5b6vhYiza1fPx7nmrnJi7x4hplnfVmyoifwzcK
 OjFw1y8vTvPr8cTqBNLlbReIhHw9p1TWZ4BOKDOEzZamhHIqOeaSeykeztdTlDGk/UwK
 wq+g==
X-Gm-Message-State: AOAM5303hTCcSUinZQ/A7B9F5ntzgjSUtr+Uoz63aLnxay7KaKflqsbo
 l47KUo4OUS5lS+M7v+sFrx/o2dPxaOjh06n2KCY=
X-Google-Smtp-Source: ABdhPJxgqLfFVry733DNOKPvH4QXB4kbe6SrACHb/LG0c9LEOsGFu78K9d3pwe2On0/9GCZgWhDuAmoGkNJ7CJ3UlKc=
X-Received: by 2002:a5d:96d7:: with SMTP id r23mr33070160iol.126.1594153415893; 
 Tue, 07 Jul 2020 13:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CADBGO7-hp4Pyfn+rq9d=ZxHmpMwitv-oLjYPJmCKSH6cLHVx=w@mail.gmail.com>
 <CADBGO78-mqwapj+mdpFUO-puL0OZ_1QeBc+4yo4S9g1O4deNjg@mail.gmail.com>
 <2d312ec0-d280-c0e3-2b1e-ff9c70c3168f@gmail.com>
 <20200707075740.dkc76ceb7wytdoem@sirius.home.kraxel.org>
In-Reply-To: <20200707075740.dkc76ceb7wytdoem@sirius.home.kraxel.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 7 Jul 2020 13:23:09 -0700
Message-ID: <CADBGO79KSm3KV7=otOg=u7WjwBV=j3T7iU0fcTF-nGgtZvy+Aw@mail.gmail.com>
Subject: Re: Failure prints during format or mounting a usb storage device
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001268ac05a9dfc4a6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd29.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sai Pavan Boddu <saipava@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vikram Garhwal <fnuv@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001268ac05a9dfc4a6
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 7, 2020 at 12:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> >
> > Gerd, do you know the purpose of the 'short_not_ok' parameter to
> > usb_packet_setup()?
>
> Well, some usb host controllers have a flag in the transfer control
> blocks to indicate the host controller should stop processing requests
> in case of a short transfer.
>
> The usb core uses the flag to just to that (i.e. halt the endpoint on
> short transfers).  It is also checked when usb-host pipelines requests
> (requests queued after a short-not-ok packet can't be pipelined because
> we don't know yet whenever we should continue processing the endpoint or
> not).
>
> xhci has no such flag so the flag is never set.
>
> > The simple patch below fixes the reported problem,
> > but I don't know if it could cause some other problems for XHCI.
> > hcd-ehci, hcd-ohci, hcd-uhci all set the parameter conditionally,
> > but hcd-xhci never sets it. I don't understand the purpose of the
> > parameter myself.
> >
> > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > index b330e36fe6..9fb96fdd66 100644
> > --- a/hw/usb/hcd-xhci.c
> > +++ b/hw/usb/hcd-xhci.c
> > @@ -1614,7 +1614,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
> >      xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets
> int_req */
> >      usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
> > -                     xfer->trbs[0].addr, false, xfer->int_req);
> > +                     xfer->trbs[0].addr, dir == USB_TOKEN_IN,
> xfer->int_req);
>
> I suspect this might lead to queues being halted even though they should
> not.
>
> Why does 7ad3d51ebb8a522ffcad391c4bef281245739dde look at short-not-ok?
>

Because the patch changes dev-storage to terminate the transfer if a
short packet is received, so I figured 'short-not-ok' should affect
that behavior.

I guess instead I could add another flag that only hcd-dwc2 sets. Does
that sound OK to you?

Thanks,
Paul


> take care,
>   Gerd
>
>

--0000000000001268ac05a9dfc4a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2020 at 12:57 AM Gerd Hoffmann=
 &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 Hi,<br>
&gt; <br>
&gt; Gerd, do you know the purpose of the &#39;short_not_ok&#39; parameter =
to<br>
&gt; usb_packet_setup()?<br>
<br>
Well, some usb host controllers have a flag in the transfer control<br>
blocks to indicate the host controller should stop processing requests<br>
in case of a short transfer.<br>
<br>
The usb core uses the flag to just to that (i.e. halt the endpoint on<br>
short transfers).=C2=A0 It is also checked when usb-host pipelines requests=
<br>
(requests queued after a short-not-ok packet can&#39;t be pipelined because=
<br>
we don&#39;t know yet whenever we should continue processing the endpoint o=
r<br>
not).<br>
<br>
xhci has no such flag so the flag is never set.<br>
<br>
&gt; The simple patch below fixes the reported problem,<br>
&gt; but I don&#39;t know if it could cause some other problems for XHCI.<b=
r>
&gt; hcd-ehci, hcd-ohci, hcd-uhci all set the parameter conditionally,<br>
&gt; but hcd-xhci never sets it. I don&#39;t understand the purpose of the<=
br>
&gt; parameter myself.<br>
&gt; <br>
&gt; diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c<br>
&gt; index b330e36fe6..9fb96fdd66 100644<br>
&gt; --- a/hw/usb/hcd-xhci.c<br>
&gt; +++ b/hw/usb/hcd-xhci.c<br>
&gt; @@ -1614,7 +1614,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)=
<br>&gt;=C2=A0 =C2=A0 =C2=A0 xhci_xfer_create_sgl(xfer, dir =3D=3D USB_TOKE=
N_IN); /* Also sets int_req */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 usb_packet_setup(&amp;xfer-&gt;packet, dir, ep, xf=
er-&gt;streamid,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0xfer-&gt;trbs[0].addr, false, xfer-&gt;int_req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0xfer-&gt;trbs[0].addr, dir =3D=3D USB_TOKEN_IN, xfer-&gt;int_req);<b=
r>
<br>
I suspect this might lead to queues being halted even though they should<br=
>
not.<br>
<br>
Why does 7ad3d51ebb8a522ffcad391c4bef281245739dde look at short-not-ok?<br>=
</blockquote><div><span class=3D"gmail_default" style=3D"font-family:monosp=
ace"><br></span></div><div><span class=3D"gmail_default" style=3D"font-fami=
ly:monospace">Because=C2=A0the patch changes dev-storage to terminate the t=
ransfer if a</span></div><div><span class=3D"gmail_default" style=3D"font-f=
amily:monospace">short packet is received, so I figured &#39;short-not-ok&#=
39; should affect</span></div><div><span class=3D"gmail_default" style=3D"f=
ont-family:monospace">that behavior.</span><br></div><div><span class=3D"gm=
ail_default" style=3D"font-family:monospace"><br></span></div><div><span cl=
ass=3D"gmail_default" style=3D"font-family:monospace">I guess instead I cou=
ld add another flag that only hcd-dwc2 sets. Does</span></div><div><span cl=
ass=3D"gmail_default" style=3D"font-family:monospace">that sound OK to you?=
</span></div><div><span class=3D"gmail_default" style=3D"font-family:monosp=
ace"><br></span></div><div><span class=3D"gmail_default" style=3D"font-fami=
ly:monospace">Thanks,</span></div><div><span class=3D"gmail_default" style=
=3D"font-family:monospace">Paul</span></div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
take care,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>

--0000000000001268ac05a9dfc4a6--

