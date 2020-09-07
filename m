Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B28C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878CE208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH4m6H9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878CE208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLAy-0006xi-JC
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLAI-0006G8-W4; Mon, 07 Sep 2020 13:42:51 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLAH-00084x-C0; Mon, 07 Sep 2020 13:42:50 -0400
Received: by mail-lj1-x244.google.com with SMTP id c2so16919085ljj.12;
 Mon, 07 Sep 2020 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=CZaAXVEW7YBExCKkBSIOxTM0I72F5wNA8S5Lf7dJteA=;
 b=qH4m6H9tkDWHC+f25WUzXmLfaAA3EUwNlE+UUQzLSJ9HOdWx/pOwopkLUtHaqLdOWW
 l4nbyK1RV5sIi1W+IW1T8XXtUWhqbKylGADtfjVe+6Xv2qL1w1CWrxd4nlS89AV07zIB
 xigOt5SgWs7dp9fE8SqQcCWUOHtbtBJ2VgdTLuzHfgaPhsRWdFINUhA5grIb2kPFluHB
 a/J/LjRGjFXvMnxdKrCv83/Dhoy/9a7pWtxOvj4oEr35BFzeFWnWq/CvXHcW4rmvEB3A
 Kh0kvaxJsHL6hNr7XGoY/r/D/OI1eVEtBaym7bWKjbuVXLM1LI0p8uzIy19s8pKMp29U
 CWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=CZaAXVEW7YBExCKkBSIOxTM0I72F5wNA8S5Lf7dJteA=;
 b=RfiNoPr2jt6EgQWsx5d3M8dvuNHetxyPPrxsNKITNsrRquVn8JkGASemq3mpYgJNbd
 EcFbJuSnY6f0n2wkXJ7Ndo502tUm0jcJ9fOgAX2MDbHgIqa/+W/qAbcGkkIJnO4074dZ
 e1AQCEqX8ZlTgG5uQODNv0JOrwAyKBVKna+lwe1Owau0OwRGWC/bZI3Kt0SX5JksRZ/k
 TgxTlYjKoFyDVtjIA0DgauR+4O6V8u9V83D6zcGyLPVYeg6kipDuUBONNpylBxgLGs/f
 p3nJpZtlyeAZ/qC+0ZkuZUING0oAf4S2pzauSojNJ5C2PSgyrNkUKjpnIVzJK76H3svS
 m+iQ==
X-Gm-Message-State: AOAM532GZaXWYMySdtbxnJ3t88PQMRDDyAR/MeGEXMD2LrWUKC2F55Mj
 zBjdaZrBIJFSm2ASuZNqsz6tvqu1UR1YYzOTuKc=
X-Google-Smtp-Source: ABdhPJxGG26DF98n3lL6BwoVx1J1z5neYaweAizNM10Sguw7yGHzH5Qs2DqizCmPNxiJh1SJnAHRbIfd47rzzI24RoI=
X-Received: by 2002:a2e:2a83:: with SMTP id
 q125mr11363431ljq.242.1599500566452; 
 Mon, 07 Sep 2020 10:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200905062333.1087-1-luoyonggang@gmail.com>
 <20200905062333.1087-9-luoyonggang@gmail.com>
 <8d7357bc-518e-e408-bf56-32fcce8bb520@redhat.com>
In-Reply-To: <8d7357bc-518e-e408-bf56-32fcce8bb520@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 8 Sep 2020 01:42:34 +0800
Message-ID: <CAE2XoE_Th3ZnWcR=m5HOQtVpGzQHsUFfEcE3xKaTVPy=v6wdMw@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] osdep: These function are only available on
 Non-Win32 system.
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000014df5205aebcbfff"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000014df5205aebcbfff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2020 at 4:33 PM Thomas Huth <thuth@redhat.com> wrote:

> On 05/09/2020 08.23, Yonggang Luo wrote:
> > int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
> > int qemu_unlock_fd(int fd, int64_t start, int64_t len);
> > int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool
> exclusive);
> > bool qemu_has_ofd_lock(void);
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  include/qemu/osdep.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 412962d91a..e80fddd1e8 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -502,11 +502,11 @@ int qemu_close(int fd);
> >  int qemu_unlink(const char *name);
> >  #ifndef _WIN32
> >  int qemu_dup(int fd);
> > -#endif
> >  int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
> >  int qemu_unlock_fd(int fd, int64_t start, int64_t len);
> >  int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool
> exclusive);
> >  bool qemu_has_ofd_lock(void);
> > +#endif
> >
> >  #if defined(__HAIKU__) && defined(__i386__)
> >  #define FMT_pid "%ld"
> >
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Please also queue this


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000014df5205aebcbfff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2020 at 4:33 PM Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 05/09/2020=
 08.23, Yonggang Luo wrote:<br>
&gt; int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);<=
br>
&gt; int qemu_unlock_fd(int fd, int64_t start, int64_t len);<br>
&gt; int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusi=
ve);<br>
&gt; bool qemu_has_ofd_lock(void);<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/qemu/osdep.h | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h<br>
&gt; index 412962d91a..e80fddd1e8 100644<br>
&gt; --- a/include/qemu/osdep.h<br>
&gt; +++ b/include/qemu/osdep.h<br>
&gt; @@ -502,11 +502,11 @@ int qemu_close(int fd);<br>
&gt;=C2=A0 int qemu_unlink(const char *name);<br>
&gt;=C2=A0 #ifndef _WIN32<br>
&gt;=C2=A0 int qemu_dup(int fd);<br>
&gt; -#endif<br>
&gt;=C2=A0 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclus=
ive);<br>
&gt;=C2=A0 int qemu_unlock_fd(int fd, int64_t start, int64_t len);<br>
&gt;=C2=A0 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool e=
xclusive);<br>
&gt;=C2=A0 bool qemu_has_ofd_lock(void);<br>
&gt; +#endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #if defined(__HAIKU__) &amp;&amp; defined(__i386__)<br>
&gt;=C2=A0 #define FMT_pid &quot;%ld&quot;<br>
&gt; <br>
<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank">thuth@redhat.com</a>&gt;<br>
<br></blockquote><div>Please also queue this=C2=A0</div></div><br clear=3D"=
all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=
=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br>=
</div></div>

--00000000000014df5205aebcbfff--

