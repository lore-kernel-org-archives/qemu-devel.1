Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC1C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 07:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E37206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 07:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjwLIvr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E37206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kObvD-0004PK-Ey
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 03:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kObuP-0003wR-3H
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 03:24:45 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kObuN-0002Qb-7V
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 03:24:44 -0400
Received: by mail-lj1-x243.google.com with SMTP id b19so2994941lji.11
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 00:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=HqIvb9jVV7xjQVyWgl0XmEgW+zyP5ypZgsbvUAL+H8o=;
 b=LjwLIvr5SRegNLgJJnmReDt6FEU253vOGMDx0xHamh5/CJMQKE0eWymrbPvww5RiVW
 WwNOvc7v23jb7VrGHHbBPak2Au4yzjAM86mwcJT2CDv0KXOGdSv3N0lsxzCca2WqoTJj
 zVuSDxSqp3yDmAOSGuoy97Uw0EGXKFofXPsmDnocmkNyeeCWG4izZ4QNu26w/p/zWWWX
 dyezoEJQHY/zdJCtenQouMIkNulxvt6k/TTbG51q+i37LqNgMSwwLdo7GgkP3VX/9swb
 ZRFprkDsWe6lpbSkU66gHsFm/oG6TtV8z44jocBBCiRLHcpwu9O1N39o9g/Pc9cbVxyp
 7v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=HqIvb9jVV7xjQVyWgl0XmEgW+zyP5ypZgsbvUAL+H8o=;
 b=PL0B7igmQyg4R5sJtP8Q02OglwtsZPbBA5Rz3eStO5GltC8wjOp17VAswzE8Jaz/Tz
 zGuM+HMPo7KNHmYaEBIi6ThJHE4upD98h+3DF4UoZ3Lyjf/4/HQCLa3IEBC2ysgfvZhG
 RWicoZKJpC+myNDw5bgPVvmGfhgsmoX8/eesYju89RN+HNbHadwYyLNXpGyp/0fnFQye
 0DS/B/lmvUaUYpy6qSkdqd0zHu2sK92o1NrlwcAh6KeJCXXsg+bLdHj6Pe6VGKxLDka2
 NynCm0p/zWXHZA4acG2PAzOjM9I2ucsVc/o/XdVDQ5rpikjGmkcfBARmee6HIlmrg6Cb
 pLEw==
X-Gm-Message-State: AOAM532zJnl3wr5SUE0gGSqMzpaQZBSQNcZQclvjTrBH23Sf41s5uB6u
 bx//oQE1wItXguvzjrCDc3oYZFxbZsuaxXYIxzI=
X-Google-Smtp-Source: ABdhPJzDT1cikjcH/PunGyhQsdYNhIkPjPKSAgxxebGZSMiayvtUaUGe/oIHcLBwT8b9pryR8bLqHEH2JSoo5AsSus0=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr1822726ljj.447.1601709881468; 
 Sat, 03 Oct 2020 00:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
In-Reply-To: <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2020 15:24:31 +0800
Message-ID: <CAE2XoE-RnJ2j732JfxDA2A9O0Bp4KJ2rGG0LTjrDMKvRox-VBg@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000084adc505b0bf248b"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000084adc505b0bf248b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2020 at 9:11 PM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> On Fri, 2 Oct 2020 at 14:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 02/10/20 14:35, Peter Maydell wrote:
> > >
> > > It would be better to do the "see if a static library is present"
> > > test. This isn't too hard to do in configure (compare that
> > > six line fix to the detection of libgio). Hopefully it is
> > > not too hard to do in meson ?
> >
> > Yes, something like:
> >
> > if enable_static
> >   skeleton =3D 'int main(void) { return 0; }'
> >   if not cc.links(skeleton, dependencies: libudev)
> >     if get_option('mpath').enabled()
> >         error('Cannot link with libudev')
> >       else
> >         warning('Cannot link with libudev, disabling')
> >         libudev =3D not_found
> >       endif
> >     endif
> >   endif
> > endif
>
> This duplicates the information that the thing that depends
> on libudev is mpath. Can we put this in a wrapper around
> dependency() so that we could just say something like
>   libudev =3D compile_checked_dependency('libudev',
>                        required: get_option('mpath').enabled(),
>                        static: enable_static)
>
Hi Bonzini,
This looks like a frequently used function, can we upstrem to meson?


> for those dependencies that want to do the "does this compile"
> check ?
>
> thanks
> -- PMM
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000084adc505b0bf248b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 2, 2020 at 9:11 PM Peter Maydell &lt;<=
a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt;=
 wrote:<br>&gt;<br>&gt; On Fri, 2 Oct 2020 at 14:05, Paolo Bonzini &lt;<a h=
ref=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br>&g=
t; &gt;<br>&gt; &gt; On 02/10/20 14:35, Peter Maydell wrote:<br>&gt; &gt; &=
gt;<br>&gt; &gt; &gt; It would be better to do the &quot;see if a static li=
brary is present&quot;<br>&gt; &gt; &gt; test. This isn&#39;t too hard to d=
o in configure (compare that<br>&gt; &gt; &gt; six line fix to the detectio=
n of libgio). Hopefully it is<br>&gt; &gt; &gt; not too hard to do in meson=
 ?<br>&gt; &gt;<br>&gt; &gt; Yes, something like:<br>&gt; &gt;<br>&gt; &gt;=
 if enable_static<br>&gt; &gt; =C2=A0 skeleton =3D &#39;int main(void) { re=
turn 0; }&#39;<br>&gt; &gt; =C2=A0 if not cc.links(skeleton, dependencies: =
libudev)<br>&gt; &gt; =C2=A0 =C2=A0 if get_option(&#39;mpath&#39;).enabled(=
)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 error(&#39;Cannot link with libu=
dev&#39;)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 else<br>&gt; &gt; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 warning(&#39;Cannot link with libudev, disabling&#39;)<br>&g=
t; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 libudev =3D not_found<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 endif<br>&gt; &gt; =C2=A0 =C2=A0 endif<br>&gt; &gt; =C2=
=A0 endif<br>&gt; &gt; endif<br>&gt;<br>&gt; This duplicates the informatio=
n that the thing that depends<br>&gt; on libudev is mpath. Can we put this =
in a wrapper around<br>&gt; dependency() so that we could just say somethin=
g like<br>&gt; =C2=A0 libudev =3D compile_checked_dependency(&#39;libudev&#=
39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0required: get_option(&#39;mpath&#39;).enabled(),<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0static: enable_static)<br>&gt;<div>Hi Bonzini,<br><div>This lo=
oks like a frequently used function, can we upstrem to meson?</div><div>=C2=
=A0</div><div><br>&gt; for those dependencies that want to do the &quot;doe=
s this compile&quot;<br>&gt; check ?<br>&gt;<br>&gt; thanks<br>&gt; -- PMM<=
br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div></div></div>

--00000000000084adc505b0bf248b--

