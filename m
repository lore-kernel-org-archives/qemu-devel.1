Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E728C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 19:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA08E20659
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 19:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwXoVvgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA08E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYwLZ-0003EG-Jm
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 15:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYwKg-0002ml-FV
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 15:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYwKd-0007yI-Gx
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 15:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604171668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rseW22qqPrwOI6Nms2PHu6QL/Dhopt5+EZqRECvy/3w=;
 b=WwXoVvgoFqymlwaGbDB8dxttq9ecGNiFx+vGaj8vxXNmAuJMJMnc36JW8QkSX2cri7ufIx
 SAxfo5WQnwOlO4mdZvK//XvVhox5dg3o5SvpYJ+Qw2e0d0zU1NIr4Dq0eO/VZ2p7egDatL
 j4i0dnFsvxamZnLNmgF/cgde8ZvZZuY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-iDtZT_yHNlqQnzSetHT8ng-1; Sat, 31 Oct 2020 15:14:25 -0400
X-MC-Unique: iDtZT_yHNlqQnzSetHT8ng-1
Received: by mail-pj1-f69.google.com with SMTP id cm17so208320pjb.2
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 12:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rseW22qqPrwOI6Nms2PHu6QL/Dhopt5+EZqRECvy/3w=;
 b=C3+bHfcIUhkiiVwnFdDWNCTNo+VCFxuW1JzSq8LvwXTxdHw4YRaJhG67JOoe239b1l
 z63HF6u/yflhZ3QxRKJiRyybIIQEtD24D9wW87AnRJAApa0FD+mZK/qUbL5MewzF3CB1
 NaQsqtRWS3Oe1pCkWVFGkicNEsRou9TtCeyex/WroanG1KXc+XK1NielS2UCmW2K6Hah
 apwNnKDE0SNOjyYmuk2+nqfxKUPMmGdHhWFKTH8RIdb5a4l/EKclU8CfLpTwxqnXr2KE
 6sLIDVRSfMgAsS1c0nmvPt4boxZFJWrQL+aByYxQ+zGbgaCiws/HeZZ8Q1oyy1nYz/IB
 BdUA==
X-Gm-Message-State: AOAM530HJpYkIvxtem8M666J+1iEy559Q1zhVsjAVT6mgb1k+hax4Ry8
 CTnhvLMkf+7HKaUEoaWZWUGyc/gOIybEh4MKawWUfd8VkohPpO2uZEO52R39JzzexP6KZgu+91r
 hjRr8x8R9WKxRnJ6b8uIUBRCq4uXoXDY=
X-Received: by 2002:a63:2f41:: with SMTP id v62mr7179396pgv.10.1604171664482; 
 Sat, 31 Oct 2020 12:14:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuzVwPFHYUhzcA+0y2MUg83Qg3kXytkCfA88zdSEVwkn1sGaRBWMbzX5VwIo1eWyFvkJjJiUIcXW4JNGdb6ww=
X-Received: by 2002:a63:2f41:: with SMTP id v62mr7179383pgv.10.1604171664214; 
 Sat, 31 Oct 2020 12:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201017144805.1641371-1-pbonzini@redhat.com>
 <CAFEAcA8CEDe6yinvaTMqbho7i_ZBWOSYG8_J_R5Xx56VxXD=uQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8CEDe6yinvaTMqbho7i_ZBWOSYG8_J_R5Xx56VxXD=uQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 31 Oct 2020 20:14:12 +0100
Message-ID: <CABgObfaM4JHN=9DwuW3tPDZMrYgc+jo1cJrBCMb_zVc5+nZdxw@mail.gmail.com>
Subject: Re: [PULL v3 00/22] Build system + misc changes for 2020-10-16
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000346bc005b2fc52ce"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 15:14:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000346bc005b2fc52ce
Content-Type: text/plain; charset="UTF-8"

Yup, it works only with --sphix-build which obviously is how I tested it...
I will include a fix in my next pull request (I don't really have anything
planned, but something will most likely pop up).

Paolo

Il sab 31 ott 2020, 16:46 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Sat, 17 Oct 2020 at 15:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > ----------------------------------------------------------------
> > * Drop ninjatool and just require ninja (Paolo)
> > * Fix docs build under msys2 (Yonggang)
> > * HAX snafu fix (Claudio)
> > * Disable signal handlers during fuzzing (Alex)
> > * Miscellaneous fixes (Bruce, Greg)
> >
> > Yonggang Luo (3):
> >       docs: Fix Sphinx configuration for msys2/mingw
> >       meson: Move the detection logic for sphinx to meson
> >       cirrus: Enable doc build on msys2/mingw
>
> I've just noticed that there seems to be a minor bug with
> the new sphinx detection logic: if the Sphinx is the
> wrong version then it prints:
>
> Program sphinx-build found: YES
> ../../docs/meson.build:30: WARNING:  exists but it is either too old
> or uses too old a Python version
>
> ie it hasn't actually managed to substitute in the
> program name, so there's just a double-space after
> WARNING: instead...
>
> thanks
> -- PMM
>
>

--000000000000346bc005b2fc52ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yup, it works only with --sphix-build which obviously is =
how I tested it... I will include a fix in my next pull request (I don&#39;=
t really have anything planned, but something will most likely pop up).<div=
 dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 31 ott 2020, =
16:46 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">On Sat, 17 Oct 2020 at 15:50, Paolo Bonzini &lt;<a href=3D"mailto:pbonzi=
ni@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>=
&gt; wrote:<br>
&gt; ----------------------------------------------------------------<br>
&gt; * Drop ninjatool and just require ninja (Paolo)<br>
&gt; * Fix docs build under msys2 (Yonggang)<br>
&gt; * HAX snafu fix (Claudio)<br>
&gt; * Disable signal handlers during fuzzing (Alex)<br>
&gt; * Miscellaneous fixes (Bruce, Greg)<br>
&gt;<br>
&gt; Yonggang Luo (3):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0docs: Fix Sphinx configuration for msys2/min=
gw<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0meson: Move the detection logic for sphinx t=
o meson<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cirrus: Enable doc build on msys2/mingw<br>
<br>
I&#39;ve just noticed that there seems to be a minor bug with<br>
the new sphinx detection logic: if the Sphinx is the<br>
wrong version then it prints:<br>
<br>
Program sphinx-build found: YES<br>
../../docs/meson.build:30: WARNING:=C2=A0 exists but it is either too old<b=
r>
or uses too old a Python version<br>
<br>
ie it hasn&#39;t actually managed to substitute in the<br>
program name, so there&#39;s just a double-space after<br>
WARNING: instead...<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div>

--000000000000346bc005b2fc52ce--


