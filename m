Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90348C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFDF2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZZKr7Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFDF2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQRU6-0007BQ-Kn
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 04:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQRTG-0006b2-VY; Thu, 08 Oct 2020 04:40:18 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQRTE-0007Uy-EP; Thu, 08 Oct 2020 04:40:18 -0400
Received: by mail-il1-x144.google.com with SMTP id c5so4928257ilr.9;
 Thu, 08 Oct 2020 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yo8eawsYt25LHabU7xyYGWra2pm7iePuuilWGf4A5jo=;
 b=MZZKr7Jh44969O3Tyaasauofrg7fcFBfBeDg3zieIrTrXrN2hiSXQ0dZj4cIlu8wTa
 rG0NPosgyZL0qbT0r2agPhGatkhkC/SNE0sl6hZ2EG+jexRwUQgMG0LxqZJMXraxMwWE
 WMjRxgU3xBtgPh28nH1/uHj5AIhg4BZq9SsBK2wZiYwk6l4HJ7vA9OGOM78bnzMY9Xzv
 Ms90kwwBnGHg9nbRETe5ef239fUeyp7aBahWCIbI72pW0tnGGSXdJadKpX04C350fReE
 7fduhuTzpEjADmyQl6aFKoeEzBUHkR+UzMfhq6IWeKsX3OmG75vymbcmklMAizt93ldK
 M+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yo8eawsYt25LHabU7xyYGWra2pm7iePuuilWGf4A5jo=;
 b=KrpK29OnrTDd/tZGbFV2FCtefQIPwhRu0O5aqEkCfKnRVyUolGv8hD7nao6ddM7C4y
 zPVzsb6EI+Xj9SxCBgzmX8o28Wp82l0cYK/gCwAZ1B5gAR3jXszZ9DQhzO/CQgtThjze
 7IKgSuLNMPBQ+EIeUPYDaf2TUrZYY8JhsrCQ+YvvPdBnZDJKHmuKWydcMNZX503yQyLh
 30arCaD9DU3YPmLOTPvOeLAmwaZjz+W8Qc1Gr34HpQnGb4KM2VNFbIa8Nwj+dx1LyPN+
 iMYEzLFGlVRG3UrUX5S75wM35Kqe17RtfEgom9W47doJiAOQQFPsNMiUPs21FWno0ZdN
 CRGw==
X-Gm-Message-State: AOAM531juumFzIbGmwOYstH9+wdWn4KPImBMoX5PEjCy+cQ3T+vKlWPs
 lzAhjcj8V3Q87pJKbqxHnqF1aE+u5ihEIkoj0xk=
X-Google-Smtp-Source: ABdhPJx2j4FIOwQMvNSAGpbi9ZvZqtrjtuafXCf2I/APtsvVFHtypcfUmMo9+anK8UeDKeJvKUnrsntMmfZUdPkkkNo=
X-Received: by 2002:a92:cb8c:: with SMTP id z12mr5453670ilo.123.1602146415004; 
 Thu, 08 Oct 2020 01:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201008060528.68579-1-chetan4windows@gmail.com>
 <df199cc8-c383-ed03-6244-7a204e92397b@redhat.com>
 <ba4f81dd-8e5c-1d50-311c-fdc41f9cc504@redhat.com>
In-Reply-To: <ba4f81dd-8e5c-1d50-311c-fdc41f9cc504@redhat.com>
From: Chetan <chetan4windows@gmail.com>
Date: Thu, 8 Oct 2020 14:10:01 +0530
Message-ID: <CAPPKfOHQV44b+kkcc3QYsLXya-5Ttcbve51uqRUS0e5GyouX6w@mail.gmail.com>
Subject: Re: [PATCH] Fixing LGPL version number
To: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f1d1b005b124c7dc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=chetan4windows@gmail.com; helo=mail-il1-x144.google.com
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f1d1b005b124c7dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'll be working on replacing the license text in LGPL licensed files with
the SPDX identifier tag and will submit it as a separate patch.


*On 08/10/2020 09.54, Philippe Mathieu-Daud=C3=A9 wrote: *


*> --- > *

* >Also, if you use a script to do that cleanup, it would be >useful to
include it in the commit description.*

Sure, I'll be including the commands/script I use.

Chetan

On Thu, Oct 8, 2020 at 1:27 PM Thomas Huth <thuth@redhat.com> wrote:

> On 08/10/2020 09.54, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi,
> >
> > On 10/8/20 8:05 AM, Chetan Pant wrote:
> >> There is no "version 2" of the "Lesser" General Public License. It is
> >> either "GPL version 2.0" or "LGPL version 2.1". This patch replaces al=
l
> >> occurrences of "LGPL version 2" with "LGPL version 2.1" in comment
> section.
> >
> > This looks like a good cleanup!
> >
> > Since you already listed all the files using this license,
> > it can be a good opportunity to correct and use the full
> > license text (which is miswritten in various places):
> >
> > ---
> >
> >  Copyright (C) <year> <name of author>
> >
> > This library is free software; you can redistribute it and/or modify it
> > under the terms of the GNU Lesser General Public License as published b=
y
> > the Free Software Foundation; either version 2.1 of the License, or (at
> > your option) any later version.
> >
> > This library is distributed in the hope that it will be useful, but
> > WITHOUT ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
> > General Public License for more details.
> >
> > You should have received a copy of the GNU Lesser General Public Licens=
e
> > along with this library; if not, write to the Free Software Foundation,
> > Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>
> Please don't use that version. If the FSF move to another office again, w=
e
> have to update the whole mess again.
>
> > Or simpler, add the SPDX identifier tag:
> >
> >   SPDX-License-Identifier: LGPL-2.1-or-later
>
> SPDX tags would be cool, of course, but it could also be done in a separa=
te
> patch later.
>
>  Thomas
>
>

--000000000000f1d1b005b124c7dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I&#3=
9;ll be working on replacing the license text in LGPL licensed files with t=
he SPDX identifier tag and will submit it as a separate patch.

</div><div><br></div><div>
<i><span class=3D"gmail-im">On 08/10/2020 09.54, Philippe Mathieu-Daud=C3=
=A9 wrote:</span> <br></i></div><div>
<i><span class=3D"gmail-im">&gt; ---<br>
&gt; <br></span></i></div><div><span class=3D"gmail-im"><i>
&gt;Also, if you use a script to do that cleanup, it would be<br>
&gt;useful to include it in the commit description.</i>

</span>

</div><div><br></div><div>Sure, I&#39;ll be including the commands/script I=
 use.<br></div><div><br></div><div>Chetan<br></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 8, 2020 at 1=
:27 PM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank=
">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 08/10/2020 09.54, Philippe Mathieu-Daud=C3=A9 wrote:<b=
r>
&gt; Hi,<br>
&gt; <br>
&gt; On 10/8/20 8:05 AM, Chetan Pant wrote:<br>
&gt;&gt; There is no &quot;version 2&quot; of the &quot;Lesser&quot; Genera=
l Public License. It is<br>
&gt;&gt; either &quot;GPL version 2.0&quot; or &quot;LGPL version 2.1&quot;=
. This patch replaces all<br>
&gt;&gt; occurrences of &quot;LGPL version 2&quot; with &quot;LGPL version =
2.1&quot; in comment section.<br>
&gt; <br>
&gt; This looks like a good cleanup!<br>
&gt; <br>
&gt; Since you already listed all the files using this license,<br>
&gt; it can be a good opportunity to correct and use the full<br>
&gt; license text (which is miswritten in various places):<br>
&gt; <br>
&gt; ---<br>
&gt; <br>
&gt;=C2=A0 Copyright (C) &lt;year&gt; &lt;name of author&gt;<br>
&gt; <br>
&gt; This library is free software; you can redistribute it and/or modify i=
t<br>
&gt; under the terms of the GNU Lesser General Public License as published =
by<br>
&gt; the Free Software Foundation; either version 2.1 of the License, or (a=
t<br>
&gt; your option) any later version.<br>
&gt; <br>
&gt; This library is distributed in the hope that it will be useful, but<br=
>
&gt; WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesse=
r<br>
&gt; General Public License for more details.<br>
&gt; <br>
&gt; You should have received a copy of the GNU Lesser General Public Licen=
se<br>
&gt; along with this library; if not, write to the Free Software Foundation=
,<br>
&gt; Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA<br>
<br>
Please don&#39;t use that version. If the FSF move to another office again,=
 we<br>
have to update the whole mess again.<br>
<br>
&gt; Or simpler, add the SPDX identifier tag:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0SPDX-License-Identifier: LGPL-2.1-or-later<br>
<br>
SPDX tags would be cool, of course, but it could also be done in a separate=
<br>
patch later.<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div></div>

--000000000000f1d1b005b124c7dc--

