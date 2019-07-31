Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB005C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950FB20449
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1oS4KfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950FB20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsm7p-0001V8-GB
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 06:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsm7J-00016C-BH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsm7I-0003rc-Em
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:45:57 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:39918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsm7I-0003qg-9x
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:45:56 -0400
Received: by mail-ot1-x32c.google.com with SMTP id r21so63657713otq.6
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fa0iz9hMqXtV479S/4Wj7KLlTuhwPNrFYDTL6memU6c=;
 b=P1oS4KfOhMjQUgYwaezjDpM1Z22p6j+MfnFujWcL1/P89oNkQblrDrFw8o5upy8hZc
 CKR5FbQYw1N3hwIH7zgNSUdrT5nxrzEs7xEouBVGdXBVO8a1eow2JKrcGceDsfXtDASd
 +Hv3sBz+nKiFkf0xgbGEJlJ6xqfixyNe2ZdYpLV4pE2fKuQ6+HfnzR2KnZI41vbSS3bo
 d3ne/0b6G6vCLpzdEKdRFG6eSFKHApphTQlH1vSvu7E8HNRVzpybUcMTgzcqi1DpzUOu
 QETTr4iNFCSeeurmtGzhf31JUZHz8cFuq+i+c/DD96eFPVc81o2QgwIfbFNpIHUGIY4X
 Sz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fa0iz9hMqXtV479S/4Wj7KLlTuhwPNrFYDTL6memU6c=;
 b=lGnSPG1QnTTHseoGTUtL1OCCBSNOvBOClX4e97UVsQwz7NIe0RBdqYsxNSgkGcQ4l2
 IfKCb27GBmJwEH0ZtxOXTsfHsVy6n2AQFsSHayMSLAhdMSRDp1k7a8LTDwCr6XGlWV44
 4FeclXWTxipBviAb83vp/CV335gWkRBzlZtEM03iuLXcyHgn2JBW0x5k1L7feqk7PWwN
 56IiojMvBo+eKKPL4qZe5xMVZTPPlXHbqA2eTSbVoZ9oZO79+SfAyVIO2SjOuuvzBQkL
 EQfbdtUNYJ2FGb/3EZ0TYusull4FyIH5LgzBpwhppTTkqqO7wrbXxlfgmUyqVbBwAi0E
 Oa/w==
X-Gm-Message-State: APjAAAWqrZfCJXYQrMiYjL+qqMkb3tDtmuT2fsCGHGQDyKVoQrM3ye3X
 GPzLHH/a1gf8w+fW18DlcPY8MS7aCD5viAy9Lkh2WQ==
X-Google-Smtp-Source: APXvYqxVD3/COZkyJRqbFBrqXh3r2WvRqxvGv8/9TSbSTJpzYMx21WhNSvdc2VtYZhFR679tsUkUdytlkAyD3gFkIGY=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr84237618otj.97.1564569952921; 
 Wed, 31 Jul 2019 03:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net> <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
 <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
 <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com>
 <87zhku90bd.fsf@dusky.pond.sub.org>
 <54711eb6-4d87-665a-c95a-749ee125b7c9@redhat.com>
In-Reply-To: <54711eb6-4d87-665a-c95a-749ee125b7c9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2019 11:45:41 +0100
Message-ID: <CAFEAcA8EC2xmskmxSmrpR0XZ_55pkBp3GLGrUbb7z=SXzQAerw@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: Re: [Qemu-devel] When to use qemu/typedefs.h
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 31 Jul 2019 at 09:40, Thomas Huth <thuth@redhat.com> wrote:
> IMHO we should get rid of mandating typedefs. They are causing too much
> trouble - e.g. do you also remember the issues with duplicated typedefs
> in certain compiler versions in the past? (these should be hopefully
> gone now, but still...)
>
> And many QEMU developers are also working on the Linux kernel, which
> rather forbids typedefs. Having to switch your mind back and forth
> whether to use typedefs or not is really annoying.

I would rather keep typedefs -- it's one of the style issues we're
reasonably consistent with. QEMU isn't the kernel, and its style
is not the same on many points. If we switch to "use 'struct Foo'"
we'll have a codebase which becomes rapidly very inconsistent
about whether we use 'struct' or not.

thanks
-- PMM

