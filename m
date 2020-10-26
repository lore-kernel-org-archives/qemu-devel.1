Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE64C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8997A20773
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLE8yP6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8997A20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9hC-0003X9-4e
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 17:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kX9fp-0002iD-Bo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:05:01 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:45273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kX9fl-0005cZ-Kp
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 17:05:01 -0400
Received: by mail-lj1-x235.google.com with SMTP id a4so11900230lji.12
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=5To1xcAEvuNaP7uA7RHYWK6HjXN1EQ1i2An/gNEEmz8=;
 b=jLE8yP6rTVrb2VWfCcXt7mgkZcekwzv95pqxzyCGHPMO7fX1poe5mcPPQceKACDFw9
 eVoIyBz2k3OxqUOzyf+5hhQzELnOf5xFuwpgkwjiQxJgKY+Dn9jb59gbsjswiYPjqVn3
 wp0Hqp2HLjlSyVgqVuf6oYjdjCZ9ezG5mq7sDGMZumK3nTI23KZqOIu5sdMCPfaCS2NI
 TNFdklxUcgjBFHHd0atGcdnPnLIUig74DASlXsNXpsFfhZcGhqwOV2ZUC0JGN6nvX7rS
 z4Q/dKUVUZPu4xdb3x5r6it436mTxWJM/ekOaDw2LTski3V6VpEFqJ0z7w0Sp12Mblje
 maLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=5To1xcAEvuNaP7uA7RHYWK6HjXN1EQ1i2An/gNEEmz8=;
 b=M88J3vfrU4tVwDFURoHDnRtZQKUJhujInOuJ2XTpXW2fO9yBX/RQIGi/fOFpbxkGH3
 pm3C5h/CgyjW4k2qMMe7UMPj+wITdoGfaBuhAQKkEryauuXbo5A+xsd7bCGWOeazaIi6
 QwmDd2GWHT5y+JJZxmoO882XakQ9XryATRAytaYI06uHpbKsgY4AFqq5X3z+QrRaDotT
 tBZk3sqQqt5YZtK7ENhAIvpNM+q0eS6AfCH3B6F5y3YIdQQBXu2uiMPK53m+daiG1Xon
 oqxXrU96jw0FbpF80Knm1lFYuc3308WCQzHq1BLTGVbknF31x51y8Kzpm5URS/9X0Sko
 cbTQ==
X-Gm-Message-State: AOAM532MyxQyuUsBcNOiq2FskUhl/9R6hgEBz9A4qkESMv1adNnyajpB
 5LbOKH59iOyHOK9Xk7FfFY0NYJkYcYW4akYjlgc=
X-Google-Smtp-Source: ABdhPJyw1v81R2y/rv6O+KlugKSTb4Uj5OsWLHzTdw1ASbXtr05cDsw7EkhMMme203/vLNeekN6av+7P5DXA1xReaNc=
X-Received: by 2002:a05:651c:1b6:: with SMTP id
 c22mr7294155ljn.447.1603746295556; 
 Mon, 26 Oct 2020 14:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201026135131.3006712-1-pbonzini@redhat.com>
 <CAFEAcA-WscaYcpooMQ0F2Etc+Rzf5M=Bb-b9Dw7pGsaaO8Od=g@mail.gmail.com>
 <CAE2XoE9AvG-G70Rm5S=q+Xz3C2_VVGdL6DHXme=ZFPU+OOwQng@mail.gmail.com>
 <CABgObfaWBLrx6nsZktbDw7PC4_L5_HQKKUF+HGLSwVRMrK+_mQ@mail.gmail.com>
In-Reply-To: <CABgObfaWBLrx6nsZktbDw7PC4_L5_HQKKUF+HGLSwVRMrK+_mQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 27 Oct 2020 05:04:44 +0800
Message-ID: <CAE2XoE9=gHOy-gwwDbSd6UABt8F9_N5zeymXK3G3ORVUvWNnzQ@mail.gmail.com>
Subject: Re: [PULL 00/17] Build system changes and misc fixes for QEMU 5.2
 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000041b07005b29948e2"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x235.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000041b07005b29948e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 4:58 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il lun 26 ott 2020, 19:59 =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoy=
onggang@gmail.com> ha
scritto:
>>
>> This pull request confused me, the windows msys2 build time slow down
from 40min to more than one hour.
>
>
> Probably just the cache being rebuilt. Cirrus CI times seem to vary a lot
but 40min and 1h5min seem to be the common cases before or after these
changes:
>
> https://cirrus-ci.com/task/5531259461959680
> With this PR: 35+2 (build+test)
>
> https://cirrus-ci.com/task/4570682912669696
> With this PR: 10+4
>
> https://cirrus-ci.com/task/6662289128423424
> With this PR: 35+2, +20 to rebuild cirrus cache
>
> https://cirrus-ci.com/task/5383432727429120
> Without this PR: 30+2, +18 to rebuild cirrus cache
>
> Paolo
That's correct, cirrus's building time are not stable. My own build are
already passed.
https://cirrus-ci.com/task/5357017537708032, if the cache are works, then
it's definitely won't exceed the time


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000041b07005b29948e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 27, 2020 at 4:58 AM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt;<br>&gt;<br>&gt; Il lun 26 ott 2020, 19:59 =E7=BD=97=E5=8B=87=
=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyon=
ggang@gmail.com</a>&gt; ha scritto:<br>&gt;&gt;<br>&gt;&gt; This pull reque=
st confused me, the windows msys2 build time slow down from 40min to more t=
han one hour.<br>&gt;<br>&gt;<br>&gt; Probably just the cache being rebuilt=
. Cirrus CI times seem to vary a lot but 40min and 1h5min seem to be the co=
mmon cases before or after these changes:<br>&gt;<br>&gt; <a href=3D"https:=
//cirrus-ci.com/task/5531259461959680">https://cirrus-ci.com/task/553125946=
1959680</a><br>&gt; With this PR: 35+2 (build+test)<br>&gt;<br>&gt; <a href=
=3D"https://cirrus-ci.com/task/4570682912669696">https://cirrus-ci.com/task=
/4570682912669696</a><br>&gt; With this PR: 10+4<br>&gt;<br>&gt; <a href=3D=
"https://cirrus-ci.com/task/6662289128423424">https://cirrus-ci.com/task/66=
62289128423424</a><br>&gt; With this PR: 35+2, +20 to rebuild cirrus cache<=
br>&gt;<br>&gt; <a href=3D"https://cirrus-ci.com/task/5383432727429120">htt=
ps://cirrus-ci.com/task/5383432727429120</a><br>&gt; Without this PR: 30+2,=
 +18 to rebuild cirrus cache<br>&gt;<br>&gt; Paolo<div>That&#39;s correct, =
cirrus&#39;s building time are not stable. My own build=C2=A0are already pa=
ssed.<br><a href=3D"https://cirrus-ci.com/task/5357017537708032">https://ci=
rrus-ci.com/task/5357017537708032</a>, if the cache are works, then it&#39;=
s definitely=C2=A0won&#39;t exceed the time<br><br><br>--<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=
=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--00000000000041b07005b29948e2--

