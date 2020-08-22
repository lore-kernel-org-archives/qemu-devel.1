Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E55C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 10:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F6B20714
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 10:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDSGpCUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F6B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9R5V-0004kF-2f
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 06:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k9R4v-0004L0-5z
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 06:48:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k9R4t-0006C4-Cf
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 06:48:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so4178308wrw.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=6yGsDrMoFEoK+cWTwTXqhVtUcXTflF8R636kqJaklnk=;
 b=cDSGpCUintaiOwqmoaoqn7raa3ZE2K781Gs29EsP//1x4/0km4cFmmML4uVmCh3iaf
 E2UvzWrOG3hgIqOIzhYxSO9NnYPM+pp2+VzK1MWTK5qPTLxz+7isb3DGCULP2Qblovxj
 HFsUZ7U/bV7o+1OBXTgtcw6BhEGwOnIHrqsXNQaOZyoCRqDlIue5dBIqV3+xjiaHftW8
 wom8Ph/Z4uTug8k1VYRo5WCLgOUvS28iTxl0SlTBNz19tRBIIpLw8a5oV3G0S7lDKV+E
 +bQgqN/7DiAnKHb2ay7a1gmjOt3yTAF0DDFU9i1FTNuminWCg3ub6JU3seBsUsacFKyC
 QhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=6yGsDrMoFEoK+cWTwTXqhVtUcXTflF8R636kqJaklnk=;
 b=GYO3simAW0dHhIqfPRKF5eq0EPIlR2Iqu08l1FIgrUMdM6wC20Itxpa1tGTtaOAiO5
 LS5tnFEs3WV8LZ34RVm9NMBAFJ021igBX3iawlxtQ0lqofQVQHbakPo7h6S4Fid3FUt9
 U+U/36wKHAy2eK600zu/iC/3HyB7fB4N7HJt4dqQYP35+kTzqzZz57lizyZkuTZnnm+k
 XfNfcuzOEm+B882mFbWVPhBXgrkRd7nB+YN0iAJh47/+3mAmr9JmBUb+RJX0id3IlELI
 ntKCEvrAil3PlfHQPe5vfmFZ1biXV+ld9rpX4IKrhuG+W8gb/KVRwVQmmiOTbYd7IHXC
 gs7Q==
X-Gm-Message-State: AOAM530nGKD8lOJ/YvzSQjBslsd7AVL5uyq64sMlPu3mXrKOLnL0dc5o
 VJyW3OU2JVXct9qKZMfO78MDbl/HXT7KsWbpCbg=
X-Google-Smtp-Source: ABdhPJxoeO8py2+mxdBD3kliXEzdw0HRvA5eVd8ueuhB6SBt03spBc+75Ax01XenALB6YTgbnALdXvPMUdlYCC4ekiA=
X-Received: by 2002:adf:e550:: with SMTP id z16mr6615603wrm.329.1598093329668; 
 Sat, 22 Aug 2020 03:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:2489:0:0:0:0:0 with HTTP; Sat, 22 Aug 2020 03:48:49
 -0700 (PDT)
In-Reply-To: <9cd49239-a7db-c229-8cf4-fd6ac8faaaa4@vivier.eu>
References: <20200821222830.91463-1-carenas@gmail.com>
 <9cd49239-a7db-c229-8cf4-fd6ac8faaaa4@vivier.eu>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 22 Aug 2020 12:48:49 +0200
Message-ID: <CAHiYmc6=1vh5jrxuq+HuzJdFFygrwSpF=WF1+U92Sd3zsKExZg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: warn if trying to use qemu-mipsn32[el] with
 non n32 ELF
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000003ba28005ad7519aa"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Maciej W. Rozycki" <macro@linux-mips.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003ba28005ad7519aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, August 22, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 22/08/2020 =C3=A0 00:28, Carlo Marcelo Arenas Bel=C3=B3n a =C3=A9crit =
:
> > While technically compatible will (depending on the CPU) hopefully fail
> > later with a cryptic error:
> >
> >   qemu: Unexpected FPU mode
> >
> > Provide an earlier hint of what the problem might be by detecting if th=
e
> > binary might not be using the n32 ABI and print a warning.
> >
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > ---
> >  linux-user/elfload.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index fe9dfe795d..64c3921cd9 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -2390,6 +2390,13 @@ static void load_elf_image(const char
> *image_name, int image_fd,
> >      if (!elf_check_ehdr(ehdr)) {
> >          goto exit_errmsg;
> >      }
> > +#ifdef TARGET_ABI_MIPSN32
> > +/* from arch/mips/include/asm/elf.h */
> > +#define EF_MIPS_ABI2 0x00000020
>
> This is already defined in include/elf.h
>
> > +    if (!(ehdr->e_flags & EF_MIPS_ABI2)) {
> > +        fprintf(stderr, "warning: ELF binary missing n32 flag\n");
>
> I think an exit would be more appropriate:
>
>     errmsg =3D "warning: ELF binary missing n32 flag";
>     goto exit_errmsg;
>

Carlo, Laurent,

I agree with both Laurent's remarks above.

At the same time, I also support the spirit of Carlo's patch - but please,
Carlo, if possible, send the v2 that is going to address Laurent's concerns=
.

Moreover, Carlo, please consider doing more cleanup in this area. For
example, is the case "attempt passing n32 executable to non-n32 qemu"
handled in a user-friendly manner? What about "passing 64-bit executable to
32-bit qemu"? What about opposite endians? Are all user visible messages
clear and appropriate? Could you do a thourough analysis in this area?
There are 36 combinations (6x6, given 6 mips supported ABIs).

I would prefer a complete solution for all these mips combinations
"executable vs qemu" in linux user. Perhaps you can send a series of
patches on this topic, this one being, let's say, just the first one in
that series.

Yours,
Aleksandar




> > +    }
> > +#endif
> >
> >      i =3D ehdr->e_phnum * sizeof(struct elf_phdr);
> >      if (ehdr->e_phoff + i <=3D BPRM_BUF_SIZE) {
> >
>
> CC'ing mips maintainers (and Maciej as he sent a patch on the N32 topic
> 2 years ago...)
>
> Thanks,
> Laurent
>
>

--0000000000003ba28005ad7519aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, August 22, 2020, Laurent Vivier &lt;<a href=3D"mailto:=
laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Le 22/08/2020 =C3=A0 00:28, Carlo Marcelo Arenas Bel=C3=B3n a =
=C3=A9crit=C2=A0:<br>
&gt; While technically compatible will (depending on the CPU) hopefully fai=
l<br>
&gt; later with a cryptic error:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0qemu: Unexpected FPU mode<br>
&gt; <br>
&gt; Provide an earlier hint of what the problem might be by detecting if t=
he<br>
&gt; binary might not be using the n32 ABI and print a warning.<br>
&gt; <br>
&gt; Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n &lt;<a href=3D"mailto:c=
arenas@gmail.com">carenas@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/elfload.c | 7 +++++++<br>
&gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt; <br>
&gt; diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
&gt; index fe9dfe795d..64c3921cd9 100644<br>
&gt; --- a/linux-user/elfload.c<br>
&gt; +++ b/linux-user/elfload.c<br>
&gt; @@ -2390,6 +2390,13 @@ static void load_elf_image(const char *image_na=
me, int image_fd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!elf_check_ehdr(ehdr)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit_errmsg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +#ifdef TARGET_ABI_MIPSN32<br>
&gt; +/* from arch/mips/include/asm/elf.h */<br>
&gt; +#define EF_MIPS_ABI2 0x00000020<br>
<br>
This is already defined in include/elf.h<br>
<br>
&gt; +=C2=A0 =C2=A0 if (!(ehdr-&gt;e_flags &amp; EF_MIPS_ABI2)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;warning: ELF binary=
 missing n32 flag\n&quot;);<br>
<br>
I think an exit would be more appropriate:<br>
<br>
=C2=A0 =C2=A0 errmsg =3D &quot;warning: ELF binary missing n32 flag&quot;;<=
br>
=C2=A0 =C2=A0 goto exit_errmsg;<br></blockquote><div><br></div><div>Carlo, =
Laurent,</div><div><br></div><div>I agree with both Laurent&#39;s remarks a=
bove.</div><div><br></div><div>At the same time, I also support the spirit =
of Carlo&#39;s patch - but please, Carlo, if possible, send the v2 that is =
going to address Laurent&#39;s concerns.</div><div><br></div><div>Moreover,=
 Carlo, please consider doing more cleanup in this area. For example, is th=
e case &quot;attempt passing n32 executable to non-n32 qemu&quot; handled i=
n a user-friendly manner? What about &quot;passing 64-bit executable to 32-=
bit qemu&quot;? What about opposite endians? Are all user visible messages =
clear and appropriate? Could you do a thourough analysis in this area? Ther=
e are 36 combinations (6x6, given 6 mips supported ABIs).</div><div><br></d=
iv><div>I would prefer a complete solution for all these mips combinations =
&quot;executable vs qemu&quot; in linux user. Perhaps you can send a series=
 of patches on this topic, this one being, let&#39;s say, just the first on=
e in that series.</div><div><br></div><div>Yours,</div><div>Aleksandar</div=
><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 i =3D ehdr-&gt;e_phnum * sizeof(struct elf_phdr);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ehdr-&gt;e_phoff + i &lt;=3D BPRM_BUF_SIZE) {<=
br>
&gt; <br>
<br>
CC&#39;ing mips maintainers (and Maciej as he sent a patch on the N32 topic=
<br>
2 years ago...)<br>
<br>
Thanks,<br>
Laurent<br>
<br>
</blockquote>

--0000000000003ba28005ad7519aa--

