Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C4C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8229922265
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOEu+VQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8229922265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsiq-00073t-AX
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQsh8-0005Yy-NV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:44:26 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQsh6-0001GT-FO
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:44:26 -0400
Received: by mail-lj1-x243.google.com with SMTP id c21so9642032ljn.13
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=USSVvBNNed8aibMHgrDmRiw30tDpUDYMDioOmGbvOi8=;
 b=EOEu+VQe3M5Li2fF6UFmzWnOqisUZ6v7tx96TXwPZlmrThEEYHBH0LijLPkrO+jTkk
 iTDsxKW4xcj7gENUJCF1PiKMDdVbNyWGn97yaQZFQeIsMucsNA/i26VPe9pQuTmiX8hh
 XdwJVp4igeC0j8AatIV5oahTyWvseL9ZsnhfoAzXg2P8oukWo+tE8utXsJZZF4OXp+pR
 0QzPGBdiI7oiM18/eKKGn/rlvpEGhF0xnU6yp6lU02BJpra+rgqw4dnBHS1sSMMRJ0qO
 5PqF88LR5eGK92ywTLxhF8jTb6xE6/Gvncmo45uMaHovMaF07WJVjnmM/0/A5LedgX1x
 /RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=USSVvBNNed8aibMHgrDmRiw30tDpUDYMDioOmGbvOi8=;
 b=LJ0PqhBBTPdZwBM4aHv2YGq8NgkmayZD1hutWEeSEKgNYjNNuM6MQIN6TFGsVuHQpa
 jMcD69sjNWXiNyn8RLk2CVAYJdvTlSSTYEFfx4T29yUxTgIUkVDdxFxdTDzqSmH2VFIo
 +bGFFX1uZWvg1SFni5+MMBvYsWLT12sWoxPRWTwxHW0PqvjdAB9RIp9eaY1ZG4zhWlTD
 N3wbzdu+4EcFFhS2ddPGCEGKi2PMRdbmGHZo6vAzNlSdBnnLXx9hk3InsDplLVtwy+nH
 /T899mq1ezmHz5ey9IVoAMo/aSmFM3zZ91oyDet6ydYEZgZgJu28DoHhEnYOAPH8o5ri
 hEeg==
X-Gm-Message-State: AOAM530brMuRiPuSUkSAL/xrz17nWNFjpB2gI9+5LOffqM28/ij8vZYz
 SPXOOderQCI0O7wOBE7mU4BUKXLhLCZTN1psxxk=
X-Google-Smtp-Source: ABdhPJyLnVpEUsQ7mcGcnzjUFnJ5+d2sSRCUD6+o59O2tO0JD/Ee4w2pt7uy8BwPAR2NNUF6HPKDyLoPf+822mpVXVo=
X-Received: by 2002:a2e:87c9:: with SMTP id v9mr1082878ljj.368.1602251062684; 
 Fri, 09 Oct 2020 06:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE9YyZwRr5j3fCATTb32pacuGrT_yUBoUTd30k+id1D3iw@mail.gmail.com>
 <27f82fe6-5b0f-7e35-29d9-7b00ae8f189e@redhat.com>
 <20201009133840.GA25901@redhat.com>
In-Reply-To: <20201009133840.GA25901@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2020 21:44:11 +0800
Message-ID: <CAE2XoE8BaJQd4uYxNHoc1h_2_gV5sQRrFrWqc-X0LFG=QU0zQQ@mail.gmail.com>
Subject: Re: How about using clang-format instead checkpatch for fixing style?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006eae6005b13d2563"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006eae6005b13d2563
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2020 at 9:38 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:
>
> On Fri, Oct 09, 2020 at 03:25:04PM +0200, Paolo Bonzini wrote:
> > On 09/10/20 15:02, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > > We can even using clang-format to format the whole repository.
> >
> > checkpatch does other checks than formatting.
> >
> > Reformatting the whole repository has been mentioned many times, people
> > were worried of messing up the result of "git blame".  But without doin=
g
> > that, it's hard to get rid of checkpatch because checkpatch only looks
> > at the lines that are touched by the patch.
>
> It is a no-win situation.
>
> checkpatch.pl is code that makes people run away screaming in horror,
> because who really wants to look at Perl code that tries to parse C
> code with regexes. The fact that you can submit a patch and get
> complaints about things you didn't actually change is a poor experiance,
> especially for new contributors who will wonder what they did wrong.
>
> Certain subsystem maintainers have done bulk cleanups for pieces of
> code before, most notably culling tabs. So we have taken the pain
> a little before. I presume we'll continue to periodically clean
> code.
>
> Aside from the git blame pain, there will also be a period of time
> when cherry-picking patches back to old versions will be tediously
> conflicting, potentially forcing cherr-picking of the style cleanup
> patches too. If the cleanup patches are fine grained it might not
> be too terrible though.
>
> So we have pain with current state and we have pain with use of
> clang-format. The difference is the current pain is long term
> ongoing pain, while the clang-format pain will be an initial
> hit whose impact will slowly fade over time.
>
> Personally I think it would be worth the change in the long
> term. I should really put my money where my mouth is though and
> propose it for libvirt too.
When the repository getting bigger and bigger, a automatically formatter
are more
and more needed,
LLVM/Chrome(Blink)/Rust and may big project are already using formatter,
python also did that, qemu are getting bigger and bigger everyday.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
https://www.instagram.com/dberrange :|
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006eae6005b13d2563
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 9, 2020 at 9:38 PM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Fri, Oct 09, 2020 at 03:25:04PM +0200, Paolo B=
onzini wrote:<br>&gt; &gt; On 09/10/20 15:02, =E7=BD=97=E5=8B=87=E5=88=9A(Y=
onggang Luo) wrote:<br>&gt; &gt; &gt; We can even using clang-format to for=
mat the whole repository.<br>&gt; &gt;<br>&gt; &gt; checkpatch does other c=
hecks than formatting.<br>&gt; &gt;<br>&gt; &gt; Reformatting the whole rep=
ository has been mentioned many times, people<br>&gt; &gt; were worried of =
messing up the result of &quot;git blame&quot;.=C2=A0 But without doing<br>=
&gt; &gt; that, it&#39;s hard to get rid of checkpatch because checkpatch o=
nly looks<br>&gt; &gt; at the lines that are touched by the patch.<br>&gt;<=
br>&gt; It is a no-win situation.<br>&gt;<br>&gt; <a href=3D"http://checkpa=
tch.pl">checkpatch.pl</a> is code that makes people run away screaming in h=
orror,<br>&gt; because who really wants to look at Perl code that tries to =
parse C<br>&gt; code with regexes. The fact that you can submit a patch and=
 get<br>&gt; complaints about things you didn&#39;t actually change is a po=
or experiance,<br>&gt; especially for new contributors who will wonder what=
 they did wrong.<br>&gt;<br>&gt; Certain subsystem maintainers have done bu=
lk cleanups for pieces of<br>&gt; code before, most notably culling tabs. S=
o we have taken the pain<br>&gt; a little before. I presume we&#39;ll conti=
nue to periodically clean<br>&gt; code.<br>&gt;<br>&gt; Aside from the git =
blame pain, there will also be a period of time<br>&gt; when cherry-picking=
 patches back to old versions will be tediously<br>&gt; conflicting, potent=
ially forcing cherr-picking of the style cleanup<br>&gt; patches too. If th=
e cleanup patches are fine grained it might not<br>&gt; be too terrible tho=
ugh.<br>&gt;<br>&gt; So we have pain with current state and we have pain wi=
th use of<br>&gt; clang-format. The difference is the current pain is long =
term<br>&gt; ongoing pain, while the clang-format pain will be an initial<b=
r>&gt; hit whose impact will slowly fade over time.<br>&gt;<br>&gt; Persona=
lly I think it would be worth the change in the long<br>&gt; term. I should=
 really put my money where my mouth is though and<br>&gt; propose it for li=
bvirt too.<div>When the repository getting bigger and bigger, a automatical=
ly formatter are more</div><div>and more needed,=C2=A0</div><div>LLVM/Chrom=
e(Blink)/Rust and may big project are already using formatter,</div><div>py=
thon also did that, qemu are getting bigger and bigger everyday.<br>&gt;<br=
>&gt; Regards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <a href=3D"https://berr=
ange.com">https://berrange.com</a> =C2=A0 =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a =
href=3D"https://www.flickr.com/photos/dberrange">https://www.flickr.com/pho=
tos/dberrange</a> :|<br>&gt; |: <a href=3D"https://libvirt.org">https://lib=
virt.org</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<a href=3D"https://fstop138.berrange.com">https://fstop138.ber=
range.com</a> :|<br>&gt; |: <a href=3D"https://entangle-photo.org">https://=
entangle-photo.org</a> =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a href=3D"https://www=
.instagram.com/dberrange">https://www.instagram.com/dberrange</a> :|<br>&gt=
;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=
=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerel=
y,<br>Yonggang Luo</div></div>

--0000000000006eae6005b13d2563--

