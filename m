Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A48C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD250206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZVRU0xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD250206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJf4R-0001pe-SS
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:09:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJeak-0000yI-AY
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJeaj-00057a-1Z
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:39:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJeai-00056n-O0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:39:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id 26so3546448wmj.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=cjJ0b6oIOdBDVcj7IkornDiK1g2KcyT3iFX8P4wkfMQ=;
	b=AZVRU0xX6M1OwZ41NjQdYxDdPhjNF6kEfUkg5/zeuIq40E5qJ/F8UeVjjyugfeTg3l
	SC/Bs3scKKOGSmbubCLtlIJfXhmNX/uKmPRVwJIaAMFO2Y1XEJKW2NdoM/n/TPzmjBii
	VhhosksL8YO2pf+JsAcaacMOuJwXkimGw+TNSD+fzIw/09acI8wvcYQpGTwsUno4fwrU
	pOB1KmzYLXbuvcsp60lAX309KQCy6xUpwQjzaAAnIA7Pi0NSm9zvI3j5MvLAE9sUz7x7
	nUG7hQkSC1jsdmlV+Oobx0Ycx8BS+6MihBXQMg1QGO34frF761oaUtaQh1lDDCPo8r9u
	VEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=cjJ0b6oIOdBDVcj7IkornDiK1g2KcyT3iFX8P4wkfMQ=;
	b=Y2xwFU6SMEZgFyhX6yxLqsPnILGg8jq2MM5Y3F6CN/isA6T2TaViiEBNO99ljSYy6d
	W6wD69T6ppgFgZHvTh7IjESX+CGNko7BK69OgkbUhrzwkHT/FbsFafPMfVKgiu9jsykI
	xZFVHU1TfE11xtdURtv5FSj9ViGFvgxuiWbIuEKKXVhvXvBScBiE/81Qd3nSbALy6WJd
	HxcIL0lMOSQuGYKTO9OwYDIb5ckTZIv5jve1wqPIdknS7nTxkjczlz7r4cl5GNw5ehEE
	aMfEJgDr8jCRLrPd3KPOd22c55sh+JRNfzD8KWBC0e/S3YRI2y8oRObymVLk2vvQROUQ
	XKIw==
X-Gm-Message-State: APjAAAWbBF3Rky94Ue8vrlauA8WGqJSq5/4nq0gE3XKqqSuTCS52odNF
	G1+rCxaVdDd6lMwtV93OyZsN+w==
X-Google-Smtp-Source: APXvYqzcYGs3UVewJsbL5neCLARHjz9td+SZAGvjesz+D4oIY1LashxsLSwSv+otqbI+0bFFS6InoA==
X-Received: by 2002:a1c:c7c9:: with SMTP id x192mr3654485wmf.151.1556199546778;
	Thu, 25 Apr 2019 06:39:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y197sm23555536wmd.34.2019.04.25.06.39.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:39:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9ECC71FF87;
	Thu, 25 Apr 2019 14:39:05 +0100 (BST)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<20190408182748.1238-2-jan.bobek@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190408182748.1238-2-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:39:05 +0100
Message-ID: <874l6mw6fa.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RISU PATCH 1/5] risu_i386: move reginfo_t and
 related defines to risu_reginfo_i386.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425133905.668cnJWcvFdPmddY9LSWF-GMSve6PQJYRn-MgbKcr1Y@z>


Jan Bobek <jan.bobek@gmail.com> writes:

> In order to build risu successfully for i386, we need files
> risu_reginfo_i386.{h,c}; this patch adds the former by extracting the
> relevant code from risu_i386.c.
>
> This patch is pure code motion; no functional changes were made.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_i386.c         | 23 +----------------------
>  risu_reginfo_i386.h | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 22 deletions(-)
>  create mode 100644 risu_reginfo_i386.h
>
> diff --git a/risu_i386.c b/risu_i386.c
> index 5e7e01d..6798a78 100644
> --- a/risu_i386.c
> +++ b/risu_i386.c
> @@ -14,28 +14,7 @@
>  #include <string.h>
>
>  #include "risu.h"
> -
> -/* This is the data structure we pass over the socket.
> - * It is a simplified and reduced subset of what can
> - * be obtained with a ucontext_t*
> - */
> -struct reginfo {
> -    uint32_t faulting_insn;
> -    gregset_t gregs;
> -};
> -
> -#ifndef REG_GS
> -/* Assume that either we get all these defines or none */
> -#define REG_GS 0
> -#define REG_FS 1
> -#define REG_ES 2
> -#define REG_DS 3
> -#define REG_ESP 7
> -#define REG_TRAPNO 12
> -#define REG_EIP 14
> -#define REG_EFL 16
> -#define REG_UESP 17
> -#endif
> +#include "risu_reginfo_i386.h"
>
>  struct reginfo master_ri, apprentice_ri;
>
> diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
> new file mode 100644
> index 0000000..5bba439
> --- /dev/null
> +++ b/risu_reginfo_i386.h
> @@ -0,0 +1,37 @@
> +/***********************************************************************=
********
> + * Copyright (c) 2010 Linaro Limited
> + * All rights reserved. This program and the accompanying materials
> + * are made available under the terms of the Eclipse Public License v1.0
> + * which accompanies this distribution, and is available at
> + * http://www.eclipse.org/legal/epl-v10.html
> + *
> + * Contributors:
> + *     Peter Maydell (Linaro) - initial implementation
> + ***********************************************************************=
*******/
> +
> +#ifndef RISU_REGINFO_I386_H
> +#define RISU_REGINFO_I386_H
> +
> +/* This is the data structure we pass over the socket.
> + * It is a simplified and reduced subset of what can
> + * be obtained with a ucontext_t*
> + */
> +struct reginfo {
> +    uint32_t faulting_insn;
> +    gregset_t gregs;
> +};
> +

The actual reg definitions can be dropped here (as rth does in his fixup
series). We can get them from ucontext.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +#ifndef REG_GS
> +/* Assume that either we get all these defines or none */
> +#   define REG_GS      0
> +#   define REG_FS      1
> +#   define REG_ES      2
> +#   define REG_DS      3
> +#   define REG_ESP     7
> +#   define REG_TRAPNO 12
> +#   define REG_EIP    14
> +#   define REG_EFL    16
> +#   define REG_UESP   17
> +#endif /* !defined(REG_GS) */
> +
> +#endif /* RISU_REGINFO_I386_H */


--
Alex Benn=C3=A9e

