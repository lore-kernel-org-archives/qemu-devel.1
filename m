Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F45C55186
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A23A20780
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojlpQwmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A23A20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCUK-0005fn-Eb
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRCTH-00054X-NZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRCTG-0003eL-Hf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:19:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRCTG-00037v-40
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:19:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id r26so1708549wmh.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 03:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/grsPV6SgvDHL8f+iOpbOXBjOaAr1dX7NVRkmfRx7Xc=;
 b=ojlpQwmz1NEHgm9sPrOKX+dfWx81GSkl+t6F8MWJOR93B7qxzDAYG5oMQekJCTU0e6
 tp+DyfC8UYLPXwh6IRAT/jsSP161CCO22Xjdm3fpiSSUjqqPetu+sgza0rixEP2G6A6O
 ZotwRXSnaUh06z9FIDXq3cIelr/gD4aPd6gNl9rxuMKRVRd3t4K3rRMRRO1jyNp6/S1H
 SeF9C5VF0a+EVnDOXLJNWz+KPNp2X5BZkHWQP3ELcFNE3CGyOnwyf0vI0TLrq+ac2tcR
 fi9JFfnq21nr9wc2wAckQWiJ4S3PUy9M6Ahp6vHYrF1ADPdnJ7hh9QO7S7Fy2DXynJGC
 HCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/grsPV6SgvDHL8f+iOpbOXBjOaAr1dX7NVRkmfRx7Xc=;
 b=tBDPhQvfZOddlwYAY1UqD8g6vKppUlev+2YGrwvsnmsJH5CPkcwZDSEO9t3OBD+b1u
 X/6Gl8Bax5uPk7f069KVT3ramzsqrFg92GmTFJETCdajpTUGCnaqp6/vadm9Zy32LP2G
 LElYgoH5G5FN7D6OOWi9rWwGXV37hjpHyud78YgY09qj1od0hUReYq9kjj3rqDErw/jt
 MEypJEayT2GuI+3WighuI71hXSqNkCynFRP0lR94B3oVOjBIj7mTAN5A11mP0Qo6nfYC
 RDn1w7To3hK3iP6zpyY8mPi2pFtII1muPkwWHWXVCpAcOCHrhwI8bAGfvr2fWbnfSDDI
 +Mxw==
X-Gm-Message-State: AGi0PuaKZp4s1JwM8cIZ/b28mr7lKW1pX1HtmrU3mcPKDt3AZZICeZmM
 SE+T6Mg22xrG4easvTJrtU0=
X-Google-Smtp-Source: APiQypIBjGv3NkqBJw83+YaBwSFDM8sQz8tJ4ae1T43O2RW8burFfJcgjTzV1Fi3/bjIWyKsESxhzQ==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr10024179wmf.85.1587550748041; 
 Wed, 22 Apr 2020 03:19:08 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 17sm6955082wmo.2.2020.04.22.03.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 03:19:07 -0700 (PDT)
Subject: Re: [PATCH v2 27/36] tcg: Fix integral argument type to
 tcg_gen_rot[rl]i_i{32, 64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <f6dadf97-b4a6-f0d9-abb7-01741a0612ad@amsat.org>
Date: Wed, 22 Apr 2020 12:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422011722.13287-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 3:17 AM, Richard Henderson wrote:
> For the benefit of compatibility of function pointer types,
> we have standardized on int32_t and int64_t as the integral
> argument to tcg expanders.
> 
> We converted most of them in 474b2e8f0f7, but missed the rotates.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op.h |  8 ++++----
>  tcg/tcg-op.c         | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

