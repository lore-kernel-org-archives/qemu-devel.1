Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE54C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67607206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwHZpPHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67607206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb9Sp-0003Y9-Mp
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9Qb-0001F0-E8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9E3-0005oh-BA
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:48:07 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hb9E3-0005o1-3X
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:48:03 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so7071094plo.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7xpjKC3BQuV7Sie+SdYzDNJrDLotknhw8TT9nR4Q7v0=;
 b=VwHZpPHjd3ld+v7MhMWSgwsaWmWJKG9QQRxpvSIQX1L0iR/cAFSK88qeadW5QaFHRJ
 mhNKbb/uopXcSzit1pC+3MMTpRoFkhSDSv4oDSQ9xXX79ythL/dl0xdgYOMsvabokugG
 vnM5omJso/XB7kxcFYLDyfqd5n9JBrNSYo2sIXIL/iepUjz+RqUr5Xa2FIyVge7rF5PT
 hT19M0xsqpCIArtDJuSc9IYarWsqTw/kf1Qd14EfGZwfzvx9jrEf1h2GyHxR+hBuy/kM
 RZttkubA301PUNnJdGUGO+Hs+PuCZSSIQinz+rG01l7LGrnXfgydS1DIiJPmoCIIeyTR
 pB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7xpjKC3BQuV7Sie+SdYzDNJrDLotknhw8TT9nR4Q7v0=;
 b=QQziydLXLt8ydZqfs78nNoP9SSrIq6VXMpUbBH5v0XJWVooQjj6KXXRv62vM3JFo+z
 FE/jTJumNsT0BsbwFGc0cRXaVbV7BkD9NjPiGZqL3aYFKyO+n/BZmRjqAlMu2/Ola+MO
 9nR5in8kqt8LssUAjBETs2935h1Y2Ji70JqznLCkUZVnp215wjv6x1g00FvgCNGoq320
 RK38uxPz+ji3WUfljWPwjPDoHoP/yyqeyKDO++XNbJtebWmUDbFyZ3hTnxOZ3kFlSWwL
 Y2TSiUK57gXDSiT36JJ6XLiOLSQg2qVd7DcptwARn0F3hrr3bK5KOMA7bNyHayZN4hYH
 liyw==
X-Gm-Message-State: APjAAAWP4Aa0n3rbrwod/OTYY8wzzbsbFWFyuIUP7hcXra4xbdG9atWF
 mcA1P2kwiD6nV/9XR9UYWqgxgg==
X-Google-Smtp-Source: APXvYqzVo7Q609EqhhWgFiQGKknzMDGJ7vVeF4XhfEoUUP4L6jQNWbRHnFZvX8hxdIvKq6/5X6vOQw==
X-Received: by 2002:a17:902:42a5:: with SMTP id
 h34mr46132747pld.16.1560368881762; 
 Wed, 12 Jun 2019 12:48:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 a12sm324381pgq.0.2019.06.12.12.48.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 12:48:00 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <69cdfc94-c56f-1e72-8b84-311e2a820087@linaro.org>
Date: Wed, 12 Jun 2019 12:47:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602110903.3431-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v2 02/15] target/ppc: remove
 getVSR()/putVSR() from mem_helper.c
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

On 6/2/19 4:08 AM, Mark Cave-Ayland wrote:
> -    getVSR(xt_num, &xt, env);                                     \
> +                                                                  \
>      nb = (nb >= 16) ? 16 : nb;                                    \
>      if (msr_le && !lj) {                                          \
>          for (i = 16; i > 16 - nb; i--) {                          \
> -            cpu_stb_data_ra(env, addr, xt.VsrB(i - 1), GETPC());  \
> +            cpu_stb_data_ra(env, addr, t.VsrB(i - 1), GETPC());   \
>              addr = addr_add(env, addr, 1);                        \
>          }                                                         \
>      } else {                                                      \
>          for (i = 0; i < nb; i++) {                                \
> -            cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());      \
> +            cpu_stb_data_ra(env, addr, t.VsrB(i), GETPC())  ;     \
>              addr = addr_add(env, addr, 1);                        \
>          }                                                         \
>      }                                                             \
> +    *xt = t;                                                      \

Do not write back stores.

Actually, in this case there's no reason to copy t = *xt.  Just store directly
from xt->VsrB(i).



r~

