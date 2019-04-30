Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B9DC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 05:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F5C20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 05:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F5C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLLdy-00030I-LB
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 01:49:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLLd9-0002hl-0x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLLd7-0001ls-TA
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:48:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLLd7-0001kt-Ms
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:48:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so2315729wmf.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 22:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mB5hwtD0lVeScACb5aXbuHQSlQcRb5LcExbeoQ67zSM=;
	b=fUCLVtoRdkTCAjwu+jQuhesQehSeHNSeR4r0rH7D6/FTIbOH8nfYEQZ4I1WmA94qLA
	vdAPod7/5ED01/LEIyPitI3N6/fhRR5BVZLJhSZnfonX5q6W5qTZ3/y2J7iKzRRZQuS2
	nPJOvxkqhRi1bsrfau+1AN7pZqJWBmovKoYHTeFoU+SHiJf1LogFDRJ8V26T+x3g5NGL
	mH+BlZfldGYUx6tgfPc07zCHVY+mEc46upWQpC2iBhs1yDY3+8W5RaGEwJiVL6Wcekvx
	qkQFtx5e3iKCh1yDV8K2QbLIIABSj8d1zH+PTt5E0xwiQ0vPye+LnMHjLe+4utv2DFaF
	SDXw==
X-Gm-Message-State: APjAAAWuX2AbAuG29t/AMzPOptl+ydU1LWtW3fL0zFh/UELIGVlxD7Z9
	6ahQMWOQMysRaduRCVWL/uIrGTjq5D4=
X-Google-Smtp-Source: APXvYqymj+X+qh++F1A4jT5/4XLSwoJICzbvbCcdOSld5r4aL4IfppZ0wI1uqpSTsmdkOdehlGEBlg==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr1760733wma.60.1556603314648;
	Mon, 29 Apr 2019 22:48:34 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	b11sm2597382wmh.29.2019.04.29.22.48.33
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 22:48:33 -0700 (PDT)
To: driver1998 <driver1998@foxmail.com>, qemu-devel@nongnu.org
References: <20190429003339.22956-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1f63055b-f5a6-8972-a227-3ba1bcd0004b@redhat.com>
Date: Tue, 30 Apr 2019 07:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429003339.22956-1-driver1998@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 4/4] include/qemu/osdep.h: Move the
 __USE_MINGW_ANSI_STDIO define up to avoid confliction.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430054833.dcjMO3i5mCCoLIHMU_NiDEDSU0FwqtGDgoaGyq-vlbM@z>

Hi,

On 4/29/19 2:33 AM, driver1998 wrote:
> Signed-off-by: driver1998 <driver1998@foxmail.com>

Is driver1998 your real name? :)

> ---
>  include/qemu/osdep.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 303d315c5d..af2b91f0b8 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -85,17 +85,17 @@ extern int daemon(int, int);
>  #endif
>  #endif
>  
> +/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */

As the comment says, this definition is used by <stdio.h>.
I suppose you encountered an issue with one of the following headers
including it earlier, which is odd...
Can you paste the error you are trying to fix?

Thanks,

Phil.

> +#ifdef __MINGW32__
> +#define __USE_MINGW_ANSI_STDIO 1
> +#endif
> +
>  #include <stdarg.h>
>  #include <stddef.h>
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <sys/types.h>
>  #include <stdlib.h>
> -
> -/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
> -#ifdef __MINGW32__
> -#define __USE_MINGW_ANSI_STDIO 1
> -#endif
>  #include <stdio.h>
>  
>  #include <string.h>
> 

