Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED1CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDEF20675
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8vrY3JS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDEF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wX1-0004uk-4r
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eugenis@google.com>)
 id 1k5w5J-0006wV-GI
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 15:06:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eugenis@google.com>)
 id 1k5w5H-0006qu-Nh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 15:06:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id 184so2959597wmb.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K42oFIs3UH2s1ljZXw2qrvpj9Qd7Ph3STv9rVq8ourw=;
 b=R8vrY3JS5QaxBGFkgoo2X5dFz/tpu9yTFCil4+1QN1Pi4Nm8JQ2VlBDs3RWBDQAV+o
 uybjH80OhheOHReEDsbdOCrxxByeTyHkZcvTrJ08xVV4VrUna+giqNMLtZ+Z3CBatGsf
 z7RWQHT2eGvgTVpUloYr9YU/BGDTy3Oh362WfNPQwC/vHRCJG0raM/HhZ6CeQ3FXmh8D
 jrzJcX3/VTWAtIoo+9EeLDmavrwgPevI26/DLxq/50cP34Lq6VtJNlLwgx9gbRv6mty1
 nxHUKP6qot73CnhdiIluL6uDAswtEX0vCORreZ/bhrK2nDTkLcQVD1otatQI5Z9EpI2E
 qaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K42oFIs3UH2s1ljZXw2qrvpj9Qd7Ph3STv9rVq8ourw=;
 b=Y5bvpUhWG1sS39wN1t3sE2KuVp2tEC3f8VRPSNNpW/Hk5mDkomhRoRJRd2wub8Pisg
 vvjg1rPIkWEM0xmPcaI4ECQKl8gn4ziuNW5vjqsyKbM41xlXpxD4EG8YekQ/zmbJ4L2V
 PeYVypNV5oho46/Pl/hrB/iONN2KDpe/HP+ATJqbOu9x65AzoxFd+mV2OpZsdBrLJhcB
 ohnKLqOCaJn/duTFjfvxhN37Z3RdudXT7gmEQdSZvMF7m9h4ceDMP1sPOOmLAGRw2C2Y
 XFfboY6iPynPA7hBYsmV8qNIq2F3PwMkj/1jjuf66CuXxhq/TuauosxG9pDGl3ww8COf
 cTNg==
X-Gm-Message-State: AOAM532QL3zrEOpYcAU/IK0OpkBdXfiz1RTa4LcvXFCoNyANKiUQ14T0
 K2PLG95D+fa78DWsMyfr1KU24m642Hr6rucGpHBLWw==
X-Google-Smtp-Source: ABdhPJwCuxjzCcTUFWU3CggEbA4IqJjxDLk1KaxvnNeXbT+ZIh5+nYkK+bdBYYB+XRxulvaXPlt7cLPhBhno9W34J+0=
X-Received: by 2002:a1c:7702:: with SMTP id t2mr941300wmi.169.1597259205218;
 Wed, 12 Aug 2020 12:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
 <CAAeHK+z=CU5dQepy+SBtVMAp-=k8BODorG768CYwoR3NEKCWFg@mail.gmail.com>
 <b2d524a2-1523-d03a-72a9-407ab03fa897@linaro.org>
 <CAAeHK+zD3ZdjpZOBny3QuYtKe-qzhmEfd9w+nr3NrzEuzHHRvw@mail.gmail.com>
In-Reply-To: <CAAeHK+zD3ZdjpZOBny3QuYtKe-qzhmEfd9w+nr3NrzEuzHHRvw@mail.gmail.com>
From: Evgenii Stepanov <eugenis@google.com>
Date: Wed, 12 Aug 2020 12:06:31 -0700
Message-ID: <CAFKCwrjSU89jiUbzd8Ys8nV6NDCJer=FbUnGWv8m0p0E+9MdVg@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Complete ISS for MTE tag check fail
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Branislav Rankov <Branislav.Rankov@arm.com>, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org, peter.maydell@linaro.org, 
 Elena Petrova <lenaptr@google.com>, Kostya Serebryany <kcc@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>
Content-Type: multipart/alternative; boundary="0000000000008b0a1f05acb2e30b"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=eugenis@google.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Aug 2020 15:34:28 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008b0a1f05acb2e30b
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 12, 2020 at 11:03 AM Andrey Konovalov <andreyknvl@google.com>
wrote:

> On Wed, Aug 12, 2020 at 7:52 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 8/12/20 10:38 AM, Andrey Konovalov wrote:
> > > On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson
> > > <richard.henderson@linaro.org> wrote:
> > >>
> > >> As reported by Andrey, I was missing the complete ISS info for
> > >> the Data Abort raised upon a synchronous tag check fail.
> > >>
> > >> The following should fix that.  All the twisty little rules for
> > >> the ISS.ISV bit are already handled by merge_syn_data_abort.
> > >> Probably the most important bit that was missing was ISS.WnR,
> > >> as that is independent of ISS.ISV.
> > >>
> > >> Andrey, will you please test?
> > >
> > > Looks like WnR is now being set properly, but SAS is still always 0.
> >
> > Are you looking at ESR_EL1?
> >
> > On page D13-2992 of revision F.a:
> >
> > # ISV is 0 for all faults reported in ESR_EL1 or ESR_EL3.
> >
> > which means that ISS[23:14] are RES0, which includes SAS.
>
> +more Arm and Google people
>
> Is this known? Do we not get access size when MTE fault happens?
>

It sounds like this applies to all data abort exceptions, no matter MTE or
not.

--0000000000008b0a1f05acb2e30b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 12, 2020 at 11:03 AM Andr=
ey Konovalov &lt;<a href=3D"mailto:andreyknvl@google.com">andreyknvl@google=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Wed, Aug 12, 2020 at 7:52 PM Richard Henderson<br>
&lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richa=
rd.henderson@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 8/12/20 10:38 AM, Andrey Konovalov wrote:<br>
&gt; &gt; On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson<br>
&gt; &gt; &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_bl=
ank">richard.henderson@linaro.org</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; As reported by Andrey, I was missing the complete ISS info fo=
r<br>
&gt; &gt;&gt; the Data Abort raised upon a synchronous tag check fail.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The following should fix that.=C2=A0 All the twisty little ru=
les for<br>
&gt; &gt;&gt; the ISS.ISV bit are already handled by merge_syn_data_abort.<=
br>
&gt; &gt;&gt; Probably the most important bit that was missing was ISS.WnR,=
<br>
&gt; &gt;&gt; as that is independent of ISS.ISV.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Andrey, will you please test?<br>
&gt; &gt;<br>
&gt; &gt; Looks like WnR is now being set properly, but SAS is still always=
 0.<br>
&gt;<br>
&gt; Are you looking at ESR_EL1?<br>
&gt;<br>
&gt; On page D13-2992 of revision F.a:<br>
&gt;<br>
&gt; # ISV is 0 for all faults reported in ESR_EL1 or ESR_EL3.<br>
&gt;<br>
&gt; which means that ISS[23:14] are RES0, which includes SAS.<br>
<br>
+more Arm and Google people<br>
<br>
Is this known? Do we not get access size when MTE fault happens?<br></block=
quote><div><br></div><div>It sounds like this applies to all data abort exc=
eptions, no matter MTE or not.</div><div>=C2=A0</div></div></div>

--0000000000008b0a1f05acb2e30b--

