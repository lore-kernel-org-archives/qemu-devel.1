Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC7E20870
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EvjBhQy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC7E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzPJ-0003lH-OE
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzO2-0002m9-99
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:05:18 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:37309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzO0-0003Tw-HJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:05:17 -0400
Received: by mail-ej1-x643.google.com with SMTP id e22so23683938ejr.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nu8+ykLxiOPFA8bKANAHXNRJcMmmq/90jkdNTtPVqoc=;
 b=EvjBhQy78HOlkrt4qEbPT4b5vsVTzBV7skUy8RwUlJw9uI8mhbxE9rryMaYlhzUscv
 pt3mQD1RJDgWm4r7fM0mKsmdyf+gnVwURRCUKZrjByp9mxvhz0aO36JVVx/127ZxrHAc
 1NHW5QduxD8A9lvyUBebgokXQDbbitryYy0m0COU7/7rO+5Hm1Kmvp9qxKJJutn6qvnb
 IouiFreAyFnURskExnYQNcnxau+XdnFaeu0uvyzW2/jOXEXC6+Uy6igzITd5IM+YZHnI
 6HYQ2Pu0CYXYis1U1xRd7ffqlZDKnHJRbxZC1VUX2mr/omEscR/D96a9FHNUVQxdk9xL
 oo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nu8+ykLxiOPFA8bKANAHXNRJcMmmq/90jkdNTtPVqoc=;
 b=B3TWAAc/RI54MQMmU1EmAcL5SiCb9fY4yh/4jU2zDldV2paAcdHlWfApxn0hjMHvQM
 Ux/JLNUqmdA5mbCJqZsuvgGHhxm1E2b3n669/OXxZiYnPTP+WyKx/YhE7B8xVEnx3omo
 22NcO0UIdaeK6hdDqK2DK7EK/N9QzVBB/R0xatWz4gO3ifOOcxL7qcBEfRWFMSDgdhvC
 undqE61CDqqQE0pL7DeBiD1QG3TyxOpHbRj8ZAvN+kIYvUeKVegPUtW8mhFyOlOu+tKt
 0XN36cVKuQkYAJW4nprvKhS1Ezf5mbSx5HFP4ERnbuZuQAuBaxmQQdqkyRtUC4SqU7Tj
 ylHw==
X-Gm-Message-State: AOAM532mmF245kkL++TYjMZxFQFc8kVDyvy6wOzCMC2dLcTGDB6Bz9kh
 GS0MBperxJfUi7mTRpAETRRP67GE0LPklbeKghfYZg==
X-Google-Smtp-Source: ABdhPJxZAc43/mTfMMYY7MZhZMaWGt8oE0aljsh6IN6N3EnjSXLXsql2n+zVuuooCq0btdQqv1q4kOqJ8fEJjEWxGTM=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr27983435ejk.407.1602515115252; 
 Mon, 12 Oct 2020 08:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201008174359.157627-1-dgilbert@redhat.com>
 <7f8ffa77-cc95-b121-0da8-269d37c52830@redhat.com>
 <fa6c8769-b1d7-cd75-2c2e-d8bc74ebe51e@vivier.eu>
In-Reply-To: <fa6c8769-b1d7-cd75-2c2e-d8bc74ebe51e@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 16:05:04 +0100
Message-ID: <CAFEAcA9T-81tXcM1A0b-y-_ZkC_0sqJ8cQuEvDkfbobXJQr70Q@mail.gmail.com>
Subject: Re: [PATCH] mingw: Fix builds on f33 mingw
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 15:39, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 08/10/2020 =C3=A0 19:46, Thomas Huth a =C3=A9crit :
> > On 08/10/2020 19.43, Dr. David Alan Gilbert (git) wrote:
> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>
> >> Fedora 33's mingw moans about:
> >>
> >> In file included from ../tests/test-bitmap.c:12:
> >> /home/dgilbert/git/migpull/include/qemu/osdep.h:76: error: "__USE_MING=
W_ANSI_STDIO" redefined [-Werror]
> >>    76 | #define __USE_MINGW_ANSI_STDIO 1
> >>       |
> >>
> >> the fix is to make sure osdep.h is the first include - which is our
> >> rule anyway; but one we broke in a couple of places.
> >>
> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> ---
> >>  migration/dirtyrate.c | 2 +-
> >>  tests/test-bitmap.c   | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >> index ab9e1301f6..42b71e771e 100644
> >> --- a/migration/dirtyrate.c
> >> +++ b/migration/dirtyrate.c
> >> @@ -10,8 +10,8 @@
> >>   * See the COPYING file in the top-level directory.
> >>   */
> >>
> >> -#include <zlib.h>
> >>  #include "qemu/osdep.h"
> >> +#include <zlib.h>
> >>  #include "qapi/error.h"
> >>  #include "cpu.h"
> >>  #include "qemu/config-file.h"
> >> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> >> index 2f5b71458a..c3c9d79667 100644
> >> --- a/tests/test-bitmap.c
> >> +++ b/tests/test-bitmap.c
> >> @@ -8,8 +8,8 @@
> >>   * Author: Peter Xu <peterx@redhat.com>
> >>   */
> >>
> >> -#include <stdlib.h>
> >>  #include "qemu/osdep.h"
> >> +#include <stdlib.h>
> >>  #include "qemu/bitmap.h"
> >>
> >>  #define BMAP_SIZE  1024
> >>
> >
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >
> >
>
> Applied to my trivial-patches branch.

This is the wrong version of this patch -- can you take
Marc-Andr=C3=A9's instead, please?

thanks
-- PMM

