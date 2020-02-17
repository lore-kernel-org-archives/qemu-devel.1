Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF1C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CB120718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmLoq72j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CB120718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3hic-0007qy-T6
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 09:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j3hi4-0007Pn-UZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j3hi3-0000BW-OO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:49:20 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:41585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j3hi3-0000BA-Ha
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:49:19 -0500
Received: by mail-oi1-x22d.google.com with SMTP id i1so16873342oie.8
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 06:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ySk/WjZHI3VwbNxfkXONikn9fWfZngPMP+eS7znGzoQ=;
 b=EmLoq72jSG99tTha1JIGBUpr5ggLUwwmz73tv5Xk5fQ4kzB4tsmQr3n69hVcakpHa2
 a3ASHsUtGAq3Kag3FoppC9SzjSQodoshFYLXffKk8ia+TFG68AsslIgBkP+UOdDqisWd
 7hVdzWLH5vleQ0nY2haDTl8MzDxK6sMPbu2YYp5/PB8tm42phDLxmZ313QBrfSGSztdh
 R0bB9Qcv2FTGBzubjrN5xK6lpJe7XqRjCUZxWv1/v09R3NzZ0RhO6IRi2mHbjBM8SmTk
 jJtiY66dgCzh0UiBaWwd+2HjwGvvy07P0AEso6vB7II/6nk2GJ5oXDxMOK0x/vN5vlD+
 +GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ySk/WjZHI3VwbNxfkXONikn9fWfZngPMP+eS7znGzoQ=;
 b=m98BSGitXGWlC71xlB4Lve1/MJeh6AQoKXvUPzEsYdDrH8fVi1384n1/LXHyFoI5ra
 l8mZj2gNq8u8BoTTbJj6C7wx31eWsNKEh+KmhPJZ7svNQpFxbGs+KyIcDMSdC83wCvVK
 b+s8kQ0cE5c8Q7n0j8neDHzP6tvVhNCEZMowZVq6rvrvQo3rZEjMVBnE8QzNVYzcKQ75
 j/eY/jqFjpH58Rb5HCWX6Jr+5RR21vkcBfkWfgctmuSpI5NkfYoQBRnAoAFsOy/VxaLI
 cVt7b1/luKd4ceoU+YKqz8CrEe0DmzXOT2pWj3VZwO3YzjEipkdBrxAHdvexs1GYPd7Y
 c7SA==
X-Gm-Message-State: APjAAAVWAPV8NI2eZ30yYg5x++EYSOb3rztaxxzcjgqLjqdG8DTkZGLa
 JolRtymz83fNxsgD33nItD+79lAjSz/4EUn+B8I=
X-Google-Smtp-Source: APXvYqx5cTyuFlkuFFOdb+oLj9MVyEwXyZC33rrCGAFq/kusWJxtfY83IHX89QaWXx6e+k9ZQYtrn9gtNcXZcm/BCX4=
X-Received: by 2002:aca:5844:: with SMTP id m65mr10232458oib.136.1581950958171; 
 Mon, 17 Feb 2020 06:49:18 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
 <CAFEAcA-RnKYfJRaGDSFFx=O17mdvsPMEwbfQ1prTrhmrosAGHQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-RnKYfJRaGDSFFx=O17mdvsPMEwbfQ1prTrhmrosAGHQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 17 Feb 2020 15:48:58 +0100
Message-ID: <CAL1e-=gN65hjRYvxPpsvo0TLLKAY80UGq0mhPPXMAXg+Oo8MGQ@mail.gmail.com>
Subject: Re: should we have a new 'tools' manual?
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e9fb06059ec6a8cd"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e9fb06059ec6a8cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

3:37 PM Pon, 17.02.2020. Peter Maydell <peter.maydell@linaro.org> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Fri, 7 Feb 2020 at 11:50, Peter Maydell <peter.maydell@linaro.org>
wrote:
> > but some of our documentation has always been a bit of an awkward
> > fit into this classification:
> >  * qemu-img
> >  * qemu-nbd
> >  * virtfs-proxy-helper
> > etc. I've tended to put these things into interop/.
> >
> > The proposal from Dan and David was that we should add a sixth
> > top-level manual
> >  * QEMU Tools Guide (docs/tools)
> >
> > which would be a more coherent place for these to live.
>
> OK, consensus seems to be that this is a good idea.

Hi,

I add the same good opinion to the consensus.

But, we also should create some sort of action item lists for appropriate
people about completing existing and/or creating missing documentation
parts.

Truly yours,
Aleksandar

> Here's
> what I specifically intend to move:
>  docs/interop/qemu-img.rst
>  docs/interop/qemu-nbd.rst
>  docs/interop/virtfs-proxy-helper.rst
>  docs/interop/qemu-trace-stap.rst
>  docs/interop/virtiofsd.rst
>
> Nothing else (in particular including qemu-ga.rst) moves;
> none of the as-yet unconverted documents need to move either.
>
> thanks
> -- PMM
>

--000000000000e9fb06059ec6a8cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">3:37 PM Pon, 17.02.2020. Peter Maydell &lt;<a href=3D"mailto=
:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On Fri, 7 Feb 2020 at 11:50, Peter Maydell &lt;<a href=3D"mailto:peter=
.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt; &gt; but some of our documentation has always been a bit of an awkward=
<br>
&gt; &gt; fit into this classification:<br>
&gt; &gt;=C2=A0 * qemu-img<br>
&gt; &gt;=C2=A0 * qemu-nbd<br>
&gt; &gt;=C2=A0 * virtfs-proxy-helper<br>
&gt; &gt; etc. I&#39;ve tended to put these things into interop/.<br>
&gt; &gt;<br>
&gt; &gt; The proposal from Dan and David was that we should add a sixth<br=
>
&gt; &gt; top-level manual<br>
&gt; &gt;=C2=A0 * QEMU Tools Guide (docs/tools)<br>
&gt; &gt;<br>
&gt; &gt; which would be a more coherent place for these to live.<br>
&gt;<br>
&gt; OK, consensus seems to be that this is a good idea.</p>
<p dir=3D"ltr">Hi,</p>
<p dir=3D"ltr">I add the same good opinion to the consensus.</p>
<p dir=3D"ltr">But, we also should create some sort of action item lists fo=
r appropriate people about completing existing and/or creating missing docu=
mentation parts.</p>
<p dir=3D"ltr">Truly yours,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; Here&#39;s<br>
&gt; what I specifically intend to move:<br>
&gt; =C2=A0docs/interop/qemu-img.rst<br>
&gt; =C2=A0docs/interop/qemu-nbd.rst<br>
&gt; =C2=A0docs/interop/virtfs-proxy-helper.rst<br>
&gt; =C2=A0docs/interop/qemu-trace-stap.rst<br>
&gt; =C2=A0docs/interop/virtiofsd.rst<br>
&gt;<br>
&gt; Nothing else (in particular including qemu-ga.rst) moves;<br>
&gt; none of the as-yet unconverted documents need to move either.<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br>
&gt;<br>
</p>

--000000000000e9fb06059ec6a8cd--

