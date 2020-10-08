Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545C1C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5608217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEDom/NU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5608217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYCN-0006qO-Ja
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQY3E-00080m-Ks
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:41:53 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:33920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQY3C-0001TB-GQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:41:52 -0400
Received: by mail-ed1-x52d.google.com with SMTP id x1so6328628eds.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r64ZZx9bjWtXBdUUIcYa87604w1d3wlv8wpaQqXSNBs=;
 b=NEDom/NUNRHB0eufjsiezHXHVVl45V0GGbwJhWvFJMChVLUzwWm0LdtQyUx/2kLUW2
 3mjJUN5twjjA3D2j5hFMD//sTd69aSj9rYgGf02FsR8q+GXyPPAdXWly5nyDm2ZRLPV/
 Hdq6MulXotThxagrGzZ9KWlnhTCDCv+ylinS/ZuK718DmBMcCyrhQ4XxTWz4CcV+riFS
 EeZMUrKrcPEWoGjr6lf5J5bo98Af/6WKffzgUSYvUc3jMcyrGJJ7GMbW8rd8s7p8HV/6
 ShVo7y+ADjpjynyEnuDDKSgCGA8ezToXcjg5WH9lZk6Xskoz767JIHj2xOQwLvnDWEze
 O2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r64ZZx9bjWtXBdUUIcYa87604w1d3wlv8wpaQqXSNBs=;
 b=eqpMl3n4d7q9ZMvXwj5DYVbRe4zS2KbA0rrq77yseSRX/nWYQch0ndj8F/LXNVSDXi
 KzXB4xNXl6yZPE+79Xz6QrsD7t77DYVGXyZlPeNkKBWMRuUF/EUB4weKrH62ngYRhnTq
 AqKNcbaaZdzSP5Ey9UDQCDGF+XPmBchG3T5u/n8Mdf8qt+iNpQky0Pwn/u++XDdE/eIQ
 FEE62U8hVJe40Iz8xZ0Vr95NAofiJ4fQq/pbIZnVhU2O4mM8WGetdXA83MaeR+qCU85W
 Mf9nRRw/UVGpPyJDdboRLEvQwNRGWZp8Vulxm5zyDWTp+1F10k74w01qaNTyYEwUGGNB
 lfFA==
X-Gm-Message-State: AOAM532rfb37pe1SoUsojldF4tCegtgjr4l/o1k/Ap8gEYeZ4cK0DWM9
 d6bpMIhzGPaiaFjvO5pUas7/OBFj9PuOfK8pWMPx9Q==
X-Google-Smtp-Source: ABdhPJymr1L5xyunOcy4oj3bbm8HgyYr61RxhBc7l7QJilRUQfiAJFgGnhWuhtR/KZxpBVlq/CL6OcBGzcAMuDYbO/w=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr9421777edw.251.1602171708747; 
 Thu, 08 Oct 2020 08:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201006220647.GR7303@habkost.net>
 <CAFEAcA_se7jErv9AFM2D7UdDMurB9Lb6W9aAXD6648spQ6idKg@mail.gmail.com>
 <87mu0xyrtn.fsf@dusky.pond.sub.org> <20201008151521.GB7303@habkost.net>
In-Reply-To: <20201008151521.GB7303@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 16:41:37 +0100
Message-ID: <CAFEAcA_=uScLjGR6vHbjsQK0-jgNuwNK+jcNf-u1yAh-863+2A@mail.gmail.com>
Subject: Re: Purpose of QOM properties registered at realize time?
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 16:15, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Thu, Oct 08, 2020 at 11:45:08AM +0200, Markus Armbruster wrote:
> > A first class static array property, where the size of the array is part
> > of the value could perhaps cover this case.
>
> This is an interesting idea, I think we should explore that.
>
> qdev_pass_gpios() would become unnecessary and could be replaced
> by a single (static) alias property.

At least in the current implementation, aliasing properties
is not the only thing qdev_pass_gpios() does -- it also
updates the NamedGPIOList data structures. It might be
possible to reimplement it so that we really are just
aliasing properties, though.

thanks
-- PMM

