Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD4C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482D822297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIVUph2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482D822297
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOJz-0004p1-Gq
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34834)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvOJV-0004NS-Bq
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvOJU-0006K2-Ar
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:57:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvOJU-0006HC-0D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:57:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so551942wmj.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BEGF5ZKRg/6nQQPix/cLIJa4vbqHiI0jphxFw2Ir/i0=;
 b=WIVUph2qA4iJUlGR3t62rbSP3zZO5uSKXecUW53vIZjVtESFiJOlIQXb0mWO2BCSsZ
 AOFhwCGpFuRz/LEvIT/5aqYEYMkAxXSy3E9UU4acEdWSOP3akfkIcBTbhPlu2zl7wYos
 ntWS5QfLSYt1Ee4DDhhPzOP6y6LEv4jvnrTpISGLsfaxhYYLPMa20x0sFxaymMP17zZl
 PJLNX5GPjpskBelg8aqt8b/vmE3y9xj7WdbJvrqF7K/7+YsdubjMcvKmvW3t2s33ETmC
 zAV9c5t2A+dLPQgiwub6NFw+QYVKXQTHOPmPrMHCpHg0Q1hEH2NQA1GczR/7WBzbRg08
 p70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BEGF5ZKRg/6nQQPix/cLIJa4vbqHiI0jphxFw2Ir/i0=;
 b=OvOODvak8qObbeO0YbEj4dR2mbuEjceClO3zqCKSGl9SG51Qeyij/ABJdoUCvRkFZp
 reaMkBbXWntgVVUcaNdtbjDoDmZl96G18avBUunnEjz8NimQmoWLDgaoeo4A/4CMc1d3
 dAK9foagppEiMHnDEN1MxKVIKhH85Gan2EFUD3Dch5gq4biMGMyXLm3dx0nGWNSBeCvS
 9cd3NBe8ASct42cFNspc96TH84BVzUsiJHpp3GJbbtAYvy5FrPec2za+3fY8aywBfUKB
 VlWaXmwT00lnR3fERfvQXv5x2aFLAgJiGENWoZMXZIXfmFYuME/fWaC+YbEg7DmtaKBP
 5xuA==
X-Gm-Message-State: APjAAAWnGI4jy+N65mCpbQK9c4xnXWHsizXqocSfBKxtdhnQMSn3c0uu
 wDA4Q34oAfbm/cTsokb+kdg/2tkVQ/I=
X-Google-Smtp-Source: APXvYqzBRxPUUWRAZtzyZZ3IxJ+EvEeBODABCS1b3Ev3p6j+Yita85XU9kEu36TzKMwqbAEloQaDzQ==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr616698wme.29.1565193437906; 
 Wed, 07 Aug 2019 08:57:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w25sm429765wmk.18.2019.08.07.08.57.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 08:57:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 070751FF87
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 16:57:17 +0100 (BST)
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-20-armbru@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190806151435.10740-20-armbru@redhat.com>
Date: Wed, 07 Aug 2019 16:57:16 +0100
Message-ID: <87d0hhhstf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 19/29] Include qemu/queue.h slightly less
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
<snip>
>  nbd/client.c                | 1 +
>  nbd/nbd-internal.h          | 1 -
>  nbd/server.c                | 1 +
<snip>
> diff --git a/nbd/client.c b/nbd/client.c
> index 4de30630c7..d554ae353d 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -19,6 +19,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/queue.h"
>  #include "trace.h"
>  #include "nbd-internal.h"
>  #include "qemu/cutils.h"
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index 049f83df77..ec3d2e2ebc 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -28,7 +28,6 @@
>  #endif
>
>  #include "qemu/bswap.h"
> -#include "qemu/queue.h"
>  #include "qemu/main-loop.h"
>
>  /* This is all part of the "official" NBD API.
> diff --git a/nbd/server.c b/nbd/server.c
> index 10faedcfc5..dbd2ff8555 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -19,6 +19,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/queue.h"

I don't see any queue primitives in server.c and indeed I can comment it ou=
t.

--
Alex Benn=C3=A9e

