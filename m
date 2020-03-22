Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEE8C1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6309720722
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgterhDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6309720722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG7UD-0007S5-HM
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 16:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jG7TS-00072K-3h
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jG7TQ-0006Sm-T8
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:45:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:32980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jG7TQ-0006SX-KE
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:45:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id a25so14427199wrd.0
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jeyki5JShoyTKH4jDq5slm6Y+jJT8tNYOQAhNhsq3Oo=;
 b=VgterhDrAQg1Y3nOFbIFAUd6ftI/avB6tI3td8Ft93c3nSEVn6IYuHmq4uQi+yEzV/
 a3Fz4gb3daNO0X9RvTKNT8oYSmINHcyu2Ipwdvy2St7O/scf/uN5lKh6NlJpgaTMQXlp
 Jx0jbCWg0k102zfUshYik3sAH+Ri9q30BtWT7hCVhU53jZgQXjMkaQRD2Oak42W2Igg4
 zwDYjY0idu2E4rca7AU7m4UsZkSum2ZiXmJfY9Fu/DuRFgz16/32SNKuJsPCjLQmWw8c
 eUQ5GVkUh/ntqeoG4/1fg4mAqee34+NT4pbItiG97LFvnudtDTOmZwr6Esn7ovFrtR/F
 8yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jeyki5JShoyTKH4jDq5slm6Y+jJT8tNYOQAhNhsq3Oo=;
 b=gBKkl1uAOsqnUtSH4LjUs06dh63cUuGWLbibC6VpSSiUrHOq7r+IUfTK3uQmYjzGy1
 HtYtbRw5lbAVUj/0ZON0MNUu1JJNBm9AmQN+HZ2Rxbfv3kFMyz3zq5oRH51NKJ+HMP3S
 q96aLIXiUAtSKuivfHkOioLnjDUIwDjITcyQ9mQ4TuvbWcVL7/VVRg5t7kdLscIGzIjT
 eeOF4qaP+ty/fzaPF3hnVD3kPYTIRj4C+pIEwaFMGx6KdwBkit34sRrIA7Z1ysvOsLcS
 ytDBWd8Xp1wWOMDTRx3smqgf8IeJJyPQO7J4CxlqK7IkXr+MVn6fYrnkDDIfWy3JiC5e
 mOgA==
X-Gm-Message-State: ANhLgQ2X1vIou6awLP68ymYDF7yr65t8k5DjnNt4QimIc3dqdYhkI6cX
 YZ3y0mt8dSM3FSWWHmmNW8GdpQEJ13m64QeRk0Q=
X-Google-Smtp-Source: ADFU+vt6Wtc+yIeaAdlcKEBADW1AaGIgWPOLkjJqQQ1Diy/4/oZMSdzdt+NAd1ZQjZ+QABP89fesGKTtZm83PcunyrU=
X-Received: by 2002:adf:ba48:: with SMTP id t8mr25523205wrg.329.1584909931018; 
 Sun, 22 Mar 2020 13:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
 <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
 <CAHiYmc4Qv4yL8LMp_nFqx20bq-hRO-umh5R899H6hdSyKrpNBA@mail.gmail.com>
 <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
In-Reply-To: <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 22 Mar 2020 21:45:12 +0100
Message-ID: <CAHiYmc4V3z5NogeKM0NowCXcL=ny7MsNoQqfRZsX_D3Yv2hNHA@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000707c5105a1779944"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000707c5105a1779944
Content-Type: text/plain; charset="UTF-8"

21:14 Ned, 22.03.2020. Peter Maydell
> *Everything* is supposed to work in out of tree builds.
> If it doesn't that's a bug -- unless people report bugs
> we'll never know to fix them. Most developers use out
> of tree builds and all our CI is out of tree builds, so
> they actually get better ad-hoc and CI coverage than
> in-tree. Out-of-tree is overwhelmingly what we build and
> what we test, so it's in-tree that breaks more often and
> where I'd expect to find more things we didn't realise
> were broken.
>
> To be clear, I'm not saying we should pull the rug out
> from anybody. I'm saying:
>  * we should clearly say what our plans are, with a
>    long warning if we can reasonably give longer warning
>  * if there's anything that we would accidentally
>    be breaking with those plans, we should adjust the
>    plans so we don't break things we didn't mean to break
>
> This doesn't seem controversial to me...
>

OK, given all info you presented in last paragraphs and elsewhere - that
seems to have more emphasis on potential adjustments, and the obligatory
condition that nothing breaks - I agree with the approach you spelled out,
or, in other words, agree with introducing deprecation note.

I hope that we all perceive occasional differences in opinions as our value
(and, I even claim, a key to success of any dev community), and not a
nuisance or a danger.

Thanks! :)

Regards,
Aleksandar

> thanks
> -- PMM

--000000000000707c5105a1779944
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">21:14 Ned, 22.03.2020. Peter Maydell <br>
&gt; *Everything* is supposed to work in out of tree builds.<br>
&gt; If it doesn&#39;t that&#39;s a bug -- unless people report bugs<br>
&gt; we&#39;ll never know to fix them. Most developers use out<br>
&gt; of tree builds and all our CI is out of tree builds, so<br>
&gt; they actually get better ad-hoc and CI coverage than<br>
&gt; in-tree. Out-of-tree is overwhelmingly what we build and<br>
&gt; what we test, so it&#39;s in-tree that breaks more often and<br>
&gt; where I&#39;d expect to find more things we didn&#39;t realise<br>
&gt; were broken.<br>
&gt;<br>
&gt; To be clear, I&#39;m not saying we should pull the rug out<br>
&gt; from anybody. I&#39;m saying:<br>
&gt; =C2=A0* we should clearly say what our plans are, with a<br>
&gt; =C2=A0 =C2=A0long warning if we can reasonably give longer warning<br>
&gt; =C2=A0* if there&#39;s anything that we would accidentally<br>
&gt; =C2=A0 =C2=A0be breaking with those plans, we should adjust the<br>
&gt; =C2=A0 =C2=A0plans so we don&#39;t break things we didn&#39;t mean to =
break<br>
&gt;<br>
&gt; This doesn&#39;t seem controversial to me...<br>
&gt;</p>
<p dir=3D"ltr">OK, given all info you presented in last paragraphs and else=
where - that seems to have more emphasis on potential adjustments, and the =
obligatory condition that nothing breaks - I agree with the approach you sp=
elled out, or, in other words, agree with introducing deprecation note.</p>
<p dir=3D"ltr">I hope that we all perceive occasional differences in opinio=
ns as our value (and, I even claim, a key to success of any dev community),=
 and not a nuisance or a danger.</p>
<p dir=3D"ltr">Thanks! :)</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; thanks<br>
&gt; -- PMM<br>
</p>

--000000000000707c5105a1779944--

