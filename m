Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1AC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FC220731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wmfnq2wP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FC220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFqd-0007Ku-MO
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 16:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFoH-0005SQ-RG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFnI-0007D7-FP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:29:29 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUFnH-00078w-CL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:28:27 -0400
Received: by mail-pj1-x1041.google.com with SMTP id h12so3921431pjz.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=A7+ZVS0TOmcdhqvub3gm3KVAHgp6kudxQV8JsTnJ9XI=;
 b=Wmfnq2wPdEbkQp/jzzBAk10/Z+jFw7VxtTpiBaKcb64g7chuXSmdPNXL+JL0TlAAdf
 pCtXLbflEintzNspNhspHxfBOUd5PHVv8N1M6OI4ACQpFjDRl2L5JzrBFEl8dxZ7T/V+
 eifG2434/cWGlkQgkXRT1VUnUT6t56O4FI5SMZ1FNHZBPjWG5BZFkfpdDCj7ZhVhKE8E
 KmufgMEzbWUW6B04ewL4hr+coFK3pK2G8o7v1vI04l/gCDmo/mIwD/hDCSLPAgzRIrS3
 nFUyzWTHs3yHcgzHKO6TMDk4BoRcKwzugJcvaUivcVpOjO7iaWJlcelxb86qDGsIXOSi
 b4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A7+ZVS0TOmcdhqvub3gm3KVAHgp6kudxQV8JsTnJ9XI=;
 b=bskxafzse+PgaZwBhClrEts/OfdmlO9WN9SnHkeWj+TqbnKzktVQt+GLIEftp5Mfd+
 AZcpnN0eoarg6ofFSPfAHNnbeiki/NBsCrfi8pDFm0dPHVg4xYgCpb35drPGJAL64Url
 bJ2/0jvgOiTLaI/qYmkHJ+H6jc6A+wZBF35hztQrxyHOMbzD/1FaiEsUCZORKbFpB3EK
 TN3pOCX2lVQ8S22cs/JQl82lrrV2qcp8BFmczBj42Gfz1GalaoFI0vtNcn1BHa3KsH2E
 AEZo00JGrkidG52Zvk7SvUi16w9l+1IcKHmmCqH9ZByT8Np5hw/vuVjV0nAdBCfqXTPN
 ODFg==
X-Gm-Message-State: AGi0PubFNL/GBevUKK3Eg6EcZ0H/az075snJ+Gn/p4c6aYf5Q9G7AT10
 OOGIvOIYkhXlN/vmgLezkbG4sNgQhmo=
X-Google-Smtp-Source: APiQypI4t6tzq7y8P1kkLEbRTwoTCvAaq7t5aEuJ7VRGWNy3EtZRUr9i/TWiyMVUTZ63mcT+WZsqMg==
X-Received: by 2002:a17:90a:24e6:: with SMTP id
 i93mr698545pje.13.1588278505094; 
 Thu, 30 Apr 2020 13:28:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l1sm507127pgn.66.2020.04.30.13.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 13:28:24 -0700 (PDT)
Subject: Re: [PATCH 20/36] target/arm: Convert Neon 3-reg-same
 VQRDMLAH/VQRDMLSH to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c8d148d-8980-ad8b-da32-008a0e6f81be@linaro.org>
Date: Thu, 30 Apr 2020 13:28:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> These don't use do_3same() because they want to
> operate on VFP double registers, whose offsets are different from the
> neon_reg_offset() calculations do_3same does.

Actually, no, it's an around the bush way of computing the same register offset.

vfp_reg_offset(true, reg)

->  vfp.zregs[reg >> 1].d[reg & 1];

neon_reg_offset(reg, 0)

->  vfp_reg_offset(false, 2 * reg + 0)
->  vfp.zregs[(2 * reg) >> 2].d[((2 * reg) >> 1) & 1]
    + ((2 * reg) & 1) * offsetof(lower/upper)
->  vfp.zregs[reg >> 1].d[reg & 1] + 0


r~

