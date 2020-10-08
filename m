Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDDDC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20872083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnK0u8W+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20872083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQSki-0003m4-Gj
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQSjY-00039i-Nv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:01:12 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:40621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQSjV-0001Vc-N3
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:01:12 -0400
Received: by mail-ej1-x62d.google.com with SMTP id p15so7223864ejm.7
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eloJToFC63NRjpwM8VbhiW+S7qE4fG6bP32gqbRdD+k=;
 b=QnK0u8W+wVMbGRCeazs2dDyNdOlbNEzt8uirEZsCt5ypeiw/supPdgEebDQ0A7m2Ri
 EmCEDXKJbcdFadyNZdPk7pNAVxARHckeoW5eEjZePyhICgpo6DPjcSxEh/2Dq7O0H4tu
 CH6vcR7saT5SWbvzvZBXxLNpAYxWDb5pl+74UTJvBVmqRqS1pXkb8OovFkODyNGXj5nj
 Oe9rpXZencEiyGRLIChDA9LuGCCZe0hcuzrHY7s1gX+we3kbIYXFNSYvGKNCWhpGP3qD
 xr6ra93x8kQ2d6xOU9kQpzxPIX48dZmVnvAPoD7IcJfXdFLap3zN19sWX9e682t1PMx4
 M8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eloJToFC63NRjpwM8VbhiW+S7qE4fG6bP32gqbRdD+k=;
 b=cj58nzFnXkYE3/1f3fbCzlM1fhpODQcH1dmQSPoO7/AMmKF1YPuiaie6vUE6GbhNrd
 ADKrezoBBJ8a2i0iMK5+S3Q5F10bvvf2+gaE2jKMU5+zEowMJEI3pd+7DtgnzOiXLTgV
 S2fOEg5Ny2/68bS7IU7PrIV8awbhpXnaOs52MYmbfBng5HCVVw9SWq6aowi9LAM0IHEp
 c0CshMVn3Glxhu7csl1nd4zhcXfkECvxCqDwVwNif3mzU7vEpGvS1QD8iy9s9GEwd8eK
 wsg/dVLSTbI2Rl5/JhVVdWX7D8Kt6zveCidI0RaPiohLeOvrtD1yqfPHyYw8h6GXlncX
 xFjw==
X-Gm-Message-State: AOAM532zC7he4kLd8eNC2++xzeYIA4MJqaTjmnR+0Lzk/2pG8AFqqcYf
 +UazcUU22l5MtZyOv9A/bm6deLD8LopGJiP0TRWEqg==
X-Google-Smtp-Source: ABdhPJwILtXqid7N8FtTtnQcgK4rxvfw8FVqz6Bw3uEo5KF0fO3M1LOMZKZJdUQa/MQFavFueafAq4pQzuwuQ4A0xB0=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr8128802ejb.56.1602151265968; 
 Thu, 08 Oct 2020 03:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201006220647.GR7303@habkost.net>
 <CAFEAcA_se7jErv9AFM2D7UdDMurB9Lb6W9aAXD6648spQ6idKg@mail.gmail.com>
 <87mu0xyrtn.fsf@dusky.pond.sub.org>
In-Reply-To: <87mu0xyrtn.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 11:00:54 +0100
Message-ID: <CAFEAcA_txULmHTGipXp=7PW9gkM-JFf=5WT9h=BNKKpLcr+uEQ@mail.gmail.com>
Subject: Re: Purpose of QOM properties registered at realize time?
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 10:45, Markus Armbruster <armbru@redhat.com> wrote:
> In real hardware, the number of GPIOs and such is fixed.

That depends on your point of view. Often this kind of
parameter is configurable in the hardware also, as a
parameter to the RTL, so different boards/SoCs using the
same device may vary in how they choose to configure it.

thanks
-- PMM

