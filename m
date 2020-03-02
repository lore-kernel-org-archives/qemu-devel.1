Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43E0C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FF924686
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beJRAEAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FF924686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qwj-00061E-DF
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8qvw-0005Qs-TO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8qvv-00023f-NS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:40:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8qvv-00023W-Ip
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583178055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loCJ5YJU+wlUCSxyXywh6VOhf41XGO53mHah08OLEkw=;
 b=beJRAEAqkLNuqaNsCk82SDKs2cPyt7fdPFwbsBchzvlC0odt7iS4cHUT06kvsdCBzhlu8W
 D0N21HwdmUEhHh7zxWYdIEMVEAtFZN4lRPvDjDAzhyChlNaYL0nRTT8+ySkwUPnt57y8qo
 J8o6eNQRYa8SSmwEl/6BxybO30tSajQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-Qq20LC4GOLi_XYzI03qpsQ-1; Mon, 02 Mar 2020 14:40:50 -0500
X-MC-Unique: Qq20LC4GOLi_XYzI03qpsQ-1
Received: by mail-ed1-f70.google.com with SMTP id x13so352465eds.19
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 11:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rej9j7Oj4Ih8b0H7aNGA5q+y30UjTifsKe5+DDM2m+M=;
 b=H/yaJWTpVkZZB8xEAjztm6ik7Od4cDcA58Es1/ffcAZ+Xbkp9AVpSlIFBUw6KQQfrS
 HxMEmoP35sbpzYku2OOKjy1foxx/xZ6lYn6Es5a3K/1Sz59R/VsuAaIdtQH/ObSGwsaS
 JuWhRaCD5tNov2FzMdzowk5lARDcoAinvrJs+ZwujefrGMGPZJMvbzvXPIS9xk1IizJ/
 WTFh6EBiShjwFVPA/KfBh3NF/nQHfwqoXfpyF9/H74DxYDZKP1o56z0iZTV2bmR7avO8
 wb0k3jJNRu4d2YVYrT+Vi3Vprih/3wsGvSqzX6r6RkbuPD8jBRDjIdcfFJuA++QziErj
 wswg==
X-Gm-Message-State: ANhLgQ1HLlIh8xOJWUHboRW3M5y+OHnA1TPSEXJ8x3HmsYJvLrlZBbgO
 +GaybXb+BEic7zVqU9CvHSGxvjL/ba2GMJLYyLa+X2+mU+ouU5ZiotgoVmlBr2/hUl1oWXt9yb5
 7OYxsauKifqUYHxCXrWAUCbGB0et8SPQ=
X-Received: by 2002:a17:906:528b:: with SMTP id
 c11mr840666ejm.247.1583178049736; 
 Mon, 02 Mar 2020 11:40:49 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv4rkjsinxjc7v42c/yPyQzrT7GtIZU30uNHNiXmnSdKUTKel1ooy1TPtRy3x/0LxqJ9m8trEItmRDAlNjE0+I=
X-Received: by 2002:a17:906:528b:: with SMTP id
 c11mr840643ejm.247.1583178049506; 
 Mon, 02 Mar 2020 11:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com>
 <20200128140945.929-3-n54@gmx.com>
 <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
 <4e29b732-ce95-02f1-ec9c-31f1ce33cda0@gmx.com>
 <4ece50db-33c7-4630-6b0f-52197b2ae845@redhat.com>
 <5b289981-1e54-2301-af36-86361415bf6b@gmx.com>
 <bd4bb6d3-be33-2f97-8ee5-695b41b5eff1@m00nbsd.net>
In-Reply-To: <bd4bb6d3-be33-2f97-8ee5-695b41b5eff1@m00nbsd.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Mar 2020 20:40:36 +0100
Message-ID: <CABgObfZ5AdBmU7R8ycFwTLxEHXQw_GrXwJ0BMvDWgJEvKevcGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
To: Maxime Villard <max@m00nbsd.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000041e7fd059fe45d9a"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, Kamil Rytarowski <n54@gmx.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000041e7fd059fe45d9a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Il lun 2 mar 2020, 20:14 Maxime Villard <max@m00nbsd.net> ha scritto:

> Le 02/03/2020 =C3=A0 19:05, Kamil Rytarowski a =C3=A9crit :
> > On 02.03.2020 18:12, Paolo Bonzini wrote:
> >> On 03/02/20 12:56, Kamil Rytarowski wrote:
> >>> On 03.02.2020 12:41, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> @@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE, default is
> >>>>> enabled if available:
> >>>>>     hax             HAX acceleration support
> >>>>>     hvf             Hypervisor.framework acceleration support
> >>>>>     whpx            Windows Hypervisor Platform acceleration suppor=
t
> >>>>> +  nvmm            NetBSD Virtual Machine Monitor acceleration
> support
> >>>>>     rdma            Enable RDMA-based migration
> >>>>>     pvrdma          Enable PVRDMA support
> >>>>>     vde             support for vde network
> >>>>> @@ -2757,6 +2775,20 @@ if test "$whpx" !=3D "no" ; then
> >>>>>       fi
> >>>>>   fi
> >>>>>
> >>>>
> >>>> Maybe you can add something like:
> >>>>
> >>>> if test "$targetos" =3D "NetBSD"; then
> >>>>     nvmm=3D"check"
> >>>> fi
> >>>>
> >>>> to build by default with NVMM if available.
> >>>
> >>> I will add nvmm=3Dyes to the NetBSD) targetos check section.
> >>
> >> No, nvmm=3Dyes instead should fail the build if nvmm.h is not availabl=
e.
> >> That is not a good default.
> >>
> >> Paolo
> >>
> >>
> >
> > Most users will get nvmm.h in place now and this is still a tunable.
> >
> > I have got no opinion what to put there, nvmm=3Dcheck still works.
>
> I would keep "yes", for consistency with the other entries. Changing all
> entries to "check" should be done in a separate commit, unrelated to
> NVMM.
>

The difference is that KVM for example does not need external includes or
libraries.

Paolo


> > diff --git a/configure b/configure
> > index d4a837cf9d..b3560d88bb 100755
> > --- a/configure
> > +++ b/configure
> > @@ -836,7 +836,7 @@ DragonFly)
> >  NetBSD)
> >    bsd=3D"yes"
> >    hax=3D"yes"
> > -  nvmm=3D"yes"
> > +  nvmm=3D"check"
> >    make=3D"${MAKE-gmake}"
> >    audio_drv_list=3D"oss try-sdl"
> >    audio_possible_drivers=3D"oss sdl"
> >
>
>

--00000000000041e7fd059fe45d9a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 2 mar 2020, 20:14 Maxime Villard &lt;<a href=3D=
"mailto:max@m00nbsd.net">max@m00nbsd.net</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Le 02/03/2020 =C3=A0 19:05, Kamil Rytarowski a =
=C3=A9crit=C2=A0:<br>
&gt; On 02.03.2020 18:12, Paolo Bonzini wrote:<br>
&gt;&gt; On 03/02/20 12:56, Kamil Rytarowski wrote:<br>
&gt;&gt;&gt; On 03.02.2020 12:41, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;&gt;&gt;&gt;&gt; @@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE,=
 default is<br>
&gt;&gt;&gt;&gt;&gt; enabled if available:<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 hax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HAX acceleration support<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 hvf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hypervisor.framework acceleratio=
n support<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 whpx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Windows Hypervisor Platform accelerati=
on support<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 nvmm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 NetBSD Virtual Machine Monitor acceleration suppor=
t<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 rdma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable RDMA-based migration<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 pvrdma=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable PVRDMA support<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 vde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 support for vde network<br>
&gt;&gt;&gt;&gt;&gt; @@ -2757,6 +2775,20 @@ if test &quot;$whpx&quot; !=3D =
&quot;no&quot; ; then<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 fi<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Maybe you can add something like:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; if test &quot;$targetos&quot; =3D &quot;NetBSD&quot;; then=
<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 nvmm=3D&quot;check&quot;<br>
&gt;&gt;&gt;&gt; fi<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; to build by default with NVMM if available.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I will add nvmm=3Dyes to the NetBSD) targetos check section.<b=
r>
&gt;&gt;<br>
&gt;&gt; No, nvmm=3Dyes instead should fail the build if nvmm.h is not avai=
lable.<br>
&gt;&gt; That is not a good default.<br>
&gt;&gt;<br>
&gt;&gt; Paolo<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; <br>
&gt; Most users will get nvmm.h in place now and this is still a tunable.<b=
r>
&gt; <br>
&gt; I have got no opinion what to put there, nvmm=3Dcheck still works.<br>
<br>
I would keep &quot;yes&quot;, for consistency with the other entries. Chang=
ing all<br>
entries to &quot;check&quot; should be done in a separate commit, unrelated=
 to<br>
NVMM.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">The difference is that KVM for example does not need external includes=
 or libraries.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
&gt; diff --git a/configure b/configure<br>
&gt; index d4a837cf9d..b3560d88bb 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -836,7 +836,7 @@ DragonFly)<br>
&gt;=C2=A0 NetBSD)<br>
&gt;=C2=A0 =C2=A0 bsd=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 hax=3D&quot;yes&quot;<br>
&gt; -=C2=A0 nvmm=3D&quot;yes&quot;<br>
&gt; +=C2=A0 nvmm=3D&quot;check&quot;<br>
&gt;=C2=A0 =C2=A0 make=3D&quot;${MAKE-gmake}&quot;<br>
&gt;=C2=A0 =C2=A0 audio_drv_list=3D&quot;oss try-sdl&quot;<br>
&gt;=C2=A0 =C2=A0 audio_possible_drivers=3D&quot;oss sdl&quot;<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000041e7fd059fe45d9a--


