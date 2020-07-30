Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22453C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46CD2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WKgf3sZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46CD2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k13c2-0007W0-4U
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 04:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k13bR-00072u-1Y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:07:49 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:41713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k13bO-0003FT-Ii
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:07:48 -0400
Received: by mail-ot1-x32b.google.com with SMTP id a65so10300742otc.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UQsqOwv0Bj/SsgWe8rf6tO6u76r/jzzA/V2mY0pM3bg=;
 b=WKgf3sZt6Bf2jUAXLvFi0pG5P8HPyI0+WF0wdBwjAUnCsgczeJUkS7f1iGjxB+YjLO
 GynsDzHDr+BFfIpPShYG9w3CVbXnOsM43qfwHiW5mAlS4FsqQv9bVkCo5djiI4o6RbSl
 QippqECljfxXpov+XYQy/wgoYxydxtQF9i/jmRcKzWQixlIkkkfObax5812Jbc0cn4H3
 4zOWqnH1V6KH1v+p0Ov7hbhG1ccubrKod4I24goQZUaFg8Qvawx8F9KXo3XZltVPsCJv
 jqoseN0pa2TZSCLbTT8umXlofm1FU/gE3kpvHj8z9WvXCY5nfQZVJyP40LPZwLv2109r
 Dolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UQsqOwv0Bj/SsgWe8rf6tO6u76r/jzzA/V2mY0pM3bg=;
 b=mNfq5Todmg+0wPI7GoP0TvbYlqWept2H4oq9l4Y923vfu8lf4hxzyy1ghGKRPl8zTW
 AXPEEXg/Ih5zjDvo8sbpOqntIurYELztuOTA8RozD4l7G1Of7Kk+UEvkxZ/bBOCB/LvE
 oTYlJG8nONAWi4UrDvYYfw6xhcXk6yKBQpNpJE2c2t+qAcWTr55vXnK/Q6lHNGRchPRQ
 PDfTwYQUCgTiGPsO5JxADa7rJ9F8/3HbGE89aJblMO5rk/SB3ppU55XdEQ/dIqNvP5Nq
 ChsYXzwW3+vzoqZ72XrIofOl6xydHtgaA8LhyYdN5Yh6OmFsH7uxhBrhd4Mf/eYeAxXh
 YTKw==
X-Gm-Message-State: AOAM530nlq9VXD2IfkFnYQNye3JiHVHJ0dP9gFDlyFGVj9cr+zeRQ5BB
 hVtMsg9DhBURF7fdmqyAvFvBmHB10z8kQvpR+vdQVA==
X-Google-Smtp-Source: ABdhPJy1f7MSG6+V4q5x5e+XaLueACbt5Wu1SfVVmKV9/EWCUVBpTI26VA72x2R/qw1ewK9n2xqELbxjg6NyBNpRQys=
X-Received: by 2002:a05:6830:1e71:: with SMTP id
 m17mr1467317otr.188.1596096464640; 
 Thu, 30 Jul 2020 01:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200722091641.8834-2-frank.chang@sifive.com>
 <mhng-0246b27e-f392-45a9-806e-9998bb5ede5e@palmerdabbelt-glaptop1>
 <CAKmqyKMEraiyw_r7U3v8K-2pdipBh3otaPOaNPLKtpvqPe780A@mail.gmail.com>
In-Reply-To: <CAKmqyKMEraiyw_r7U3v8K-2pdipBh3otaPOaNPLKtpvqPe780A@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 30 Jul 2020 16:07:33 +0800
Message-ID: <CAE_xrPi0Rc88P4wehno_ewjH_-wCm5bicO-rae-ZYsAgVpyOBw@mail.gmail.com>
Subject: Re: [RFC v2 01/76] target/riscv: drop vector 0.7.1 support
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000cd74dc05aba42af6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x32b.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cd74dc05aba42af6
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 28, 2020 at 4:05 AM Alistair Francis <alistair23@gmail.com>
wrote:

> On Mon, Jul 27, 2020 at 12:54 PM Palmer Dabbelt <palmer@dabbelt.com>
> wrote:
> >
> > On Wed, 22 Jul 2020 02:15:24 PDT (-0700), frank.chang@sifive.com wrote:
> > > From: Frank Chang <frank.chang@sifive.com>
> > >
> > > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > > ---
> > >  target/riscv/cpu.c | 24 ++++++------------------
> > >  target/riscv/cpu.h |  2 --
> > >  2 files changed, 6 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 228b9bdb5d..2800953e6c 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -106,11 +106,6 @@ static void set_priv_version(CPURISCVState *env,
> int priv_ver)
> > >      env->priv_ver = priv_ver;
> > >  }
> > >
> > > -static void set_vext_version(CPURISCVState *env, int vext_ver)
> > > -{
> > > -    env->vext_ver = vext_ver;
> > > -}
> > > -
> > >  static void set_feature(CPURISCVState *env, int feature)
> > >  {
> > >      env->features |= (1ULL << feature);
> > > @@ -339,7 +334,6 @@ static void riscv_cpu_realize(DeviceState *dev,
> Error **errp)
> > >      CPURISCVState *env = &cpu->env;
> > >      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
> > >      int priv_version = PRIV_VERSION_1_11_0;
> > > -    int vext_version = VEXT_VERSION_0_07_1;
> > >      target_ulong target_misa = 0;
> > >      Error *local_err = NULL;
> > >
> > > @@ -363,7 +357,6 @@ static void riscv_cpu_realize(DeviceState *dev,
> Error **errp)
> > >      }
> > >
> > >      set_priv_version(env, priv_version);
> > > -    set_vext_version(env, vext_version);
> > >
> > >      if (cpu->cfg.mmu) {
> > >          set_feature(env, RISCV_FEATURE_MMU);
> > > @@ -455,19 +448,14 @@ static void riscv_cpu_realize(DeviceState *dev,
> Error **errp)
> > >                  return;
> > >              }
> > >              if (cpu->cfg.vext_spec) {
> > > -                if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
> > > -                    vext_version = VEXT_VERSION_0_07_1;
> > > -                } else {
> > > -                    error_setg(errp,
> > > -                           "Unsupported vector spec version '%s'",
> > > -                           cpu->cfg.vext_spec);
> > > -                    return;
> > > -                }
> > > +                error_setg(errp,
> > > +                       "Unsupported vector spec version '%s'",
> > > +                       cpu->cfg.vext_spec);
> > > +                return;
> > >              } else {
> > > -                qemu_log("vector verison is not specified, "
> > > -                        "use the default value v0.7.1\n");
> > > +                qemu_log("vector version is not specified\n");
> > > +                return;
> > >              }
> > > -            set_vext_version(env, vext_version);
> > >          }
> > >
> > >          set_misa(env, RVXLEN | target_misa);
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index eef20ca6e5..6766dcd914 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -79,8 +79,6 @@ enum {
> > >  #define PRIV_VERSION_1_10_0 0x00011000
> > >  #define PRIV_VERSION_1_11_0 0x00011100
> > >
> > > -#define VEXT_VERSION_0_07_1 0x00000701
> > > -
> > >  #define TRANSLATE_PMP_FAIL 2
> > >  #define TRANSLATE_FAIL 1
> > >  #define TRANSLATE_SUCCESS 0
> >
> > If I'm reading things correctly, 5.0 did not have the V extension.  This
> means
> > that we can technically drop 0.7.1 from QEMU, as it's never been
> released.
>
> There is no intention of this making it into 5.1. We are currently in
> hard freeze.
>
> The idea is that QEMU 5.1 will support v0.7.1 and then hopefully 5.2
> will support v0.9.
>
> > That said, I'd still prefer to avoid dropping 0.7.1 so late in the
> release
> > cycle (it's already soft freeze, right?).  Given the extended length of
> the V
> > extension development process it seems likely that 0.7.1 is going to end
> up in
> > some silicon, which means it would be quite useful to have it in QEMU.
>
> Agreed!
>
> >
> > I understand it's a lot more work to maintain multiple vector
> extensions, but
> > it was very useful to have multiple privileged extensions supported in
> QEMU
> > while that was all getting sorted out and as the vector drafts has
> massive
> > differences it'll probably be even more useful.
>
> Hopefully a release will be enough for this as managing both will be a
> huge maintenance burden.
>
> Alistair
>
> >




Although RVV v1.0 spec is not ratified yet.
However, the differences between RVV v0.9 by far are minor:
1. SLEN=VLEN layout mandatory.
>> Luckily we haven't defined *slen* in our RVV implementation by far, so
we can just ignore the change.
2. Support ELEN > VLEN for LMUL > 1
3. Defined vector FP exception behavior.
4. Added reciprocal and reciprocal square-root estimate instructions.
>> *vfrece7.v* and *vfrsqrte7.v* instructions are added, but the
behaviors are still undefined.
5. Defined hint behavior on whole register moves and load/stores to enable
microarchitectures with internal data rearrangement.
>> Serveral *vl**<NF>re<EEW>.v* and *vs<NF>r.v* instructions are added.
6. Added *vrgatherei16* instruction.
7. Rearranged bits in *vtype* to make *vlmul* bits into a contiguous field.

As QEMU v5.1 is already hard-freezed and should be released between
2020/08/11 and 2020/08/18.
So perhaps we still have some time for waiting RVV v1.0 spec. to be
ratified before QEMU v5.2 is soft-freezed?

We have already made these RVV v1.0 changes in our local branch.
(*vfrece7.v* and *vfrsqrte7.v* instructions are not included as they're not
defined yet.)
So, if it's okay, we can skip RVV v0.9 and bump to RVV v1.0 directly in our
next version of patchset.
Which I think may relieve the burden for the community to maintain
multi-version of vector drafts.

Any thoughts?

Frank Chang

--000000000000cd74dc05aba42af6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Jul 28, 2020 at 4:05 AM Alistair =
Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a=
>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Mon, Jul 27, 2020 at 12:54 PM Palmer Dabbelt &lt=
;<a href=3D"mailto:palmer@dabbelt.com" target=3D"_blank">palmer@dabbelt.com=
</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, 22 Jul 2020 02:15:24 PDT (-0700), <a href=3D"mailto:frank.chan=
g@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> wrote:<br>
&gt; &gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" t=
arget=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifi=
ve.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 target/riscv/cpu.c | 24 ++++++------------------<br>
&gt; &gt;=C2=A0 target/riscv/cpu.h |=C2=A0 2 --<br>
&gt; &gt;=C2=A0 2 files changed, 6 insertions(+), 20 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; &gt; index 228b9bdb5d..2800953e6c 100644<br>
&gt; &gt; --- a/target/riscv/cpu.c<br>
&gt; &gt; +++ b/target/riscv/cpu.c<br>
&gt; &gt; @@ -106,11 +106,6 @@ static void set_priv_version(CPURISCVState *=
env, int priv_ver)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;priv_ver =3D priv_ver;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -static void set_vext_version(CPURISCVState *env, int vext_ver)<b=
r>
&gt; &gt; -{<br>
&gt; &gt; -=C2=A0 =C2=A0 env-&gt;vext_ver =3D vext_ver;<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 static void set_feature(CPURISCVState *env, int feature)<br=
>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;features |=3D (1ULL &lt;&lt; feature)=
;<br>
&gt; &gt; @@ -339,7 +334,6 @@ static void riscv_cpu_realize(DeviceState *de=
v, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(de=
v);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int priv_version =3D PRIV_VERSION_1_11_0;<br>
&gt; &gt; -=C2=A0 =C2=A0 int vext_version =3D VEXT_VERSION_0_07_1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong target_misa =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; &gt;<br>
&gt; &gt; @@ -363,7 +357,6 @@ static void riscv_cpu_realize(DeviceState *de=
v, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 set_priv_version(env, priv_version);<br>
&gt; &gt; -=C2=A0 =C2=A0 set_vext_version(env, vext_version);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (cpu-&gt;cfg.mmu) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_feature(env, RISCV_FEATURE_=
MMU);<br>
&gt; &gt; @@ -455,19 +448,14 @@ static void riscv_cpu_realize(DeviceState *=
dev, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu-&gt;cfg.v=
ext_spec) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_s=
trcmp0(cpu-&gt;cfg.vext_spec, &quot;v0.7.1&quot;)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 vext_version =3D VEXT_VERSION_0_07_1;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {=
<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 error_setg(errp,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Unsupported vector spec version &#3=
9;%s&#39;&quot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.vext_spec);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_se=
tg(errp,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;Unsupported vector spec version &#39;%s&#39;&quot=
;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.vext_spec);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log=
(&quot;vector verison is not specified, &quot;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;use the default value v0.7.1\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log=
(&quot;vector version is not specified\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_vext_version(env, =
vext_version);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_misa(env, RVXLEN | target_m=
isa);<br>
&gt; &gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; &gt; index eef20ca6e5..6766dcd914 100644<br>
&gt; &gt; --- a/target/riscv/cpu.h<br>
&gt; &gt; +++ b/target/riscv/cpu.h<br>
&gt; &gt; @@ -79,8 +79,6 @@ enum {<br>
&gt; &gt;=C2=A0 #define PRIV_VERSION_1_10_0 0x00011000<br>
&gt; &gt;=C2=A0 #define PRIV_VERSION_1_11_0 0x00011100<br>
&gt; &gt;<br>
&gt; &gt; -#define VEXT_VERSION_0_07_1 0x00000701<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 #define TRANSLATE_PMP_FAIL 2<br>
&gt; &gt;=C2=A0 #define TRANSLATE_FAIL 1<br>
&gt; &gt;=C2=A0 #define TRANSLATE_SUCCESS 0<br>
&gt;<br>
&gt; If I&#39;m reading things correctly, 5.0 did not have the V extension.=
=C2=A0 This means<br>
&gt; that we can technically drop 0.7.1 from QEMU, as it&#39;s never been r=
eleased.<br>
<br>
There is no intention of this making it into 5.1. We are currently in<br>
hard freeze.<br>
<br>
The idea is that QEMU 5.1 will support v0.7.1 and then hopefully 5.2<br>
will support v0.9.<br>
<br>
&gt; That said, I&#39;d still prefer to avoid dropping 0.7.1 so late in the=
 release<br>
&gt; cycle (it&#39;s already soft freeze, right?).=C2=A0 Given the extended=
 length of the V<br>
&gt; extension development process it seems likely that 0.7.1 is going to e=
nd up in<br>
&gt; some silicon, which means it would be quite useful to have it in QEMU.=
<br>
<br>
Agreed!<br>
<br>
&gt;<br>
&gt; I understand it&#39;s a lot more work to maintain multiple vector exte=
nsions, but<br>
&gt; it was very useful to have multiple privileged extensions supported in=
 QEMU<br>
&gt; while that was all getting sorted out and as the vector drafts has mas=
sive<br>
&gt; differences it&#39;ll probably be even more useful.<br>
<br>
Hopefully a release will be enough for this as managing both will be a<br>
huge maintenance burden.<br>
<br>
Alistair<br>
<br>
&gt;=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
=C2=A0</blockquote><div><br></div><div>Although RVV v1.0 spec is not ratifi=
ed yet.</div><div>However, the differences between RVV v0.9 by far are mino=
r:</div><div>1. SLEN=3DVLEN layout mandatory.</div><div>&gt;&gt; Luckily=C2=
=A0we haven&#39;t defined=C2=A0<i>slen</i> in our RVV implementation by far=
, so we can just ignore the change.=C2=A0</div><div>2.=C2=A0Support ELEN &g=
t; VLEN for LMUL &gt; 1</div>3.=C2=A0<span style=3D"color:rgb(0,0,0);white-=
space:pre-wrap">Defined vector FP exception behavior.</span></div><div clas=
s=3D"gmail_quote"><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">4. =
</span><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">Added reciproc=
al and reciprocal square-root estimate instructions.</span></div><div class=
=3D"gmail_quote"><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">&gt;=
&gt; </span><i>vfrece7.v</i>=C2=A0and=C2=A0<i>vfrsqrte7.v</i>=C2=A0instruct=
ions are added, but the behaviors=C2=A0are still undefined.</div><div class=
=3D"gmail_quote"><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">5. <=
/span><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">Defined hint be=
havior on whole register moves and load/stores to enable microarchitectures=
 with internal data rearrangement.</span></div><div class=3D"gmail_quote"><=
span style=3D"color:rgb(0,0,0);white-space:pre-wrap">&gt;&gt; Serveral <i>v=
l</i></span><i>&lt;NF&gt;re&lt;EEW&gt;.v</i> and <i>vs&lt;NF&gt;r.v</i> ins=
tructions are added.</div><div class=3D"gmail_quote"><span style=3D"color:r=
gb(0,0,0);white-space:pre-wrap">6. </span><span style=3D"color:rgb(0,0,0);w=
hite-space:pre-wrap">Added <i>vrgatherei16</i> instruction.</span></div><di=
v class=3D"gmail_quote"><font color=3D"#000000"><span style=3D"white-space:=
pre-wrap">7. </span></font><span style=3D"color:rgb(0,0,0);white-space:pre-=
wrap">Rearranged bits in <i>vtype</i> to make <i>vlmul</i> bits into a cont=
iguous field.</span></div><div class=3D"gmail_quote"><span style=3D"color:r=
gb(0,0,0);white-space:pre-wrap"><br></span></div><div class=3D"gmail_quote"=
><span style=3D"color:rgb(0,0,0);white-space:pre-wrap"></span></div><div cl=
ass=3D"gmail_quote"><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">A=
s QEMU v5.1 is already hard-freezed and should be released between 2020/08/=
11 and 2020/08/18.</span><br></div><div class=3D"gmail_quote"><div class=3D=
"gmail_quote"><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">So perh=
aps we still have some time for waiting RVV v1.0 spec. to be ratified befor=
e QEMU v5.2 is soft-freezed?</span></div><div class=3D"gmail_quote"><br></d=
iv><div class=3D"gmail_quote">We have already made these RVV v1.0 changes i=
n our local branch.<span style=3D"color:rgb(0,0,0);white-space:pre-wrap"><b=
r></span></div><div class=3D"gmail_quote">(<i>vfrece7.v</i>=C2=A0and=C2=A0<=
i>vfrsqrte7.v</i>=C2=A0instructions are not included as they&#39;re not def=
ined=C2=A0yet.)</div><div class=3D"gmail_quote"></div></div><div class=3D"g=
mail_quote"><font color=3D"#000000"><span style=3D"white-space:pre-wrap">So=
, if it&#39;s okay, we can </span></font>skip RVV v0.9 and=C2=A0<span style=
=3D"white-space:pre-wrap;color:rgb(0,0,0)">bump to RVV v1.0 directly in our=
 next version of patchset.</span></div><div class=3D"gmail_quote"><span sty=
le=3D"white-space:pre-wrap;color:rgb(0,0,0)">Which I think may relieve the =
burden for the community to maintain multi-version of vector drafts.</span>=
</div><div class=3D"gmail_quote"><span style=3D"white-space:pre-wrap;color:=
rgb(0,0,0)"><br></span></div><div class=3D"gmail_quote"><span style=3D"whit=
e-space:pre-wrap;color:rgb(0,0,0)">Any thoughts?</span></div><div class=3D"=
gmail_quote"><span style=3D"white-space:pre-wrap;color:rgb(0,0,0)"><br></sp=
an></div><div class=3D"gmail_quote"><span style=3D"white-space:pre-wrap;col=
or:rgb(0,0,0)">Frank Chang</span></div></div>

--000000000000cd74dc05aba42af6--

