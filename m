Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4970CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145C32070A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5zHjeZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145C32070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icAPp-0007Uh-7Q
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 10:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1icA2Z-0007FQ-7u
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1icA2P-0006w1-6X
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:24:33 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:43274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1icA2N-0006fd-Rb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:24:29 -0500
Received: by mail-ed1-x535.google.com with SMTP id dc19so3469532edb.10
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 07:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0BFBCN04jdGlNSwxdk9GhU+61wcJ9HUdCARS1ttEYB8=;
 b=h5zHjeZnYITC/1omSkoYMafb5pICGF9+tjiAHXdNt084hTXxOToCZja73RZjLHoCMR
 YSeqwBK2rJ7BwFtPCXtONZODR6+v95eWELu67885flX5nY8+kKvbKUzQrNqw78MsOTA2
 XcBy45otOEVgRr7PABnjXJ+dl2GgQb/D/bmtt9iM8JVBPIe324Thf1hGVg0+y0uecAkv
 rYG+z1E0GIMoXXHsIN5xDq5OFTV4PdaxCqNT4gpeoBIZMOPfWMrz5T4VOJjg/zmutAki
 6YtaTLZ1oLicYxhfE87jZcTKoPVX5sGu2Dxbiv8FFLJcKIJMgG6pdeE6SYqREQbvqma0
 TB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0BFBCN04jdGlNSwxdk9GhU+61wcJ9HUdCARS1ttEYB8=;
 b=L/gA09XINTWs/cqH3O5emH+NjcrB7UlEqxGZCACXkdOlkcfsJuHAxVMu9i2aQ14a71
 FVjEyiM7vO0+bG5fp8gvnWJPa3lL9f1fRgYhrrtqvHvRfx/uQpziU3NxgbT3FTEkumiF
 Jx6d1UUvT14t7QL22irgiCh0rgKNFGCANW7ggdvcUN5G5epOBXvnxqEEtlYYs0Qio9hA
 uDcIvHL131EDUAdKDRLiVC3fQ+aKtaI3SqAP0j0yZsgo4LU1njcUkG7oU3gSRt/0iiaL
 kVMxl/cniar45xEPpTr3/C5both002WZcY+7DP/8s0df0qhwMFbmDJ59a3JQGtGwdZHm
 uTOw==
X-Gm-Message-State: APjAAAW3JkKRB4ro0MthV3/Iue4NNJ1S9GdiggOpNfswLsyaPemXnOoB
 uYdL8Tg3ZN+Ms82HRxf4LypayUM7n+2UGWV4+PBP8SUi
X-Google-Smtp-Source: APXvYqxr7l9XCtWxF0OTeOD/YaSY2EYKWCRleBeivwIAJJeUr7Kt/ftuNmJTamI2Lz1BK45DSElRuO1UgRODSeJx1UU=
X-Received: by 2002:aa7:d84b:: with SMTP id f11mr3862407eds.96.1575386664026; 
 Tue, 03 Dec 2019 07:24:24 -0800 (PST)
MIME-Version: 1.0
References: <CAGbAg_CAh-U-xRh+d6wNLQVWoHXEA0xcW6021Qd4WsMJBGfgOg@mail.gmail.com>
In-Reply-To: <CAGbAg_CAh-U-xRh+d6wNLQVWoHXEA0xcW6021Qd4WsMJBGfgOg@mail.gmail.com>
From: Esteban Bosse <estebanbosse@gmail.com>
Date: Tue, 3 Dec 2019 16:24:11 +0100
Message-ID: <CAGbAg_A5G2trFWEuAL2da169v=XFrS44g64F6yZo5phLC+T=PQ@mail.gmail.com>
Subject: Re: BeagleBone support, omap1, omap2, omap3, etc.
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007e472f0598ce4a99"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::535
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007e472f0598ce4a99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

El mi=C3=A9., 6 nov. 2019 16:04, Esteban Bosse <estebanbosse@gmail.com> esc=
ribi=C3=B3:

> Hello!
>
> Some months ago I started to work trying to port the Beaglebone support
> from the old qemu-linaro fork to the new QEMU mainstream.
>
> During my work I found that the Beaglebone have an OMAP3 mpu this mpu has
> very strong relation with the OMAP2 and OMAP1 in qemu, they implement a l=
ot
> of functions in common.
>
> Then I understood that the omap1 and omap2 don't implement things like QO=
M
> and needs a lot of work to upgrade it, at the same time they are some
> boards like: omap1_sx, palm, nseries that implement this mpus.
>
> Looking the datasheet of the omap1 I realized that it's an very old devic=
e
> and some questions like "make sense work with this old device?" comes to =
my
> mind.
>
> When I went to the KVM Forum the last week I talked with some of you, and
> you help my with different ideas and proposal to make this task, but I
> can't see the right way to make this work because it is a lot of work.
>
> My motivation is learn more about embedded devices, architecture, kernel,
> etc. and of course contribute to the community.
>
> I would love to hear your opinions about this 3 related devices with they
> respected boards.
>
> Maybe someone is interested to work with me.
> I dream to make this work beautiful (like the musca board with the armsse
> and armv7m modules) with a good variety of tests. And in the same time I
> would like to write some documentation about the process with the final
> idea to "make an easier way for new contributors".
>
> If someone want to work with me in this task, should know that I don't
> have to much experience and I'm doing this job in my free time (this mean=
s
> that I work only in my free time).
>
> I appreciate any kind of comment or advice.
>
> Thanks for your time ;)
> EstebanB
>

--0000000000007e472f0598ce4a99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ping=C2=A0</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">El mi=C3=A9., 6 nov. 2019 16:04, Esteban Boss=
e &lt;<a href=3D"mailto:estebanbosse@gmail.com">estebanbosse@gmail.com</a>&=
gt; escribi=C3=B3:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"=
>Hello!<br><br>Some months ago I started to work trying to port the Beagleb=
one support from the old qemu-linaro fork to the new QEMU mainstream.<br><b=
r>During my work I found that the Beaglebone have an OMAP3 mpu this mpu has=
 very strong relation with the OMAP2 and OMAP1 in qemu, they implement a lo=
t of functions in common.<br><br>Then I understood that the omap1 and omap2=
 don&#39;t implement things like QOM and needs a lot of work to upgrade it,=
 at the same time they are some boards like: omap1_sx, palm, nseries that i=
mplement this mpus.<br><br>Looking the datasheet of the omap1 I realized th=
at it&#39;s an very old device and some questions like &quot;make sense wor=
k with this old device?&quot; comes to my mind.<br><br>When I went to the K=
VM Forum the last week I talked with some of you, and you help my with diff=
erent ideas and proposal to make this task, but I can&#39;t see the right w=
ay to make this work because it is a lot of work.<br><br>My motivation is l=
earn more about embedded devices, architecture, kernel, etc. and of course =
contribute to the community.=C2=A0<br><br>I would love to hear your opinion=
s about this 3 related devices with they respected boards.<br><br>Maybe som=
eone is interested to work with me. <br>I=C2=A0dream to make this work beau=
tiful (like the musca board with the armsse and armv7m modules) with a good=
 variety of tests. And in the same time I would like to write some document=
ation about the process with the final idea to &quot;make an easier way for=
 new contributors&quot;.<br><br>If someone want to work with me in this tas=
k, should know that I don&#39;t have to much experience and I&#39;m doing t=
his job in my free time (this means that I work only in my free time).<br><=
br>I appreciate any kind of comment or advice.<div><br>Thanks for your time=
 ;)<br><div>EstebanB</div></div></div>
</blockquote></div>

--0000000000007e472f0598ce4a99--

