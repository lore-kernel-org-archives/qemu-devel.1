Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CEAC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A622083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A622083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrTa-0004Tp-QX
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrD8-0003aR-G6
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:30 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:46645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrD6-0001Wy-JN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:30 -0400
Received: by mail-qt1-f182.google.com with SMTP id b3so5831063qtg.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HQiv60Nk2oLaohYdcGV37/WqeKMe1EAPw29O2AALm0c=;
 b=jdGPZrwtkn0qbRDaPYCJWtb4aLY3xiRuLoA/CbH/t5yGkxsIwEwcc3ranvAA5Ny5gr
 GkK/03g/IY5jE+jxNpIm+Om4Ko1YHfPwsAeu92hCEN/czm/smj2b4M1N4no6dSam0tFv
 y6FKftpLyo/y02vzUQen0DeYyneZJm0DT7wqNM7/MMbSm1Z8CsJcK8iY61yebgFtGd2p
 V9oOrpJC2d8umtiUFbTC70WloJDXivG2HW8A66sIQ6IvDrLqkuRvAMSuJ82M29uG5vpf
 UjRyQfm5zw9KtusYV4+kzexP5T/GzvjOYu957BIUm6WA14PQdzmQyCLLtXXzoXoDkT1v
 581A==
X-Gm-Message-State: AOAM533ZzQLOqn5U2DUxtSqVlHfxF5Lb1o0OkCgVgacp4rxcowvJMRhF
 HRUe51g4gLUd2gssyv8JrFHpJZ2tmXpgXelbn3Y=
X-Google-Smtp-Source: ABdhPJz8VRNvfWL6UR2pX6cnqR63ggRzfEA7TT34+1vLKVs1T53GAOMcEvAd9LI6gkqLplhpRaelkXF6zLczwaZ91A0=
X-Received: by 2002:ac8:660f:: with SMTP id c15mr3353563qtp.34.1598908767705; 
 Mon, 31 Aug 2020 14:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200827113259.25064-1-peter.maydell@linaro.org>
 <8385e0cf-b955-e62d-dfdc-51380b7c5433@redhat.com>
 <CAFEAcA_3fiQ86aby8PALZNUukPE1RhgV+1+hjoEF+aCfCp3mbw@mail.gmail.com>
 <0fd6bf04-f021-6716-c010-93def04c6f5d@redhat.com>
In-Reply-To: <0fd6bf04-f021-6716-c010-93def04c6f5d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:11:38 +0200
Message-ID: <CAAdtpL761E3jrnSK4zfOh-EQSPuJGN709i-vqeancSvmdJuSgQ@mail.gmail.com>
Subject: Re: [PATCH] Deprecate lm32 port
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000209f3105ae32f52d"
Received-SPF: pass client-ip=209.85.160.182;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qt1-f182.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:19:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000209f3105ae32f52d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 16:51, Thomas Huth <thuth@redhat.com> a =C3=A9cri=
t :

> On 27/08/2020 16.19, Peter Maydell wrote:
> > On Thu, 27 Aug 2020 at 14:52, Thomas Huth <thuth@redhat.com> wrote:
> >> What's next? moxie? ... apart from the tree-wide clean-ups and trivial
> >> fixes, moxie did not have any major updates since 2013 when it has bee=
n
> >> added, as far as I can see ... is anybody still using it?
> >
> > I was never very clear on how much use moxie had to start with...
> >
> > An extremely rough-and-ready guide to how well-loved a target
> > is might be "did it get converted to TranslatorOps?". Unconverted:
> >  * avr
> >  * cris
> >  * lm32 (deprecation in progress)
> >  * microblaze (rth just posted patches for this)
> >  * moxie
> >  * nios2
> >  * tilegx (deprecation in progress)
> >  * unicore32 (deprecation in progress)
>
> Another criteria might be: Do we have a tcg, qtest or acceptance test to
> check that the target is still working?
>

And to some extent "is there documentation publicly available?" as it makes
maintenance by others possible.


> - avr has an acceptance test
>
> - cris has tcg tests
>
> - lm32 has tcg tests
>
> - microblaze has acceptance tests (and one trivial qtest)
>
> - moxie ... has only one very trivial qtest (boot-serial-test)
>
> - nios2 has an acceptance test
>
> - tilegx does not have any tests at all
>
> - unicore32 does not have any tests at all
>   (not counting the trivial machine-none-test)
>
> So from that point of view, unicore32, tilegx and moxie are the
> candidates for deprecation.
>
> > I think dropping the moxie maintainer an email to ask about
> > the architecture's status wouldn't be a bad idea if you
> > wanted to start that ball rolling.
>
> Ok, good idea, I'll try to write a mail later today.
>
>  Thomas
>
>
>

--000000000000209f3105ae32f52d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 16:51, Thomas Huth &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">On 27/08/2020 16.19, Peter Maydell w=
rote:<br>
&gt; On Thu, 27 Aug 2020 at 14:52, Thomas Huth &lt;<a href=3D"mailto:thuth@=
redhat.com" target=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt; w=
rote:<br>
&gt;&gt; What&#39;s next? moxie? ... apart from the tree-wide clean-ups and=
 trivial<br>
&gt;&gt; fixes, moxie did not have any major updates since 2013 when it has=
 been<br>
&gt;&gt; added, as far as I can see ... is anybody still using it?<br>
&gt; <br>
&gt; I was never very clear on how much use moxie had to start with...<br>
&gt; <br>
&gt; An extremely rough-and-ready guide to how well-loved a target<br>
&gt; is might be &quot;did it get converted to TranslatorOps?&quot;. Unconv=
erted:<br>
&gt;=C2=A0 * avr<br>
&gt;=C2=A0 * cris<br>
&gt;=C2=A0 * lm32 (deprecation in progress)<br>
&gt;=C2=A0 * microblaze (rth just posted patches for this)<br>
&gt;=C2=A0 * moxie<br>
&gt;=C2=A0 * nios2<br>
&gt;=C2=A0 * tilegx (deprecation in progress)<br>
&gt;=C2=A0 * unicore32 (deprecation in progress)<br>
<br>
Another criteria might be: Do we have a tcg, qtest or acceptance test to<br=
>
check that the target is still working?<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">And to some extent &quot;is there do=
cumentation publicly available?&quot; as it makes maintenance by others pos=
sible.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
- avr has an acceptance test<br>
<br>
- cris has tcg tests<br>
<br>
- lm32 has tcg tests<br>
<br>
- microblaze has acceptance tests (and one trivial qtest)<br>
<br>
- moxie ... has only one very trivial qtest (boot-serial-test)<br>
<br>
- nios2 has an acceptance test<br>
<br>
- tilegx does not have any tests at all<br>
<br>
- unicore32 does not have any tests at all<br>
=C2=A0 (not counting the trivial machine-none-test)<br>
<br>
So from that point of view, unicore32, tilegx and moxie are the<br>
candidates for deprecation.<br>
<br>
&gt; I think dropping the moxie maintainer an email to ask about<br>
&gt; the architecture&#39;s status wouldn&#39;t be a bad idea if you<br>
&gt; wanted to start that ball rolling.<br>
<br>
Ok, good idea, I&#39;ll try to write a mail later today.<br>
<br>
=C2=A0Thomas<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000209f3105ae32f52d--

