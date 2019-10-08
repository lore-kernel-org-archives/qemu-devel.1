Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B237C47404
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 03:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FFF20867
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 03:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYqkHCtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FFF20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHg2K-0000YW-A7
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 23:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHg1S-0008Us-Vi
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 23:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHg1R-0000jR-QH
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 23:18:50 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:43243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHg1R-0000j5-MV
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 23:18:49 -0400
Received: by mail-yw1-xc41.google.com with SMTP id q7so5936016ywe.10
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 20:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b5yIKmmNoKJrilF6g3EXjAEu9BhFAIhQDCBPbmUikMY=;
 b=VYqkHCtAnHYMzjHqblHLvsMEANl7+Oyg7EJw9OLHD5H59u+zKMwBffPMIumEKUsU8t
 zDRdEyIUiON7P8DwCE2jwR6CG/cMYdFYnLzs1lsd7wONmMY0BijxKyv8xxsmieur6Meg
 BZxA+lENLR60/AKHlql6hLq7xwd5GQ77ewIzkZJzWrgVV9jcNRI9jMhbCe9P1XVcgOMk
 zCRP9GWwp+6GfThmXDJw1wzyBVujGYBWjW8iBHfoKdiWYngTNtsliukvHKQc6MzsgeRx
 37OQD3Kxbz4FFqhyTXBsE+81vRHPMdDeZwtM19qY0CD85gUNkNb3rM6FCZZZJBNguaLK
 j0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b5yIKmmNoKJrilF6g3EXjAEu9BhFAIhQDCBPbmUikMY=;
 b=MMfLEImNE17H9EpBx6w6BD7WvOom0jw28WVwwdmGpOpZ+Avp1vVIs+qJer9k/x43GO
 GckHLJ9CCDCD2VirVimucMjPm5sDxuv/nef16IAhYwiNx9YMHMYRofiUp/qVUPSijsYS
 63GKmgyW0yCqB/i4i3AByaTxEZ17r8vSv1aXq0tx8sp8+C4MkxWNBCxy1CZhNCh2Wy/K
 bvhznUQBUa3xrirrnS4wsXTtp88XdcTjTDComi5ainLP6/gb0g/GgkN6y5CxHSUmUH/O
 uQ9tIu7es6FBNp86dfJXK4SHF0IIOzBZGlhdC2rswRZAMHVv7rq8dPFZZGX7sxnOCpby
 3bzA==
X-Gm-Message-State: APjAAAXAiFbGJc20B/sLRMtR1JJ2PqQWrQZDsjCAON42DnNUyw1IBbRv
 clt2pEc0wEOil2WmqBX7N6l5Gg==
X-Google-Smtp-Source: APXvYqwVxZ1mFJGsFOjEybvI6UCk4L/2uklWE5f5Td+iWydo4mnk1Hql2GwBcMtDx3XmknDHiiG3xg==
X-Received: by 2002:a0d:e301:: with SMTP id m1mr22389524ywe.243.1570504728607; 
 Mon, 07 Oct 2019 20:18:48 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id g1sm4282639ywk.53.2019.10.07.20.18.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 20:18:47 -0700 (PDT)
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
To: Dayeol Lee <dayeol@berkeley.edu>
References: <20191007052813.25814-1-dayeol@berkeley.edu>
 <5583387c-5c5b-8890-999b-2ba4d75cd69d@linaro.org>
 <CACjxMEsw+Deh176JLP2aF4Pdkb_s8MiPApwMON-_K6ed61-Zyw@mail.gmail.com>
 <3747223d-23ee-1f28-e165-b2b0c5746b68@linaro.org>
 <CACjxMEtPRxTQdOYFL97G7aYXC6KTBuGY2avf1bPJLYGEpURh=Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4cfde72b-9a31-a6c5-a7af-a3418a750f3a@linaro.org>
Date: Mon, 7 Oct 2019 23:18:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACjxMEtPRxTQdOYFL97G7aYXC6KTBuGY2avf1bPJLYGEpURh=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:41 AM, Dayeol Lee wrote:
> if pmp_hart_has_privs() gets addr=0x2000 and size=0,
> pmp_hart_has_privs() will ALWAYS return false because the code assumes size > 0.
> It checks if (addr) and (addr + size - 1) are within the PMP range for each PMP
> entry.

You certainly could do

    if (size == 0) {
        size = -(addr | TARGET_PAGE_MASK);
    }

to assume that all bytes from addr to the end of the page are accessed.  That
would avoid changing too much of the rest of the logic.

That said, this code will continue to not work for mis-aligned boundaries.

r~


> (addr + size - 1) is supposed to be the last byte address of the memory access,
> but it ends up with (addr - 1) if size = 0.
> Thus, pmp_hart_has_privs() returns false as (addr - 1) = 0x1fff is within the
> range, and addr = 0x2000 is out of the range (partial match violation).


