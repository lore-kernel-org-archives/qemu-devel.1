Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596C320826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwP+Dtzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596C320826
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSVk-00016h-Lk
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrSV3-0000Lz-R1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 16:41:33 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29]:38520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrSV1-0007O4-V3
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 16:41:33 -0400
Received: by mail-vs1-xe29.google.com with SMTP id s20so10320018vsq.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cKBz1OF/qMRx6//rmFlziZ4XnepphOoCK4gWS2boX0U=;
 b=HwP+DtziY9gB7I68z/qr3u8GCqrksK3eZqV6gpQ7tgdxpSAjNkCOfcIbMXwVE2x4yy
 u/wXLW0o1fqQ8qXNErsxw6XEmS/+7c6Xk459k5AIxVtHJdig8PEZN3PDOQiOfIAA3hpT
 w3XmBaueZzx/w5Z2zLOGm2cQCFakX7w7W1WkemU0hr5u7lU8YU0B+VzErfUDeXXH8tFX
 Il66o5hPh+QX9UpOzGDiD2kvP84niQUcetDJJzGqdWxG6T890rgOXmGdA0I84Ega+ADQ
 QGI2MPuDNpKmzrhjn93ZZeTeQeYrfKvuxqnSqsGdtQ9NHSdBmftO8JT12tyrIK94u03m
 R0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cKBz1OF/qMRx6//rmFlziZ4XnepphOoCK4gWS2boX0U=;
 b=WopIGW6oqXkzRgay9QzHrL7QiJbLrfDJUcBYTAlRKeykYrQ8HaXjSg4+gymBDzoaTT
 bRsMgNKzcBcn9rIyR3+gRqDKtzDHLzY7nFriy5a1Y7ifc8ce5zav5bJJyp0AxwueTGKX
 QPCM7+ppoa2CYgg2A+lAoLQg2cAvQm8jxtoVl/RNObNablUTMT0ckFgiPizqnvqWoYu/
 U7jYuHYNPY/lRqeW2dXWm9IH2MapnFDXlO3bYJ7fGaJLVw2ke64ZPOIDk6oQBLpXE+yL
 6qBosvkvzwIk1su9brBnrlB+koXaiA8OiUq2jgGeHq8uqhq9Rn+EH449+0biQQl5465L
 VOJQ==
X-Gm-Message-State: AOAM530WsVeECD5ecPzumI57IdhhNxmFyjwc9iGwuba96+vjpoM2+ccH
 sWluvQ4fdRlZoIoSUOhDUDZQMU2qb7qd7Fz2UkfnDg==
X-Google-Smtp-Source: ABdhPJzwZvD3szCz0vS7OWkTfYC0IMBF82nrCNN/qWH2wy30Cjd+tK92BJdu5jQ3b6xaxU9HdNzQiod7bVWtOK2Dy3I=
X-Received: by 2002:a67:d88c:: with SMTP id f12mr26472087vsj.92.1593808889304; 
 Fri, 03 Jul 2020 13:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <CAFEAcA_3y3XoF6BsYUt19f2CvyseahSEZWfY0iQxByJKaMA29w@mail.gmail.com>
In-Reply-To: <CAFEAcA_3y3XoF6BsYUt19f2CvyseahSEZWfY0iQxByJKaMA29w@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 3 Jul 2020 13:41:17 -0700
Message-ID: <CAFQmdRa2isDEFDWiQcKut63RkOjsoa8Fxw-Z0bB19kEd41euaQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: multipart/alternative; boundary="000000000000b0436b05a98f8c4c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe29.google.com
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

--000000000000b0436b05a98f8c4c
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 3, 2020 at 5:27 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Sat, 27 Jun 2020 at 00:55, Havard Skinnemoen <hskinnemoen@google.com>
> wrote:
> >
> > Time for another refresh of this patchset. Sorry it took so long -- I've
> been
> > trying to figure out why the Winbond flash model isn't working with
> > npcm750-evb, and I'm fairly convinced the number of dummy cycles in DIO
> mode
> > should be 4, not 1. Unfortunately, I don't see any other machines using
> Winbond
> > flash in DIO mode, so it's hard to prove that it's correct. I'm planning
> to
> > post a libqos-based test suite separately.
> >
> > I'm also planning to add the vbootrom to qemu as a submodule, similar to
> the
> > other roms, but not in this pathset (let me know if you do want me to
> include
> > this in the series).
>
> Hi; it looks like codewise this patchset is ready to go in
> and it's all been reviewed. I see however that all the
> new files are GPL-v2-only. We usually prefer GPL-v2-or-later
> for new code: is it possible to use that license instead ?
>

I sent an e-mail to our licensing team to see if there are any issues with
doing that. I don't expect a response until next week though, since this is
a long weekend.

I'll send out a v4 with updated headers if they approve.

Thanks,
Havard

--000000000000b0436b05a98f8c4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Jul 3, 2020 at 5:27 AM Peter Mayd=
ell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.or=
g</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Sat, 27 Jun 2020 at 00:55, Havard Skinnemoen=
 &lt;<a href=3D"mailto:hskinnemoen@google.com" target=3D"_blank" class=3D"c=
remed">hskinnemoen@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Time for another refresh of this patchset. Sorry it took so long -- I&=
#39;ve been<br>
&gt; trying to figure out why the Winbond flash model isn&#39;t working wit=
h<br>
&gt; npcm750-evb, and I&#39;m fairly convinced the number of dummy cycles i=
n DIO mode<br>
&gt; should be 4, not 1. Unfortunately, I don&#39;t see any other machines =
using Winbond<br>
&gt; flash in DIO mode, so it&#39;s hard to prove that it&#39;s correct. I&=
#39;m planning to<br>
&gt; post a libqos-based test suite separately.<br>
&gt;<br>
&gt; I&#39;m also planning to add the vbootrom to qemu as a submodule, simi=
lar to the<br>
&gt; other roms, but not in this pathset (let me know if you do want me to =
include<br>
&gt; this in the series).<br>
<br>
Hi; it looks like codewise this patchset is ready to go in<br>
and it&#39;s all been reviewed. I see however that all the<br>
new files are GPL-v2-only. We usually prefer GPL-v2-or-later<br>
for new code: is it possible to use that license instead ?<br></blockquote>=
<div><br></div><div>I sent an e-mail=C2=A0to our licensing team to see if t=
here are any issues with doing that. I don&#39;t expect a response until ne=
xt week though, since this is a long weekend.</div><div><br></div><div>I&#3=
9;ll send out a v4 with updated headers if they approve.</div><div><br></di=
v><div>Thanks,</div><div>Havard=C2=A0</div></div></div>

--000000000000b0436b05a98f8c4c--

