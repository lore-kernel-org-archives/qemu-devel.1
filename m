Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EB8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4D02166E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MH6KvYn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4D02166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i15Vz-0001wk-Ot
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i15Ur-0000wt-Tp
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i15Uq-0000Ln-RE
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:04:37 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i15Uq-0000LK-JJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:04:36 -0400
Received: by mail-oi1-x244.google.com with SMTP id k22so6483621oiw.11
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JqhEi/08yjYp5wKsz4zqpLIZJD2LKiVya3SfzuVh/bw=;
 b=MH6KvYn5dOM7PGVRBBX0U2XpLa9FeGQtR6OIsWozv37BVp4wssyySvLX1dUAN4u5EG
 Vomzekm19ziM4NDiZICFDAi1daXEKpidWkp5R5l5TL5IVAGMe1WvsPRwKfJycINQNaG0
 YsN0gd7Gu5EeemNIv1ebNa8HdIppyqx+rRZlUiwCJ3rQayA45b8LGmpnOtZ9jqA7htC9
 G0Uc1XhCGuTlVOs2OYtbU2Z9lLpg6mi3T9WFvW5SuC2DPMLWSGmhW8J4DpSdpgXtJgmH
 SecxD6GDtGYCWckPqG/EJqX1oIKK8TvBypyZ5z49fP7DfXMQS8ZHiyruYxq1hn3NYU8H
 8Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JqhEi/08yjYp5wKsz4zqpLIZJD2LKiVya3SfzuVh/bw=;
 b=kskwvcpL2ofJqq4Dcd1lQXrbpitJxerOwAiHQp7qe5TCFuiom24as188cb4FjPz1bq
 M8wY1ol4GuBMFDYpgUIJlFor73stxlfX8MA1GQAM7n8WLUfzDH4Jip+YNm/V0EOtupRZ
 Itnr9yJA+KbgKTpgvNGzKy8Z20IN4J/ASG00bNeWVhju9aLk+aephS2j2x2jchSnjslN
 Yy53piE9RLt1GngT0IW4CTPO5x8ziDCyqeO3rzK5WR+W1z/RFFxMmgxs4wkzAIF9uImO
 QyXID905qa4qPgQuwtcCpzgELHHjXQxDl9n9Emk2Ppv7K2/ZmMUJE70gcNmG+gYu9L9N
 8GmA==
X-Gm-Message-State: APjAAAW1m6+Bf+8PvJNUJ+tR9kkfNul/Rw21sUruyl3wqealILakzuhx
 fRoLdKmhTRirNKpdm/V8uBDaArvY9DadfbdYlMq+QA==
X-Google-Smtp-Source: APXvYqy5SwaNtz+Z2llzGR1P8qbcYJCzUpy67XpCJgikTe1Cb3FvWzNJkxKIYmJPf6OkUDLeeDxXDZP/lBjmww77KPU=
X-Received: by 2002:aca:4814:: with SMTP id v20mr2422504oia.98.1566551075519; 
 Fri, 23 Aug 2019 02:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190823084203.29734-1-thuth@redhat.com>
In-Reply-To: <20190823084203.29734-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 10:04:23 +0100
Message-ID: <CAFEAcA9bqzoT01E3tQREeAb1U3UJU0t8rOeX3E=pjmCM3J+O0g@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] tests/check-block: Skip iotests when
 sanitizers are enabled
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 09:43, Thomas Huth <thuth@redhat.com> wrote:
>
> The sanitizers (especially the address sanitizer from Clang) are
> sometimes printing out warnings or false positives - this spoils
> the output of the iotests, causing some of the tests to fail.
> Thus let's skip the automatic iotests during "make check" when the
> user configured QEMU with --enable-sanitizers.

Do you have a log of what the sanitizer is saying?

(There are quite a lot of sanitizer warnings on running
the main build too -- at the moment we don't have anything
in the CI that runs the sanitizers, except that patchew
does for a limited (x86-targets-only) config, to defend
the parts that we've managed to make warning-free. But
I think that the warnings I've looked at are mostly for
real-but-unimportant leaks, rather than false positives.)

thanks
-- PMM

