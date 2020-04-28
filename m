Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA62C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25752206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rY55x3p5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25752206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLKV-0007Zz-6H
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTLEs-0001fY-AP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTL4a-0003Ul-11
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:57:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTJa2-0000kc-Vh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:18:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id x4so1350224wmj.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X20AhwnLzUb4+o6kwSMODjI+L6Tyhic8AwN1+VsLtIk=;
 b=rY55x3p5gmP9frgp5Y9KCGrTCRMszyoDtxs9EwzXe07b90Q4Z99T9uG3cCVCaF68rH
 N4yDzogcttRNQH6rw+GRzQMwUTmAlIwwPClufvxqdAxsh/qlwtQ6lcGc/k95ZVMz+Puv
 w3BwxqqEo4L7EIgmCsOOhWtvTCk4vYck3VXPjmLZhf8UtELkv94K9EYkAq7Hrq2+ExKl
 vRoF3l3Tgv3ghphvAY0wdvNRhRq0Thp25UA3hxFzmVK9gG641PklkGoEtbefMeirzd3t
 dFHvvNETUVI9xV96YVN9svzQcjaJ4NUX4f2D5e+cx2OTcNZQit3qLrpoaq2GllVjqqBj
 STGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=X20AhwnLzUb4+o6kwSMODjI+L6Tyhic8AwN1+VsLtIk=;
 b=CTvOM5HIulpfGWa91JhYh8dlr5H/0X4gEKQn5AivSXRYiIl+tGhLDTBLJUtvXgS7lc
 rlB+XgW7RoknGFrfaXIOanq1hR0RgZhU7SynLHMqMgD/G34qRA0da0E0DHk0bsjUl9wS
 UGrPTieVocz4P2I0doUnjMsALNYs2V1w18+Ta6sJIvIaP77G/xwuXSmxB3C9RD8s31W3
 BeNAwFRT90ImlA68RkJZBMb0qoJIO5xdozuFaPqNgQcRVjxjIjPXadS9bPM2TGV4s+2W
 kggSVy7/UfQaJRZa7DnkgV3h8EHVFXIr1Gb2BSI6Etf2r+AqFeXph+o7Pzs5OoDWh3AO
 Ajlg==
X-Gm-Message-State: AGi0PubrBAnrYVH8NxsuQv0Kha3KuKFaWbxLtLX/hq35kxjcxfPwuetr
 lySMx5e4cLMyQO79UC95KmE=
X-Google-Smtp-Source: APiQypL+vgwcFtgnvoGs4vVgrtluQ8/L8JaTsPzvlyCvgK4yUTvi3EyWCpYekHxZTbynqV0z9dkRiQ==
X-Received: by 2002:a05:600c:2941:: with SMTP id
 n1mr2775369wmd.25.1588054733489; 
 Mon, 27 Apr 2020 23:18:53 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id v19sm24803070wra.57.2020.04.27.23.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 23:18:52 -0700 (PDT)
Subject: Re: [PATCH for-5.1 7/7] MAINTAINERS: Add myself as Loongson-3
 maintainer
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-7-git-send-email-chenhc@lemote.com>
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
Message-ID: <38fe3267-3d1b-26eb-13e5-dd3ed7039e61@amsat.org>
Date: Tue, 28 Apr 2020 08:18:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1587979995-17717-7-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 4/27/20 11:33 AM, Huacai Chen wrote:
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa9a057..efe840b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1080,6 +1080,12 @@ F: hw/isa/vt82c686.c
>  F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
>  
> +Loongson-3
> +M: Huacai Chen <chenhc@lemote.com>
> +S: Maintained
> +F: hw/mips/mips_loongson3.c
> +F: hw/pci-host/ls7a.c

I still haven't received the series cover, so I'm not sure if you
intended to include the LS7A bridge chip here, but if so it seems you
forgot to include it.

> +
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> 

