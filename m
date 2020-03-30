Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 23:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03778206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 23:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRWO9ND9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03778206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ3qV-0002Ns-6Q
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 19:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jJ3po-0001yq-Bf
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jJ3pm-0004He-P3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:28:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jJ3pm-0004FH-Id
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:28:46 -0400
Received: by mail-wr1-x436.google.com with SMTP id w10so23805788wrm.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Ks/386OvziPkqnKHk5rTYeo1esNZ66a1dynQcQujVM=;
 b=sRWO9ND9bzrG1jsuTBSQk77UhFIUFOfbXjuEm5d/WUrO/s+SAOtIC3ppB40uaHgeCC
 OW1o94Q9LPjK+G9zT1Jeqx3I9uttV0Z15EteWT3perjMOsf92GFaC75+1mydALceB6Au
 kikKTe53Hchdxs4qgmxJa60CvlkZVsyzevFZ23qqX+bIiaTyNbBGJWbGKV3qkd865QZl
 5wRU9T6ThkSkFQ5+BC8PH80F9OT5sNfGS6zi66O8RHrcmWQ4UgPS4COkctgs8icKYLAT
 VPy9NJFVbW0kXn+Y6ed9Yk/v9T6asmzlh9WIIi+ZXPMCpxuVfJg6BKSuWzFOlkjQSr1Y
 S8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Ks/386OvziPkqnKHk5rTYeo1esNZ66a1dynQcQujVM=;
 b=dOIXQsUwbtIdYQSPSfeXSZG04wkTrkfdbAW8yue+QYNx/1/l/OdxLBrXpD1rFlA51c
 DTu0fEpoGTq80vcEXAItI4XbhcDdbpuLBd27P/kWN+fTDG4JOxPWBUZEf99YwQONTMC4
 UAnOOKIsMV0FVq9EEhQ8vnMenHdwGxAAtufN4Bxos+yNPpxbaaLzks6OVNZG5Tsnjx6p
 2Rf+FBuhsfw0AfjrR1a5ZedV8rmGY/Pe0ujFXDrhhkbS8kqEp3hkNPIT6hGtWFvm05Sp
 cOe1hIt6Krk/7Bi+UaNPgoB71cdegu1YQMNS1k6GQZz5cnHjISJAsd6haWSgZ9ijfMvY
 AVzQ==
X-Gm-Message-State: ANhLgQ1KibOaSHS6KLRq/nQ+H62qU2KViK9OYVFAC4lEW04DL7kUi7wy
 /vt2Jd3Tqp7oZ9J4gjdEUz3W8CKCLEchnH2QPq0=
X-Google-Smtp-Source: ADFU+vv+T4vO7kXH3OXkoNNvBrukI96aqXbcwgPVCyDqXEHyxlVXCizdYq+EWPnAJr1uYH5aaWtdXkWZM0YxrAZfGYI=
X-Received: by 2002:a5d:65c4:: with SMTP id e4mr16215425wrw.147.1585610925341; 
 Mon, 30 Mar 2020 16:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200330121345.14665-1-f4bug@amsat.org>
 <ed9ac5c8-0654-3c74-3e35-5d7b02a548b6@twiddle.net>
 <18ac6d57-049e-4b45-0c9e-27190d832b50@twiddle.net>
In-Reply-To: <18ac6d57-049e-4b45-0c9e-27190d832b50@twiddle.net>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 31 Mar 2020 01:28:29 +0200
Message-ID: <CAHiYmc5xTGEw6b0gVXmbHhNO_WH30hK8+mAErmL0S6rB9Oa=Jg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0?] decodetree: Use Python3 floor division operator
To: Richard Henderson <rth@twiddle.net>
Content-Type: multipart/alternative; boundary="000000000000f4ff3905a21acf25"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f4ff3905a21acf25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

20:47 Pon, 30.03.2020. Richard Henderson <rth@twiddle.net> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 3/30/20 10:14 AM, Richard Henderson wrote:
> > On 3/30/20 5:13 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> This script started using Python2, where the 'classic' division
> >> operator returns the floor result. In commit 3d004a371 we started
> >> to use Python3, where the division operator returns the float
> >> result ('true division').
> >> To keep the same behavior, use the 'floor division' operator "//"
> >> which returns the floor result.
> >>
> >> Fixes: 3d004a371
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >> We didn't notice it because only the RX port (which uses the
> >> --varinsnwidth option, and got merged very recently) triggers
> >> these problems.
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>  scripts/decodetree.py | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Queued to tcg-next for 5.0.
>

Richard, great, could you please pick up the LMI patch from the other day
together with this patch in your tcg-5.0 queue?

Yours, Aleksandar

>
> r~
>
>

--000000000000f4ff3905a21acf25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">20:47 Pon, 30.03.2020. Richard Henderson &lt;<a href=3D"mail=
to:rth@twiddle.net">rth@twiddle.net</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 3/30/20 10:14 AM, Richard Henderson wrote:<br>
&gt; &gt; On 3/30/20 5:13 AM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt;&gt; This script started using Python2, where the &#39;classic&#39=
; division<br>
&gt; &gt;&gt; operator returns the floor result. In commit 3d004a371 we sta=
rted<br>
&gt; &gt;&gt; to use Python3, where the division operator returns the float=
<br>
&gt; &gt;&gt; result (&#39;true division&#39;).<br>
&gt; &gt;&gt; To keep the same behavior, use the &#39;floor division&#39; o=
perator &quot;//&quot;<br>
&gt; &gt;&gt; which returns the floor result.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Fixes: 3d004a371<br>
&gt; &gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt; We didn&#39;t notice it because only the RX port (which uses =
the<br>
&gt; &gt;&gt; --varinsnwidth option, and got merged very recently) triggers=
<br>
&gt; &gt;&gt; these problems.<br>
&gt; &gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 scripts/decodetree.py | 4 ++--<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; &gt;&gt;<br>
&gt; &gt; <br>
&gt; &gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.hend=
erson@linaro.org">richard.henderson@linaro.org</a>&gt;<br>
&gt;<br>
&gt; Queued to tcg-next for 5.0.<br>
&gt;</p>
<p dir=3D"ltr">Richard, great, could you please pick up the LMI patch from =
the other day together with this patch in your tcg-5.0 queue?</p>
<p dir=3D"ltr">Yours, Aleksandar</p>
<p dir=3D"ltr">&gt;<br>
&gt; r~<br>
&gt;<br>
&gt;<br>
</p>

--000000000000f4ff3905a21acf25--

