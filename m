Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1870CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D417206DD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKEM1Emw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D417206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSXE-0000Ks-EJ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSVp-0007M0-Qt
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:34:54 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSVn-0006LW-HZ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:34:53 -0400
Received: by mail-lf1-x144.google.com with SMTP id d24so7430382lfa.8
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=p68fqP+9WSCreV6RpdsXdjr/pCjbIEjQTqsKHjz8klM=;
 b=IKEM1EmwYPwfx0BoKhCCnPn6QQ22zGR1rHqs2Nn58HhNZ2EU+SaZTfhl/ez0J1jiMx
 UiE8EdvKv9/DibJ4wbyb1h6JyStwQ0bYeCKrcJGZNFyrunaJYiEbebdQ2RSMSIvP3nuQ
 VXr+/cesQduuSdw6QUL4yXtIElxBdSoXFTr5cpFs6v7QsbqATs5gIITo+Jvyo96M3Cou
 CTX3JCChdEI7lalGR7IX2oRSOpG8C0132Yn+qy7XSecF53r+BQJ7bsnPBWK2tKWmkMqy
 lNet+XLmb4x869PD/QUxJOT19M+OGAjxLhG7ON7GVyM2YORYQBwVRp+6fKQ1Gdb7K4lK
 HGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=p68fqP+9WSCreV6RpdsXdjr/pCjbIEjQTqsKHjz8klM=;
 b=CnuopbAvOzerB/vfesAjny+izbN9mdJTrj1hfcqHdzh4u94rAju365ZYaBG0Y2R6y8
 S2YK3UWuqdxGKW/l4ejt53yrgNYNn20NySz7O9p1hXmch2WqT+03SD+8ax1DLxXnUVQn
 7z7ZlR0bpz4fO4iCSwvhzoeJNfwHqadqtT5KYfUngCz4ciguO9+AGD53NLUsIemzMBnw
 E2LUiZlANyi4B542Hca71vUQhcn5ZaZEmT963Jw5p5Xuz+t14F3oaC7C0txdef5nGgV1
 HmgDcWLFzlM38PwP2vWThhbrfTl2U32/qCya+m7pRo4uo+0WiqYVCF0zaMbd+X0V2v+3
 0cqw==
X-Gm-Message-State: AOAM531SlDERVV5Fss0bLQJ8vp7fMeepYbPOKNa3Fe8Em7APkMTj5xR3
 KLWWfYJf7IawzuSLI6PZJPvrzKIot14U7JUsmqc=
X-Google-Smtp-Source: ABdhPJzPzydOUvyJe+UiOy7gyvcUtTsEtho+bSjhZRXPu+EjALoeYcksj5a0nfUdZygyBVfEl1bEG4mHL7MYqwVyWeI=
X-Received: by 2002:a19:560a:: with SMTP id k10mr5487982lfb.599.1601912089123; 
 Mon, 05 Oct 2020 08:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-6-luoyonggang@gmail.com>
 <87pn5x2bjm.fsf@linaro.org>
In-Reply-To: <87pn5x2bjm.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 5 Oct 2020 23:34:39 +0800
Message-ID: <CAE2XoE8GQ3K0gp6Pr2eeq3R=X_1Mc9tPkmjVKx-TeS0G+WFJcw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] plugin: getting qemu_plugin_get_hwaddr only expose
 one function prototype
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000008a5ab05b0ee39cb"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000008a5ab05b0ee39cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2020 at 6:48 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > This is used for counting how much function are export to qemu plugin.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  plugins/api.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/plugins/api.c b/plugins/api.c
> > index f16922ca8b..d325084385 100644
> > --- a/plugins/api.c
> > +++ b/plugins/api.c
> > @@ -252,10 +252,12 @@ bool
qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
> >
> >  #ifdef CONFIG_SOFTMMU
> >  static __thread struct qemu_plugin_hwaddr hwaddr_info;
> > +#endif
> >
> >  struct qemu_plugin_hwaddr
*qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
> >                                                    uint64_t vaddr)
> >  {
> > +#ifdef CONFIG_SOFTMMU
> >      CPUState *cpu =3D current_cpu;
> >      unsigned int mmu_idx =3D info >> TRACE_MEM_MMU_SHIFT;
> >      hwaddr_info.is_store =3D info & TRACE_MEM_ST;
> > @@ -267,14 +269,10 @@ struct qemu_plugin_hwaddr
*qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
> >      }
> >
> >      return &hwaddr_info;
> > -}
> >  #else
> > -struct qemu_plugin_hwaddr
*qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
> > -                                                  uint64_t vaddr)
> > -{
> >      return NULL;
> > -}
> >  #endif
> > +}
>
> Hmm I'm not sure about this, surely you want the plugin system to
> complain early if your plugin is going to use a function that is
> incorrect for the mode you are running in?
I merged these two function for couting how much function are exported, so
getting the code easier to review, otherwise
 function qemu_plugin_get_hwaddr   would be exported twice.
>
> Although we do currently unconditionally export the syscall functions
> and arguably they should be CONFIG_USER only as well.
>
> >
> >  bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
> >  {
>
>
> --
> Alex Benn=C3=A9e



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000008a5ab05b0ee39cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Oct 5, 2020 at 6:48 PM Alex Benn=C3=A9e &l=
t;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =
wrote:<br>&gt;<br>&gt;<br>&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyongga=
ng@gmail.com">luoyonggang@gmail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; Th=
is is used for counting how much function are export to qemu plugin.<br>&gt=
; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyo=
nggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &g=
t; =C2=A0plugins/api.c | 8 +++-----<br>&gt; &gt; =C2=A01 file changed, 3 in=
sertions(+), 5 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/plugins/=
api.c b/plugins/api.c<br>&gt; &gt; index f16922ca8b..d325084385 100644<br>&=
gt; &gt; --- a/plugins/api.c<br>&gt; &gt; +++ b/plugins/api.c<br>&gt; &gt; =
@@ -252,10 +252,12 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t i=
nfo)<br>&gt; &gt; <br>&gt; &gt; =C2=A0#ifdef CONFIG_SOFTMMU<br>&gt; &gt; =
=C2=A0static __thread struct qemu_plugin_hwaddr hwaddr_info;<br>&gt; &gt; +=
#endif<br>&gt; &gt; <br>&gt; &gt; =C2=A0struct qemu_plugin_hwaddr *qemu_plu=
gin_get_hwaddr(qemu_plugin_meminfo_t info,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint64_t vaddr)<br>&gt; &gt; =C2=A0{<br>&gt; &gt; +#ifdef =
CONFIG_SOFTMMU<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D current_c=
pu;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0unsigned int mmu_idx =3D info &gt;&gt;=
 TRACE_MEM_MMU_SHIFT;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0hwaddr_info.is_store=
 =3D info &amp; TRACE_MEM_ST;<br>&gt; &gt; @@ -267,14 +269,10 @@ struct qem=
u_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,<br>&gt;=
 &gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; <br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0=
return &amp;hwaddr_info;<br>&gt; &gt; -}<br>&gt; &gt; =C2=A0#else<br>&gt; &=
gt; -struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_=
t info,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t vaddr)<br>&gt; &gt=
; -{<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0return NULL;<br>&gt; &gt; -}<br>&gt; =
&gt; =C2=A0#endif<br>&gt; &gt; +}<br>&gt;<br>&gt; Hmm I&#39;m not sure abou=
t this, surely you want the plugin system to<br>&gt; complain early if your=
 plugin is going to use a function that is<br>&gt; incorrect for the mode y=
ou are running in?<div>I merged these two function for couting how much fun=
ction are exported, so getting the code easier to review, otherwise</div><d=
iv>=C2=A0function qemu_plugin_get_hwaddr=C2=A0 =C2=A0would be exported twic=
e.<br>&gt;<br>&gt; Although we do currently unconditionally export the sysc=
all functions<br>&gt; and arguably they should be CONFIG_USER only as well.=
<br>&gt;<br>&gt; &gt; <br>&gt; &gt; =C2=A0bool qemu_plugin_hwaddr_is_io(con=
st struct qemu_plugin_hwaddr *haddr)<br>&gt; &gt; =C2=A0{<br>&gt;<br>&gt;<b=
r>&gt; --<br>&gt; Alex Benn=C3=A9e<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--00000000000008a5ab05b0ee39cb--

