Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1364C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA93C20748
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd6lseq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA93C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juKme-0001ze-UT
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 15:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1juKlq-0001ZF-Bc
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 15:02:46 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1juKlo-0002mS-Nk
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 15:02:46 -0400
Received: by mail-ed1-x541.google.com with SMTP id d18so7329953edv.6
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eaqNcoZBjEEGvuxm1GOEfA0cD1sCIYq+eJiFIJWpdeI=;
 b=Jd6lseq8h3Bn1Zp3Q7krBS4mFD9r+mpceXlfa2xpxWwMeHEA6eSZ5m5XGm9uEXtl4p
 bDfH7WVt2BG+0Fbai8qYoivc07Th4XkX0N/ZTIUV8h6/SZHOwvmdDUwlY1dznFbSP2mT
 nn69ovEhockuxQ6YtXnWOGLdG2BQW1DW1D4eonRLAfzSpQPwUVUjjTIYNZHohC9JiSuN
 xrk9gIk40J4khpIMi/FhzQ1lbH3R7E0jW0j7oOvWR4A/DQ1U2ibpH+fFtovnMAsTj9Cl
 o2xjudTg6QYagCsUsB4fyjIDSXcDPH3yHEtdRw15dQrciTK6l9s57GRRYGLFosrOtrcg
 ILjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eaqNcoZBjEEGvuxm1GOEfA0cD1sCIYq+eJiFIJWpdeI=;
 b=CmT55VUv1GMwQ1KbHnkhjAqiHpO6WtZeHcxgEiRQU0lfatHCSrkFKGkyCQ2QNERNKr
 BPqu+renETcvZ1X9UD2WKTGRkdUpwPmgfoXSOlZ4n2+ukUOoTGNliRAQG277/fI6i/4R
 zggCk4UcOye6GCaT29rP5F2IPURTi9PWHjz7/V6vAqaHXIlEW56ndRCTggYgN75Pdv9H
 qZS5h7YppeNOL9i9F8BV0V36EwGR2etAR4XA5/PIOetYysdbV4YMLqBfQidr86lq/GH5
 YO83hqvnQvyeUqH7wNEJl7npVwgJUIuMQu+T4XqlAmiJq0ibG4KbmeUCLZdAtU42jWNK
 TUSg==
X-Gm-Message-State: AOAM532W/eCqUDGH0iGVW8DSC1B3qnBo2raVJZsF000dai/fF+FxGRy8
 DEBwGip0OfXHMPWlAwY4ux8ae3g8bnIt9bU3vDE=
X-Google-Smtp-Source: ABdhPJzXjfvmc88ffBVF0GgXy9hZW1Y4lJumsgDwqzwLbPPnFiQhhUVXaVrm4or10SZwUH6qF0f+CeszjPFm+bbgaUo=
X-Received: by 2002:a05:6402:3049:: with SMTP id
 bu9mr71006695edb.232.1594494162732; 
 Sat, 11 Jul 2020 12:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200703145614.16684-1-peter.maydell@linaro.org>
 <CAFEAcA8UpTzG2Loc8sqLcHVHaYLQr9fR=-b28LYhVTgGC_RedQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8UpTzG2Loc8sqLcHVHaYLQr9fR=-b28LYhVTgGC_RedQ@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 11 Jul 2020 20:02:32 +0100
Message-ID: <CA+XhMqzxRh70+G1+rZTtssW+VXkKLJRkEG9T+mi6WgDKbbA6WA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Build fixes for Haiku
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002a8c2905aa2f1a23"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002a8c2905aa2f1a23
Content-Type: text/plain; charset="UTF-8"

Alright thanks for the assistance. Regards.

On Sat, 11 Jul 2020 at 19:44, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Fri, 3 Jul 2020 at 15:56, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > This patchset is essentially a resend of David Carlier's build fixes
> > for the Haiku platform. I've taken David's patches and put them together
> > into a set of emails threaded in the way our CI tools expect, as the
> > easiest way to get the patchew robot to run the build tests so we can
> > check they didn't accidentally break one of the BSDs. I've also put
> > in the patch from Gerd that fixes the drm.c issue. I've also expanded
> > on the commit messages for all the patches so that we have a record
> > of why we made the changes if we need to look back at it in future.
> >
> > Assuming no issues turn up, I'll arrange to get these into master
> > at some point before the 5.1 release.
>
> I've made the minor renames from CONFIG_ to HAVE_ where suggested
> and will put these into the tree via a target-arm pullreq I'm
> planning for Monday.
>
> thanks
> -- PMM
>

--0000000000002a8c2905aa2f1a23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Alright thanks for the assistance. Regards.</div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 11 Jul =
2020 at 19:44, Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Fri, 3 Jul 2020 at 15:56, Peter Maydell &lt;<a=
 href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@l=
inaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; This patchset is essentially a resend of David Carlier&#39;s build fix=
es<br>
&gt; for the Haiku platform. I&#39;ve taken David&#39;s patches and put the=
m together<br>
&gt; into a set of emails threaded in the way our CI tools expect, as the<b=
r>
&gt; easiest way to get the patchew robot to run the build tests so we can<=
br>
&gt; check they didn&#39;t accidentally break one of the BSDs. I&#39;ve als=
o put<br>
&gt; in the patch from Gerd that fixes the drm.c issue. I&#39;ve also expan=
ded<br>
&gt; on the commit messages for all the patches so that we have a record<br=
>
&gt; of why we made the changes if we need to look back at it in future.<br=
>
&gt;<br>
&gt; Assuming no issues turn up, I&#39;ll arrange to get these into master<=
br>
&gt; at some point before the 5.1 release.<br>
<br>
I&#39;ve made the minor renames from CONFIG_ to HAVE_ where suggested<br>
and will put these into the tree via a target-arm pullreq I&#39;m<br>
planning for Monday.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000002a8c2905aa2f1a23--

