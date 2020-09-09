Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B20C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C7521532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQvt6BR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C7521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvQ6-0003jR-Po
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvOp-00021O-Ef; Wed, 09 Sep 2020 04:24:15 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvOn-0004kG-AW; Wed, 09 Sep 2020 04:24:15 -0400
Received: by mail-lj1-x243.google.com with SMTP id u4so2338601ljd.10;
 Wed, 09 Sep 2020 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Gnbq+ERRpcKFcGr0F/H5TXOgoKxmxPWOjKaWZv/PHLU=;
 b=MQvt6BR7nJFnexjOHvRI8Gy5HL1XEiXtNOXImDV2tDBKWWXa1521e9EUw2lmD9sRgd
 P1ZeUQ05DRAc0CMsL+CmvA/hBGbl+5kO4ExJx8rPWtIJ5KErdbbEnxRhlZ4UGWmt0Zms
 UhmMqJF4OcAr5N5kGfWCmtUdiRDJ/bMOrPjz05F2lD1nJUIYRbX+ibiCjKDQVlxcsvoR
 l23YrDJL7tsstqnUk70bJg0hk92IDWUvmwSc64h3cIBAYeq8K2tMw4Uy42zZfjazQyCb
 thTCPWUy9u5mav1QFBeu7yV7WzdPZqn+ZgR1jCZRsoyff/oRl329nKc402Q1RJ335zjZ
 8E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Gnbq+ERRpcKFcGr0F/H5TXOgoKxmxPWOjKaWZv/PHLU=;
 b=qVlZPfCImso7ECv+/uauvPPLWPav22JB8nZMjonadT+r2pk1zBRuNrsn/4MPHkg57P
 MiK8k68rzdk0n2NRlNlZ1inswVGT1zVRfS4h9+NE/BfFTzocToN0D2+LlCaGt9YvDmnB
 C4hO2OyR4ENOc7ChaVf6JTAzmrXFuvIy2A2p29t4sOPs+fOEyO7sets5KXMYdWe3L81I
 D6C4UD5RaJ9NVqOSUyFcgd5sX/47IlzlIv8mS8waKAN4PlzOVLMTnEe+bub5XYAe/5CA
 ZVMmnuP8lw6QZPsGa6u/PoTTmltJtUMVeuufsBtrB6i4oowU5E9MXa+Md+2HNPBWomkt
 k/Dw==
X-Gm-Message-State: AOAM533PwfSeMlcem6QGaWGHHX6ZrgTdhHTsAzjgapMs+csglaTidq5s
 FcwhLdxHcQ9CVr0juhZ30QxT4+iFEvKom+zWPGU=
X-Google-Smtp-Source: ABdhPJxGZgDhoGqPZqEKdTcHQt6arkEPGfIBYa49/3YOdK865vZ/QL1c1BKFWMgQ/C8oZTx8aqi/nL2bNbidIp4iEGI=
X-Received: by 2002:a2e:89d6:: with SMTP id c22mr1389084ljk.242.1599639851070; 
 Wed, 09 Sep 2020 01:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-15-luoyonggang@gmail.com>
 <20200909081735.GE1011023@redhat.com>
In-Reply-To: <20200909081735.GE1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 16:24:00 +0800
Message-ID: <CAE2XoE_-E6yZ9HKZVRd3VN7SRD_w6DUQwcG4e_51-8y2JzOEvw@mail.gmail.com>
Subject: Re: [PATCH 14/16] cirrus: Building freebsd in a single short
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000017790005aedd2dce"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000017790005aedd2dce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:17 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Sep 09, 2020 at 03:48:18AM +0800, Yonggang Luo wrote:
> > freebsd 1 hour limit not hit anymore
>
> How long does the combined job take with this change ? If it is
> within 10 minutes of the limit, then we still want the split, as
> transient changes in the CI system can push it over the limit
> making the test unreliable.
>
I think we going to a wrong direction, I think there is some tests a stall
the test runner,
please look at
https://cirrus-ci.com/task/5110577531977728
When its running properly, the consumed time are little, but when tests
running too long, look at the cpu
usage, the cpu usage are nearly zero. does't consuming time.

And look at
https://cirrus-ci.com/task/6119341601062912

If the tests running properly, the time consuming are little

We should not hide the error by split them

>
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  .cirrus.yml | 35 ++++++++---------------------------
> >  1 file changed, 8 insertions(+), 27 deletions(-)
> >
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index 49335e68c9..b0004273bb 100644
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
> -y
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
> s390x-softmmu
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
> -y
> > -    bash curl cyrus-sasl git glib gmake gnutls gtk3 gsed libepoxy
> mesa-libs
> > -    nettle perl5 pixman pkgconf png SDL2 usbredir
> > -  script:
> > -    - ./configure --enable-werror --target-list=3D'alpha-softmmu
> ppc64-softmmu
> > -        ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
> > -        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu
> > -        sparc-bsd-user sparc64-bsd-user x86_64-bsd-user i386-bsd-user'
> > -        || { cat config.log; exit 1; }
> > +    - ../configure --enable-werror || { cat config.log; exit 1; }
> >      - gmake -j$(sysctl -n hw.ncpu)
> >      - gmake -j$(sysctl -n hw.ncpu) check
> >
> > --
> > 2.28.0.windows.1
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000017790005aedd2dce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:17 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Sep 09, 2020 at 03:48:18AM +0800, Yonggang Luo wrote:<br>
&gt; freebsd 1 hour limit not hit anymore<br>
<br>
How long does the combined job take with this change ? If it is<br>
within 10 minutes of the limit, then we still want the split, as<br>
transient changes in the CI system can push it over the limit<br>
making the test unreliable.<br></blockquote><div>I think we going to a wron=
g direction, I think there is some tests a stall the test runner,</div><div=
>please look at=C2=A0</div><div><a href=3D"https://cirrus-ci.com/task/51105=
77531977728">https://cirrus-ci.com/task/5110577531977728</a><br></div><div>=
When its running properly, the consumed time are little, but when tests run=
ning too long, look at the cpu=C2=A0</div><div>usage, the cpu usage are nea=
rly zero. does&#39;t consuming time.</div><div><br></div><div>And look at=
=C2=A0</div><div><a href=3D"https://cirrus-ci.com/task/6119341601062912">ht=
tps://cirrus-ci.com/task/6119341601062912</a></div><div><br></div><div>If t=
he tests running properly, the time consuming are little</div><div><br></di=
v><div>We should not hide the error by split them=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .cirrus.yml | 35 ++++++++---------------------------<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 27 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.cirrus.yml b/.cirrus.yml<br>
&gt; index 49335e68c9..b0004273bb 100644<br>
&gt; --- a/.cirrus.yml<br>
&gt; +++ b/.cirrus.yml<br>
&gt; @@ -1,38 +1,19 @@<br>
&gt;=C2=A0 env:<br>
&gt;=C2=A0 =C2=A0 CIRRUS_CLONE_DEPTH: 1<br>
&gt;=C2=A0 <br>
&gt; -freebsd_1st_task:<br>
&gt; +freebsd_12_task:<br>
&gt;=C2=A0 =C2=A0 freebsd_instance:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 image_family: freebsd-12-1<br>
&gt; -=C2=A0 =C2=A0 cpu: 4<br>
&gt; -=C2=A0 =C2=A0 memory: 4G<br>
&gt; -=C2=A0 install_script: ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg=
 install -y<br>
&gt; -=C2=A0 =C2=A0 bash curl cyrus-sasl git glib gmake gnutls gsed<br>
&gt; -=C2=A0 =C2=A0 nettle perl5 pixman pkgconf png usbredir<br>
&gt; +=C2=A0 =C2=A0 cpu: 8<br>
&gt; +=C2=A0 =C2=A0 memory: 8G<br>
&gt; +=C2=A0 install_script:<br>
&gt; +=C2=A0 =C2=A0 - ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ;<br>
&gt; +=C2=A0 =C2=A0 - pkg install -y bash curl cyrus-sasl git glib gmake gn=
utls gsed <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nettle perl5 pixman pkgconf png us=
bredir<br>
&gt;=C2=A0 =C2=A0 script:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - mkdir build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - cd build<br>
&gt; -=C2=A0 =C2=A0 - ../configure --disable-user --target-list-exclude=3D&=
#39;alpha-softmmu<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc64-softmmu ppc-softmmu riscv32-softmmu=
 riscv64-softmmu s390x-softmmu<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sparc64-softmmu sparc-softmmu x86_64-soft=
mmu i386-softmmu&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 --enable-werror || { cat config.log; exit=
 1; }<br>
&gt; -=C2=A0 =C2=A0 - gmake -j$(sysctl -n hw.ncpu)<br>
&gt; -=C2=A0 =C2=A0 - gmake -j$(sysctl -n hw.ncpu) check<br>
&gt; -<br>
&gt; -freebsd_2nd_task:<br>
&gt; -=C2=A0 freebsd_instance:<br>
&gt; -=C2=A0 =C2=A0 image_family: freebsd-12-1<br>
&gt; -=C2=A0 =C2=A0 cpu: 4<br>
&gt; -=C2=A0 =C2=A0 memory: 4G<br>
&gt; -=C2=A0 install_script: ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg=
 install -y<br>
&gt; -=C2=A0 =C2=A0 bash curl cyrus-sasl git glib gmake gnutls gtk3 gsed li=
bepoxy mesa-libs<br>
&gt; -=C2=A0 =C2=A0 nettle perl5 pixman pkgconf png SDL2 usbredir<br>
&gt; -=C2=A0 script:<br>
&gt; -=C2=A0 =C2=A0 - ./configure --enable-werror --target-list=3D&#39;alph=
a-softmmu ppc64-softmmu<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc-softmmu riscv32-softmmu riscv64-softm=
mu s390x-softmmu<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sparc64-softmmu sparc-softmmu x86_64-soft=
mmu i386-softmmu<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sparc-bsd-user sparc64-bsd-user x86_64-bs=
d-user i386-bsd-user&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 || { cat config.log; exit 1; }<br>
&gt; +=C2=A0 =C2=A0 - ../configure --enable-werror || { cat config.log; exi=
t 1; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - gmake -j$(sysctl -n hw.ncpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - gmake -j$(sysctl -n hw.ncpu) check<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.28.0.windows.1<br>
&gt; <br>
&gt; <br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000017790005aedd2dce--

