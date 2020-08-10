Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50987C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C3020709
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="kYLXH4nT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C3020709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54bc-0006Ne-NK
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1k54aP-0005N4-Mf
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:59:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1k54aN-0004Oz-QP
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:59:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id r4so7543724wrx.9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vayavyalabs.com; s=vayavyalabs;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zi64ULicIIiiacJzd3FUjVSfT8MaPS0cdmQ6sXrOmFY=;
 b=kYLXH4nTb6z/8YQ5CmP4EJa8qH9dU/Lr9EFOVD82Sy3KUYswYN9ewNPXeNEI6iWiwA
 GuN14wg3oOJ+ZDyCBobNHsJj0BaMShGyRf7dpH30oSqckoaYGLpjoMxy2688YN5uD4Hl
 W/PX34ltIR7yovSI+il+rA15HMC6CuTKXwrNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zi64ULicIIiiacJzd3FUjVSfT8MaPS0cdmQ6sXrOmFY=;
 b=Tvo8s8ZfDwAWl+AfZfJl/B10EYNDYqBFaJB1czaU8wEHkMOwgWP4NijhxI4BYIuXtk
 XWEo4tZYE1YR8d1AaxU+po8AiPbo5KJ3gJk90j5bdm9gc8HHT3UzhEbmNt1ovmeljitC
 juQR2xwdCbQILL/w8honxVc0oMs5DfE1PT+dfnuTp6BhAyHflYv0FZW1YG3Va5Woa8rB
 qXrzPOi72XhQMIuqQsgAvQou49yfqY3M+NG467QPPK0C/Bhh32eIxc5pOjp3woJeZywe
 OxOwu1Omp5pK3Qtreiber15xnI5VQmSgP7azGmDFWFQ8rOi73IrUP3oe/1XWAAoIAKqR
 n6iw==
X-Gm-Message-State: AOAM530yFKFw5gseVMF8RR/i00/6ISBYSSeeP4DBRYKdhlP4corGMpqm
 ri3AJbqOhstJO4bz0OJ5JtkgaJMISyu0W0BQD0wjX2Ry
X-Google-Smtp-Source: ABdhPJzbT7iFt/1zFZ+iOzCZrrY6EWwDpKJL51F7L+MPv2uPGcfbxf9d3iIkbgKhSDQkF9GEsZ9YtMDzCyP9Zec/Zkg=
X-Received: by 2002:a5d:4802:: with SMTP id l2mr22704294wrq.183.1597053557651; 
 Mon, 10 Aug 2020 02:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+GrFDssmZWBCL0gh3QLX5BMhmgTQUywLSSQn=cpF2P1ZQ@mail.gmail.com>
 <87r1se3k7m.fsf@linaro.org>
In-Reply-To: <87r1se3k7m.fsf@linaro.org>
From: Pratik Parvati <pratikp@vayavyalabs.com>
Date: Mon, 10 Aug 2020 15:29:06 +0530
Message-ID: <CA+aXn+ETrBneXK3N6+gzO_7R=6mdxXr_Oig7MjOe7VzO5OD0mg@mail.gmail.com>
Subject: Re: QEMU Library support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fdcfc205ac83017f"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=pratikp@vayavyalabs.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fdcfc205ac83017f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As an experiment, I have modelled non-existing ARM Watchdog model (SP805)
interfaced to the versatile PB platform. What actually I was looking is -
some sort of QEMU library, where I can model new device outside the QEMU
source hierarchy and still be able to compile it using QEMU library and
include files to add support for the new device. If QEMU doesn't provide a
library, Is there a flexibly that I can tweak something inside the QEMU to
generate it?

Regards,
Pratik


On Mon, Aug 10, 2020 at 3:18 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Pratik Parvati <pratikp@vayavyalabs.com> writes:
>
> > Hi team,
> >
> > Lately, I have been working on QEMU modeling and interfacing it into th=
e
> > existing platform. What actually I wanted to check is; whether QEMU
> > supports library that gives developers a clean interface to develop and
> > integrate peripheral model in to QEMU. I know of the Greensocs SystemC
> > bridge - but that was quite difficult to work with in past.
>
> Not really - with a few exceptions like vhost-user and in KVM device
> emulation all devices are emulated in the QEMU code base. As a result
> the best way to maintain a device is to have it integrated upstream
> (along with some tests to ensure it is working).
>
> As you note there are various forks of QEMU that support device
> modelling but none of these features have been merged upstream and would
> likely need to assuage worries about such interfaces being used to avoid
> GPL compliance.
>
> What sort of devices are you looking to model? Are these existing
> devices or experimental/research things?
>
> --
> Alex Benn=C3=A9e
>

--000000000000fdcfc205ac83017f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As an experiment, I have modelled non-existing=C2=A0ARM Wa=
tchdog model (SP805) interfaced to the versatile PB platform. What actually=
=C2=A0I was looking is - some sort of QEMU library, where I can model new d=
evice outside the QEMU source hierarchy=C2=A0and still be able to compile i=
t using QEMU library and include files to add support for the new device. I=
f QEMU doesn&#39;t provide a library, Is there a flexibly that I can tweak =
something inside the QEMU to generate it?<div><br clear=3D"all"><div><div d=
ir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr">Regards,<div>Pratik</div></div></div></div><br></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, =
Aug 10, 2020 at 3:18 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@=
linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><br>
Pratik Parvati &lt;<a href=3D"mailto:pratikp@vayavyalabs.com" target=3D"_bl=
ank">pratikp@vayavyalabs.com</a>&gt; writes:<br>
<br>
&gt; Hi team,<br>
&gt;<br>
&gt; Lately, I have been working on QEMU modeling and interfacing it into t=
he<br>
&gt; existing platform. What actually I wanted to check is; whether QEMU<br=
>
&gt; supports library that gives developers a clean interface to develop an=
d<br>
&gt; integrate peripheral model in to QEMU. I know of the Greensocs SystemC=
<br>
&gt; bridge - but that was quite difficult to work with in past.<br>
<br>
Not really - with a few exceptions like vhost-user and in KVM device<br>
emulation all devices are emulated in the QEMU code base. As a result<br>
the best way to maintain a device is to have it integrated upstream<br>
(along with some tests to ensure it is working).<br>
<br>
As you note there are various forks of QEMU that support device<br>
modelling but none of these features have been merged upstream and would<br=
>
likely need to assuage worries about such interfaces being used to avoid<br=
>
GPL compliance.<br>
<br>
What sort of devices are you looking to model? Are these existing<br>
devices or experimental/research things?<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div>

--000000000000fdcfc205ac83017f--

