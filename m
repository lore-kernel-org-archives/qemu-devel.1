Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF26C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4279D208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOnH0KeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4279D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0bO-0006Mu-6U
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVzvi-0005Bh-Se
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:28:39 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:41529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVzvg-0001AZ-Th
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:28:38 -0400
Received: by mail-lj1-x233.google.com with SMTP id p15so2194411ljj.8
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=ZngIh3I0UxdpWmpzcKTePZFXrpYnh/iTyYpxYyoY0M0=;
 b=iOnH0KeB5HgfTQRebijifFaeGPO1RUj6Mca6Zh9LxHKgXCoqWE6Gw5ZI+ziRH7BzrI
 utNcxs9X2ILOyHLNwuIkCOdIqH88K4jCCQWcYm8cObPDEmzNYWYkg1DMhdaGSlZwFRXU
 55kVxm1c8gIdZpKmPLHwInFmoOKGIESsfBUTYwKfWzifDKNeJX5CagxS39g5KgPrJa3e
 pBq3GCjJ2+wWmz9s5t/ZiJsaMEAGBKiVFn3fqw2l43yQoIKhQnJXyCnbird9QFB/dymc
 KTL3cyqQwxFHethYqWLjoGYIrHjNrdugcRUE+Z9a4sUt4JpaDMO9pVXLV9AIUd1KbIF2
 Ejhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=ZngIh3I0UxdpWmpzcKTePZFXrpYnh/iTyYpxYyoY0M0=;
 b=pCnMut9U4kb8AhajIYOMV/USPlZXvNX35kH1LJH/TsyYjz3StncbXCeph2a2vtvee1
 aq6HShlkL8teeNgChniA+MQLOl/WuFoCAjp1iA3YzwKymKPg8RoeTJjfiz+Np4EXeKmj
 cQw//aIAt6DwcRnTrzPMsvOX2i8CXN2BpXVZCJD4ZLLe9BZG2r2TXojT4lVwjAKbSPTW
 99iS6fNbK9TJx21MbFe2CD+Ws7ceOlZpo1wESn5JawAkgynSVudgk1sF7SOaz/zTo9Xc
 Tcu9BYKZXoBHmnUCz8z9o/yQFa2HS8/eVQqS9Q6ws+fW+PcBaRQodeo5haR8hxhUdpnS
 kWQQ==
X-Gm-Message-State: AOAM531XHgkCktzz+RFY/PBz639wvNyv/Gt8qPhTiTb76p/a55k3NLuE
 GsJRxwy6o3AUNWS79l1+cAtQI+l0aMlXHpRUvsyY/A==
X-Google-Smtp-Source: ABdhPJzkJdk82uptBRK3p/TqajVDA8Nhq6AI2+KN8wcopmUTTASGt5ci5N1lddVRKU8U0nRhkAkW5t90+OH4lwYTRnQ=
X-Received: by 2002:a2e:a481:: with SMTP id h1mr1292265lji.207.1603470514580; 
 Fri, 23 Oct 2020 09:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <87o8kttj2e.fsf@linaro.org>
 <20201023105120.sqharyxujgh7nppk@sirius.home.kraxel.org>
 <87d019tb0u.fsf@linaro.org> <20201023123217.GA18593@xpredator>
In-Reply-To: <20201023123217.GA18593@xpredator>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Fri, 23 Oct 2020 17:28:22 +0100
Message-ID: <CAHDbmO2_6=MgcJBgy3f8K4tkjHs_c34CvoL_krob+55CwL32hw@mail.gmail.com>
Subject: Re: [agl-dev-community] Tips for debugging GPU acceleration.
To: agl-dev-community@lists.automotivelinux.org, 
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks - that seems to do the trick.
I can't find where in the agl repo that is set. The recipe seems to be in:

  meta-agl-cluster-demo/recipie-graphics/wayland/weston-ini-conf/virtual-la=
ndscape.cfg

but I can't see where the "transform=3D270" got added.

Visually it looks a lot nicer now although I could still do with
getting rid of the quite large AGL lower banner which is cropping out
the main display.

On Fri, 23 Oct 2020 at 13:32, Marius Vlad <marius.vlad@collabora.com> wrote=
:
>
> On Fri, Oct 23, 2020 at 12:52:17PM +0100, Alex Benn=C3=A9e wrote:
> >
> > Gerd Hoffmann <kraxel@redhat.com> writes:
> >
> > >   Hi,
> > >
> > >>   [    2.930300] [drm] virgl 3d acceleration not supported by host
> > >
> > > Nope, not active.
> > >
> > >>     -display gtk,show-cursor=3Don \
> > >
> > > Needs -display gtk,gl=3Don for opengl support.
> >
> > Awesome - even on TCG the display is now nice and snappy.
> >
> > For bonus points:
> >
> > The AGL panel display is rotated 90 degrees which is putting a bit of a
> > crink in my neck. Is their anyway to rotate the view port. I tried
> > inverting xres and yres but that didn't do anything.
> Hi,
>
> The output is rotated, edit /etc/xdg/weston/weston.ini and comment out
> transform ini entry from the Virtual-1 output section. Reboot, or
> restart weston@display service. Note that the apps are optimized for
> landscape.
>
> Enabling 3D with qemu might be something worth adding in the docs.
> >
> > >>     -device virtio-gpu-pci,virgl=3Dtrue
> > >
> > > virgl is silently turned off in case opengl support is not available.
> > > Ideally virgl should be OnOffAuto not bool, but I fear changing that
> > > now (and start throwing errors on virgl=3Don if opengl is not availab=
le)
> > > will break stuff ...
> >
> > At least a warn_report maybe?
> >
> > >
> > > take care,
> > >   Gerd
> >
> >
> > --
> > Alex Benn=C3=A9e
> >
> >
> >
> >
> >
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8772): https://lists.automotivelinux.org/g/agl-dev-co=
mmunity/message/8772
> Mute This Topic: https://lists.automotivelinux.org/mt/77748325/5085169
> Group Owner: agl-dev-community+owner@lists.automotivelinux.org
> Unsubscribe: https://lists.automotivelinux.org/g/agl-dev-community/leave/=
9010164/1597297750/xyzzy [alex.bennee@linaro.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


--=20
Alex Benn=C3=A9e
KVM/QEMU Hacker for Linaro

