Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68351C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7862072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2VLl+V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7862072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxGf-0000aW-9P
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jIxFQ-0007u7-7X
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jIxFP-00045q-5G
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:26:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jIxFO-00041u-Up
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:26:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id s1so22429260wrv.5
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hipaFijxDpWnJJLB9FttQE4iVLVI5yEayDwAAUiqp4I=;
 b=S2VLl+V0mmVhHXyvO0/cWUBmRuXsiV51ycvbpAicA39UiwF5wigSTQ9RoEvQ/iJqBY
 iyR/sqEGZdgah/zehloAWXbMo9aQ0S2XWfBmcOeXl1wLDUBJg3DJJpmouYPYrG2t4uZ3
 f6qUu7zl77d6ZIE/Gd8Le1GwHMURK7I1/VxKmECnpEKr/mbXoooP0jvVemqkBsbBkCtv
 NzULaCi8Mv/WeVU4rNw0vNhPL7hzyQe99jC+y68RWmK0tjjGlyFDasZctCUMu000CN/M
 +zSwHeQzNSpcPjRx9r4IrWu92Q8fMYBSgKCqbokbpF376BY7S9xQaadsz8zY32H/JrWj
 uNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hipaFijxDpWnJJLB9FttQE4iVLVI5yEayDwAAUiqp4I=;
 b=lHndlXRSt1eUrev2/84IOh1JkotH2e7lDwyX1ullHggTKVSQQNOEI8FvwMRExUDZ+O
 /SUb2zh+NlfiT5Bdg8QJP8J83rfksJjL6eqXy0CVHny1RtDOp1Idiv2H75MjfcXg9yQi
 7ljc+9eLAH0GCTST1Fc4E6zN7xjhn0ae7DPXLnJpC5ngWK34hF0EqbD/oPP4nuXIs+r5
 jgTNKa5Mnw7KWZ1pLVSylJk4bSgQ85sUSevtYgGthJmP+2+KgGwz67ILvPX5cynKquwG
 lMLBxvO0aDkjKsahtm1MqX/8+P7PKwHKK5ecE0AXwBvhsTU1gwi+dLsPL2BMdMq5gBDf
 /d2w==
X-Gm-Message-State: ANhLgQ0rI15pWqsS+7OCD+DeGKzwh8CrH/jZd38sn6MwgamCvuJwZjaT
 08/zzuuvHn8MelpqoA+iJiVRhfEi1RTmUTqqNT8=
X-Google-Smtp-Source: ADFU+vtDmegPXC5OLEOmrU2juJJCeDMeHEGvryDBTFYAqjuwOBZiCXbcaBxhji6ASlmVLdBYotMBkjB1EjAmIgHQmd8=
X-Received: by 2002:adf:e282:: with SMTP id v2mr15651301wri.329.1585585602073; 
 Mon, 30 Mar 2020 09:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
In-Reply-To: <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 30 Mar 2020 18:25:27 +0200
Message-ID: <CAHiYmc7ga5Kaxg_Wi6TMu+E-HErUHZE94naynkMoFRDirFVP0g@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000092990405a214ea5f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000092990405a214ea5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

15:32 Pon, 30.03.2020. Peter Maydell <peter.maydell@linaro.org> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Consensus in the thread seemed to lean towards having
> the 'configure/make' runes auto-create a build directory;
> if we want to do that we should probably not say anything in
> the release notes, because we'll cause people to change
> unnecessarily. Or at least have them say "We recommend
> out-of-tree builds. In future we might make the commands
> that currently do an in-tree build automatically create
> and use a build directory for you." rather than a blanket
> "we're going to drop this and you should change what you
> do now".
>

My vote is for the former, rather than for the latter. I fact, if I may
suggest, I would use some longer and stronger wording, just for the simple
reason that the warning is less likely to be ignored (as Zoltan, I think
rightfully, noted to potentially be quite frequent case in reality):

"We strongly recommend
out-of-tree builds. In future we might make the commands that currently do
an in-tree build automatically create and use a separate build directory
for you. Still, our recommentation is that you change all your build
procedures to use only out-of-tree builds as soon as it is possible for
you."

Regards,
Aleksandar

> Thoughts?
>
> thanks
> -- PMM
>

--00000000000092990405a214ea5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">15:32 Pon, 30.03.2020. Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Consensus in the thread seemed to lean towards having<br>
&gt; the &#39;configure/make&#39; runes auto-create a build directory;<br>
&gt; if we want to do that we should probably not say anything in<br>
&gt; the release notes, because we&#39;ll cause people to change<br>
&gt; unnecessarily. Or at least have them say &quot;We recommend<br>
&gt; out-of-tree builds. In future we might make the commands<br>
&gt; that currently do an in-tree build automatically create<br>
&gt; and use a build directory for you.&quot; rather than a blanket<br>
&gt; &quot;we&#39;re going to drop this and you should change what you<br>
&gt; do now&quot;.<br>
&gt;</p>
<p dir=3D"ltr">My vote is for the former, rather than for the latter. I fac=
t, if I may suggest, I would use some longer and stronger wording, just for=
 the simple reason that the warning is less likely to be ignored (as Zoltan=
, I think rightfully, noted to potentially be quite frequent case in realit=
y):</p>
<p dir=3D"ltr">&quot;We strongly recommend<br>
out-of-tree builds. In future we might make the commands that currently do =
an in-tree build automatically create and use a separate build directory fo=
r you. Still, our recommentation is that you change all your build procedur=
es to use only out-of-tree builds as soon as it is possible for you.&quot; =
</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; Thoughts?<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br>
&gt;<br>
</p>

--00000000000092990405a214ea5f--

