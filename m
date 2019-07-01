Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A2CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23C8214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIFUt+cS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23C8214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxHe-0005G0-2Z
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hhwqx-0007x3-4r
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hhwqv-0007tI-LD
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:00:19 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:42639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hhwqv-0007s3-Ch
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:00:17 -0400
Received: by mail-qk1-x743.google.com with SMTP id b18so11007527qkc.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KmulFpp+onsU+2LH7/08w2AAXB4qeFKTekOlowVMNP8=;
 b=GIFUt+cSEWCRVF/+MaLN8zrSafB76FSxAz15D7IEWQr8O6cvXsPjJXnfoGrXJwkbKi
 O53dqJzAQDTHYcqYqWkZgxUXBHbKKDyMcqr6mZyDkVIaI3btSmVdCDJ9RhVTrStR/hkg
 z0Spkc3JKFgqhGgKp6n6e3porod6h0E9dbncyDMUAAjemZ82J/PTffWH63oEZ2WqV3GA
 xDsgUPzdwoXcO3VBtl363eFUPFIl2W3vQIzSwVopfhKbSlbFKd+4ksehq9SVCb9qCagW
 NmHaq84QNWh/8oBcrYde4QTvgGwbZ7inMzrTqntMxUNYWMUqIUeR/VRYLus4+5rck5Xt
 VM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KmulFpp+onsU+2LH7/08w2AAXB4qeFKTekOlowVMNP8=;
 b=jPJQLlrx8tJhDu/3CFYyXqFaj3l+l+rAJRJpxbMZ8CjV0Z2UWV8dIQlLZccCjb+5Dj
 1N1vLnmrcyB/nQ4KLqPUQ9tcUXGnAUNQFdIe28M3tWYeDpF2nMzS3P0IiMy+8rwTTSUf
 dEgVGi5zcYa9PYJYhGA9vB5rJJ33D+Dsx6yIuToISBI95n/xePEobbpW2IxAYLzg+M8W
 twp2ls4NLB0g9O1r4JVrIZyqlmTRt87BSr/H7rMWYIiRpP/0oNA3DXMuHWyqvvPY+WQ9
 5RbxgCsWvEQUopeJ4EAHcKZcg7FzzE/R2vWVB3WDmapLivfBNpOiojELSuJy4QU+SrHF
 b3+A==
X-Gm-Message-State: APjAAAVrSCkT7B/NOKSy48JWI6Ul7gAeyVx5ihXUk2JVo27i3ze24khF
 k/KQz4t2QMuxWHu5K1TsztSacDigHDJkxQ6a4GI=
X-Google-Smtp-Source: APXvYqwsNlEw/XGT9RyUZ8pQAk2dR9QFFyzOWNsO43oWCsyVNW3tk6u9YmW2LhnLJoQPGrU76KlwWnMrW2r5NM+vppc=
X-Received: by 2002:a37:27c9:: with SMTP id
 n192mr20668904qkn.460.1561989615162; 
 Mon, 01 Jul 2019 07:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190628120118.78920-1-mrolnik@gmail.com>
 <20190628120118.78920-2-mrolnik@gmail.com>
 <20190628151022.02946447@redhat.com>
 <CAK4993jutEKXd+RKq=Y3ij=k38Ou-ugVhD62nEP9MtPCbtw+aQ@mail.gmail.com>
 <20190701110836.48f433f6@redhat.com>
In-Reply-To: <20190701110836.48f433f6@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 1 Jul 2019 06:59:39 -0700
Message-ID: <CAK4993hAJS5vyF7LpL7MNaiw8f+ca6Ust=dQ2suQm84Hma+yLw@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v24 1/7] target/avr: Add outward facing
 interfaces and core CPU logic
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

should I use *-avr-cpu* suffix or can I do without it. i.e. *xyz* instead
of *xyz-avr-cpu*

On Mon, Jul 1, 2019 at 2:08 AM Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 28 Jun 2019 18:54:27 +0300
> Michael Rolnik <mrolnik@gmail.com> wrote:
>
> > Igor.
> >
> > so avr6 instead of a6-avr-cpu, xmega2 instead of xmega2-avr-cpu and so
> on,
> > right?
> (it would be better if question was rith under context that prompted it)
> [...]
>
> > > > +++ b/target/avr/cpu.h
> > > > @@ -0,0 +1,283 @@
> > > > +/*
> > > > + * QEMU AVR CPU
> > > > + *
> > > > + * Copyright (c) 2016 Michael Rolnik
> > > > + *
> > > > + * This library is free software; you can redistribute it and/or
> > > > + * modify it under the terms of the GNU Lesser General Public
> > > > + * License as published by the Free Software Foundation; either
> > > > + * version 2.1 of the License, or (at your option) any later
> version.
> > > > + *
> > > > + * This library is distributed in the hope that it will be useful,
> > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > > + * Lesser General Public License for more details.
> > > > + *
> > > > + * You should have received a copy of the GNU Lesser General Public
> > > > + * License along with this library; if not, see
> > > > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > > > + */
> > > > +
> > > > +#ifndef CPU_AVR_H
> > > > +#define CPU_AVR_H
> > > > +
> > > > +#include "qemu-common.h"
> > > > +#include "qom/cpu.h"
> > > > +#include "exec/cpu-defs.h"
> > > > +#include "fpu/softfloat.h"
> > > > +
> > > > +#define TCG_GUEST_DEFAULT_MO 0
> > > > +
> > > > +#define TYPE_AVR_CPU "avr-cpu"
> > > > +
> > > > +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
> > > > +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
> > > we probably can do without above macro and opencode typenames
> > > directly since we don't have 'model' notion and don't need
> > > translate it into typename anymore.
> I'd guess question was about that part.
> What I've meant is to replace
>  AVR_CPU_TYPE_NAME("avr6") and etc
> with
>  "avr6-avr-cpu"
>    or even better with macro
>  TYPE_AVR6_CPU "avr6-avr-cpu"
> use it through out the code
> and do the same for other sub-types
>
> [...]
>
>

-- 
Best Regards,
Michael Rolnik
