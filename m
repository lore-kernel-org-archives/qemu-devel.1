Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B62C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432A621BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="WnpDwzNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432A621BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvKEQ-0002Fg-Gq
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 07:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jusual@mail.ru>) id 1hvKDx-0001gR-3N
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@mail.ru>) id 1hvKDv-0003YW-Vk
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:35:21 -0400
Received: from smtp63.i.mail.ru ([217.69.128.43]:40016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@mail.ru>) id 1hvKDv-0003X6-DW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version;
 bh=ZaOPz/DGlZqjgKsjLjlZvpdQ69iTYd9HLkVHCfSFsxI=; 
 b=WnpDwzNhHk/P/4raHsgfwdSRk8oyPqrxDdA06DRPMOKPECVNXTIhWR7k7vBY0ccN6xqOnTU4pbwAueF+5tGvznm1xEYXR/XSnAEJm/5aS9wqUaze+dfEZ2cPuRppI85gWeZzxO2gus+so8SehZAJeKPdU5FsgqylO9D17W7PRD4=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <jusual@mail.ru>)
 id 1hvKDs-0006Yk-1p
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:35:16 +0300
Received: by mail-lj1-f169.google.com with SMTP id m8so51548638lji.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 04:35:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUOHRfPFP9eGvDPcN4d9y0Wf9eiY1hNJO0N4nnAE7fRV3hkXV6C
 vubtj1fF7Nqrne7EbCFc2qa8x6ZJPWIooUxK88Ig4g==
X-Google-Smtp-Source: APXvYqynoJaDrJF2ou8kgKFrNRCYCd7OfKlzsxqho1OG1aR1Ow8eJ1WthaHicfBsHRc/a3ORYN1eouF+uHf2yLrPdkY=
X-Received: by 2002:a2e:b60c:: with SMTP id r12mr4454470ljn.124.1565177715654; 
 Wed, 07 Aug 2019 04:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
 <20190801234031.29561-5-mehta.aaru20@gmail.com>
In-Reply-To: <20190801234031.29561-5-mehta.aaru20@gmail.com>
Date: Wed, 7 Aug 2019 13:35:04 +0200
X-Gmail-Original-Message-ID: <CAMDeoFV225HaRL0CexmDEzqWK7mS1=fomJvY5Mo7E=k0LtYY9g@mail.gmail.com>
Message-ID: <CAMDeoFV225HaRL0CexmDEzqWK7mS1=fomJvY5Mo7E=k0LtYY9g@mail.gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: smtp63.i.mail.ru; auth=pass smtp.auth=jusual@mail.ru
 smtp.mailfrom=jusual@mail.ru
X-77F55803: 689590B63E0A4B015A78504BD2AC29411A843C288C57C5026D30E1CE72670D02D9F6B2704949CFF94EBA3AB22F47EEB5
X-7FA49CB5: 0D63561A33F958A5AD1C3B6ED727A91AD0C748C0BB59584F6880CB131C0C3F5B8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A50BD5087FBFCDAA3AA81AA40904B5D9CF19DD082D7633A093541453170D46FCD81D268191BDAD3D78DA827A17800CE713722DCDE94E7D67EC76A7562686271EF5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE737F87A5E8E3D9C6F555751999830EE5675ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85084A3168D6E26DF927F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 4C235FE2E5D2D890DB26952483C990AC7E1798A64BE4D96767465BE9156F21320C3146F132CC074C342D7E53901C55FD6F53C80213D1719C4487B406A59785443329DBF425CF03A167EA787935ED9F1B
X-Mras: OK
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 217.69.128.43
Subject: Re: [Qemu-devel] [PATCH v9 04/17] block/io_uring: implements
 interfaces for io_uring
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
From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Julia Suvorova <jusual@mail.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 2, 2019 at 1:41 AM Aarushi Mehta <mehta.aaru20@gmail.com> wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6de200453..be688fcd5e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2530,6 +2530,13 @@ F: block/file-posix.c
>  F: block/file-win32.c
>  F: block/win32-aio.c
>
> +Linux io_uring
> +M: Aarushi Mehta <mehta.aaru20@gmail.com>
> +R: Stefan Hajnoczi <stefan@redhat.com>

s/stefan@redhat.com/stefanha@redhat.com

> diff --git a/block/io_uring.c b/block/io_uring.c
> new file mode 100644
> index 0000000000..902b106954
> --- /dev/null
> +++ b/block/io_uring.c
> @@ -0,0 +1,409 @@
> +/*
> + * Linux io_uring support.
> + *
> + * Copyright (C) 2009 IBM, Corp.
> + * Copyright (C) 2009 Red Hat, Inc.
> + * Copyright (C) 2019 Aarushi Mehta
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include <liburing.h>
> +#include "qemu-common.h"
> +#include "block/aio.h"
> +#include "qemu/queue.h"
> +#include "block/block.h"
> +#include "block/raw-aio.h"
> +#include "qemu/coroutine.h"
> +#include "qapi/error.h"
> +
> +#define MAX_EVENTS 128

This is called 'entries' in the liburing documentation, so MAX_ENTRIES
will be a better choice.

> +typedef struct LuringState {
> +    AioContext *aio_context;
> +
> +    struct io_uring ring;
> +
> +    /* io queue for submit at batch.  Protected by AioContext lock. */
> +    LuringQueue io_q;
> +
> +    /* I/O completion processing.  Only runs in I/O thread.  */
> +    QEMUBH *completion_bh;
> +} LuringState;
> +
> +/**
> + * ioq_submit:
> + * @s: AIO state
> + *
> + * Queues pending sqes and submits them
> + *
> + */
> +static int ioq_submit(LuringState *s);

Now you can remove this declaration by moving the function before
luring_process_completions_and_submit()

> +LuringState *luring_init(Error **errp)
> +{
> +    int rc;
> +    LuringState *s;
> +    s = g_new0(LuringState, 1);
> +    struct io_uring *ring = &s->ring;

Please rewrite it with declarations at the beginning of the block.

Best regards, Julia Suvorova.

