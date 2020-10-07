Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C3C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF63920797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw8N41GT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF63920797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5Fq-0004ku-O2
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ5Dh-0002pr-EC; Wed, 07 Oct 2020 04:54:45 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ5Df-00041D-II; Wed, 07 Oct 2020 04:54:45 -0400
Received: by mail-lj1-x244.google.com with SMTP id 133so1193823ljj.0;
 Wed, 07 Oct 2020 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=WUm6kk3l/nP+LeFH6oczXVPLfb8g8NLzOSbVsoR97Mg=;
 b=Bw8N41GTGskphmMDpgLviUkZF2xcZrjlak4j4YqTspUucjGY722goymH4tvC3jYOCL
 76yoryZTGgsDjcJaGV2zzhVp/Uwa/IbxTIyT7buyF5htBgENHIZkxzPEeOy2O7ZE6zKa
 gXHc5TV2+Smwt2f3kqllWsejfWk5zavd5dT80TS9ImbDSVi1BaVWm2vGl2itvcdrCX/L
 96jM9pChE5UbZ/sz70w90VqUZ1sVEIEWiBT7WgGU59mFqQXlYdiB1jNgE+1v94Ma/j/R
 4qyGhMvbZV4Sja83O1eT6JWy8OVyobcHju58plohpuTnTplCbCKYbCD5DKw39VYYgAc+
 x8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=WUm6kk3l/nP+LeFH6oczXVPLfb8g8NLzOSbVsoR97Mg=;
 b=msnNO+MDX2nyiphLi9xXRyrBct18Z+cxFkUMrVgimEwSv4HNuyHPXYuZAVRbJZhy/q
 vcajKxW7w5qUu5vMbA0zQx4ZUsixXXmHcqK18E/GXCmvV+2KOY1atcdV69hrx9gW3oDg
 mYY2uGSXle5oSmceDTW3E35zY1X8Yhc3T2ySX9wDV3sOaseYujXEcQUzJV12VA9XPgMi
 /0+zj3SXOJBGpXIX+PZUmEc1G3kY3Aprde/XuF0a/AFXvIeT35UV4qiyADLUtIA4CsSr
 tyBzOLxYiffhBbw7cRQBQ4jyt5CSlvEyr2Or+dzqGDRqewcfUS4gXJAoXM3zIBK0dSuB
 JQRQ==
X-Gm-Message-State: AOAM530QCtFaQNkFxHVWemMXwlkkhtuG3erZtq60nOnFGYhi/iRqBjmB
 xjZnZqLbhO01Wpd+mL6xyCKlT2uObfYHY6AN6qA=
X-Google-Smtp-Source: ABdhPJwUALn7Wgbr5wbZAmxFM4V+nyPN7ItEucd+1e+b5MC1H7KkIYkd5OVYJtwY7hUWjzZJhE6WigI9Kqgn54IkDnE=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr918997ljj.447.1602060881435;
 Wed, 07 Oct 2020 01:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201007035154.109-1-luoyonggang@gmail.com>
 <20201007035154.109-3-luoyonggang@gmail.com>
 <6b4528dc-918d-ebf4-db27-cbd67fa96c11@redhat.com>
 <90b2011a-3e58-1e91-d603-89e099162426@redhat.com>
In-Reply-To: <90b2011a-3e58-1e91-d603-89e099162426@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2020 16:54:29 +0800
Message-ID: <CAE2XoE_okx+xQKsroYOfduqUMgiXoSX4dCMcuyO8+7Oh=3_XoA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cirrus: Fixing and speedup the msys2/mingw CI
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bf21ae05b110dd76"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-level <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bf21ae05b110dd76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2020 at 4:41 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 07/10/2020 10.18, Paolo Bonzini wrote:
> [...]
> >
> > On top of this, whoever commits this needs to replace the URL with
> > something under download.qemu.org, but that's the easy part.
>
> I agree with Daniel - please let's not get go this way again. We've had
this
> with the various Free-/Net-/OpenBSD images in the past, and then we were
> suddenly stuck with a fixed image where most people were not able to
change
> it anymore. That was very frustrating.
>
> Apart from that, you also have to respect the GPL if you provide binaries
> ... so you'd need to gather all the sources for that blob, too, and be
ready
> to provide those in case somebody asks...
>
> Yonggang, could you please try to use the caching mechanism of Cirrus-CI
> instead? See https://cirrus-ci.org/guide/writing-tasks/#cache-instruction
> ... then we're a little bit more independent from downloading the msys2
for
> each CI run.
Looks good for me, let's me investigate
>
>  Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000bf21ae05b110dd76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Oct 7, 2020 at 4:41 PM Thomas Huth &lt;<a =
href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<br=
>&gt; On 07/10/2020 10.18, Paolo Bonzini wrote:<br>&gt; [...]<br>&gt; &gt;<=
br>&gt; &gt; On top of this, whoever commits this needs to replace the URL =
with<br>&gt; &gt; something under <a href=3D"http://download.qemu.org">down=
load.qemu.org</a>, but that&#39;s the easy part.<br>&gt;<br>&gt; I agree wi=
th Daniel - please let&#39;s not get go this way again. We&#39;ve had this<=
br>&gt; with the various Free-/Net-/OpenBSD images in the past, and then we=
 were<br>&gt; suddenly stuck with a fixed image where most people were not =
able to change<br>&gt; it anymore. That was very frustrating.<br>&gt;<br>&g=
t; Apart from that, you also have to respect the GPL if you provide binarie=
s<br>&gt; ... so you&#39;d need to gather all the sources for that blob, to=
o, and be ready<br>&gt; to provide those in case somebody asks...<br>&gt;<b=
r>&gt; Yonggang, could you please try to use the caching mechanism of Cirru=
s-CI<br>&gt; instead? See <a href=3D"https://cirrus-ci.org/guide/writing-ta=
sks/#cache-instruction">https://cirrus-ci.org/guide/writing-tasks/#cache-in=
struction</a><br>&gt; ... then we&#39;re a little bit more independent from=
 downloading the msys2 for<br>&gt; each CI run.<div>Looks good for me, let&=
#39;s me investigate<br>&gt;<br>&gt; =C2=A0Thomas<br>&gt;<br><br><br>--<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div></div>

--000000000000bf21ae05b110dd76--

