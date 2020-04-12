Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F18FC2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE85206A1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upDjUpEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE85206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjcT-0007od-7y
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 16:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjbd-0007DT-Gu
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjbc-0006N3-EY
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:53:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjbW-0006LN-8Q; Sun, 12 Apr 2020 16:53:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id a201so7861163wme.1;
 Sun, 12 Apr 2020 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mxZfja+pMtsyZn7NyyvNui8QdMv5d+tEPWa2ib23Vsc=;
 b=upDjUpEVWiKT/SPKzvX+tZleLtJOozr0ZrUafdeIzFGtJQ2oDophvIJJhs3UYVv699
 bWyNMM5UhPhhP9K6y5o04RJVUIpa5IKQkUmolPhCRgzrmwRYTzosnqqB38cSolkS/01g
 JTM3myAfQOjrceURxXyN3NPgE2drBTWewQz9HaLkq9ZfLALPQIA0WJJCm4+9dMVV8AHy
 WIK/GC0Aj/feW4KwWnwK5zF6tu+22erJe44n4yWoE/92IEkeBwGrxkEH9rDxPc//F5aS
 kz4UduYAimnxk+xVr/FGJFNZpVl4yPuCmbgmIWqoRhExD1tFV0MzPSOZ4efqkFKugW8K
 5BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mxZfja+pMtsyZn7NyyvNui8QdMv5d+tEPWa2ib23Vsc=;
 b=uAZGRnu3btzDTmDDdgQmcY4NHnonhaR7XG98LVbYws8ItCmICmMaWWsv6ue2iJilW4
 TNKsyHF/C6CyjHlvtZ8v0/2n/J1SB5FQeRvDe8sDAPLNf01S7Y13NvZCle2vbGRlH7w1
 Nj5EvK+ESdUSwumvaSNKkkKSq3K6eUDJrTiUDIR9q5VNd1SxhZqmQK0E+x8YeenNPsbz
 6UgOAo5NV0fJXaleL+ZO7GUoNvVI1sxoh5PUjCWsvF4OE6ymHX9iZyeWN7k8wZuf5Ek1
 z2H5lQY/auG282eMs3616keGo5a00KriDvabPmaKSKNvjVBHg62JKPs/5FtGNyrss0+k
 VXhQ==
X-Gm-Message-State: AGi0PuZWT4/I4NSZnHWOJCEfAhiFthdSno7dlQRe+d0Yr0teHUM51T+O
 B5H2Q9Ys9MO049E+RgNx9XY=
X-Google-Smtp-Source: APiQypKVCfc8aWd1t23Piyntc5a8uvIpVQJBYhOQb0WCmcWa/kh0z8uOt9v8saXe4Frc2vY8aDazYQ==
X-Received: by 2002:a1c:2705:: with SMTP id n5mr15146865wmn.94.1586724800927; 
 Sun, 12 Apr 2020 13:53:20 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h6sm12166517wmf.31.2020.04.12.13.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2020 13:53:20 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200411091453.30371-1-f4bug@amsat.org>
 <20200411091453.30371-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2004111953020.75236@zero.eik.bme.hu>
 <811e2026-963d-e4d6-b90c-2713f9f30404@amsat.org>
 <CAFEAcA-ntHLEJnQ8Sd_c8n8LJmJ0X44VousM-BtNTndXRdf8ew@mail.gmail.com>
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
Message-ID: <98306a3a-46c9-cedd-48c2-af065c597640@amsat.org>
Date: Sun, 12 Apr 2020 22:53:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ntHLEJnQ8Sd_c8n8LJmJ0X44VousM-BtNTndXRdf8ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/11/20 11:36 PM, Peter Maydell wrote:
> On Sat, 11 Apr 2020 at 20:45, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Buffer overflows are security issues because they allow attacker to
>> arbitrarily write data in the process memory, and eventually take
>> control of it. When attacker takes control, it can access underlying
>> private data.
> 
> Note that for QEMU our security boundary is "VMs using KVM"; so
> buffer overflows are a security issue in code and devices that
> you can use in a KVM setup (including pluggable devices like
> PCI devices) but not devices you can only use in a TCG setup
> (where they're just bugs, though obviously ones we should
> fix sooner rather than later).

"VMs using KVM" as security boundary is very clear, thanks.

Note 1: This this doesn't appear on the QEMU security process
description: https://www.qemu.org/contribute/security-process/

Note 2: If a reported bug is not in security boundary, it should be
reported as a bug to mainstream QEMU, to give the community a chance to
fix it.

Regards,

Phil.

> 
> thanks
> -- PMM
> 

