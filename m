Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781B7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB17207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qagQuQVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB17207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKee-0006up-PU
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKd3-0005s6-LM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:58:21 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:44488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKd1-0007b0-RS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:58:21 -0400
Received: by mail-lf1-x12e.google.com with SMTP id b1so1719199lfp.11
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=EQCFiLPqy54cOc4oNxB+VqAY0JVPe8TM66pw9MySVYc=;
 b=qagQuQVuMh6R8680yM6vTMqc+FyJbzreoHIlTFNljJN/UlRAPKoj4M05I5Q7XYc1ir
 dk/NIhqoYCrPRINw6vR/J/pZMtMrftzS3sJpZe+ET9jeAb7rCLQjzBQJsKzURAMDgtHr
 YpKukwiJy+vLhBsj7uRmKFz74obevL8ZtnLXdj5fMo/nhvo8F9OII8WRKsITx+8SZMXb
 u0B9+cjK+gtCmdFErIXxpFzUKMRzLYnhjz5u9XLtSP/kH+61kuj+qH5M5dFrZNLfjciq
 qLwN0942qWPw6ilQ45Bb+s07/LQ2HBh6C6kVaCM6yTR4kTRvIho72J2LaWm9QQ/4K8DN
 41IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=EQCFiLPqy54cOc4oNxB+VqAY0JVPe8TM66pw9MySVYc=;
 b=dQi0wyVD02JqPOZbdVjb9N8FGf223YkQHoQhIhF1kxf7LSncVIpWNju2GwxGdHelG5
 y1uyZULSY9e1M+Qq3nAm2c9myrMS+nZrFZgPhoUufvr+l8Z6y9Jhz6z382EZMg19W5IL
 kGzORrF/x08oyBlyEHE3OJyjaWEIyWFhLRxeoS8ZbXJrLoGkEskXFnPvIesYiAa84b0g
 xLy9cCpyE8HyS0s+/l0XUmik157V0ZZddPPPMIptDFvVLPvBCPtMy4WbfSKhKOSta4/j
 SzDYNgvYsoYQjt63pj+l11Fw1rYRFLvIJbIIkkyr4e/0O3i+aK0TmkMAib7AROAZA1/C
 sFdQ==
X-Gm-Message-State: AOAM5332CiPd+8wgZAae5TT11lR0nZQ4HnfruXlAkMU8CmVqYSrX4K0N
 mHR8mImKl+pGhYZjnf/Fb/sYow4zX3xXebZFflQ=
X-Google-Smtp-Source: ABdhPJwdxaawhz/E7zj1fndK3SoAwKIpG4L02jQVl9Catn8KQdEyXIQD4cHoHA+h5fXpRkWk4sij4oH+xxHUkEaiGq8=
X-Received: by 2002:a19:f819:: with SMTP id a25mr794973lff.382.1602835097423; 
 Fri, 16 Oct 2020 00:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201015220626.418-1-luoyonggang@gmail.com>
 <20201015220626.418-4-luoyonggang@gmail.com>
 <9bd01bce-7409-26f9-5401-8f5ddd4f924c@redhat.com>
 <CAE2XoE9EvboWrqMp_SD0BJ+=D3JjXUeL22qaZD=G5R+M0c4Npg@mail.gmail.com>
 <4d0c598d-84c4-b760-790b-f2041bf3066e@redhat.com>
In-Reply-To: <4d0c598d-84c4-b760-790b-f2041bf3066e@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 15:58:06 +0800
Message-ID: <CAE2XoE-Y_DkEtzgu0RUmXEzcWaXNZOeWKsFisH3cU_b2PQCPVA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] meson: Move the detection logic for sphinx to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009d951905b1c52094"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12e.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009d951905b1c52094
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 3:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 16/10/20 09:52, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >> build_docs =3D false
> >> if sphinx_build.found()
> >>   # This is a bit awkward but works: create a trivial document and
> >>   # try to run it with our configuration file (which enforces a
> >>   # version requirement). This will fail if sphinx-build is too old.
> >>   run_command('mkdir', ['-p', tmpdir / 'sphinx'])
> >>   run_command('touch', [tmpdir / 'sphinx/index.rst'])
> >>   sphinx_build_test_out =3D run_command(SPHINX_ARGS + [
> >>     '-c', meson.current_source_dir() / 'docs',
> >>     '-b', 'html', tmpdir / 'sphinx',
> >>     tmpdir / 'sphinx/out'])
> >>   build_docs =3D (sphinx_build_test_out.returncode() =3D=3D 0)
> >> endif
> > There is subtle error here, when  sphinx_build not found, there is
> > SPHINX_ARGS  should be [],
> > otherwise, latter place using  SPHINX_ARGS  have not found sphinx_build
> > will cause error by meson
> > ..
> > I'll add
> >
> > else
> >   SPHINX_ARGS  =3D []
> > endif
>
> All uses of SPHINX_ARGS are protected by build_docs, and in turn
> build_docs is false if "not sphinx_build.found()".  Am I missing
something?
Not all protected, missed in qapi/schema tests
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000009d951905b1c52094
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 16, 2020 at 3:57 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 16/10/20 09:52, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 wrote:<br>&gt; &gt;<br>&gt; &gt;&gt; build_docs =3D false<br>&gt; &gt;&gt;=
 if sphinx_build.found()<br>&gt; &gt;&gt; =C2=A0 # This is a bit awkward bu=
t works: create a trivial document and<br>&gt; &gt;&gt; =C2=A0 # try to run=
 it with our configuration file (which enforces a<br>&gt; &gt;&gt; =C2=A0 #=
 version requirement). This will fail if sphinx-build is too old.<br>&gt; &=
gt;&gt; =C2=A0 run_command(&#39;mkdir&#39;, [&#39;-p&#39;, tmpdir / &#39;sp=
hinx&#39;])<br>&gt; &gt;&gt; =C2=A0 run_command(&#39;touch&#39;, [tmpdir / =
&#39;sphinx/index.rst&#39;])<br>&gt; &gt;&gt; =C2=A0 sphinx_build_test_out =
=3D run_command(SPHINX_ARGS + [<br>&gt; &gt;&gt; =C2=A0 =C2=A0 &#39;-c&#39;=
, meson.current_source_dir() / &#39;docs&#39;,<br>&gt; &gt;&gt; =C2=A0 =C2=
=A0 &#39;-b&#39;, &#39;html&#39;, tmpdir / &#39;sphinx&#39;,<br>&gt; &gt;&g=
t; =C2=A0 =C2=A0 tmpdir / &#39;sphinx/out&#39;])<br>&gt; &gt;&gt; =C2=A0 bu=
ild_docs =3D (sphinx_build_test_out.returncode() =3D=3D 0)<br>&gt; &gt;&gt;=
 endif<br>&gt; &gt; There is subtle error here, when =C2=A0sphinx_build not=
 found, there is<br>&gt; &gt; SPHINX_ARGS =C2=A0should be [],<br>&gt; &gt; =
otherwise, latter place using =C2=A0SPHINX_ARGS =C2=A0have not found sphinx=
_build<br>&gt; &gt; will cause error by meson<br>&gt; &gt; ..<br>&gt; &gt; =
I&#39;ll add<br>&gt; &gt;<br>&gt; &gt; else<br>&gt; &gt; =C2=A0 SPHINX_ARGS=
 =C2=A0=3D [] =C2=A0<br>&gt; &gt; endif<br>&gt;<br>&gt; All uses of SPHINX_=
ARGS are protected by build_docs, and in turn<br>&gt; build_docs is false i=
f &quot;not sphinx_build.found()&quot;.=C2=A0 Am I missing something?<div>N=
ot all protected, missed in qapi/schema tests<br>&gt;<br>&gt; Paolo<br>&gt;=
<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=
=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerel=
y,<br>Yonggang Luo</div></div>

--0000000000009d951905b1c52094--

