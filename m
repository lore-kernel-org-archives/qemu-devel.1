Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC593C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E852085B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5zavMR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E852085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfnQ-0003Af-Q0
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqfmi-0002Ww-Lc
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:40:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33283
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqfmD-0003LP-HJ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593621599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1iX5MYB000v7uy97zKOGY26aZHx+xJ5dItP/i4ClzRY=;
 b=a5zavMR2FLuSS4kknhVMrhio2OlLvypycXgq9B4BclPLsiS/tSnilNpk4n9ige7Me1Q3wI
 h271smMhbQ0ZPpGUsSlnf+ctJyBdIBV+MGaRPdUxP4XLT4aYCDAndcS1up9Ou+NbvuX0Z2
 Y+26fPNe/EBLeKJIZeV1ijN12XXS2gs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-o9o2fiS7N4W_xByzZzzpOA-1; Wed, 01 Jul 2020 12:39:54 -0400
X-MC-Unique: o9o2fiS7N4W_xByzZzzpOA-1
Received: by mail-ed1-f71.google.com with SMTP id y4so10178315edv.17
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 09:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1iX5MYB000v7uy97zKOGY26aZHx+xJ5dItP/i4ClzRY=;
 b=gNLeN+bPeD6YdBc/hwkAyI1iCoMyEpoRbQGbzyEx7pDFj9Lg8OdhYefL15er2cRIRz
 1WpVBsNCAmPIzShlGL+qVCIm0TgynzyxV9YT82sKkdNrhg9vgXejsrtDVggWnO7Ay1AH
 WbX2UstHHHbl1LxbAMb255dRAIPCSh1nZH3M5YDpq+yltXyNMVdjtCOGHCT9cLqgJRsk
 TgHrrc0CaAJKcFdGhY+S0wNCHVm7phJ1hZbn391UJZbHmzIccW2yw7j3C/WWHC3V3Uu5
 kEM7a3A3e5SioBm2ecwvMU8N7wVaPYcLG2MuPTJFHKLNTcnb8lBDafR85rI4Nd4ZrjIY
 YdoA==
X-Gm-Message-State: AOAM5319oZb4q3jab/6rpm6lUZTfHcS/2ELxr3x4ZGbWKO8pOzq/UYUF
 /omEdQG4zLHWbYKOE+5DQgKSEpJ3hhli5kjXjdYRMj+BGAMCULsa71YtUf2a0Y7/2oEehX1pmY6
 b2BiYHf2LhZbNZbBAXH+wlZDC9vHjfHQ=
X-Received: by 2002:aa7:d04e:: with SMTP id n14mr5363704edo.161.1593621593128; 
 Wed, 01 Jul 2020 09:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8lkm1+qg9FjjFIuxP2ZnQvOf+qUuUpTeUU42XlXKcxjGqC2Jxl0qx3UQC+iIJaRHXF5xQn9HUyEvY8WUYjAk=
X-Received: by 2002:aa7:d04e:: with SMTP id n14mr5363682edo.161.1593621592913; 
 Wed, 01 Jul 2020 09:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200624160608.383931-1-pbonzini@redhat.com>
 <20200701162841.GG3608@work-vm>
In-Reply-To: <20200701162841.GG3608@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 1 Jul 2020 18:39:40 +0200
Message-ID: <CABgObfZjrBe+87Lhyw_Zyyuyun3VBpHa1RuzovmvthrU-Ea-pQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: add support for AMD nested live migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f3cc3605a963f0f9"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--000000000000f3cc3605a963f0f9
Content-Type: text/plain; charset="UTF-8"

Il mer 1 lug 2020, 18:28 Dr. David Alan Gilbert <dgilbert@redhat.com> ha
scritto:

>
> > +    return (nested_state->format == KVM_STATE_NESTED_FORMAT_SVM &&
> > +            nested_state->size > offsetof(struct kvm_nested_state,
> data));
>
> How does this nested_state->size work? It looks like even if it's 1 byte
> into 'data' we transmit a whole KVM_STATE_NESTED_SVM_VMCB_SIZE.
>

The format is documented as having either 0 or KVM_STATE_NESTED_SVM_VMCB_SIZE
bytes (for vmx instead it can be 0, 4K or 8K).

Paolo


> Dave
>
> > +}
> > +
> > +static const VMStateDescription vmstate_svm_nested_state = {
> > +    .name = "cpu/kvm_nested_state/svm",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = svm_nested_state_needed,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_U64(hdr.svm.vmcb_pa, struct kvm_nested_state),
> > +        VMSTATE_UINT8_ARRAY(data.svm[0].vmcb12,
> > +                            struct kvm_nested_state,
> > +                            KVM_STATE_NESTED_SVM_VMCB_SIZE),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static bool nested_state_needed(void *opaque)
> >  {
> >      X86CPU *cpu = opaque;
> >      CPUX86State *env = &cpu->env;
> >
> >      return (env->nested_state &&
> > -            vmx_nested_state_needed(env->nested_state));
> > +            (vmx_nested_state_needed(env->nested_state) ||
> > +             svm_nested_state_needed(env->nested_state)));
> >  }
> >
> >  static int nested_state_post_load(void *opaque, int version_id)
> > @@ -1139,6 +1166,7 @@ static const VMStateDescription
> vmstate_kvm_nested_state = {
> >      },
> >      .subsections = (const VMStateDescription*[]) {
> >          &vmstate_vmx_nested_state,
> > +        &vmstate_svm_nested_state,
> >          NULL
> >      }
> >  };
> > --
> > 2.26.2
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>

--000000000000f3cc3605a963f0f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il mer 1 lug 2020, 18:28 Dr. David Alan Gilbert &lt;<a href=3D=
"mailto:dgilbert@redhat.com">dgilbert@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><br>
&gt; +=C2=A0 =C2=A0 return (nested_state-&gt;format =3D=3D KVM_STATE_NESTED=
_FORMAT_SVM &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_state-&gt;size &gt; =
offsetof(struct kvm_nested_state, data));<br>
<br>
How does this nested_state-&gt;size work? It looks like even if it&#39;s 1 =
byte<br>
into &#39;data&#39; we transmit a whole KVM_STATE_NESTED_SVM_VMCB_SIZE.<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The =
format is documented as having either 0 or=C2=A0<span style=3D"font-family:=
sans-serif">KVM_STATE_NESTED_SVM_VMCB_SIZE bytes (for vmx instead it can be=
 0, 4K or 8K).</span></div><div dir=3D"auto"><span style=3D"font-family:san=
s-serif"><br></span></div><div dir=3D"auto"><span style=3D"font-family:sans=
-serif">Paolo</span></div><div dir=3D"auto"><span style=3D"font-family:sans=
-serif"><br></span></div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<br>
Dave<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription vmstate_svm_nested_state =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;cpu/kvm_nested_state/svm&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .needed =3D svm_nested_state_needed,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_U64(hdr.svm.vmcb_pa, struct kvm_n=
ested_state),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(data.svm[0].vmcb12,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kvm_nested_state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KVM_STATE_NESTED_SVM_VMCB_SIZE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 static bool nested_state_needed(void *opaque)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 X86CPU *cpu =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CPUX86State *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return (env-&gt;nested_state &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmx_nested_state_needed(env=
-&gt;nested_state));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (vmx_nested_state_needed(en=
v-&gt;nested_state) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0svm_nested_state_need=
ed(env-&gt;nested_state)));<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int nested_state_post_load(void *opaque, int version_id)<=
br>
&gt; @@ -1139,6 +1166,7 @@ static const VMStateDescription vmstate_kvm_nest=
ed_state =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .subsections =3D (const VMStateDescription*[]) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vmstate_vmx_nested_state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vmstate_svm_nested_state,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 };<br>
&gt; -- <br>
&gt; 2.26.2<br>
&gt; <br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank" rel=3D"noreferrer">dgilbert@redhat.com</a> / Manchester, UK<br>
<br>
</blockquote></div></div></div>

--000000000000f3cc3605a963f0f9--


