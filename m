Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFD82053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKOupgfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFD82053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIpm-0003Ro-Jb
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiIgO-0000rO-Fg
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:23:24 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiIgN-0005LJ-8e
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:23:24 -0400
Received: by mail-ot1-x343.google.com with SMTP id g5so13756841otg.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tPUSdgkNqRgn8rtdqR9ikhIUybs05cEFLM9cKDAxYO0=;
 b=CKOupgfechEpD6aT26TaLux3dmyikxrLPP2RSXasIiRp0U8Ix2BTm0/RZW2AVtiesD
 i2HXbXlB0I1r9ijbxylXZ+lS1q+LmGmJnl+42dWw9qtCpbH3JeUV4ueUMgJ/V0WIITmh
 4WMDbhUA0d4iAiocf/zKQS+v575kaXMlzdqSnT0ubDd9ZFKX7a14Tcx+C6t8oBuWzu/y
 SU3YEPlCJnZzHb/6Hv0rlpsQpNYKIIH11qYwM9J/nnuRqRHjsPaz+TpcKAgE4pqfw+A+
 D3PH6g5AD0b9MJyJlQtvdpsnN5IymcJvciViGdYNnrZlc7I0hfS12/pcudxJIasxpP6E
 SmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tPUSdgkNqRgn8rtdqR9ikhIUybs05cEFLM9cKDAxYO0=;
 b=iDAOpLkGbQIJ1JbNzzIAJIOTWidqqSMQ2uHldtsR2dgwB3kwgs4jRyEzxW3CUaRU3w
 JXRL/dnwErT4EcSBGBLvAKStEUm9N2PZPAN5yBD5ZyWCDyYfDggCWQGR3A1iA5osAEYk
 GVJY6JVDWjWCH7k6qXj5LeebhCK3AaVS2+7f91Zd9EuzqzSq+GK35E+imwhTRehwYGqK
 8K830A22ez6ovq0YE21Nb2iCBlTwo8AYLAuibj452QszTieig4mLzOJZKZqlz42fV+EJ
 TQkNCcFLYARLMNrth1U5Dl5sOJnMVNwkW3JFQHBjcT+nZhq0bxYVY1idjfKN6BPOysRT
 otcQ==
X-Gm-Message-State: AOAM531K0xaQUDAKrf1jNWenJ0pn8XDVJ/fpUJcLuJdbLfINOohT/ilE
 zB7+F2eqNqFyc268XgpcYk/Lh9msDqzdPoM6BD853A==
X-Google-Smtp-Source: ABdhPJxcofOLCij+FWeqCU4G/bl+63i5R93RPbUAb7Ny7EB44ILkb9fo2vamKJXUcUaQ2TAhyPK8TXnjjy35V6IrAe0=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr18273561ote.135.1591626201767; 
 Mon, 08 Jun 2020 07:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-7-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-7-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 15:23:10 +0100
Message-ID: <CAFEAcA_GC_ds0-qM-+-Dkza8CggP741Fv7i8T7+=R6abxUKRzg@mail.gmail.com>
Subject: Re: [PATCH v2 06/24] armv7m: Delete unused "ARM,
 bitband-memory" devices
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 at 12:04, Markus Armbruster <armbru@redhat.com> wrote:
>
> These devices are optional, and enabled by property "enable-bitband".
> armv7m_instance_init() creates them unconditionally, because the
> property has not been set then.  armv7m_realize() realizes them only
> when the property is true.  Works, although it leaves unrealized
> devices hanging around in the QOM composition tree.  Affects machines
> microbit, mps2-an505, mps2-an521, musca-a, and musca-b1.
>
> Delete the unused devices by making armv7m_realize() unparent them.
> Visible in "info qom-tree"; here's the change for microbit:
>
>      /machine (microbit-machine)
>        /microbit.twi (microbit.i2c)
>          /microbit.twi[0] (qemu:memory-region)
>        /nrf51 (nrf51-soc)
>          /armv6m (armv7m)
>            /armv7m-container[0] (qemu:memory-region)
>     -      /bitband[0] (ARM,bitband-memory)
>     -        /bitband[0] (qemu:memory-region)
>     -      /bitband[1] (ARM,bitband-memory)
>     -        /bitband[0] (qemu:memory-region)
>            /cpu (cortex-m0-arm-cpu)
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

