Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8B5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A88207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3c9cTCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A88207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm1Dh-0000NV-RJ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jm1Ci-0008Ow-Sz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:32:08 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:34923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jm1Cg-00051Q-Vh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:32:08 -0400
Received: by mail-ot1-x334.google.com with SMTP id d4so5634554otk.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xgBZ+10QrapINCW11438zn3eSIExCwJ1tFs1YbjV0Z0=;
 b=d3c9cTCbG4C60IoP/0pjF3yy/ayXCwO04OekhF77Y4yF6l1kvvbMWsGdS/folSZOeA
 uz7VChoR3zP/wm+KsDe96O3KURsjBjn3vHVK6YvHqYyOh2Ngotpc6TN3V6opOvManqj9
 ZDzvHDxii6b8yWk7jcsbMe0l6j4p3A/bZxXqQ8c8IMwZABc3KIVN7di0wj5EsH6tSkJ2
 EI66QMosgnV2xh4bVT7HC0AtqobmVQR8fbO+sPstjifAKdRKmLON2J3bLrMGNliSyd2j
 UuvFU80taUaioLTSx2NAHZM+iKLkJrzm2hsMsx2PkH7qbR+k9hVxWAXw7dV4gCfJe18a
 A85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xgBZ+10QrapINCW11438zn3eSIExCwJ1tFs1YbjV0Z0=;
 b=BoxrrvoA0Zj78XRt9xNufBHItnMe5S3MTT0T4Hka2n7lWIzWFlmD/JkEjYnyd5Iaz0
 pet9eNdUjd4jOT5lvhOv9phqBrBqCOK1xVO6tS3nwK7Bq4gqpo3uuVW54m6WCuMVwP7z
 JQcgHhAz+m46Y7HA/xBVoToufJWo/ewMfXYPOD57KPhJo9Zy0GH7P6xJ2UWsVBQ3eFls
 407na9zkY07JDAoCD7pU69znOKAQy2qEtN6q4fwXD2Gyb8iU15Ex82heOzaVveVrrJIH
 tSkjEs/N1nYbQQIqiYk/2hTkVVrK9oaSXCOfTy8iq4PIhgLGp2yI5lBf07DPK39R0jvw
 TV/A==
X-Gm-Message-State: AOAM531G92h2yONU7PEJWQlygaCWWhqhW2QWgIs/AvTf1CX7sA9ELPG4
 32/MezH3esl4xF9gZpYUzvXLwSk6M5T/yw5/w/LPnw==
X-Google-Smtp-Source: ABdhPJwF9zijJfzyqugJ0r0reN9nliDeaWGH14Xibs00YDMuNgKPm/N+YyC+RtDHM8Ia9Vxuk6tgeGDgsVQpCwff0rA=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr410299otn.221.1592512325601; 
 Thu, 18 Jun 2020 13:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uyW33vsUTNMPpKN=S-obPWf+EZwS3TiznJgq4Av7R-3tg@mail.gmail.com>
In-Reply-To: <CAM2a4uyW33vsUTNMPpKN=S-obPWf+EZwS3TiznJgq4Av7R-3tg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 21:31:54 +0100
Message-ID: <CAFEAcA8LULxscffJvbDOTNyeSpZ0vkJoxgMWN1e5VDQ-ym6uYw@mail.gmail.com>
Subject: Re: Usage of pci bus
To: Gautam Bhat <mindentropy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 at 20:36, Gautam Bhat <mindentropy@gmail.com> wrote:
> I am confused with the usage of PCI bus for connecting different
> peripherals. If I want to emulate an ARM board which doesn't have a
> PCI controller how can I emulate it to be as close to the real board
> as possible? Is there an ARM interconnect or something where I can
> connect the peripheral controllers and the peripherals to these
> controllers?

I'm not sure what you're asking here. If the board you want
to emulate doesn't have a PCI controller, then just don't
implement a model of a PCI controller. You won't be able
to use any PCI devices, but that's fine, because the real
hardware you're modelling doesn't have PCI devices.
Most of the devices you emulate are going to be the simple
straightforward type which have some MMIO-mapped registers
and an interrupt line. In QEMU we call those "sysbus" devices;
there are lots of examples in the tree.

thanks
-- PMM

