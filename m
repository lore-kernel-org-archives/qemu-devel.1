Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB063C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD22207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nILy7IH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD22207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CSf-0005Jp-Om
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1k5Bn6-0003Qu-Iv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:40:56 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1k5Bn4-0006od-JP
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:40:56 -0400
Received: by mail-ed1-x544.google.com with SMTP id c10so7000587edk.6
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mRIbPDXF0FzIw0mNU4V3FgZzxMrRV2XMeZ2gIscav9w=;
 b=nILy7IH2BZTB96YwpnRQr4K/nIKvFw7r4HWZM9DEdeOHVeUXOs1Fcqb5Pr9qH+TOk+
 Xrn4RY9LiejIOsMOfhrE+mQuL+rXnWNqSd4+OQm+vlG7/k0ttA8BjkZet9Vcz/S3/86k
 a0UssVGfw5+TtGoeHwE1hDn7URaDdMiz95gQXYBFWnNjIu91Vi3ZpvsZwmPlNr/FGbbY
 9RspBwHxldqyl7Le0mk48/PmoG/yjpPSEZZK09lJCOK/BqJmk6jA9FjBIZ1ail9B/gQJ
 uF19lXi2nr3ZnVTrUJ38BRsCqU5i0kB9qgNC1hyu1nd7bYSVELiD1dp0nlLh7T7ltnfI
 6Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mRIbPDXF0FzIw0mNU4V3FgZzxMrRV2XMeZ2gIscav9w=;
 b=F4lL47lZ7o9OeeBfXsjjOqpfK4U5CyzVdElldSWqXjt5DtWmu0nLotQdFII1XDuZvb
 YCWqbSkH8+lWVrLAYz51yenELaKa36voUUE3RJufKYIGZb05m0wpvvBM4EVH4XxZ1j/0
 DGzgfnbAyrtYiqIOx7v9IHL8rukWqIXW2eVnW1iYyWpPz/YYLvnIjyKM4CCP8m4ouffL
 TK3oSpKmJadAsiZn1UqGVxVCwT1ttFX6qk3/GFZrbJ2HhH8k3ZGrg56wk54SL29JMArS
 rDyOvNQBrWEdKTx35Owo0Dk5h+oY1MwKBzXMBxL1P0FYm1afe8Kp3oZCTc1XdhqSufyr
 f2FA==
X-Gm-Message-State: AOAM532t5DZnjiRsL7rSaxhvUq3s4o4mJza98omQ6bmVaCbod4I971iy
 Aa8xXWBt6A0kxcV2GLXrDjz6Oh3Txm70lGMxtEo=
X-Google-Smtp-Source: ABdhPJx5tQDbMEh62lybynQs5R3Di6Tj39PLdgsR/n1GsaxAW9/QPoJorFQQEEp4U+G633rgifbSHw3xOomiyCRGGsI=
X-Received: by 2002:a50:ee0a:: with SMTP id g10mr21179434eds.289.1597081252117; 
 Mon, 10 Aug 2020 10:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200717125639.1103876-1-arilou@gmail.com>
 <20200717125639.1103876-2-arilou@gmail.com>
 <837db114-d7a3-7e0b-dfd4-db136711c120@redhat.com>
In-Reply-To: <837db114-d7a3-7e0b-dfd4-db136711c120@redhat.com>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 10 Aug 2020 20:40:40 +0300
Message-ID: <CAP7QCoj5fCW4f9WkRrErfn95pFvs9n23_U-TLnKGC6XUG_8nBg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hyperv: Enable SCONTROL if SYNIC is enabled
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b5c1a605ac897413"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=arilou@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b5c1a605ac897413
Content-Type: text/plain; charset="UTF-8"

I think both patches are

On Mon, Aug 10, 2020, 20:27 Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 17/07/20 14:56, Jon Doron wrote:
> > Based on an analysis of the HyperV firmwares (Gen1 and Gen2) it seems
> > like the SCONTROL is not being set to the ENABLED state as like we have
> > thought.
> >
> > Also from a test done by Vitaly Kuznetsov, running a nested HyperV it
> > was concluded that the first access to the SCONTROL MSR with a read
> > resulted with the value of 0x1, aka HV_SYNIC_CONTROL_ENABLE.
> >
> > It's important to note that this diverges from the value states in the
> > HyperV TLFS of 0.
> >
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  target/i386/kvm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index b8455c89ed..6a62e8ae94 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -1904,6 +1904,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
> >
> >      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
> >          int i;
> > +
> > +        env->msr_hv_synic_control = HV_SYNIC_ENABLE;
> >          for (i = 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
> >              env->msr_hv_synic_sint[i] = HV_SINT_MASKED;
> >          }
> >
>
> Are both patches needed or only the Hyper-V one?
>
> Paolo
>
>

--000000000000b5c1a605ac897413
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I think both patches are=C2=A0</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10, 2020, 20:27=
 Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 17/07/20 14:56=
, Jon Doron wrote:<br>
&gt; Based on an analysis of the HyperV firmwares (Gen1 and Gen2) it seems<=
br>
&gt; like the SCONTROL is not being set to the ENABLED state as like we hav=
e<br>
&gt; thought.<br>
&gt; <br>
&gt; Also from a test done by Vitaly Kuznetsov, running a nested HyperV it<=
br>
&gt; was concluded that the first access to the SCONTROL MSR with a read<br=
>
&gt; resulted with the value of 0x1, aka HV_SYNIC_CONTROL_ENABLE.<br>
&gt; <br>
&gt; It&#39;s important to note that this diverges from the value states in=
 the<br>
&gt; HyperV TLFS of 0.<br>
&gt; <br>
&gt; Signed-off-by: Jon Doron &lt;<a href=3D"mailto:arilou@gmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">arilou@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/i386/kvm.c | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/i386/kvm.c b/target/i386/kvm.c<br>
&gt; index b8455c89ed..6a62e8ae94 100644<br>
&gt; --- a/target/i386/kvm.c<br>
&gt; +++ b/target/i386/kvm.c<br>
&gt; @@ -1904,6 +1904,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;msr_hv_synic_control =3D HV_SYNIC=
_ENABLE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(env-=
&gt;msr_hv_synic_sint); i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;msr_hv_synic_s=
int[i] =3D HV_SINT_MASKED;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
<br>
Are both patches needed or only the Hyper-V one?<br>
<br>
Paolo<br>
<br>
</blockquote></div>

--000000000000b5c1a605ac897413--

