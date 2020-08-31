Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEDCC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE0620767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE0620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kClkD-0005Bh-2p
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCljV-0004gv-V9
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:28:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCljU-0000Ik-9Q
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:28:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id ba12so5868437edb.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 08:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VwAiTNpndV3rhfUvR5t+xM0fC94EBhuq92/6dZerAM8=;
 b=jEYwPed5sXl7e7dAewXBct16fi8j5r3IjWrKvIaG1bq7MVE4jYPpZY5kJsv++AITMy
 6VD2LdFmBeHRYDybUg0vc2TyPPgyaUtBfxyiB5zZy0WnN+NWP3ITmJpGsJ+LPy/8BI/r
 7/m9EBoNxpv5qf+wrW08zWnO+pTcWqDmnHtmOI+9irnLt4AA7bJA08dr4PKAqTBpxe2c
 3PO7TDd11YSFD+Pi+gQq1lFmDz7vzYi5v+bnfmJhe38jJ/G8UJRAY+y69o0ux+F3MeJ/
 cExfFx93XQmbaW+jqZeNgBgErpwGTIWFiujEmyQg1NP28cxLdsw5iH9TZP4NO4NjdPXc
 m15g==
X-Gm-Message-State: AOAM530ejgq7TwTQkk/2hw9sjSdMFYIRDmxGALG1LBIi9qnJxYLTaelW
 44NRFp0eTLXt9OqaSnvPXZKIanVBieILQ4t7Mzs=
X-Google-Smtp-Source: ABdhPJwogGOfCUABMZw+5GfXp9X4YTrWx2DCZ9fDA8mrXNOa5DNdrcleb0FkLyKHx6A/f1LBb/XYTUktZV2kRRAP4j0=
X-Received: by 2002:a05:6402:15:: with SMTP id
 d21mr1773491edu.324.1598887710258; 
 Mon, 31 Aug 2020 08:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200827102617.14448-1-kraxel@redhat.com>
 <772abf5c-30e2-149f-2507-2c47c016dd7b@redhat.com>
In-Reply-To: <772abf5c-30e2-149f-2507-2c47c016dd7b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 17:28:14 +0200
Message-ID: <CAAdtpL4KFcZsSa-ApRCxt1gDJ+TJPfJkde3RSYQOpYrgAtjHUQ@mail.gmail.com>
Subject: Re: [PATCH] meson: fix keymaps witout qemu-keymap
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000001799d05ae2e0e29"
Received-SPF: pass client-ip=209.85.208.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000001799d05ae2e0e29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Typo "without" in subject.

Le lun. 31 ao=C3=BBt 2020 13:15, Thomas Huth <thuth@redhat.com> a =C3=A9cri=
t :

> On 27/08/2020 12.26, Gerd Hoffmann wrote:
> > In case the qemu-keymap tool generating them is neither installed on th=
e
> > system nor built from sources (due to xkbcommon not being available)
> > qemu will not find the keymaps when started directly from the build
> > tree,
> >
> > This happens because commit ddcf607fa3d6 ("meson: drop keymaps symlink"=
)
> > removed the symlink to the source tree, and the special handling for
> > install doesn't help in case we do not install qemu.
> >
> > Lets fix that by simply copying over the file from the source tree as
> > fallback.
> >
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  pc-bios/keymaps/meson.build | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
>
> Thanks, this fixes the acceptance tests on gitlab-CI for me!
>
> Tested-by: Thomas Huth <thuth@redhat.com>
>
>
>

--00000000000001799d05ae2e0e29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Typo &quot;without&quot; in subject.=C2=A0<br><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le lun. 31 a=
o=C3=BBt 2020 13:15, Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">th=
uth@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On 27/08/2020 12.26, Gerd Hoffmann wrote:<br>
&gt; In case the qemu-keymap tool generating them is neither installed on t=
he<br>
&gt; system nor built from sources (due to xkbcommon not being available)<b=
r>
&gt; qemu will not find the keymaps when started directly from the build<br=
>
&gt; tree,<br>
&gt; <br>
&gt; This happens because commit ddcf607fa3d6 (&quot;meson: drop keymaps sy=
mlink&quot;)<br>
&gt; removed the symlink to the source tree, and the special handling for<b=
r>
&gt; install doesn&#39;t help in case we do not install qemu.<br>
&gt; <br>
&gt; Lets fix that by simply copying over the file from the source tree as<=
br>
&gt; fallback.<br>
&gt; <br>
&gt; Reported-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" =
target=3D"_blank" rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 pc-bios/keymaps/meson.build | 28 +++++++++++++++++++---------<br=
>
&gt;=C2=A0 1 file changed, 19 insertions(+), 9 deletions(-)<br>
<br>
Thanks, this fixes the acceptance tests on gitlab-CI for me!<br>
<br>
Tested-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_b=
lank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000001799d05ae2e0e29--

