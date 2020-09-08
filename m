Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BD2206E7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BD2206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFXIy-0006dm-7X
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFXI6-0006Bb-9W
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:39:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFXI4-0006e7-JC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:39:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id t16so10019691edw.7
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 23:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ln1J6MYRR89KIgW3PkHU79U//d8wfT1fFVbaeffjpmc=;
 b=nhHuZuURVhC7GyTJyGHDnuuvgMv022IT0uC6F44QFqFDZwc7u4pfhhJykIC+BAmn9i
 Lmws9LXGLNdcYWtLkK27hgmvcUNoWz6NJcZ9MbSU0VEj17A/kT5LMX1KKPOm7m8jSNQD
 /sdINoMYeyvU9h8/6D+5uXYTR2zkawrqXS1UV6xCJ49mQsufnQKymUseCv8yBuXPxc3u
 hbqYdu+1N/jqjmdU02yfWp+RvWtVsYxSzzpo/5UZy30fktR8KQyCKAkV8QyhUHcDYawk
 PJyATqBYVyMvfbdjTDL6l7S8MQqinHmXv5iMeUabiDaJZTEi4GtWtjN2taMwiSfTLIHX
 EAAQ==
X-Gm-Message-State: AOAM5310g93vWtnRsyYkklklPXfzDLo9dYoEkgONai+Z7zd78PWdAFvn
 8vEUYnlXpYVvEOUig2GKoRmJVerLp+QI4okWXco=
X-Google-Smtp-Source: ABdhPJyvpl3HD12Sr3tjeYUG/TAHN7i2yXV6ngLS6C+KtkkrNDqdMy6cpTRdOMJ79sR5YxOdBhg46clHY4PDL+w1IU8=
X-Received: by 2002:a05:6402:114d:: with SMTP id
 g13mr24895250edw.157.1599547178284; 
 Mon, 07 Sep 2020 23:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200701182100.26930-1-philmd@redhat.com>
 <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
 <20200907203505.hpq5v32gayc5o5yd@mozz.bu.edu>
 <dfac2489-3c4a-aa44-c38b-435db5b0fd2c@redhat.com>
In-Reply-To: <dfac2489-3c4a-aa44-c38b-435db5b0fd2c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 8 Sep 2020 08:39:26 +0200
Message-ID: <CAAdtpL6i52airFP_p7Z5tBU-F3hYtbfv8_2=-QYbjt-NOnP6xQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005cfac805aec799a2"
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:39:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005cfac805aec799a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 8 sept. 2020 08:33, Paolo Bonzini <pbonzini@redhat.com> a =C3=A9cri=
t :

> On 07/09/20 22:35, Alexander Bulekov wrote:
> >>> RFC because I believe the correct fix is to NOT use current_cpu
> >>> out of cpus.c, at least use qemu_get_cpu(0) to get the first vCPU.
> >> Yes, I agree -- I don't think this is the correct fix.
> >> current_cpu is documented as "only valid inside cpu_exec()",
> >> ie if you're actually on a vcpu thread you can use it, but if
> >> you're not on a CPU thread, like the monitor, you need to
> >> say which vCPU you want to affect. For the monitor, that
> > Following up on this old thread.. Does qtest count as a pseudo-vCPU?
> > Since qtest already uses first_cpu for all of its address_space calls,
> > would it be appropriate to set current_cpu to first_cpu in qtest's
> > initialization?
>

qtest doesn't provide vCPU so first_cpu =3D NULL, that wouldn't help.


> No, current_cpu should never be set on non-vCPU threads.
>
> Paolo
>
>
>

--0000000000005cfac805aec799a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le mar. 8 sept. 2020 08:33, Paolo Bonzini &lt;<a href=3D"mailt=
o:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">On 07/09/20 22:35, Alexander Bulekov wr=
ote:<br>
&gt;&gt;&gt; RFC because I believe the correct fix is to NOT use current_cp=
u<br>
&gt;&gt;&gt; out of cpus.c, at least use qemu_get_cpu(0) to get the first v=
CPU.<br>
&gt;&gt; Yes, I agree -- I don&#39;t think this is the correct fix.<br>
&gt;&gt; current_cpu is documented as &quot;only valid inside cpu_exec()&qu=
ot;,<br>
&gt;&gt; ie if you&#39;re actually on a vcpu thread you can use it, but if<=
br>
&gt;&gt; you&#39;re not on a CPU thread, like the monitor, you need to<br>
&gt;&gt; say which vCPU you want to affect. For the monitor, that<br>
&gt; Following up on this old thread.. Does qtest count as a pseudo-vCPU?<b=
r>
&gt; Since qtest already uses first_cpu for all of its address_space calls,=
<br>
&gt; would it be appropriate to set current_cpu to first_cpu in qtest&#39;s=
<br>
&gt; initialization? <br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">qtest doesn&#39;t provide vCPU so first_cpu =3D NULL, =
that wouldn&#39;t help.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
No, current_cpu should never be set on non-vCPU threads.<br>
<br>
Paolo<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000005cfac805aec799a2--

