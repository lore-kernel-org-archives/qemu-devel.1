Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17261C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 14:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B0B20818
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 14:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJ7e+Z1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B0B20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv09R-0005vb-37
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 10:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hv093-0005QJ-14
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 10:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hv091-0000Kl-PJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 10:08:56 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hv091-0000KN-K7
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 10:08:55 -0400
Received: by mail-ot1-x344.google.com with SMTP id b7so42588994otl.11
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gzgxtu0/dq4kwvaccOAO9rAoqxbKfC7HMKno1MSksXQ=;
 b=VJ7e+Z1Ol7lot7JU9WFcp8j272IHcxtN39+DctnTo9G72lkpiWxVQvh8fjHFF/Rfsl
 f0S9jBPfinAnzWkgP/DNPlqna4Sp/P2M8qeNv+dSSulsXexTs4HJ7wRQbaWnD6EzXWRg
 I74d1YmHkOEH87ltf21QOxo50iyf2tTN0ZTcZLWvBDoRtHq7Pd7zsUZwGdIU4vfAsarM
 31DRysbx5cQ7aYDIK7YHQmbGqQPCwywbBYqdy9do1SqxY6wVIh6rjr8PjcFvkwR4c+e9
 0P0wBUct7aK1ggypZrveaOihL3cEg4xzzHX7NO4YD1Re+va3PLDEc6onfqFoP9uX+SDw
 7o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gzgxtu0/dq4kwvaccOAO9rAoqxbKfC7HMKno1MSksXQ=;
 b=uDJ9BYwLeEM338jpnmwhO+umNPOVIkGDa8WSBPxqTavQJ/91V+OoSKrd9uNRdSHSzF
 CcERILZKMmnlRqFWC8BpbXqKOBqsbhoCXdqFuO3zJR7nyAolFc51XHeHjfdBtFw3a4D3
 oLsuhYIq5eeQejx3tiiYTSE0oKVJjbePX2zaagxOW/hbssyvbAZGPMhqilK4T6LsygVP
 dYX7X0hyW35HMDzxVLYowMcWS+PaPrXFRSS7nykMOsqzEjzTKxvNIeMXzbZ1lDZ5E52f
 6KiLVr097tA/3W/KBtGR8D70JexR0WzBj8cIM6TJzB8D/KJMqgKIZygPqrOAyEjhwx8+
 D4eA==
X-Gm-Message-State: APjAAAVR2Oy95bnz3qzN/sKtHWJ/clUQT017yelj0ODlAO3AOZqR6XhI
 LHg78CAAbdgpXPDzDYYaUUrZLl/H/Tk2uSHCR5NVJA==
X-Google-Smtp-Source: APXvYqyJmHdRnpzGZXBtp/cPO7SKrdCHxbUc9NhzLV2J51C4fmFWe5K8DQ4auU1VarTwB3+kZfIgLej34ieRk5tkKPk=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr3505008oti.91.1565100534453; 
 Tue, 06 Aug 2019 07:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190730054501.32727-1-rashmica.g@gmail.com>
In-Reply-To: <20190730054501.32727-1-rashmica.g@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 15:08:43 +0100
Message-ID: <CAFEAcA_-qLt4JzMkG7mm5wnVvrpC8qnO=XC0GWmcU2ZXoMQEtA@mail.gmail.com>
To: Rashmica Gupta <rashmica.g@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Add Aspeed GPIO controller model
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 06:45, Rashmica Gupta <rashmica.g@gmail.com> wrote:
>
> There are a couple of things I'm not confident about here:
> - what should be in init vs realize?

We are not very good at documenting this distinction (and there's
some bits of it I'm not sure about either), but:
 * init cannot contain anything that might fail
 * init cannot contain anything that affects the simulation
 * init shouldn't do anything that needs explicit cleanup
   (eg memory allocation)
 * property creation has to happen in init, because properties
   are set after init but before realize

Thomas did a good blog post on this:
http://people.redhat.com/~thuth/blog/qemu/2018/09/10/instance-init-realize.html


> - should the irq state be in vmstate?

I guess you mean the "uint32_t int_status;" field here?
If it's state that's in your device then it needs to be
in vmstate (this roughly corresponds to 'is there a flipflop
in the hardware that holds this state', though that is not
a 100% perfect guide). A 'qemu_irq' holds no state of its own,
so you cannot query it for the state of the line after migration.
So if your device model needs to be able to know that state
itself then it has to keep it in a struct field and migrate
that struct field. (For some devices the state of the outbound
interrupt line is a purely combinatorial result of some other
state: "int_output = int_status & int_mask" is a common one
where there's a "raw interrupt status" and a mask bit that
suppresses the outbound irq line. In that case the int_output
need not be in the device's state struct or migrated, because
we can just calculate it when we need it from the int_status
and int_mask state.)

> - is there a better way to do composition of classes (patch 3)?

No strong opinion. From a quick scan through of patch 3 it
didn't look obviously doing something in a suboptimal way.

thanks
-- PMM

