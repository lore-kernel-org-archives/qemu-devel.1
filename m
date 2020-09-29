Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDCFC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A752120936
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oK65DcJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A752120936
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNIVU-00024A-GM
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kNIUu-0001dQ-43
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 12:29:00 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:41899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kNIUs-0003c6-4V
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 12:28:59 -0400
Received: by mail-ua1-x943.google.com with SMTP id n26so3651509uao.8
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hhzBC1AOjc7ScYdPVW7p644MkvB44mVD1SeXYl93jKw=;
 b=oK65DcJMNv10hznWgHOejeJcyTmPOvbV+oYu76tKd6d2u5R/tq8btAaSQfrTRd5qIC
 vjvtltqOWLZRgcpwjE/ZX/md1bp0xHpV6i3YA/GYyzz7Pjp/hzNZZiR3Zg2CXaBIBdt8
 /FQkP7XD6N2+KHYb6y2bGlUmrkdF4MTy0gx2e1LQ4cDBfEVyC7YrGI5I2A466H09+Trs
 xAy3TmLjcNPIZiwj9mPHPShHTJu1Pb31Ho0Jnn331UUEFE0DpMslypmJH6sSusOK19Es
 ouVp+/FJaVypab/81Fgv9L6ql4R0X1htZ51JJxFH9KWHR87NFdcPOWh7LA/sh9iqoIVX
 t19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hhzBC1AOjc7ScYdPVW7p644MkvB44mVD1SeXYl93jKw=;
 b=pTcmGVqGZjTETqQm2SnmsuEhl+lJ+UbU67RbTEd2fcsbhVFZpYECyFCKptCfijBrjZ
 cDd4HiX4jozpi8XJPl29G+6YLWYwkCf1akACncq8qiCDNw4WZvFQuaGZ81M+9XBTxB5H
 T9RnSDjFNvpintBAgQn3Kd/sFs4f6v8IjOfdGMumhFzI0auQXNuauzsGNHtWSL50DDFq
 1cP9aYFvb1x26pYPYoPNSjWjHU5sYuwpzNOfSIUEwH12STI47PqLrfejITxtZZkhn8Jf
 Mv4D3/wuZTQGGjVsRk6UOZk3dG+yq6JctM3VCOFnF1AUrtiP6Ydb7tOmwqFhjfHJS9kB
 eETQ==
X-Gm-Message-State: AOAM532HcmOPAmSZfhg4lkymz/s5R6+dG7gmwM1RkDmYRSHjwdexDEvW
 JYAeRJsQtKRZBUWICEo5PxBiXfjmR8klcMuU9q4uhw==
X-Google-Smtp-Source: ABdhPJzrgdX1bNv6l7Xf036ZusmyluOWOE+woB9j9xZNSShHNONUnY8kOtbb9d10iPLQ8+BHfRdxMCM+wBsoP2rO7a0=
X-Received: by 2002:ab0:390:: with SMTP id 16mr4832893uau.12.1601396935590;
 Tue, 29 Sep 2020 09:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200929003916.4183696-1-hskinnemoen@google.com>
 <c6d40849-7c80-9cd1-0a31-696f1175d463@kaod.org>
In-Reply-To: <c6d40849-7c80-9cd1-0a31-696f1175d463@kaod.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 29 Sep 2020 09:28:44 -0700
Message-ID: <CAFQmdRZbhF+BpLK8YVHLOL=Hu-JxcMEoDskidtT8t_j+fHtG6Q@mail.gmail.com>
Subject: Re: [RFC 0/3] QEMU as IPMI BMC emulator
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>, 
 Patrick Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>,
 minyard@acm.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::943;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x943.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.468,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Sep 28, 2020 at 10:27 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>
> On 9/29/20 2:39 AM, Havard Skinnemoen wrote:
> > This series briefly documents the existing IPMI device support for main
> > processor emulation, and goes on to propose a similar device structure =
to
> > emulate IPMI responder devices in BMC machines. This would allow a qemu
> > instance running BMC firmware to serve as an external BMC for a qemu in=
stance
> > running server software.
>
> Great idea !
>
> I started working on this topic some years ago with the QEMU PowerNV mach=
ine
> and the Aspeed machine. They can communicate over network with this iBT d=
evice
> patch :
>
>   https://github.com/legoater/qemu/commit/3677ee52f75065b0f65f36382a62f08=
0ac74d683

Oh, cool, if we split that into an Aspeed part and a VM protocol part,
it's basically what I had in mind. Are you planning to submit that, or
would it be OK if we base our work on it?

> This is good enough for the IPMI needs of OpenPOWER systems but the overa=
ll
> system lacks a few bus. An important one being the LPC bus which we use f=
or
> PNOR mappings.

Right. Perhaps the next step should be an out-of-process flash protocol?

> So, we added a little PNOR device in the QEMU PowerNV machine and mapped
> its contents in the FW address space of the LPC bus. With the internal IP=
MI
> BMC simulator, it mimics well enough an OpenPOWER system from the host
> perspective.

Cool.

> All this to say, that if the goal is full system emulation, we should may
> be take another approach and work on the QEMU internals to run multiple
> architectures in the same QEMU binary.

Interesting. Will it be too slow to run the server and BMC in separate
processes?

We might actually be more interested in going the other way and move
more things out of process, as we start to tackle larger, more complex
systems.

> According to Peter, this is mostly a configure/build issue and cleanups
> are needed to remove the assumptions that were done with single arch
> binaries. A big task but not necessarily difficult. I will help for
> ARM and PPC !

It sounds great to have the option to simulate multiple architectures
in the same process, and getting rid of single-arch assumptions seems
like a nice cleanup. However, I'm hoping we'll still support
multi-process system emulation (and the MultiProcessQEMU work seems to
be moving in that direction as well).

> Anyhow, the IPMI documentation you provided is good to have.

If you like, I can split off patch 1-2 (or just 2) and post them
separately while we work on the BMC-side device emulation. If we
decide to keep patch 1 and the block diagrams, we probably need to do
something better for the font path.

Thanks,

Havard

