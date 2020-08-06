Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49768C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1093F22CE3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT+TcdVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1093F22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bk2-0005GV-5p
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3bjE-0004km-L4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:58:24 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3bjD-0003DI-2E
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:58:24 -0400
Received: by mail-ot1-x342.google.com with SMTP id h16so15547838oti.7
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cg6jSMb7vDuKaL/CKUZ0NdxBSQtv5YO3adOjMHcH7gE=;
 b=pT+TcdVVCG3wm1AZKZJ3RImvkNEzoRhDsVJGwKdrErAqUAse6VG+mJ1aUsAOBgrMin
 PYmzhCotxXI1tQ6oxq93Imt2MZx70fqiQW9byFozR9NOFVE2+zcRAg5MBkL3YHgER/U/
 cUtR7qM7lqPgC1ss979ZmJxhEvCfQwUZgbpbBy4WIiVxpstHldDYYT6J982wCDSoQ6t6
 B411FgbMMMijvrnZXG3ai6LVmNG7OoXI3MFkOzBxo2gQFxCA85qbi8KzU2+5y5f28Pus
 PC58sNR2UKpc811EJNwZpF+CtJTIQBGzHGQGsoLQGzZwFF1xNkbIEIV5EWNsgk+WiBSO
 Pkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cg6jSMb7vDuKaL/CKUZ0NdxBSQtv5YO3adOjMHcH7gE=;
 b=Fjq4/vmCq4C/Ska9quiP3mDDrU9jmWG7oeY542QMoP4TwWPuWhH2IFqO0b8JrX+F2K
 AXziak+TJQAqY0jp8K34Hyjxmi0kPb5AhbAkPloLwK/Zoy5T+pK6UgP87/FcF5AjsUE4
 7nP13Nkh3AymFE8AbH5ApMsnZ+aVsb7aUjsOeXR6R/uU8W+xlOzCbQ46v31Zlcipaxo5
 0wjxraaQffiUWmvMXIjkt9O1+I2+XlLSPMBjdw5oINvGz/7BbwpiRwxsRyYdqjaNrj8v
 SmcIyOfZ+z2jBRiTgluYbFcbMtoUebgtB0x1NHhY3rrXWZzV6qrjtZm0JxQPyF7i6JrY
 Bfnw==
X-Gm-Message-State: AOAM530JIuxWh+0bEilZazsTv44mzjXbTKyxBxRxKI4Hs/boutcPxrV0
 nzdQnGTWKYu0F3zlvSQJ2ISvwjPnr5A20Dk4YgcYvg==
X-Google-Smtp-Source: ABdhPJzaG2hogC1f0lNihIRtueU7B82vAAMB8Ru+X66P/vuwMKiJpjcmkvs0zvQbB1bpAz5TXBygqqrvbYQD0156FK0=
X-Received: by 2002:a9d:3b61:: with SMTP id z88mr6429883otb.135.1596704301838; 
 Thu, 06 Aug 2020 01:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200805194812.1735218-1-ehabkost@redhat.com>
 <CAFEAcA8-REfRgq=713Tq9PfSNmRPZVzBKmLzoWLauZjqF5q5eQ@mail.gmail.com>
 <20200805221417.GC1700540@habkost.net>
In-Reply-To: <20200805221417.GC1700540@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 09:58:10 +0100
Message-ID: <CAFEAcA8YW8OX2y1ms==0Fyu-bE3eXPKb_sayUNhFoeEUN0gaBw@mail.gmail.com>
Subject: Re: [PATCH] ide: Get rid of IDEDrive struct
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 23:14, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Wed, Aug 05, 2020 at 09:41:25PM +0100, Peter Maydell wrote:
> > This is one of those areas where this change works and reduces
> > amount of code, but on the other hand it means the QOM type
> > doesn't follow the common pattern for a leaf type of:
> >  * it has a struct
> >  * it has cast macros that cast to that struct
> >  * the typeinfo instance_size is the size of that struct
> > (it wasn't exactly following this pattern before, of course).
>
> Is this really a pattern that exists and we want to follow?
> I don't see why that pattern would be useful for simple leaf
> types.

Most leaf types need this. Consider a simple device type
like TYPE_CMSDK_APB_UART. It has a TYPE_* name so that
users of it can instantiate it; it has a CMSDKAPBUART struct
that holds all the device state; it has the CMSDK_APB_UART()
cast macro so that code that gets a Device* or Object* can
get at the struct. Leaf types like ide-hd which have no
actual state of their own are I think the less common case:
most leaf types do have at least some member variables.

As Markus says, we can have a couple of standard patterns
if we want to (as we do for the class-macro conventions);
I just wanted to explain that lots of leaf types work the
way I outline above.

thanks
-- PMM

