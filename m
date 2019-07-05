Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB496C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FE0216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FE0216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjR2B-0006qp-LN
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjQrD-0005tC-Na
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjQrC-0007fq-JP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:14:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjQrC-0007cl-CZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:14:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so9716012wmj.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 09:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1ZZYlzSCLdv4OPWBTYntlE8HOA1NAm6/dTGWgZtWsKI=;
 b=rQb2ZPAJZV52/KPHxQ2FNshfpDlqBMbm9WLsqxtn1IWiCu7ThI9PCPCbdGLQ6vNDYc
 iJmCAPSVIFp2R9jKvQRoLPgxSSv7wsrQr0+DX2VaCI0T5NdFd4i4Lwg5ZqShK5WW6GXw
 PgZMa20Jr6e0zpQ32/e/L4vWfU/UFnzgZtcXhjQO72XRs+zNfG7WLjXithYlL4DTpJ2i
 c6bOygCmXuFYJ5h2s0Rmb/rLW/N/oGtuzxttTJInblOj6lXwuQmlOJW1E7/ecB1/AIag
 jLFgGKWasJAXNdICR17p0Iv0CkfEV+i85mLu86jGQyArpe50KRfGyJ4gWXzlRtTZrTZw
 67qA==
X-Gm-Message-State: APjAAAVznKJ6En4YocPkTsctJZS/WrBb+aC1lQEIGSrq7HqGT0gdv9Bl
 GNw3ATm8dFc3kM1dQjCBOHnCWA==
X-Google-Smtp-Source: APXvYqwrWx52UrhB1unI9KFv1Ev5C5ygZ327eKMVDxESM82U3TF+DJ5xiGzt8UKASXlCm7FEl/4C1A==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr3990060wmc.91.1562343281236; 
 Fri, 05 Jul 2019 09:14:41 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id y6sm7002226wrp.12.2019.07.05.09.14.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 09:14:40 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190705160421.19015-1-alex.bennee@linaro.org>
 <20190705160421.19015-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d72546fd-b37d-9175-e871-2c5ad207a060@redhat.com>
Date: Fri, 5 Jul 2019 18:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705160421.19015-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v1 4/5] gdbstub: add some notes to the
 header comment
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 6:04 PM, Alex Bennée wrote:
> Add a link to the remote protocol spec and an SPDX tag.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 8618e34311..ea3349d1aa 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1,6 +1,10 @@
>  /*
>   * gdb server stub
>   *
> + * This implements a subset of the remote protocol as described in:
> + *
> + *   https://sourceware.org/gdb/onlinedocs/gdb/Remote-Protocol.html
> + *
>   * Copyright (c) 2003-2005 Fabrice Bellard
>   *
>   * This library is free software; you can redistribute it and/or
> @@ -15,6 +19,8 @@
>   *
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #include "qemu/osdep.h"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

