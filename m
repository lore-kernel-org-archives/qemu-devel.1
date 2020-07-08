Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC71C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577E120708
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgEnv3tC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577E120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtGR3-0002jM-Lt
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 16:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtGQN-0002Co-6h
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:12:11 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtGQL-0000cS-25
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:12:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id d4so91662otk.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T25QxnJT8Tg64T4WzNZ3qJHfCnNjmcdAJFHkhMaxhiU=;
 b=fgEnv3tCBeXdvKm83K5t/c8UWCD6v8E0KQyjjCMtiXSL8D3qhEzyru4JwLI+uGN2e8
 ddmy6EI00SxGz+pYFUMcEe+NwxWWXNODnSp05TGEbL7cb5iPAEDO4a4AAUhbF0mwxW/w
 DUnPitGRK4u+m7ZdPSWEa8eCYu3m6tMZr4k/EaMF9mj7AX3jgB4M99CIq6bOFA5R3Q0q
 wCjWMYyqSJ7fhesQSH/PSkB65f3AOQHcLDMtV8Sj7lmppgAKCluFruSoTP7UsYlA0Yn6
 b9QVJgm0oAdOHzAe7MrgS5MVm9SZpNwf2mpDmYbAdg4oniTmyWlcronLyQUK+uqVS2vg
 Kzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T25QxnJT8Tg64T4WzNZ3qJHfCnNjmcdAJFHkhMaxhiU=;
 b=TuUXvEeZBLLMyGTdEhflx68OP5vfiBp+a61W9yusqigmCyKuGHNU0w7nnDANrd3Ncp
 5G5Nj6YnguvrJL4La9oF5edHD0mBxXFI/UyHZIxArct34RVC5zESZbWz/Naa9UlFenUj
 +VwdmtNMUsNVONE3jeXhY6p6Fuw70mVRZ2DLOunYh9mNtA+BBOeK3FO1dAGuxUhbF8bK
 AXJ8doIsRrRdgGgLvXTzH3hau8Mv1wPRVvmror7Kt8gP7oFV6yoZTIEfgaejpVKxVLhx
 5tYaU1XyQCK9i5DaDPQBjUUWtnpwga+LTeO/9Wa33vLFATjeWLFYD0NsDsGZxpSSIn/n
 4Hag==
X-Gm-Message-State: AOAM532NkHwPfUqf4p/3IBOCjRFMxYS/998i8CyO+bODM5DVz/lxgLh8
 ylxM73eVXSNzMplSdTUv7mStSTMzQMos5VE5IpWOnQ==
X-Google-Smtp-Source: ABdhPJxW2W1ZdzBwZhbwJ9YILYYNk8VR0a2jUrv6W+cLL/lU5lwy2Xi2OEC6VGxzyKB2l9lpQUF1TJYikObx+7jaKAE=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr44123272oto.135.1594239127024; 
 Wed, 08 Jul 2020 13:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net> <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <CAFEAcA8mFM-O=mgCQHNz4TNB5N3Trid2o95s0Nx7JVp_q_dSrw@mail.gmail.com>
 <20200708160316.GA7276@habkost.net>
 <CAFEAcA89ueUQuVPC9O9xqbBBDEzdXmbCLL69OHvk0MJ=VvSnbw@mail.gmail.com>
 <20200708173620.GB780932@habkost.net>
In-Reply-To: <20200708173620.GB780932@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2020 21:11:55 +0100
Message-ID: <CAFEAcA_bLs+PzjfmCaHQQ3z1BrQ9Uack_Qj7Za-dJwtHWu=8kw@mail.gmail.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jul 2020 at 18:36, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Wed, Jul 08, 2020 at 06:09:49PM +0100, Peter Maydell wrote:
> > Exactly. It appears that there's a bug in our mechanisms,
> > which is why I'm suggesting that the right thing is
> > to fix that bug rather than marking the CPU as halted
> > earlier in the reset process so that the KVM_RUN happens
> > to do nothing...
>
> I agree this is necessary, but it doesn't seem sufficient.
>
> Having cpu_reset() set halted=0 on spapr (and probably other
> machines) is also a bug, as it could still trigger unwanted
> KVM_RUN when cpu_reset() returns (and before machine code sets
> halted=1).

The Arm handling of starting-halted sets halted=1 within cpu_reset,
based on whether the CPU object was created with a
"start-powered-off" property.

I'm not sure in practice that anything can get in asynchronously
and cause a KVM_RUN in between spapr_reset_vcpu() calling
cpu_reset() and it setting cs->halted (and the other stuff),
though. This function ought to be called with the iothread
lock held, so KVM_RUN will only happen if it calls some
other function which incorrectly lets the CPU run.

thanks
-- PMM

