Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58739ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240182070B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmSU1FFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240182070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSf2-0002eK-4l
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHSd0-0001Zx-CZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHScz-0006nB-2M
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:00:42 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:35491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHScy-0006md-PF
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:00:41 -0400
Received: by mail-yb1-xb43.google.com with SMTP id f4so4627139ybm.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GW/+5oU8vcpueLiQ+EPc7ZItOROJfOToAgvJYJDHTic=;
 b=hmSU1FFV9EnrljpVyaOu2ZleTeuyJThhVjBoQsDmDtAtA9v2az5QukbXiGuxzFYze4
 L45wZXenumepomPrEKhuo4NhdCC3Inkv/ARN4UIZGyvuzDrGo2J2fm+k7cokgHLiR//e
 pQ4vU0pR5C3z4ZB/mVZSBB+irub0akzmYUcy4bPR9ntdD072EyYXlCCPHlg0aC5pvwWq
 umRpQpptXkz9+6lUVz5Pq7s/l5VSFhC5zkojvvnINh45Y51wAjEhrn7YoYRYKNhp+gaT
 qfo9JNWzidenhwAIIgNK7CnlVvLoUQJrSLSlwpMeAcxk9OwSwXMO6xLc4nOI5EtWGk/H
 qe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GW/+5oU8vcpueLiQ+EPc7ZItOROJfOToAgvJYJDHTic=;
 b=VnutDRGgbkDIjbgSGE59A7eeEQEnOqdwkQ7px/Qx0/UvycMB2p3SjtbQAp0jKndkjF
 adbJEEIG71GgqlnwZfoz8I9KknNH9vCGGsCvh4QZ/9Q/RpF1En3osBdFangckc9eWvKD
 hgoLOYNFxN3dIC7LTn7xrmO+b/x+10PiS2w9jRjkopSqMgvnIHahpqArYqAX4D81z2ZP
 TeOKYtSj3JpxGwjvaY2SRZh0q8HNs6Ysue1Gn9laR2F9A5Ljf7/gnBRov1jOdr/Dp+Ww
 G6G+at3FbDW7H253CyRhyBmUq+TmQgyRgxbL/4N7+/eywmp43If1gTKHznooXchMARoK
 WlRw==
X-Gm-Message-State: APjAAAX4qRrOCj7xmCjg13XXmVgym/ZXMBclCtW124iV5+W9AUVwDSUT
 pu3qphh4EIemKBxqdsEYTIuDiQ==
X-Google-Smtp-Source: APXvYqwFdiAd9Cm1URGBXWdiO5w7Lg4WzEfNycrLcW6B2uybDknfrrpZHnZ+xKBtjTnGh+NnEKpisQ==
X-Received: by 2002:a25:6ec4:: with SMTP id
 j187mr10621537ybc.331.1570453239024; 
 Mon, 07 Oct 2019 06:00:39 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id y205sm3790370ywc.6.2019.10.07.06.00.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 06:00:38 -0700 (PDT)
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
To: Dayeol Lee <dayeol@berkeley.edu>, qemu-devel@nongnu.org
References: <20191007052813.25814-1-dayeol@berkeley.edu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5583387c-5c5b-8890-999b-2ba4d75cd69d@linaro.org>
Date: Mon, 7 Oct 2019 09:00:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007052813.25814-1-dayeol@berkeley.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/19 10:28 PM, Dayeol Lee wrote:
> riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
> using pmp_hart_has_privs().
> However, the size passed from tlb_fill(), which is called by
> get_page_addr_code(), is always a hard-coded value 0.
> This causes a false PMP violation if the instruction presents on a
> PMP boundary.
> 
> In order to fix, simply correct the size to 4 if the access_type is
> MMU_INST_FETCH.

That's not correct.

In general, size 0 means "unknown size".  In this case, the one tlb lookup is
going to be used by lots of instructions -- everything that fits on the page.

If you want to support PMP on things that are not page boundaries, then you
will also have to call tlb_set_page with size != TARGET_PAGE_SIZE.

Fixing that will cause instructions within that page to be executed one at a
time, which also means they will be tlb_fill'd one at a time, which means that
you'll get the correct size value.

Which will be 2 or 4, depending on whether the configuration supports the
Compressed extension, and not just 4.


r~

