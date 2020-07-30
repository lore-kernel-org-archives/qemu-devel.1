Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1338C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7568C2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7568C2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16Oe-0004YP-KI
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k16No-0003zg-Bx; Thu, 30 Jul 2020 07:05:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k16Nm-00027p-JU; Thu, 30 Jul 2020 07:05:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id c15so9971059edj.3;
 Thu, 30 Jul 2020 04:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vwqD+Czhv6mTzpo2HX6+cQ/cC7MrcIZyKswxU9LhogM=;
 b=k79NlUo6l7+HSEQD8OMcZ1oun0ADAxJ0XCj6/WexsfXtdOOZQc3HhVIw2+1hGwPvSM
 VEoX0U2tqBdBhR1yPgdl3oG5xGaKyui2znKsrmDcUA49scPeDNkXfZgEvRDux/zo+AVe
 lwYdKFa8G97btpit5XA8lamEiS/xh6SDbuvlI05c/+Fnkh8KgTHtdOlbd22BR+7ZRkC2
 klVoi6JftxWVE9SJb50sEWi68cZYz7IXW0KlTZzGrNWEy/VZ5vO4Qusn/L0E4YVU0q5l
 sFORkY7F3QuiIHe696ANOmBbsYP7dsfrvb/nkID0Pt/PaDYRCpjU29dwUyJcZ3WDfWrD
 Nq2Q==
X-Gm-Message-State: AOAM533tTx5+baTL4AGurHr7NUTrYa+OAkP9efZkJbIN/ek+q81T/ZkK
 TBS31nmNL/fx97lUBD4/YoO7SBp7m7vXIBMPZls=
X-Google-Smtp-Source: ABdhPJxD8zUPFMgIAkRDqpwM1aDuANw5ve6LlbysaNo9wauiSMNwqKPPiYyymScOHTL/As0ow6K81WmnbESTba/dZng=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr1993173edj.93.1596107152259; 
 Thu, 30 Jul 2020 04:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <878sf3uojf.fsf@morokweng.localdomain>
 <20200730005947.GO84173@umbus.fritz.box>
In-Reply-To: <20200730005947.GO84173@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 30 Jul 2020 13:05:39 +0200
Message-ID: <CAAdtpL5Mtaf7Xwu74U33eGTCAiFZNNXeCST8COwQeW8S9j8ZVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: multipart/alternative; boundary="000000000000d57f5505aba6a7ae"
Received-SPF: pass client-ip=209.85.208.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 07:05:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d57f5505aba6a7ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 30 juil. 2020 03:00, David Gibson <david@gibson.dropbear.id.au> a
=C3=A9crit :

> On Tue, Jul 28, 2020 at 09:56:36PM -0300, Thiago Jung Bauermann wrote:
> >
> > Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> >
> > > The ARM code has a start-powered-off property in ARMCPU, which is a
> > > subclass of CPUState. This property causes arm_cpu_reset() to set
> > > CPUState::halted to 1, signalling that the CPU should start in a halt=
ed
> > > state. Other architectures also have code which aim to achieve the sa=
me
> > > effect, but without using a property.
> > >
> > > The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
> > > before cs->halted is set to 1, causing the vcpu to run while it's
> still in
> > > an unitialized state (more details in patch 3).
> >
> > Since this series fixes a bug is it eligible for 5.1, at least the
> > patches that were already approved by the appropriate maintainers?
>
> Ok by me.
>

Maybe just the arm generalization and ppc fix for 5.1, delaying all not
bugfix to 5.2?


> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>

--000000000000d57f5505aba6a7ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le jeu. 30 juil. 2020 03:00, David Gibson &lt;<a href=3D"mailt=
o:david@gibson.dropbear.id.au">david@gibson.dropbear.id.au</a>&gt; a =C3=A9=
crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Jul 28, 2020 at=
 09:56:36PM -0300, Thiago Jung Bauermann wrote:<br>
&gt; <br>
&gt; Thiago Jung Bauermann &lt;<a href=3D"mailto:bauerman@linux.ibm.com" ta=
rget=3D"_blank" rel=3D"noreferrer">bauerman@linux.ibm.com</a>&gt; writes:<b=
r>
&gt; <br>
&gt; &gt; The ARM code has a start-powered-off property in ARMCPU, which is=
 a<br>
&gt; &gt; subclass of CPUState. This property causes arm_cpu_reset() to set=
<br>
&gt; &gt; CPUState::halted to 1, signalling that the CPU should start in a =
halted<br>
&gt; &gt; state. Other architectures also have code which aim to achieve th=
e same<br>
&gt; &gt; effect, but without using a property.<br>
&gt; &gt;<br>
&gt; &gt; The ppc/spapr version has a bug where QEMU does a KVM_RUN on the =
vcpu<br>
&gt; &gt; before cs-&gt;halted is set to 1, causing the vcpu to run while i=
t&#39;s still in<br>
&gt; &gt; an unitialized state (more details in patch 3).<br>
&gt; <br>
&gt; Since this series fixes a bug is it eligible for 5.1, at least the<br>
&gt; patches that were already approved by the appropriate maintainers?<br>
<br>
Ok by me.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Maybe just the arm generalization and ppc fix for 5.1, delaying a=
ll not bugfix to 5.2?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-- <br>
David Gibson=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | I&#39;ll have my music baroque, and my code<br>
david AT <a href=3D"http://gibson.dropbear.id.au" rel=3D"noreferrer norefer=
rer" target=3D"_blank">gibson.dropbear.id.au</a>=C2=A0 | minimalist, thank =
you.=C2=A0 NOT _the_ _other_<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | _way_ _around_!<br>
<a href=3D"http://www.ozlabs.org/~dgibson" rel=3D"noreferrer noreferrer" ta=
rget=3D"_blank">http://www.ozlabs.org/~dgibson</a><br>
</blockquote></div></div></div>

--000000000000d57f5505aba6a7ae--

