Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6466CC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E3C20738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQlqxSgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E3C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIFO9-0003ED-UL
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIF5M-0006Wq-R6; Tue, 15 Sep 2020 13:49:44 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIF5K-0007fX-LH; Tue, 15 Sep 2020 13:49:44 -0400
Received: by mail-lf1-x143.google.com with SMTP id b12so4007724lfp.9;
 Tue, 15 Sep 2020 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=q6tqzKIsZvndqpS2e6iNqOmSnu7yiEdxiZoCaY2xbug=;
 b=KQlqxSgzmnPWjMvuKFlRtVoiQnTPg41Zj/EebwjphMLS7UbplRIAfAhybgRE3ERJDs
 elCWb4QwfX8P/x5+2UW1eHhSxQ84CQY9le7Yf7mxNIGtJTs0BrSFgaqbcq8YFYEBXI/l
 WF8QVCFkO8HX0OwgQII2ryttBGjwxHz/N9yZ6ux2Jd/JWOnlf3qQ9ommLpYJYHg/AQQL
 ftoVIF/Ax+EZDXAdW8g6XKI5kTGH2cc/mhLiSyn3VN4bWnGnqEbQN3kELKJxMLQE48lx
 7DWQ+AD244xJBqbrmtLgqgnBAr30eNSfYclzMMETS571TP+/z6AxiDLVJZE8EagQ0Dkp
 iWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=q6tqzKIsZvndqpS2e6iNqOmSnu7yiEdxiZoCaY2xbug=;
 b=Fbn14AftzSeLMcS6PuVtkB589LCLTLdSvLzE+mhGohDx79CY17YzSum4XR57kliwI9
 PQFQpiYC49J7RbMu9LVKCOPDnrGcrwDBcIbhyUW0zYIQSOcJujisc4koCF+IMvs6uUMG
 QFFkn7WqzskaXbGIUhQO4pBgIKFTgZfTkKlzsK5y2/aQ8iH+hPI6OC149e2GEV9DhXoK
 GPimsy2tyw6an9KTFZ7Rw7Bw2zDK+YmVqTBXgXCZ9C7VUy8u3B+wOhYtQR28US/eXO0J
 6b/7JcxNxJfw4iaVOQldANF/HSLuH2G/bbQjnRwG5xysENyVnmi8ffz0xwpChCHRBCfJ
 vA9g==
X-Gm-Message-State: AOAM533kYmnTiM38HOq8GmXQ8dRc+XBO1B35dJ2mHxZcHe0V9fOtsg8M
 8v6kz7qeh+m+e9iTQnyHaGO4pjkOZGnh0mwOObk=
X-Google-Smtp-Source: ABdhPJwH2G6aSPuFTMjiHFWS9C7IorDU+GJYQqTRE7202xyGrYBA01SonEDZd1flU3CTt7i8ZTbndSF5VataPPWoP+A=
X-Received: by 2002:a19:560a:: with SMTP id k10mr5862454lfb.599.1600192180121; 
 Tue, 15 Sep 2020 10:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200915171234.236-1-luoyonggang@gmail.com>
 <20200915171234.236-16-luoyonggang@gmail.com>
 <2b577bdb-1f92-311a-82d7-d4aa4aa23c68@amsat.org>
In-Reply-To: <2b577bdb-1f92-311a-82d7-d4aa4aa23c68@amsat.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 16 Sep 2020 01:49:27 +0800
Message-ID: <CAE2XoE9HBbtD1rRpr5weMDLOGK-AU3KXjSPvF--H+yEQde0rvg@mail.gmail.com>
Subject: Re: [PATCH v10 15/26] cirrus: Building freebsd in a single short
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000077f5b505af5dc648"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000077f5b505af5dc648
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 1:48 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:
>
> Typo "single shot" in subject?

Yeap, single shot, hope the maintainer fix it
>
>
> On 9/15/20 7:12 PM, Yonggang Luo wrote:
> > This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba
> > ("cirrus.yml: Split FreeBSD job into two parts").
> >
> > freebsd 1 hour limit not hit anymore
> >
> > I think we going to a wrong direction, I think there is some tests a
stall the test runner,
> > please look at
> > https://cirrus-ci.com/task/5110577531977728
> > When its running properly, the consumed time are little, but when tests
running too long,
> > look at the cpu usage, the cpu usage are nearly zero. doesn't consuming
time.
> >
> > And look at
> > https://cirrus-ci.com/task/6119341601062912
> >
> > If the tests running properly, the time consuming are little
> > We should not hide the error by split them
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Reviewed-by: Ed Maste <emaste@FreeBSD.org>
> > ---
> >  .cirrus.yml | 35 ++++++++---------------------------
> >  1 file changed, 8 insertions(+), 27 deletions(-)
> >
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index 3dd9fcff7f..25fb4add9b 100644
> > --- a/.cirrus.yml
> > +++ b/.cirrus.yml
> > @@ -1,38 +1,19 @@
> >  env:
> >    CIRRUS_CLONE_DEPTH: 1
> >
> > -freebsd_1st_task:
> > +freebsd_12_task:
> >    freebsd_instance:
> >      image_family: freebsd-12-1
> > -    cpu: 4
> > -    memory: 4G
> > -  install_script: ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg insta=
ll
-y
> > -    bash curl cyrus-sasl git glib gmake gnutls gsed
> > -    nettle perl5 pixman pkgconf png usbredir
> > +    cpu: 8
> > +    memory: 8G
> > +  install_script:
> > +    - ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ;
> > +    - pkg install -y bash curl cyrus-sasl git glib gmake gnutls gsed
> > +          nettle perl5 pixman pkgconf png usbredir
> >    script:
> >      - mkdir build
> >      - cd build
> > -    - ../configure --disable-user --target-list-exclude=3D'alpha-softm=
mu
> > -        ppc64-softmmu ppc-softmmu riscv32-softmmu riscv64-softmmu
s390x-softmmu
> > -        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu'
> > -        --enable-werror || { cat config.log; exit 1; }
> > -    - gmake -j$(sysctl -n hw.ncpu)
> > -    - gmake -j$(sysctl -n hw.ncpu) check
> > -
> > -freebsd_2nd_task:
> > -  freebsd_instance:
> > -    image_family: freebsd-12-1
> > -    cpu: 4
> > -    memory: 4G
> > -  install_script: ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg insta=
ll
-y
> > -    bash curl cyrus-sasl git glib gmake gnutls gtk3 gsed libepoxy
mesa-libs
> > -    nettle perl5 pixman pkgconf png SDL2 usbredir
> > -  script:
> > -    - ./configure --enable-werror --target-list=3D'alpha-softmmu
ppc64-softmmu
> > -        ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
> > -        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu
> > -        sparc-bsd-user sparc64-bsd-user x86_64-bsd-user i386-bsd-user'
> > -        || { cat config.log; exit 1; }
> > +    - ../configure --enable-werror || { cat config.log; exit 1; }
> >      - gmake -j$(sysctl -n hw.ncpu)
> >      - gmake -j$(sysctl -n hw.ncpu) check
> >
> >
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000077f5b505af5dc648
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Sep 16, 2020 at 1:48 AM Philippe Mathieu-D=
aud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wr=
ote:<br>&gt;<br>&gt; Typo &quot;single shot&quot; in subject?<br><br>Yeap, =
single shot, hope the maintainer fix it <br>&gt;<br>&gt;<br>&gt; On 9/15/20=
 7:12 PM, Yonggang Luo wrote:<br>&gt; &gt; This reverts commit 45f7b7b9f38f=
5c4d1529a37c93dedfc26a231bba<br>&gt; &gt; (&quot;cirrus.yml: Split FreeBSD =
job into two parts&quot;).<br>&gt; &gt;<br>&gt; &gt; freebsd 1 hour limit n=
ot hit anymore<br>&gt; &gt;<br>&gt; &gt; I think we going to a wrong direct=
ion, I think there is some tests a stall the test runner,<br>&gt; &gt; plea=
se look at<br>&gt; &gt; <a href=3D"https://cirrus-ci.com/task/5110577531977=
728">https://cirrus-ci.com/task/5110577531977728</a><br>&gt; &gt; When its =
running properly, the consumed time are little, but when tests running too =
long,<br>&gt; &gt; look at the cpu usage, the cpu usage are nearly zero. do=
esn&#39;t consuming time.<br>&gt; &gt;<br>&gt; &gt; And look at<br>&gt; &gt=
; <a href=3D"https://cirrus-ci.com/task/6119341601062912">https://cirrus-ci=
.com/task/6119341601062912</a><br>&gt; &gt;<br>&gt; &gt; If the tests runni=
ng properly, the time consuming are little<br>&gt; &gt; We should not hide =
the error by split them<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang L=
uo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&g=
t;<br>&gt; &gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:=
berrange@redhat.com">berrange@redhat.com</a>&gt;<br>&gt; &gt; Reviewed-by: =
Ed Maste &lt;emaste@FreeBSD.org&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0.ci=
rrus.yml | 35 ++++++++---------------------------<br>&gt; &gt; =C2=A01 file=
 changed, 8 insertions(+), 27 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff -=
-git a/.cirrus.yml b/.cirrus.yml<br>&gt; &gt; index 3dd9fcff7f..25fb4add9b =
100644<br>&gt; &gt; --- a/.cirrus.yml<br>&gt; &gt; +++ b/.cirrus.yml<br>&gt=
; &gt; @@ -1,38 +1,19 @@<br>&gt; &gt; =C2=A0env:<br>&gt; &gt; =C2=A0 =C2=A0=
CIRRUS_CLONE_DEPTH: 1<br>&gt; &gt; <br>&gt; &gt; -freebsd_1st_task:<br>&gt;=
 &gt; +freebsd_12_task:<br>&gt; &gt; =C2=A0 =C2=A0freebsd_instance:<br>&gt;=
 &gt; =C2=A0 =C2=A0 =C2=A0image_family: freebsd-12-1<br>&gt; &gt; - =C2=A0 =
=C2=A0cpu: 4<br>&gt; &gt; - =C2=A0 =C2=A0memory: 4G<br>&gt; &gt; - =C2=A0in=
stall_script: ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg install -y<br>=
&gt; &gt; - =C2=A0 =C2=A0bash curl cyrus-sasl git glib gmake gnutls gsed<br=
>&gt; &gt; - =C2=A0 =C2=A0nettle perl5 pixman pkgconf png usbredir<br>&gt; =
&gt; + =C2=A0 =C2=A0cpu: 8<br>&gt; &gt; + =C2=A0 =C2=A0memory: 8G<br>&gt; &=
gt; + =C2=A0install_script:<br>&gt; &gt; + =C2=A0 =C2=A0- ASSUME_ALWAYS_YES=
=3Dyes pkg bootstrap -f ;<br>&gt; &gt; + =C2=A0 =C2=A0- pkg install -y bash=
 curl cyrus-sasl git glib gmake gnutls gsed<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0nettle perl5 pixman pkgconf png usbredir<br>&gt; &gt; =
=C2=A0 =C2=A0script:<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0- mkdir build<br>&gt;=
 &gt; =C2=A0 =C2=A0 =C2=A0- cd build<br>&gt; &gt; - =C2=A0 =C2=A0- ../confi=
gure --disable-user --target-list-exclude=3D&#39;alpha-softmmu<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0ppc64-softmmu ppc-softmmu riscv32-softmmu ris=
cv64-softmmu s390x-softmmu<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0sparc6=
4-softmmu sparc-softmmu x86_64-softmmu i386-softmmu&#39;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0--enable-werror || { cat config.log; exit 1; }<br>&=
gt; &gt; - =C2=A0 =C2=A0- gmake -j$(sysctl -n hw.ncpu)<br>&gt; &gt; - =C2=
=A0 =C2=A0- gmake -j$(sysctl -n hw.ncpu) check<br>&gt; &gt; -<br>&gt; &gt; =
-freebsd_2nd_task:<br>&gt; &gt; - =C2=A0freebsd_instance:<br>&gt; &gt; - =
=C2=A0 =C2=A0image_family: freebsd-12-1<br>&gt; &gt; - =C2=A0 =C2=A0cpu: 4<=
br>&gt; &gt; - =C2=A0 =C2=A0memory: 4G<br>&gt; &gt; - =C2=A0install_script:=
 ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg install -y<br>&gt; &gt; - =
=C2=A0 =C2=A0bash curl cyrus-sasl git glib gmake gnutls gtk3 gsed libepoxy =
mesa-libs<br>&gt; &gt; - =C2=A0 =C2=A0nettle perl5 pixman pkgconf png SDL2 =
usbredir<br>&gt; &gt; - =C2=A0script:<br>&gt; &gt; - =C2=A0 =C2=A0- ./confi=
gure --enable-werror --target-list=3D&#39;alpha-softmmu ppc64-softmmu<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0ppc-softmmu riscv32-softmmu riscv64-so=
ftmmu s390x-softmmu<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0sparc64-softm=
mu sparc-softmmu x86_64-softmmu i386-softmmu<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sparc-bsd-user sparc64-bsd-user x86_64-bsd-user i386-bsd-user&=
#39;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0|| { cat config.log; exit 1;=
 }<br>&gt; &gt; + =C2=A0 =C2=A0- ../configure --enable-werror || { cat conf=
ig.log; exit 1; }<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0- gmake -j$(sysctl -n hw=
.ncpu)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0- gmake -j$(sysctl -n hw.ncpu) chec=
k<br>&gt; &gt; <br>&gt; &gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A=
<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--00000000000077f5b505af5dc648--

