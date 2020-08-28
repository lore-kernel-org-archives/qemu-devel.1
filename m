Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB51C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B42F2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoYHbea0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B42F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBf12-00085O-Mt
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBf06-000734-HO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:05:06 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:33985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBf04-0002sL-RA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:05:06 -0400
Received: by mail-ed1-x541.google.com with SMTP id q21so1288132edv.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CDodWdfs1JPW208hZ7zwR8/C6tTaC/35XEeeEkEr+ss=;
 b=XoYHbea0kAf5wmQBcxJ75sCNy7amQ9hgHIjK6DgSEyrtCIBf8veUC4sPx76XDdd8HS
 t+GWNArG+f/218w2UJu6J5ldzo+KbuZQFQHii/Xs6i3WPyqvY5zP4jktONeeuZfdL4LK
 pVGcc8BWOpYxkV9E1bJNc+hHZqJExhtrdlf8/yJpkerrEDBSI2zomCX8mayIsmNySNng
 Csn2O5zoqE0j1SdjGRM+uaQpU7dtnhDODKvJsV9AxK5PHMxo6+WcGYYDsb/9AVt4mxj/
 bvz5+L0vO5flBdD6K4CzgqC6lHg1OcEgUef6Y0AS2S++xWwEjvhpB5C3aJa60b0Ipk8w
 mFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CDodWdfs1JPW208hZ7zwR8/C6tTaC/35XEeeEkEr+ss=;
 b=TnadSRjijk/Ao8fQf6rZ+6niIX4S0JwgukU7xj/aRnxl7NfdIi4LdeFYxT1ZcqumUg
 6ADlDSgcldyls8IIUAbAWfjdVXrG72aNPm62tUuUnUbHGyvz0vXlhyBHa+cz1MCrsI7J
 tzEa+pnQcS1CCekS3+8qOBRFcfsT/RZY5+r/yAnaS9Xfj60DbOYRJPsrDBExbCY9JbBS
 /vf9AcQTWnQ2Uk4VkvPPAIGu3IAGxYcqRwFy1H1P9ZBuj3CNltj9Ov0Lokpe8WoOi/yz
 h8Z7ViwQbobLirblDZUEf1LKOOEhHbt9kROFTq+czFwPdiVxBmy5fqyrjd71/7mntAgZ
 X9EQ==
X-Gm-Message-State: AOAM532YQL/fZHvJf3FxYsyb+WdGWxT5RAZngEQBNxkx0VJvP96EGoEo
 8imqFb7hfMCWMSLLS6T+HP99pNoCfx7m8sRo79Y=
X-Google-Smtp-Source: ABdhPJx7Q4Wihpfc8nrXeJUqLF+JfC7Uuv85gGd3qvCVMxYZt0/bjhTKP/S13uSbeF/cxE+R7N2L4DEDc0AB6p1RVFE=
X-Received: by 2002:a05:6402:74f:: with SMTP id
 p15mr1940391edy.377.1598623503209; 
 Fri, 28 Aug 2020 07:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200827091128.GK2954729@toto>
 <1628c0ac-db22-ef9d-22e2-6a167ceaaf55@linaro.org>
 <20200827102217.GN2954729@toto>
 <5a787d85-a75f-60cf-0c99-a40c84222b35@linaro.org>
 <20200827170948.GO2954729@toto>
 <f555646c-f725-1328-7e42-75d4047a4e9a@linaro.org>
In-Reply-To: <f555646c-f725-1328-7e42-75d4047a4e9a@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 28 Aug 2020 16:04:55 +0200
Message-ID: <CAJy5ezoNJWp=n7aPGEDwQQXBqv5YGw=yNrKNLqBRH2iji2gPYg@mail.gmail.com>
Subject: Re: [PATCH 00/77] target/microblaze improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000009dbfa05adf08a4e"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000009dbfa05adf08a4e
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Aug 2020, 15:36 Richard Henderson, <richard.henderson@linaro.org>
wrote:

> On 8/27/20 10:09 AM, Edgar E. Iglesias wrote:
> > It seems to be getting out of sync when getting a slave-error and the
> core
> > is not setup to take exceptions for slave errors. Looks like a
> pre-existing
> > bug where we're restoring CPU state without taking the exception.
> > The following fixes that particular case in my runs.
> >
> >
> > I'm on a backported QEMU 5.1 so thing may look different in master.
> >
> > diff --git a/target/microblaze/op_helper.c
> b/target/microblaze/op_helper.c
> > index 831ff2cac1..0cae51c2df 100644
> > --- a/target/microblaze/op_helper.c
> > +++ b/target/microblaze/op_helper.c
> > @@ -432,22 +432,19 @@ void mb_cpu_transaction_failed(CPUState *cs,
> hwaddr physaddr, vaddr addr,
> >      cpu = MICROBLAZE_CPU(cs);
> >      env = &cpu->env;
> >
> > -    cpu_restore_state(cs, retaddr, true);
> > -    if (!(env->msr & MSR_EE)) {
> > +    if (!cpu->cfg.iopb_bus_exception || !(env->msr & MSR_EE)) {
> >          return;
> >      }
> >
> > +    cpu_restore_state(cs, retaddr, true);
> > +
> >      env->ear = addr;
> >      if (access_type == MMU_INST_FETCH) {
> > -        if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
> > -            env->esr = ESR_EC_INSN_BUS;
> > -            helper_raise_exception(env, EXCP_HW_EXCP);
> > -        }
> > +        env->esr = ESR_EC_INSN_BUS;
> > +        helper_raise_exception(env, EXCP_HW_EXCP);
> >      } else {
> > -        if ((env->pvr.regs[2] & PVR2_DOPB_BUS_EXC_MASK)) {
> > -            env->esr = ESR_EC_DATA_BUS;
> > -            helper_raise_exception(env, EXCP_HW_EXCP);
> > -        }
> > +        env->esr = ESR_EC_DATA_BUS;
> > +        helper_raise_exception(env, EXCP_HW_EXCP);
> >      }
> >  }
>
> Thanks for the pointer.  I've re-written this section to use
> cpu_loop_exit_restore(), so that the restore is at the end.  The new patch
> will
> appear in v2, just before iflags is added to the restore state.
>
>
> r~
>

Ok, cool. I posted another fix to the list (you're on CC) but we can take
your version if it makes it easier. Note that the example I gave you missed
that there's two different props for selecting fetch and data access
faults.

Cheers,
Edgar

>

--00000000000009dbfa05adf08a4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, 28 Aug 2020, 15:36 Richard Henderson, &lt;<a h=
ref=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 8/27/20 10:09 AM, E=
dgar E. Iglesias wrote:<br>
&gt; It seems to be getting out of sync when getting a slave-error and the =
core<br>
&gt; is not setup to take exceptions for slave errors. Looks like a pre-exi=
sting<br>
&gt; bug where we&#39;re restoring CPU state without taking the exception.<=
br>
&gt; The following fixes that particular case in my runs.<br>
&gt; <br>
&gt; <br>
&gt; I&#39;m on a backported QEMU 5.1 so thing may look different in master=
.<br>
&gt; <br>
&gt; diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_help=
er.c<br>
&gt; index 831ff2cac1..0cae51c2df 100644<br>
&gt; --- a/target/microblaze/op_helper.c<br>
&gt; +++ b/target/microblaze/op_helper.c<br>
&gt; @@ -432,22 +432,19 @@ void mb_cpu_transaction_failed(CPUState *cs, hwa=
ddr physaddr, vaddr addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu =3D MICROBLAZE_CPU(cs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 cpu_restore_state(cs, retaddr, true);<br>
&gt; -=C2=A0 =C2=A0 if (!(env-&gt;msr &amp; MSR_EE)) {<br>
&gt; +=C2=A0 =C2=A0 if (!cpu-&gt;cfg.iopb_bus_exception || !(env-&gt;msr &a=
mp; MSR_EE)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 cpu_restore_state(cs, retaddr, true);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;ear =3D addr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (access_type =3D=3D MMU_INST_FETCH) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((env-&gt;pvr.regs[2] &amp; PVR2_IOPB_=
BUS_EXC_MASK)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;esr =3D ESR_EC_INSN=
_BUS;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_raise_exception(env,=
 EXCP_HW_EXCP);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;esr =3D ESR_EC_INSN_BUS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_raise_exception(env, EXCP_HW_EXCP)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((env-&gt;pvr.regs[2] &amp; PVR2_DOPB_=
BUS_EXC_MASK)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;esr =3D ESR_EC_DATA=
_BUS;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_raise_exception(env,=
 EXCP_HW_EXCP);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;esr =3D ESR_EC_DATA_BUS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_raise_exception(env, EXCP_HW_EXCP)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
<br>
Thanks for the pointer.=C2=A0 I&#39;ve re-written this section to use<br>
cpu_loop_exit_restore(), so that the restore is at the end.=C2=A0 The new p=
atch will<br>
appear in v2, just before iflags is added to the restore state.<br>
<br>
<br>
r~<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Ok, cool. I posted another fix to the list (you&#39;re on CC) but we can =
take your version if it makes it easier. Note that the example I gave you m=
issed that there&#39;s two different props for selecting fetch and data acc=
ess faults.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Cheers=
,=C2=A0</div><div dir=3D"auto">Edgar=C2=A0</div><div dir=3D"auto"><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000009dbfa05adf08a4e--

