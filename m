Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDACCC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F5B2075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+fWTF2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F5B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZJie-0003SD-Ka
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 14:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZJhJ-0002zx-Lr
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZJhH-0007Q5-M8
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:06:57 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZJhH-0007Ph-HF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:06:55 -0500
Received: by mail-ot1-x342.google.com with SMTP id f10so13625298oto.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3pXyMW7yb1irfMB+BLRxu6dyoSkZMsPul/qcTgotL7s=;
 b=s+fWTF2oAuggzV4FwYbgE3Ta2H0hgrHdFx6KcMLukVFCYQRJJFAt8QvAfbgxEwWAmN
 /V+tQeaSih/g28kxSjJ58ABkdwRjaGzWhQKqprEtOYmIUf2yLdrpW5j3zeVhpr88qtZk
 WfxOUt31gLpSW1gJ7zuipvPi9++zwaccswXfoKh2YfsZ1QcfdUejXILHlK4sfWR2jxIT
 seqqkULnL/PkVW2sXvPS97nFLB+9EvI/a7AYGoqR2aTKQrEdqOoT7HigjhXJwo8Rw7mT
 pXbJcMN/kpYDfrtg9XdHa6vycn8bik9VowmOxikTYivcNpmlSaq3IsIPxiI/8yXTOGKu
 vJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3pXyMW7yb1irfMB+BLRxu6dyoSkZMsPul/qcTgotL7s=;
 b=iAemSY+7HDAYRczfuTCXKaYNzj2cR2ZiKKIhVb+FA28RB4t+sfGdme2cN92AbKMRcY
 Mj5tWndBfF/jFjkvIfb4cYaY2uPjaEG8TGJuehLY3XLrF0LpzRfm6QcUFC/l+Y5JaYLj
 HkOyvYHzhppqDgtU5X8WDpgZ65Lh1wH/exjxOggPH+8dqLTv7yTzZC50x/x47Dj5USSS
 bSdNNQQzawhVqTPpfIxDb/4WufIqcdbFgLqmG9DTitEvqLFju+ivs76U7cVLWbHBoTzK
 viQT+Z/bFkj+/rXwCcUZTf/Ug26bDlWnvw34HR9I1CnA04xbaaHQTvVbNF0CrRGa+x6x
 wnMQ==
X-Gm-Message-State: APjAAAXFyn/2Bch1mdYlmqr1udICzZhkh/u1s8kni3zdZLjtduLhLuaj
 DANDBLfIgfq/k6eoLhOzUeWIblf0CT7ZaIvg8tE=
X-Google-Smtp-Source: APXvYqzm5BQM7g13DRcCZsPGE/vRpQ6zxPNg+yVgYcbsisVOcwOD4DYN/gitY5Nn6S2Nqwp170On7jiqe/Husn5HTww=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr22850281otc.295.1574708813288; 
 Mon, 25 Nov 2019 11:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-2-mrolnik@gmail.com>
 <CAL1e-=iiu+8a60SY=83CTSQfPZ+aOsGoZhJNMOLGtmLq8a90OA@mail.gmail.com>
 <4ac75c83-ee30-e93c-c8f1-5f83df588e0d@redhat.com>
In-Reply-To: <4ac75c83-ee30-e93c-c8f1-5f83df588e0d@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 20:06:42 +0100
Message-ID: <CAL1e-=gZ-EOBDwx52LH3GU6qrzPepZOzAsg7HeSh2j1GbDyHKQ@mail.gmail.com>
Subject: Re: [PATCH v36 01/17] target/avr: Add outward facing interfaces and
 core CPU logic
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 7:51 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 24/11/2019 16.17, Aleksandar Markovic wrote:
> >
> >
> > On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com
> > <mailto:mrolnik@gmail.com>> wrote:
> >
> >     This includes:
> >     - CPU data structures
> >     - object model classes and functions
> >     - migration functions
> >     - GDB hooks
> >
> >     Co-developed-by: Michael Rolnik <mrolnik@gmail.com
> >     <mailto:mrolnik@gmail.com>>
> >     Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk
> >     <mailto:S.E.Harris@kent.ac.uk>>
> >     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
> >     <mailto:mrolnik@gmail.com>>
> >     Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk
> >     <mailto:S.E.Harris@kent.ac.uk>>
> >     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
> >     <mailto:mrolnik@gmail.com>>
> >     Acked-by: Igor Mammedov <imammedo@redhat.com
> >     <mailto:imammedo@redhat.com>>
> >     ---
> >      target/avr/cpu-param.h |  37 +++
> >      target/avr/cpu-qom.h   |  54 ++++
> >      target/avr/cpu.h       | 253 ++++++++++++++++++
> >      target/avr/cpu.c       | 576 +++++++++++++++++++++++++++++++++++++++++
> >      target/avr/gdbstub.c   |  85 ++++++
> >      target/avr/machine.c   | 121 +++++++++
> >      gdb-xml/avr-cpu.xml    |  49 ++++
> >      7 files changed, 1175 insertions(+)
> >      create mode 100644 target/avr/cpu-param.h
> >      create mode 100644 target/avr/cpu-qom.h
> >      create mode 100644 target/avr/cpu.h
> >      create mode 100644 target/avr/cpu.c
> >      create mode 100644 target/avr/gdbstub.c
> >      create mode 100644 target/avr/machine.c
> >      create mode 100644 gdb-xml/avr-cpu.xml
> >
> >     diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> >     new file mode 100644
> >     index 0000000000..ccd1ea3429
> >     --- /dev/null
> >     +++ b/target/avr/cpu-param.h
> >     @@ -0,0 +1,37 @@
> >     +/*
> >     + * QEMU AVR CPU
> >     + *
> >     + * Copyright (c) 2019 Michael Rolnik
> >     + *
> >     + * This library is free software; you can redistribute it and/or
> >     + * modify it under the terms of the GNU Lesser General Public
> >     + * License as published by the Free Software Foundation; either
> >     + * version 2.1 of the License, or (at your option) any later version.
> >     + *
> >
> >
> > I think version 2 would be more fitting to QEMU ovarall license than 2.1
> > (see LICENCE file in QEMU root dir).
> >
> > Peter, am I right or wrong regarding GPL 2 vs. 2.1 (My interpretation is
> > that 2 is the best "default" for new files)? The wording in "LICENSE" is
> > frankly not entirely clear, and I see many new files using 2.1.
>
>  Hi Aleksandar,
>
> I think you mix up GPL and LGPL here. This file is licensed under the
> LGPL, so version 2.1 is perfectly fine here (see COPYING.LIB in the root
> directory). For the GPL, there was never a 2.1, so if it would be GPL,
> version 2 would be appropriate. Bit since it's LGPL, 2.1 is better indeed.
>

Thanks, Thomas. I already feel dizzy of this GPL/LGPL thing. :-)

If you find appropriate and feel comfortable about it, you can respond to
my general question on the lis too, where it is also obvious that I mixed up
GPL and LGPL:

https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg04179.html

Yours,
Aleksandar

>  Thomas
>

