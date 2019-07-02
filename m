Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA41C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650AB205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650AB205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiETF-0002qY-NN
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57132)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hiESX-00021V-SA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hiESW-0006Mo-J9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:48:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hiESS-0006IL-Jv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:48:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95F5334CF;
 Tue,  2 Jul 2019 08:47:54 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C503D1001DCC;
 Tue,  2 Jul 2019 08:47:53 +0000 (UTC)
Date: Tue, 2 Jul 2019 10:47:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Michael Rolnik <mrolnik@gmail.com>
Message-ID: <20190702104748.332bc714@redhat.com>
In-Reply-To: <CAK4993hAJS5vyF7LpL7MNaiw8f+ca6Ust=dQ2suQm84Hma+yLw@mail.gmail.com>
References: <20190628120118.78920-1-mrolnik@gmail.com>
 <20190628120118.78920-2-mrolnik@gmail.com>
 <20190628151022.02946447@redhat.com>
 <CAK4993jutEKXd+RKq=Y3ij=k38Ou-ugVhD62nEP9MtPCbtw+aQ@mail.gmail.com>
 <20190701110836.48f433f6@redhat.com>
 <CAK4993hAJS5vyF7LpL7MNaiw8f+ca6Ust=dQ2suQm84Hma+yLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 02 Jul 2019 08:48:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

On Mon, 1 Jul 2019 06:59:39 -0700
Michael Rolnik <mrolnik@gmail.com> wrote:

> should I use *-avr-cpu* suffix or can I do without it. i.e. *xyz* instead
> of *xyz-avr-cpu*
I think our convention for cpu types is:
  foo-target-cpu
suffix. So I'd use *-avr-cpu form.
Yes it will be a bit verbose on CLI but it really doesn't matter as
there aren't any preexisting users that used short 'cpu model' form.

> 
> On Mon, Jul 1, 2019 at 2:08 AM Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri, 28 Jun 2019 18:54:27 +0300
> > Michael Rolnik <mrolnik@gmail.com> wrote:
> >  
> > > Igor.
> > >
> > > so avr6 instead of a6-avr-cpu, xmega2 instead of xmega2-avr-cpu and so  
> > on,  
> > > right?  
> > (it would be better if question was rith under context that prompted it)
> > [...]
> >  
> > > > > +++ b/target/avr/cpu.h
> > > > > @@ -0,0 +1,283 @@
> > > > > +/*
> > > > > + * QEMU AVR CPU
> > > > > + *
> > > > > + * Copyright (c) 2016 Michael Rolnik
> > > > > + *
> > > > > + * This library is free software; you can redistribute it and/or
> > > > > + * modify it under the terms of the GNU Lesser General Public
> > > > > + * License as published by the Free Software Foundation; either
> > > > > + * version 2.1 of the License, or (at your option) any later  
> > version.  
> > > > > + *
> > > > > + * This library is distributed in the hope that it will be useful,
> > > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > > > + * Lesser General Public License for more details.
> > > > > + *
> > > > > + * You should have received a copy of the GNU Lesser General Public
> > > > > + * License along with this library; if not, see
> > > > > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > > > > + */
> > > > > +
> > > > > +#ifndef CPU_AVR_H
> > > > > +#define CPU_AVR_H
> > > > > +
> > > > > +#include "qemu-common.h"
> > > > > +#include "qom/cpu.h"
> > > > > +#include "exec/cpu-defs.h"
> > > > > +#include "fpu/softfloat.h"
> > > > > +
> > > > > +#define TCG_GUEST_DEFAULT_MO 0
> > > > > +
> > > > > +#define TYPE_AVR_CPU "avr-cpu"
> > > > > +
> > > > > +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
> > > > > +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)  
> > > > we probably can do without above macro and opencode typenames
> > > > directly since we don't have 'model' notion and don't need
> > > > translate it into typename anymore.  
> > I'd guess question was about that part.
> > What I've meant is to replace
> >  AVR_CPU_TYPE_NAME("avr6") and etc
> > with
> >  "avr6-avr-cpu"
> >    or even better with macro
> >  TYPE_AVR6_CPU "avr6-avr-cpu"
> > use it through out the code
> > and do the same for other sub-types
> >
> > [...]
> >
> >  
> 


