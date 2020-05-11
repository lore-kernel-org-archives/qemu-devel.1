Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE325C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FA0206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byIVLSJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FA0206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4Vg-0001PA-M9
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY4Un-0000Kv-F2
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:13:09 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d]:35698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY4Um-0001Hw-Ih
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:13:09 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id x13so2245652qvr.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qUbGAK5CfxdKWBwJaiIwNHINFDgmUVSdz3CMTuva/C8=;
 b=byIVLSJcn0lDO6xRS5D8K8QoAhFY2Du9yQYomptEvgsbBZda5/AOvpH/RycAd2msNT
 qR8rT/PDdogybAMYwMSD3b8f8a5QOdPlMjw7ZFQlJwUbmmEOtJAcRgo6CgB/me2Tw+k0
 04r6qvK9i8Ro7GcjaywwJnXxsvPmnf/m1oK667ARvgewR8K6MMGV64H4JksTLgriQM6u
 fkQ+PVzkxR2bUdzxZrBxxD2ZrdYXz5PjPdA5CXdIXV0HSyOHk5Dr5bSTj8EiAo0N8SM1
 HHvLpXB7MI8iU+TqXs+0ieANjE1GXktk/9EYAKIE3OU10ZJFfM89MGBIu+F2I0+8UvDZ
 MvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qUbGAK5CfxdKWBwJaiIwNHINFDgmUVSdz3CMTuva/C8=;
 b=SyawAqdeHKDxjF3AuHEuAyLngbIb+6elNr+Gx2WizYVNOYkfyREBa6UeG1Tobx3kTq
 LU5TpnHyGO2dl1rJLEZL+n7DNkvcvsj3ieoHJpBP4DJVpscOf7sAPtCkgYowmnP7vJjX
 o06rfwwP1lScGb1gNrlG6CWV3kxR/WJBz5+YMQt/nmLv434sVD9Nl3x7lu2AZvbWzcXA
 StHZtr50FU2FMeIRTm2s4snifqUC6ciPdh9QFTBkcxUrW/LXrl3ivUR56+oN7NP9LtxJ
 rexlEtL7nTV7Ysc21OJ60CbUviSRLu2NTmxM+7IKTnEn7M/DSbRcLHu6ECz21NFkurpX
 Oc9Q==
X-Gm-Message-State: AGi0PuY4ESyIRBkV3jzSMmAM8jLZklsnVH6HQ13KlEn7DFI7+9SY84HT
 VK8CEgtmt4Tx/lpGoo/sbiI8IicPkqLDWhNjkCY=
X-Google-Smtp-Source: APiQypKCrKhVMCtbrr9jnR3MXYw5P5UV+JVYEyiJ6hMNJ/4Iem6rGX69HPtNA7obH/oxiNBPS2h1amJdXjZ5ur15eEE=
X-Received: by 2002:a0c:ee4b:: with SMTP id m11mr15014202qvs.218.1589188387304; 
 Mon, 11 May 2020 02:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <158901182209.5021.12832610872088111923.malonedeb@soybean.canonical.com>
In-Reply-To: <158901182209.5021.12832610872088111923.malonedeb@soybean.canonical.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 May 2020 10:12:56 +0100
Message-ID: <CAJSP0QW6hE=Svo2RrUpLeamsC3LwCPef64923dJZTQA9JnO++A@mail.gmail.com>
Subject: Re: [Bug 1877716] [NEW] Win10 guest unsuable after a few minutes
To: Bug 1877716 <1877716@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=stefanha@gmail.com; helo=mail-qv1-xf2d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>, anatol.pomozov@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 9, 2020 at 9:16 AM Xavier <1877716@bugs.launchpad.net> wrote:
>
> Public bug reported:
>
> On Arch Linux, the recent qemu package update seems to misbehave on some
> systems. In my case, my Windows 10 guest runs fine for around 5 minutes
> and then start to get really sluggish, even unresponsive. It needs to be
> forced off. I could reproduce this on a minimal VM with no passthrough,
> although my current testing setup involves an nvme pcie passthrough.
>
> I bisected it to the following commit which rapidly starts to run sluggishly on my setup:
> https://github.com/qemu/qemu/commit/73fd282e7b6dd4e4ea1c3bbb3d302c8db51e4ccf

Thanks for bisecting this bug! Arch Linux can work around it in the
short term by building with ./configure --disable-linux-io-uring
and/or removing the liburing build dependency.

I will try to reproduce the issue and send a QEMU patch to fix it.

