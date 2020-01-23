Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EF2C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9909C21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cg/pFHRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9909C21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugJw-0005qL-4W
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuem4-0002oc-A5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuem3-0003qM-4m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:52:04 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuem2-0003pS-V5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:52:03 -0500
Received: by mail-ot1-x341.google.com with SMTP id 77so3169551oty.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SWNap8R8ZnIAl0BSUogEYnS2gly8w+H/8PxKyv9Hqmw=;
 b=cg/pFHRQ9kK95fxZkc1yQpxyxLlWQtJH1p7pw4dcowxwZXK11yvQCL8StRsUqmsXXg
 kpyun0yYZzNoQQ+okqexKf9uKwMfB2opHmqlJ7K8Wlul13PvFJaxPuQtXMjgUjelFyTp
 rjBLNjPpBvfUERmp+7Gpy85hoZMaHYtPnmmhykGnOdjHfIpZrMJS8IeCiTWry7DVUGu9
 BW84kwKJdMkabUKiI+M9QHHu1XfIvFxEhOJo7T4ZTXzpVae9nG5GChu6/Q//Z1Po7xDD
 9+7jlJfiuyMD/k2GR0kFq0Qs61ukaPhCtEWCmjYxCHB+O1vS3lU06cS3kRbW2aeu9tR6
 Kd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SWNap8R8ZnIAl0BSUogEYnS2gly8w+H/8PxKyv9Hqmw=;
 b=naVYCVAsjrqp6hbnjFkWR+zHMXrYsz70vyTtk473fsbI1I1juZ2/CFyH+I0SP9Jl+W
 EldKgxdic8UM7qDtqLHfkcfyr050bETIMIVjwII0F7UvYpGcD/mtIFFzGvuLbD2vnGZY
 gvjrgHvkZMEBFmAnVEjq1dF6hhMtIAolPyOLQ5wHwrhFeRT4Dx9x4ytOXwHtZNZm1St4
 xkn4HhuajWqF+eSWk7G3MgrSYzlmSuYRrkCoF+f08qub1EULp1PA+oK6h2VrFlDb5fu1
 Mhk9di2F0/hvQynZncf450j189gb25LcS/a7F+pVKs7DQnnsHWGYOK2ja5mtIT0Kemn4
 oPgw==
X-Gm-Message-State: APjAAAURiiVJfKz7KXl/Sb8Dl0FmzTfGMnK2yql8qZrUrasqTz0TlpL9
 B/qgTzPX4IcPkDW2E1ZVA6LIOd284F6bpf9XnE32xQ==
X-Google-Smtp-Source: APXvYqybZN0NH3Yczpgqr15kHy92InyiikrTfOb4dp4BT23HlS0uSeE9WM9LlgORx/I4eowF5LQyAxoCe7aqJMTtdKE=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr5915207otd.91.1579794721814; 
 Thu, 23 Jan 2020 07:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20200123052540.6132-1-linux@roeck-us.net>
 <20200123052540.6132-2-linux@roeck-us.net>
In-Reply-To: <20200123052540.6132-2-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 15:51:51 +0000
Message-ID: <CAFEAcA-SPUPEcV4Uw9=8-5EJmLztVorV++ypFp=vYxasncBrZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dma/pl330: Convert to support tracing
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 05:25, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Replace debug logging code with tracing.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This turns out not to compile on OSX, which is a bit
stricter about format strings:

These two:

> +pl330_dmald(uint32_t chan, uint32_t addr, uint32_t size, uint32_t num, uint32_t ch) "channel:%"PRId8" address:0x%08"PRIx32" size:0x%"PRIx32" num:%"PRId32"%c"

> +pl330_dmast(uint32_t chn, uint32_t addr, uint32_t sz, uint32_t num, uint32_t c) "channel:%"PRId8" address:0x%08"PRIx32" size:0x%"PRIx32" num:%"PRId32" %c"

both provoke
 error: format specifies type 'char' but the argument has type
'uint32_t' (aka 'unsigned int') [-Werror,-Wformat]

because of the last argument.

Easy fix would seem to be to change 'uint32_t ch' to 'char ch'
(the argument is always a literal constant 'Y' or 'N').

thanks
-- PMM

