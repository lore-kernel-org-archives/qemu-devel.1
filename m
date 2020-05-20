Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CB3207F9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJTdIgX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CB3207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbWDu-0003SR-KF
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbWD7-0002uY-Mw
 for qemu-devel@nongnu.org; Wed, 20 May 2020 17:25:09 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbWD6-00066I-Tf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 17:25:09 -0400
Received: by mail-io1-xd42.google.com with SMTP id x5so5003205ioh.6
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6OYnsSR7sKf0SE3rwJvyWJ+4Weg+TwKAwgMopLFOfi8=;
 b=tJTdIgX74ZlpZybLZG/ydjUI6kBHIwFqk3EGurXp8vC7AfZqL4HVCQ73vctrLJ7j82
 +QBY37yWNKeKPTRbwTCrkxrWaZHaJ8JpJ6GNqQVwofOxzj+uYRvgH2gLLoXAyWBprnow
 wywfpkFAyjBxK/Hvi0LtIzg2/GCmPIMexfC0BcnqftF1tKAZSe14M2ZKByuOT0wcqiPS
 B2tfBs4vX1u6wvLavw/5i+Bst68gxqaVXIdMmDCAoZKGboKVnqK2mFkjheI6jQEzVpLe
 imEj77gBkcMGxgZl6U0XnImGU9CIo3p1IbumimemLDUkwtMw0Cnzup8xCHcLwk3I2G6V
 Ug8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6OYnsSR7sKf0SE3rwJvyWJ+4Weg+TwKAwgMopLFOfi8=;
 b=CAo8zH5zZgxdD/1SkZn7yoZT5cA+bi/WB5Rd7e6zj9VMlq/J9XtbA8+dU6ooPkGdG1
 gbj+IWau7iAx6aug/K5TTcSvCTpgdX1KJZiiSwu77s5cjyZfqT848h1EsFGEtSgCYiep
 8yzzhpg+wvD4TQwEP0G2x4Odv+jLbB7qRL2EPiwmnorDZS1e1FEGTZxA6wTEUhlTTs/8
 rG/6xQyOom+m8/dq3uZsxuewBmvB+3mmlawoQruxM3dG9dpIcBNsvHnZFit5ttOyJdGG
 RgDYZ12GQO3LR9NSDtQJL9wJUoBkLOCSE/4KnhvuvpnI+wpdWZ7WI1fWpRrZn0k99i7E
 M9/g==
X-Gm-Message-State: AOAM531BEA4BV95qPsEYahw/IF/qupShEdtGWG2u5ivpa4s5u1iokPHV
 WxcbY+WK4m676u3N7lvJMZACG41th6zzbFSBkBk=
X-Google-Smtp-Source: ABdhPJyGStmNLWGsW08qBGHKjvPVwBA3fR2eeMieK7whhuPWrPxQE/AmdYVuoiu4GwZDlrCY1H1XaqZFaKN9DBFehEQ=
X-Received: by 2002:a5e:d506:: with SMTP id e6mr5259098iom.184.1590009907639; 
 Wed, 20 May 2020 14:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200512064900.28554-1-pauldzim@gmail.com>
 <20200512064900.28554-5-pauldzim@gmail.com>
 <CAFEAcA8ru0DyVTvVcTjf0AH8wi+d64m=iP_qbHrsLnGt65Y0Kg@mail.gmail.com>
 <CADBGO79puzxx8dC2_kxe0eGJ34fn=DwwgNfL9xSBt=dQvEcOUw@mail.gmail.com>
 <CAFEAcA_SVkgtr959SGKCgdFHX15pq-bkHXbF5RvMJXhVgBfb0Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_SVkgtr959SGKCgdFHX15pq-bkHXbF5RvMJXhVgBfb0Q@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 20 May 2020 14:24:40 -0700
Message-ID: <CADBGO790Wy5rQqi1VSROe9pfVWef=_6-6opxjh7cojgKZU+CZQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dwc-hsotg (dwc2) USB host controller emulation
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bbfedd05a61b0780"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bbfedd05a61b0780
Content-Type: text/plain; charset="UTF-8"

On Wed, May 20, 2020 at 6:18 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Wed, 20 May 2020 at 06:49, Paul Zimmerman <pauldzim@gmail.com> wrote:
> > Is there a tree somewhere that has a working example of a
> > three-phase reset? I did a 'git grep' on the master branch and didn't
> > find any code that is actually using it. I tried to implement it from
> > the example in reset.rst, but I'm getting a segfault on the first line in
> > resettable_class_set_parent_phases() that I'm having trouble figuring
> > out.
>
> Hmm, I thought we'd committed a change of a device to use the new
> mechanism along with the actual implementation but I can't see it
> now. Damien, what's the status with getting Xilinx devices to use the
> 3-phase reset API?
>
>
Never mind, I found the problem, I wasn't initializing my class properly.
It's working now, I'll send along a new patch series shortly.

Thanks,
Paul

thanks
> -- PMM
>

--000000000000bbfedd05a61b0780
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, May 20, 2020 at 6:18 AM Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 20 May 2020 at 06=
:49, Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com" target=3D"_bl=
ank">pauldzim@gmail.com</a>&gt; wrote:<br>
&gt; Is there a tree somewhere that has a working example of a<br>
&gt; three-phase reset? I did a &#39;git grep&#39; on the master branch and=
 didn&#39;t<br>
&gt; find any code that is actually using it. I tried to implement it from<=
br>
&gt; the example in reset.rst, but I&#39;m getting a segfault on the first =
line in<br>
&gt; resettable_class_set_parent_phases() that I&#39;m having trouble figur=
ing<br>
&gt; out.<br>
<br>
Hmm, I thought we&#39;d committed a change of a device to use the new<br>
mechanism along with the actual implementation but I can&#39;t see it<br>
now. Damien, what&#39;s the status with getting Xilinx devices to use the<b=
r>
3-phase reset API?<br>
<br></blockquote><span class=3D"gmail_default" style=3D"font-family:monospa=
ce"></span><br></div><div class=3D"gmail_quote">Never mind, I found the pro=
blem, I wasn&#39;t initializing my class properly.<br>It&#39;s working now<=
span class=3D"gmail_default" style=3D"font-family:monospace"></span>,<span =
class=3D"gmail_default" style=3D"font-family:monospace"></span><span class=
=3D"gmail_default" style=3D"font-family:monospace"> </span>I&#39;ll send al=
ong a new patch series shortly.</div><div class=3D"gmail_quote"><br></div><=
div class=3D"gmail_quote">Thanks,</div><div class=3D"gmail_quote"><span cla=
ss=3D"gmail_default" style=3D"font-family:monospace"></span>Paul<div><span =
class=3D"gmail_default" style=3D"font-family:monospace"></span></div><div><=
span class=3D"gmail_default" style=3D"font-family:monospace"><br></span></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000bbfedd05a61b0780--

