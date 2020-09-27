Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7460DC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 15:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82AF23718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKd7gTSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82AF23718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMYob-0005kJ-Im
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 11:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMYnF-00050n-94
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 11:40:53 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMYnD-00056D-2H
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 11:40:52 -0400
Received: by mail-lf1-x144.google.com with SMTP id z17so8201655lfi.12
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Aw/oXy0S5AryR+OMEPJcO+cPG+f+9XXPorESdZR4ImU=;
 b=hKd7gTSQO4VKg8unjNh0esFNZgrn3bKUXY5Tb3hziFN7qFeTcDQ5Dbj8jf9XlJVKR0
 axh7ImLvqgPjvh7zu2RtzgGOlVPouc8Csc68mZjCC45OUDo3w2huIVZc6h9yGEA43lKf
 ci/K41jthoeg+AWQUbQiSnIGPd+v4aVXkp/+8r4pX3GJWg6u4ZwLgzRVUCiq2+aDHeJE
 vJd96+DtJaLfogJPL1mDQjD43HwpZiW5t3cxmByw0iC4XrSAejojDEhHWbVlXBJyZxkQ
 fbNYBsXJRBKxrwlTu4iyP3JP09co68Z4UHWHLg/fmEhYi8Pyqmc8DDRqhFa5u8vUua9t
 /amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Aw/oXy0S5AryR+OMEPJcO+cPG+f+9XXPorESdZR4ImU=;
 b=mlBrThzu//hv4dfHnG+yMVcYgc/umZpcm6g5aGCiy1F3zm82FJ6vfv9F0YA68y1u/9
 0TP+Svfn6UxgeM1zYH0AzVUInaMC4EnINYlv2JdH6eMZapQyxSz12cQVnYT+tilYZ7kp
 jnNLmgcwvB4qA0CuYtPZ34uzgP6hFxfDPayba7X5+y9TJbG3FS4CcrkTkKs4zfk5Ss4i
 ZnrEtkU30E0/XgGpQCIIsTt2ymegvQXTXtma7jW0mlK2evHv0L75LAL5t5cc+MX2IlRQ
 w0iWtxoyW/ijCmp/fpIT9dX6Qn3nd43rGxLyx2m4ZjHMoMJk5aQ6pkAKnQMydRLCHAuj
 d+5A==
X-Gm-Message-State: AOAM531Vd5sd98qescIoeD8mEc2BbqNql1Y8SQOG0rEsRyXO6QmXeLhk
 rWNXKrPbdpubkL5EF9UnPM8k0cBmVbIMm8BAxAs=
X-Google-Smtp-Source: ABdhPJw0GSLSri4LwpjKTTbqc/Z+qhObU9EjAPNngJEhueA6hOznm3MS0DFnWEClwVv4iVDtEc5wFrniuf4XyXDvZgc=
X-Received: by 2002:a19:674f:: with SMTP id e15mr2372929lfj.50.1601221248025; 
 Sun, 27 Sep 2020 08:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200927081901.771-1-luoyonggang@gmail.com>
 <20200927081901.771-3-luoyonggang@gmail.com>
 <dd4e8591-c6cc-b86b-5103-c6f313d69f00@amsat.org>
In-Reply-To: <dd4e8591-c6cc-b86b-5103-c6f313d69f00@amsat.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 27 Sep 2020 23:40:37 +0800
Message-ID: <CAE2XoE-c9D2W6e+GD8ke-7xGtmfPEy7obrXjDCo4sEbeCKx=bQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] plugin: Fixes compiling errors on msys2/mingw
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000b2066205b04d5fb9"
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
 =?UTF-8?Q?Alex_Benn=E8=8C=85e?= <alex.bennee@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b2066205b04d5fb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2020 at 4:45 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:
>
> On 9/27/20 10:18 AM, Yonggang Luo wrote:
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  contrib/plugins/hotblocks.c | 2 +-
> >  tests/plugin/bb.c           | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> > index 3942a2ca54..37435a3fc7 100644
> > --- a/contrib/plugins/hotblocks.c
> > +++ b/contrib/plugins/hotblocks.c
> > @@ -102,7 +102,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id,
struct qemu_plugin_tb *tb)
> >  {
> >      ExecCount *cnt;
> >      uint64_t pc =3D qemu_plugin_tb_vaddr(tb);
> > -    unsigned long insns =3D qemu_plugin_tb_n_insns(tb);
> > +    size_t insns =3D qemu_plugin_tb_n_insns(tb);
> >      uint64_t hash =3D pc ^ insns;
> >
> >      g_mutex_lock(&lock);
> > diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> > index e4cc7fdd6e..de09bdde4e 100644
> > --- a/tests/plugin/bb.c
> > +++ b/tests/plugin/bb.c
> > @@ -72,7 +72,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void
*udata)
> >      CPUCount *count =3D max_cpus ?
> >          g_ptr_array_index(counts, cpu_index) : &inline_count;
> >
> > -    unsigned long n_insns =3D (unsigned long)udata;
> > +    uintptr_t n_insns =3D (uintptr_t)udata;
>
> Shouldn't this be:
>
>        uint64_t n_insns =3D (uint64_t)(uintptr_t)udata;
don't know, may i assmue  uintptr_t  <=3D  uint64_t , then that's not a pro=
lem
>
> ?
>
> >      g_mutex_lock(&count->lock);
> >      count->insn_count +=3D n_insns;
> >      count->bb_count++;
> > @@ -81,7 +81,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void
*udata)
> >
> >  static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb
*tb)
> >  {
> > -    unsigned long n_insns =3D qemu_plugin_tb_n_insns(tb);
> > +    size_t n_insns =3D qemu_plugin_tb_n_insns(tb);
> >
> >      if (do_inline) {
> >          qemu_plugin_register_vcpu_tb_exec_inline(tb,
QEMU_PLUGIN_INLINE_ADD_U64,
> >



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000b2066205b04d5fb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sun, Sep 27, 2020 at 4:45 PM Philippe Mathieu-D=
aud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wr=
ote:<br>&gt;<br>&gt; On 9/27/20 10:18 AM, Yonggang Luo wrote:<br>&gt; &gt; =
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">lu=
oyonggang@gmail.com</a>&gt;<br>&gt; &gt; Reviewed-by: Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>&g=
t; &gt; ---<br>&gt; &gt; =C2=A0contrib/plugins/hotblocks.c | 2 +-<br>&gt; &=
gt; =C2=A0tests/plugin/bb.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>=
&gt; &gt; =C2=A02 files changed, 3 insertions(+), 3 deletions(-)<br>&gt; &g=
t;<br>&gt; &gt; diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/=
hotblocks.c<br>&gt; &gt; index 3942a2ca54..37435a3fc7 100644<br>&gt; &gt; -=
-- a/contrib/plugins/hotblocks.c<br>&gt; &gt; +++ b/contrib/plugins/hotbloc=
ks.c<br>&gt; &gt; @@ -102,7 +102,7 @@ static void vcpu_tb_trans(qemu_plugin=
_id_t id, struct qemu_plugin_tb *tb)<br>&gt; &gt; =C2=A0{<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0ExecCount *cnt;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0uint64_t =
pc =3D qemu_plugin_tb_vaddr(tb);<br>&gt; &gt; - =C2=A0 =C2=A0unsigned long =
insns =3D qemu_plugin_tb_n_insns(tb);<br>&gt; &gt; + =C2=A0 =C2=A0size_t in=
sns =3D qemu_plugin_tb_n_insns(tb);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0uint64=
_t hash =3D pc ^ insns;<br>&gt; &gt; <br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0g_mu=
tex_lock(&amp;lock);<br>&gt; &gt; diff --git a/tests/plugin/bb.c b/tests/pl=
ugin/bb.c<br>&gt; &gt; index e4cc7fdd6e..de09bdde4e 100644<br>&gt; &gt; ---=
 a/tests/plugin/bb.c<br>&gt; &gt; +++ b/tests/plugin/bb.c<br>&gt; &gt; @@ -=
72,7 +72,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)=
<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0CPUCount *count =3D max_cpus ?<br>&gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ptr_array_index(counts, cpu_index) :=
 &amp;inline_count;<br>&gt; &gt; <br>&gt; &gt; - =C2=A0 =C2=A0unsigned long=
 n_insns =3D (unsigned long)udata;<br>&gt; &gt; + =C2=A0 =C2=A0uintptr_t n_=
insns =3D (uintptr_t)udata;<br>&gt;<br>&gt; Shouldn&#39;t this be:<br>&gt;<=
br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t n_insns =3D (uint64_t)(uintptr_=
t)udata;<div>don&#39;t know, may i assmue=C2=A0



uintptr_t=C2=A0 &lt;=3D=C2=A0

uint64_t , then that&#39;s not a prolem<br>&gt;<br>&gt; ?<br>&gt;<br>&gt; &=
gt; =C2=A0 =C2=A0 =C2=A0g_mutex_lock(&amp;count-&gt;lock);<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0count-&gt;insn_count +=3D n_insns;<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0count-&gt;bb_count++;<br>&gt; &gt; @@ -81,7 +81,7 @@ static void =
vcpu_tb_exec(unsigned int cpu_index, void *udata)<br>&gt; &gt; <br>&gt; &gt=
; =C2=A0static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_t=
b *tb)<br>&gt; &gt; =C2=A0{<br>&gt; &gt; - =C2=A0 =C2=A0unsigned long n_ins=
ns =3D qemu_plugin_tb_n_insns(tb);<br>&gt; &gt; + =C2=A0 =C2=A0size_t n_ins=
ns =3D qemu_plugin_tb_n_insns(tb);<br>&gt; &gt; <br>&gt; &gt; =C2=A0 =C2=A0=
 =C2=A0if (do_inline) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu=
_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,<br>&gt=
; &gt;<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000b2066205b04d5fb9--

