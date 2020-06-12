Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4023C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB961207ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTAKQ73c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB961207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmU0-0003mv-Uh
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jjmTK-0003Fc-4U
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:24:02 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d]:37211)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jjmTI-0004EG-FX
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:24:01 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id q10so2388594vka.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZBdoNOBMEF0YZONd1lNj5Y/k6+JiQQJ7kERWF7pOyRo=;
 b=dTAKQ73cyoPelcj13qBIZ3juj/RHD2H/2mggfRq4VMTW4ecN7iiZ3rURe0hhe0hDJ3
 6OQ7vlOi527ln3w2zfMo7AfPu1wewgNOgSnAInTqJIDOm6ROlGAMzloO1/MNHKUX6kby
 pgePyH8jmxBc8DcCxsQMaPfKAMIdL82cT1BlPSj2U4Wl4sXrY/oti/dHUpWyeg8huaJO
 2Gt6oPeAKo3KYC4lBjgcJJvvD6KGL295pitW8iBLF3Kl+lhZCgq0w7Oud/aZl3eATszT
 1vNe206I/FyyRHzZMWEE3q9aj7AiMr8QdMg+8KYCgloPxoACRdg/l/kJFhWDw91b/7TY
 KRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZBdoNOBMEF0YZONd1lNj5Y/k6+JiQQJ7kERWF7pOyRo=;
 b=j42APafhxEvFbOrdKl4BJxsdA2nfebOW5taPK+hVncaD26Mi1hcdorb/SBDuJEvgbP
 k1qE7G4/6+/S/iV2iz05/JAUxy/9L0yp+Jlqv3Z+MqgDViRWoR93F/rGZhfM90ZWz128
 MM/p88y4XPI694l4M8HB3j8DlbMgASHxMtTsbmcUeUeE39N+KyN9JNWBspMW7i//n0bQ
 IQYJYatKclh2ggtS6CLJLajDnpALjKWjCekzXew8+Bkn8Aj49SGrKj1RAMkpTZc7VUUX
 ur1HWhSgDJZNpchTtUfoirfa2P2lnkJYoZOOPK6fCRLB8xKXg9giwF2vZq2SwhnI/d96
 KQUA==
X-Gm-Message-State: AOAM531mmPR7yESoI+miiPMQ5WYSLNtqmLMAzou8zKHA+UZMshDpZpm6
 hskzN0VBOKtji24bvnzB+3hNrFusrtpSByZLNd4eOA==
X-Google-Smtp-Source: ABdhPJzFzVh29/H+2EbkfDiGK9ywjy2+c4yY7w37zmhtYDNr6NMA6DmQdlWoazfZSV+4gE0+tZZ9OXXsALI0J7wU/t0=
X-Received: by 2002:a05:6122:130b:: with SMTP id
 e11mr11914299vkp.20.1591979032700; 
 Fri, 12 Jun 2020 09:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
 <20200611223016.259837-2-hskinnemoen@google.com>
 <c16e1f35-ec5b-d479-16b4-944a4567a453@redhat.com>
In-Reply-To: <c16e1f35-ec5b-d479-16b4-944a4567a453@redhat.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 12 Jun 2020 09:23:41 -0700
Message-ID: <CAFQmdRarCC=Etq2baN9UsTBWXxJPSNcA3CKi19P6asJjLevzzw@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] npcm7xx: Add config symbol
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: multipart/alternative; boundary="000000000000bcd78905a7e580e3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa2d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bcd78905a7e580e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Fri, Jun 12, 2020 at 6:35 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Havard
>
> On 6/12/20 12:30 AM, Havard Skinnemoen wrote:
> > Add a config symbol for the NPCM7xx BMC SoC family that subsequent
> > patches can use in Makefiles.
> >
> > Change-Id: I6e4d5c58716cb6fe4ea5d06f148beeafda55f9a5
>
> What it this Change-Id tag used for?
>

It's used by Gerrit code review, which we use for reviews internally
(between Google and Nuvoton). I meant to remove it before mailing the
patches, sorry.

--000000000000bcd78905a7e580e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div dir=3D"ltr">On =
Fri, Jun 12, 2020 at 6:35 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Havar=
d<br>
<br>
On 6/12/20 12:30 AM, Havard Skinnemoen wrote:<br>
&gt; Add a config symbol for the NPCM7xx BMC SoC family that subsequent<br>
&gt; patches can use in Makefiles.<br>
&gt; <br>
&gt; Change-Id: I6e4d5c58716cb6fe4ea5d06f148beeafda55f9a5<br>
<br>
What it this Change-Id tag used for?<br></blockquote><div><br></div><div>It=
&#39;s used by Gerrit code review,=C2=A0which we use for reviews internally=
 (between Google and Nuvoton). I meant to remove it before mailing the patc=
hes, sorry.</div></div></div>

--000000000000bcd78905a7e580e3--

