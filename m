Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4E1C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7720920838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcDtWsy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7720920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htBtD-0006lu-RC
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52473)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htBsp-0006Jw-JJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htBso-0005by-Mi
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:16:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htBso-0005bS-Eh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:16:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id l21so34290557pgm.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nvgx3691qemUajFHkiros1xQZE99DVaku3/9F7Mq1Eg=;
 b=hcDtWsy+JB25ZfK6dakt2CQy2GNILkBDz4fmKP4LltxsEyW9pQ5a9hNrQ5PtBcGDIO
 2wUROVHkmcmtbhYedipZmcm/gbWeBLUKNQ28L5sfvT85IG6Sv65gdsQedVYYmQrbSGO3
 YyN8QSExx8a92X1XjYklzmOPaMLobwh53l+BzD+nRDZFQ9zB3UaYMic2xAe8szkBy0r+
 ROsYu2ubXm/7ASwVVCg4qAjsVTMiE7DZL91QQpLfamkjMMSV/dJUP2a0jAbpvkbE/qMV
 99Qr2iVOM48ajS9Cg+omlXcRAlBNp9F55SyIHEsdj8S2xx++sVDOQxqmLtPkfxuwXIPj
 EXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nvgx3691qemUajFHkiros1xQZE99DVaku3/9F7Mq1Eg=;
 b=fjHDMiq6CzIezlhW2MkBhEoG774wN+asME3nYIjaDo1jhs3o0vdECv4ceBBVsm8M71
 azyEiehi/qE3QZgIm5zFsdRI9eoYBOoyGeFWEbhPs13z5XWqgyHo/mezMv4EUZS6NTnp
 bE2xrxHkklg3Xg9xMl8N+oo/uUdvVygCpXiXBOECAkunWuH9QsbmjRbyGJL37+93PaEV
 S8Eq/PJIDVdNN6I0j5LkIbTeL5gd5/m2JFqtR2qZVi23BHI+NBasbrSPccOPGxoK3NW2
 i+up6dHb9mrOe51G61uvSecI5FzBo05DPIeNlY/gjVF5uVeSFA5yXDqSvrLs1qEr67MD
 TUBw==
X-Gm-Message-State: APjAAAXjky5vbzd3UexALOGZAHleQRY+tIII4ayGUXVBiolTyruR5aA1
 nSPh9YD+1OCiTohx2tfF3ztKEw==
X-Google-Smtp-Source: APXvYqxhZ2RDS8KaLywMCOz70goBxxWXc7usIn9leMztRuMga/Pw/j96VKF3/lXK/FqVM4plJ3YyRw==
X-Received: by 2002:a63:4c46:: with SMTP id m6mr122823401pgl.59.1564669000973; 
 Thu, 01 Aug 2019 07:16:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u128sm81246813pfu.48.2019.08.01.07.16.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 07:16:40 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>
References: <1564577101-29020-1-git-send-email-bmeng.cn@gmail.com>
 <581a0284-c658-265f-1b0f-6f4be5406cee@linaro.org>
 <CAEUhbmVXC6GeHYFST514cLRJHQOo5ki=ZPG=OsLzV2YA0ChQgA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ac4453de-81cd-c32a-17f8-283fa3569ed0@linaro.org>
Date: Thu, 1 Aug 2019 07:16:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmVXC6GeHYFST514cLRJHQOo5ki=ZPG=OsLzV2YA0ChQgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] riscv: rv32: Root page table address can
 be larger than 32-bit
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
Cc: QEMU riscv <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, QEMU devel <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 6:53 PM, Bin Meng wrote:
> I am not sure how (idx * ptesize) could overflow. It represents the
> offset by a page table which is [0, 4096).

You're right, I mis-read what was going on there.

However, lower down, "target_ulong ppn" needs to be promoted to hwaddr, so that

    ppn = pte >> PTE_PPN_SHIFT;
    ...
    base = ppn << PGSHIFT;

does not overflow.  (Which is the part of the page table walk that I thought I
had gleaned from the patch without actually reading the entire function.)


r~

