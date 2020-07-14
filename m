Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E3C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B08208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QqE226mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B08208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHH3-0000DJ-2S
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1jvHG3-0007fc-Ba
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:29:51 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129]:38727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1jvHG1-0000jX-HL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:29:50 -0400
Received: by mail-il1-x129.google.com with SMTP id s21so13636005ilk.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oPmkdE+zc2+GjrlXsy9ODR/8Lc9uiZVuGXNh5QlR1oI=;
 b=QqE226mtZmPg0IdnSp2Un9mqUEva4mi9XopuHA7kJBT9ZLMK/y0EURkw4X5WwmUJwX
 YNeQLUWlyIRZFb7z0ilIVbXxLL7wPmXcUHm2LVTU0K5SeaAzX5wTut/IOWPY0TvUdhQi
 kwCZu3k+Mta4uvpxzPnBFMJTgpdhXptvzGyT/QeCZr0pfhSFqzun6fg0PX6T7uAUS5Jj
 oTkJ43/nDRrBaWCaCSIM7SPN+khikPm6pd6SfIq7E3kRVw2SLKzL9PxNqtkABLT27YFC
 4S5kshm+YCCs9LIdb/6ctfhTthJ7oC/oL738/Agu5miovkfJ9sQXMcyICZfhZPwpE9cT
 4bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oPmkdE+zc2+GjrlXsy9ODR/8Lc9uiZVuGXNh5QlR1oI=;
 b=OxERf+9P7VpucVPWcXUN0v9Ust5OHLahf7WKG0izG+UsS+lAgekLvgxiIKxxVXIxuo
 SYZYQyfZeKm7IlzI44OWrQpHJoE7SNZyFI0NrB7LPPGD9ujXiT1uRDMYiHHU5kbwRZcP
 /19nJkamaBdrFdHGpNeQgPuWMnxQnGaX0b1NgCuzCxmyn4e2g3tQBjS7YBlfy8fms7fI
 P1CHzyTsn6SzS3gFZsMVNrIgRJRnG7xtHvVxyndNU5vy65cJ3TMS81cFfWaWlnPqioLV
 donPlCFFV33ZEq+4CXLtgKJt7VQga5za0nU1BTvflqBCTywrhB0JwC2u2XuW/ujRM++q
 Nmpg==
X-Gm-Message-State: AOAM533636bY9RQ6Aql4InPjlzumEx3t5BImC4q29AoGQxrR9AgxfiDG
 qWfuSAAFvAuK9b0d0yel8V4ihk51hzBveSFQHsslPg==
X-Google-Smtp-Source: ABdhPJwljZ5irwVV7hquoutSKbQgcQv9qOHro189BBXyNiUz3+0jP78OnTlDTYtyFttu3rHI0PxFY/Z5OEQN7DyZcLk=
X-Received: by 2002:a92:840b:: with SMTP id l11mr3848839ild.129.1594718988251; 
 Tue, 14 Jul 2020 02:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-64-frank.chang@sifive.com> <87eepjlfri.fsf@linaro.org>
 <87blknlfn5.fsf@linaro.org>
In-Reply-To: <87blknlfn5.fsf@linaro.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 14 Jul 2020 17:29:37 +0800
Message-ID: <CAEiOBXUyjx9WAA+awxQ9h_QP4Y_X8-NAiaYDZh_ro_Lp6QkHTg@mail.gmail.com>
Subject: Re: [RFC 63/65] fpu: implement full set compare for fp16
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cfcfac05aa637228"
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=chihmin.chao@sifive.com; helo=mail-il1-x129.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Frank Chang <frank.chang@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Kito Cheng <kito.cheng@sifive.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cfcfac05aa637228
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 8:26 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > frank.chang@sifive.com writes:
> >
> >> From: Kito Cheng <kito.cheng@sifive.com>
> >>
> >> Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
> >> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> >> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> >
> > NACK I'm afraid. What's wrong with the exiting float_compare support?
> >
> > Even if you did want to bring in aliases for these functions within
> > softfloat itself the correct way would be to use the decomposed
> > float_compare support for a bunch of stubs and not restore the old styl=
e
> > error prone bit masking code.
>
> In fact see the example float32_eq inline function in the softfloat.h
> header.
>
> --
> Alex Benn=C3=A9e
>

Hi Alex,

Thanks for the suggestion of using wrong and old implementation and this
part will be refined in next separated softfloat PR.

Thanks
Chih-Min Chao

--000000000000cfcfac05aa637228
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><br></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jul 10, 2020 at 8:26 PM Alex Benn=C3=A9e &l=
t;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_b=
lank">alex.bennee@linaro.org</a>&gt; writes:<br>
<br>
&gt; <a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chan=
g@sifive.com</a> writes:<br>
&gt;<br>
&gt;&gt; From: Kito Cheng &lt;<a href=3D"mailto:kito.cheng@sifive.com" targ=
et=3D"_blank">kito.cheng@sifive.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Kito Cheng &lt;<a href=3D"mailto:kito.cheng@sifive.=
com" target=3D"_blank">kito.cheng@sifive.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Chih-Min Chao &lt;<a href=3D"mailto:chihmin.chao@si=
five.com" target=3D"_blank">chihmin.chao@sifive.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifiv=
e.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; NACK I&#39;m afraid. What&#39;s wrong with the exiting float_compare s=
upport?<br>
&gt;<br>
&gt; Even if you did want to bring in aliases for these functions within<br=
>
&gt; softfloat itself the correct way would be to use the decomposed<br>
&gt; float_compare support for a bunch of stubs and not restore the old sty=
le<br>
&gt; error prone bit masking code.<br>
<br>
In fact see the example float32_eq inline function in the softfloat.h heade=
r.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br></blockquote><div><br></div><div>Hi Alex,</div><div><br=
></div><div>Thanks for the suggestion of using wrong and old implementation=
 and this part will be refined in next separated softfloat PR.</div><div><b=
r></div><div>Thanks</div><div>Chih-Min Chao</div></div></div>

--000000000000cfcfac05aa637228--

