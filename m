Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC5AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582F82064B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEHwmOzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582F82064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Nhi-0007Xh-Jt
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmita.jha82@gmail.com>)
 id 1k0Nh7-00075k-7g; Tue, 28 Jul 2020 07:22:53 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:38498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asmita.jha82@gmail.com>)
 id 1k0Nh5-0000RE-LF; Tue, 28 Jul 2020 07:22:52 -0400
Received: by mail-lj1-x22d.google.com with SMTP id x9so20711589ljc.5;
 Tue, 28 Jul 2020 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vP/t8cDNXWnbX1wZAVLf05Fg8zwpZdlUul15GX6ugAg=;
 b=SEHwmOzsQeV/r2OywnThVx5TivJJffqxs/VZazl8Jxx2LRY4GoKcdSuwFgaXTQ0Oe7
 FLo8/06YCD2nHLbmEC4TT7hm7KM7EnI7QKckx6PMOz10uwUIWp1YUf1YwLCroGVgEv8j
 2oAiowkQgJeVlpNU+Tz1Yfo1kH6EA5Z6qQdS4C6OkVA9uQ2FIJWh8iSQ+qR7K8klaU1S
 b6Nu07RMGxunHigxqRb/CarbilxDSrKbJ9NksUIrWupN5REkVDom7iFvd8J10+jWeLE0
 6XzX8OLP4aBn3o5zI+Q24HaB7wktEtPV83pwi1lIEBQUCxGAEcSOT9QImxnGwK01NvR0
 d96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vP/t8cDNXWnbX1wZAVLf05Fg8zwpZdlUul15GX6ugAg=;
 b=qnYtrviR4Z+oOlbtZkIiftG26Uvr+tx8xO8h9/QOAUIizeR7MdZDtIkT8qOJmjEg28
 mADsNKzJip/IatbzzhKDhDmphZgc9wD6L8wVlgA/jCx0450bfSMcneKePYtyneI9VEAz
 Fpn8XzbOjsLLL046psYJ0PzuaclhjGEIP7nkWctTTWG5nEpL3L4CFUPu+dMd7YbghYvQ
 cFqzSwzzLUm6W3UzvuT3E+agAffM2PlN7EwdXX0fWy5J7hyDuUH43KV5+kKgvJCruqgI
 xz/QE2YXRcpW4gh274NnNkpxmA1C7vDVMvv7V6Oos8Kh8v1IVEszaKomQiYVijZWXa8w
 teQg==
X-Gm-Message-State: AOAM533ddel70umufvLD8ZMXKvDHtUSSXJVR6j4P0CeOI7gcnrdxzxeD
 GMjd/SnwVAtmJgpDC9285TzaSMRpN9fuNNwc4Mc=
X-Google-Smtp-Source: ABdhPJy9Ug+hTDfiinptOJhnUcG1uATz11ECfJO+B7IAaLvutPsT4d+Pb0TOmPwLcFZLuuLj8aNLKUj1F2p/Wt+o5uw=
X-Received: by 2002:a2e:8804:: with SMTP id x4mr3699774ljh.328.1595935368993; 
 Tue, 28 Jul 2020 04:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKBCQoBmk3rA=Ht=AVZkOUc0zDVJCVyX1GLbEWK97hodOfqDA@mail.gmail.com>
 <20200629131227.GL31392@stefanha-x1.localdomain>
 <CAKKBCQrhrYNULaV2q9YGd1vxeeCrexVy_cMbQBjJKxaRKYvf3Q@mail.gmail.com>
 <20200728103729.GD10336@stefanha-x1.localdomain>
In-Reply-To: <20200728103729.GD10336@stefanha-x1.localdomain>
From: Asmita Jha <asmita.jha82@gmail.com>
Date: Tue, 28 Jul 2020 16:52:36 +0530
Message-ID: <CAKKBCQogOZKhyZ0moNbA+51bynETn=FVFwujQpJP5TeQ9eHx6Q@mail.gmail.com>
Subject: Re: Qemu installation error from source
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c0e0cf05ab7ea84f"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=asmita.jha82@gmail.com; helo=mail-lj1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c0e0cf05ab7ea84f
Content-Type: text/plain; charset="UTF-8"

Thanks for the information. Yes this helps.

Regards
Asmita

On Tue, Jul 28, 2020, 4:07 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Jul 01, 2020 at 06:04:33AM +0530, Asmita Jha wrote:
> > Thanks  for your response. I am not sure I compiled libbz2.
> > Because while installing qemu from source , I just followed the steps as
> > mentioned in wiki.
> > I am noob in this field.
> >
> > I tried using ./configure --static, it gave an error as attached in
> > screenshot.
>
> In the screenshot the linker cannot find the library dependencies needed
> to build QEMU.
>
> There are Dockerfiles that show how to build QEMU on a number of Linux
> distributions. For example, the Fedora Dockerfile is here:
> tests/docker/dockerfiles/fedora.docker
>
> This could help you in setting up the environment (which packages are
> needed, etc).
>
> Stefan
>

--000000000000c0e0cf05ab7ea84f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks for the information. Yes this helps.=C2=A0<div dir=
=3D"auto"><br></div><div dir=3D"auto">Regards</div><div dir=3D"auto">Asmita=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Tue, Jul 28, 2020, 4:07 PM Stefan Hajnoczi &lt;<a href=3D"mailto:s=
tefanha@gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">On Wed, Jul 01, 2020 at 06:04:33AM +0530, Asmita Jha wrot=
e:<br>
&gt; Thanks=C2=A0 for your response. I am not sure I compiled libbz2.<br>
&gt; Because while installing qemu from source , I just followed the steps =
as<br>
&gt; mentioned in wiki.<br>
&gt; I am noob in this field.<br>
&gt; <br>
&gt; I tried using ./configure --static, it gave an error as attached in<br=
>
&gt; screenshot.<br>
<br>
In the screenshot the linker cannot find the library dependencies needed<br=
>
to build QEMU.<br>
<br>
There are Dockerfiles that show how to build QEMU on a number of Linux<br>
distributions. For example, the Fedora Dockerfile is here:<br>
tests/docker/dockerfiles/fedora.docker<br>
<br>
This could help you in setting up the environment (which packages are<br>
needed, etc).<br>
<br>
Stefan<br>
</blockquote></div>

--000000000000c0e0cf05ab7ea84f--

