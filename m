Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306E8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E142220773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHc/tEoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E142220773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDUMq-0007hz-3a
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDULr-0006no-Ac; Wed, 02 Sep 2020 11:07:07 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229]:44334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDULp-0007N0-1y; Wed, 02 Sep 2020 11:07:06 -0400
Received: by mail-lj1-x229.google.com with SMTP id b19so6313581lji.11;
 Wed, 02 Sep 2020 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=b3fydVeY70p8Gf0MqcBHOOQQAGd/OZmf28vfIDMCJes=;
 b=kHc/tEozLX/7aPMsd8abkhiRiOZ1azoCPXNFRC9PfexVzy02hmWLR0lhcS1bUmcw8w
 lmNXwrVoMSpbOv77wDMpguabEgv8tIfFmEyLWPoLGRjEDqnyGZoojPBy+eFMb288qCJ2
 ZFjhY3Fhf2WzkQPvTZeJLU6FxvLEuhD51nW4pYe9GEXfy613qphKb8a4o6DcQoGG0mBQ
 VYrK+vvaX9hLn+Jjxa/C/uhb5tYdqUMM+hUugVRZUl9AIYQgI6D7lSWnao4guRmGUlcD
 bVXtpyZHWEeAaTdcZMwmeVSfGVTYr20x4LUsJdMXvsJuHXpC8U5k6Wot530kTI17n0GX
 2o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=b3fydVeY70p8Gf0MqcBHOOQQAGd/OZmf28vfIDMCJes=;
 b=PlhcOy2UbTY9uj4XFv1CJo4TOctlKydtdt3Je2zWMrq5Sf6kCB1UBEga/fX1TF117Z
 oSXU38M3A8/Nb9dq02if81vnF6YfOIARFuRcoY7U4jPwnulwWLDvC11PItDpD2LinK9B
 Y/aAe7ExR0l+BzQb59KRZNBC6NE5n2nFgBqvaqoJ0rdNJ4RFVlyOuQBMmTJuWrvF0dOr
 pCq3gzVSMTP5oLbKTC89t7ePxK+Cu65iY/pVIOZQmehkVg6N7wdsUj6kcj/G7MdnHVB4
 dA/fpF0nwOiTDWFQknLf0KxYGqVygiqpBeKBps4jOkpNPv8fWRbHAcybg0KStuoUleaK
 b3Dg==
X-Gm-Message-State: AOAM53365d3tlupx2hs1LblxjFMIb5ArQW4lzufeXr5RoW2vgqOd8s7N
 bCs4BV7NgEFT0nDDJby3KN6r2+yqaScUMwF5zM8=
X-Google-Smtp-Source: ABdhPJxngcQfqHT3L2QQ5uR/cgfOJvcigXUT2MuSbjX3cMUD2TP5IbzAO+gp3vc7wq8K4l2oodErsB7YQKp0WfrFt5w=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr3735751ljg.447.1599059221398; 
 Wed, 02 Sep 2020 08:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE_SkH-2dNULFAZNiRNRNP=OncwCy=xrDk0J3bzS1Th=tg@mail.gmail.com>
 <c61f6420-ffdb-b2b1-44ec-60b8a55f9c8a@redhat.com>
 <ac9ee76a-bc7f-0715-4324-d33c2fb2bb66@redhat.com>
In-Reply-To: <ac9ee76a-bc7f-0715-4324-d33c2fb2bb66@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 2 Sep 2020 23:06:49 +0800
Message-ID: <CAE2XoE-uu35tMOu=OHjhOnv5jHxegv+3vdKaU2Ue16=6E1Wt9w@mail.gmail.com>
Subject: Re: Cirrus CI for msys2 are working now, but still buiding failed
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ddcbee05ae55fcc7"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x229.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ddcbee05ae55fcc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've already making CI green match the cross version, and the fix is not
just about -L, but also need to move the git submodule update to the end of
the file

On Wed, Sep 2, 2020 at 7:41 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 02/09/20 12:38, Thomas Huth wrote:
> > Wow, that looks quite promising already! But I wonder why the build
> > system is trying to link libfdt to targets like qemu-system-avr that do
> > not need it?
> > And for the targets that need fdt, it should use the dtc submodule... I
> > can see in the log that the dtc submodule is checked out, but it does
> > not seem to be compiled ? As a test, could you please try to run
> > "configure" with "--disable-fdt" there?
>
> Mark and Yonggang have reported an issue where the linker gets
> an msys path like -L/e/qemu/dtc but it wants -LE:/qemu/dtc instead.
> But fortunately we can just use -Ldtc instead, which would be a patch lik=
e
>
> diff --git a/configure b/configure
> index 56ceca2f68..34e81a7b60 100755
> --- a/configure
> +++ b/configure
> @@ -943,7 +943,7 @@ Linux)
>    linux=3D"yes"
>    linux_user=3D"yes"
>    kvm=3D"yes"
> -  QEMU_INCLUDES=3D"-isystem ${source_path}/linux-headers
> -I$PWD/linux-headers $QEMU_INCLUDES"
> +  QEMU_INCLUDES=3D"-isystem ${source_path}/linux-headers -Ilinux-headers
> $QEMU_INCLUDES"
>    libudev=3D"yes"
>  ;;
>  esac
> @@ -4259,7 +4259,7 @@ EOF
>                symlink "$source_path/dtc/Makefile" "dtc/Makefile"
>            fi
>            fdt_cflags=3D"-I${source_path}/dtc/libfdt"
> -          fdt_ldflags=3D"-L$PWD/dtc/libfdt"
> +          fdt_ldflags=3D"-Ldtc/libfdt"
>            fdt_libs=3D"$fdt_libs"
>        elif test "$fdt" =3D "yes" ; then
>            # Not a git build & no libfdt found, prompt for system install
> @@ -5244,7 +5244,7 @@ case "$capstone" in
>      else
>        LIBCAPSTONE=3Dlibcapstone.a
>      fi
> -    capstone_libs=3D"-L$PWD/capstone -lcapstone"
> +    capstone_libs=3D"-Lcapstone -lcapstone"
>      capstone_cflags=3D"-I${source_path}/capstone/include"
>      ;;
>
> @@ -6244,8 +6244,8 @@ case "$slirp" in
>        git_submodules=3D"${git_submodules} slirp"
>      fi
>      mkdir -p slirp
> -    slirp_cflags=3D"-I${source_path}/slirp/src -I$PWD/slirp/src"
> -    slirp_libs=3D"-L$PWD/slirp -lslirp"
> +    slirp_cflags=3D"-I${source_path}/slirp/src -Islirp/src"
> +    slirp_libs=3D"-Lslirp -lslirp"
>      if test "$mingw32" =3D "yes" ; then
>        slirp_libs=3D"$slirp_libs -lws2_32 -liphlpapi"
>      fi
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

--000000000000ddcbee05ae55fcc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve already making CI green match the cross version, =
and the fix is not just about -L, but also need to move the git submodule u=
pdate to the end of the file</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Sep 2, 2020 at 7:41 PM Paolo Bonzini =
&lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 02/09/20 1=
2:38, Thomas Huth wrote:<br>
&gt; Wow, that looks quite promising already! But I wonder why the build<br=
>
&gt; system is trying to link libfdt to targets like qemu-system-avr that d=
o<br>
&gt; not need it?<br>
&gt; And for the targets that need fdt, it should use the dtc submodule... =
I<br>
&gt; can see in the log that the dtc submodule is checked out, but it does<=
br>
&gt; not seem to be compiled ? As a test, could you please try to run<br>
&gt; &quot;configure&quot; with &quot;--disable-fdt&quot; there?<br>
<br>
Mark and Yonggang have reported an issue where the linker gets<br>
an msys path like -L/e/qemu/dtc but it wants -LE:/qemu/dtc instead.<br>
But fortunately we can just use -Ldtc instead, which would be a patch like<=
br>
<br>
diff --git a/configure b/configure<br>
index 56ceca2f68..34e81a7b60 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -943,7 +943,7 @@ Linux)<br>
=C2=A0 =C2=A0linux=3D&quot;yes&quot;<br>
=C2=A0 =C2=A0linux_user=3D&quot;yes&quot;<br>
=C2=A0 =C2=A0kvm=3D&quot;yes&quot;<br>
-=C2=A0 QEMU_INCLUDES=3D&quot;-isystem ${source_path}/linux-headers -I$PWD/=
linux-headers $QEMU_INCLUDES&quot;<br>
+=C2=A0 QEMU_INCLUDES=3D&quot;-isystem ${source_path}/linux-headers -Ilinux=
-headers $QEMU_INCLUDES&quot;<br>
=C2=A0 =C2=A0libudev=3D&quot;yes&quot;<br>
=C2=A0;;<br>
=C2=A0esac<br>
@@ -4259,7 +4259,7 @@ EOF<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0symlink &quot;$sourc=
e_path/dtc/Makefile&quot; &quot;dtc/Makefile&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fdt_cflags=3D&quot;-I${source_path=
}/dtc/libfdt&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_ldflags=3D&quot;-L$PWD/dtc/libfdt&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_ldflags=3D&quot;-Ldtc/libfdt&quot;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fdt_libs=3D&quot;$fdt_libs&quot;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0elif test &quot;$fdt&quot; =3D &quot;yes&quot; ;=
 then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Not a git build &amp; no libfdt =
found, prompt for system install<br>
@@ -5244,7 +5244,7 @@ case &quot;$capstone&quot; in<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0LIBCAPSTONE=3Dlibcapstone.a<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
-=C2=A0 =C2=A0 capstone_libs=3D&quot;-L$PWD/capstone -lcapstone&quot;<br>
+=C2=A0 =C2=A0 capstone_libs=3D&quot;-Lcapstone -lcapstone&quot;<br>
=C2=A0 =C2=A0 =C2=A0capstone_cflags=3D&quot;-I${source_path}/capstone/inclu=
de&quot;<br>
=C2=A0 =C2=A0 =C2=A0;;<br>
<br>
@@ -6244,8 +6244,8 @@ case &quot;$slirp&quot; in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0git_submodules=3D&quot;${git_submodules} slirp&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0mkdir -p slirp<br>
-=C2=A0 =C2=A0 slirp_cflags=3D&quot;-I${source_path}/slirp/src -I$PWD/slirp=
/src&quot;<br>
-=C2=A0 =C2=A0 slirp_libs=3D&quot;-L$PWD/slirp -lslirp&quot;<br>
+=C2=A0 =C2=A0 slirp_cflags=3D&quot;-I${source_path}/slirp/src -Islirp/src&=
quot;<br>
+=C2=A0 =C2=A0 slirp_libs=3D&quot;-Lslirp -lslirp&quot;<br>
=C2=A0 =C2=A0 =C2=A0if test &quot;$mingw32&quot; =3D &quot;yes&quot; ; then=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_libs=3D&quot;$slirp_libs -lws2_32 -liphlpa=
pi&quot;<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000ddcbee05ae55fcc7--

