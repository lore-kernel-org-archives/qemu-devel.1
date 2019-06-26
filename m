Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1474BC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944162086D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dltpabG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944162086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2fo-0007v9-JM
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 03:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hg2cg-0006yi-Fl
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hg2cf-0002Yr-HH
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:45:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hg2cf-0002Wx-9N
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:45:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so995255wma.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AHAYtpXS6tbhYpLHicsJ2dyXjw4uT8PBxdOaQEPRrT4=;
 b=dltpabG4/k58lXThklNl0SVdASy35r/tpKYULe5t6ER7yJRkR3Ab0c3ZdHDeGQXhvc
 T1rBqu2MQR5Fdy27ngyr5cjrjPQjLCNRvQUaB2PXt2AkcDCRniVtc2JdfnABwaCjZPFq
 QjI1nIXzCf567kYFKFgEQoRX8nsZfifw0jfnZGx0JayJXfzwPzqNRPimmIFwh+fqBJYD
 vRIeeNRQBd9VNRKXGJaHCYspSfFZF/eXI2Isdg2eSL2j0+eoV2xXrDB+KaNbARjwVdyW
 qpd0GMy63KMVAuELiJ6bDKoyLHEpC7MA6G+39sbppN/h1yJkBFOwxy5Xr7pXblhxOzHT
 1TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AHAYtpXS6tbhYpLHicsJ2dyXjw4uT8PBxdOaQEPRrT4=;
 b=hv0yI+QsywW2yEu2v2QJPfs4NtCEOFht3D9qyJeexckFJn4QLbhaBj/9BmhhWzYU0x
 ZMJYourSpxocWGS4RR63xNqzk4ONtpB1b8M/RVer/EiRoW6DrD7+wv6AfYkmvkuRa5Ia
 Ex+Xsz+LJkHu/stw8S8D0fzAsn2j2nYuCQN9U6YbzXjiYyf3hFXWZOiKYoPqVDV0dKX+
 TaPIkfB74oXbSWDPpxGcU+nmfBF0j3gkRA4UziTJjLGBI3J/T+P70O0FiObuLnE3Nx0w
 p7vh/ykSMk2ZIDgbB9s3h6i2NI0QYItOi4Q9OVmj01Zu5ql+ekDJXuzvh8b0fBk64Sjr
 /78Q==
X-Gm-Message-State: APjAAAWgfdsS8kNc8LgshRv0a6GLG8hIifa9fmiKJ9mIcFsKmi9hAdCR
 bn2J67mtrEFLNd11qV4RZlI4Sg==
X-Google-Smtp-Source: APXvYqySPR8xEVQWnYdt2QSfYaLRlU/mHGKYNdNHQvbFrEq0/M2nCxgd/2oydgNaley1IfMs3+Z5rA==
X-Received: by 2002:a1c:bbc1:: with SMTP id l184mr1582503wmf.111.1561535138773; 
 Wed, 26 Jun 2019 00:45:38 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id n14sm35766786wra.75.2019.06.26.00.45.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 00:45:38 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
 <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
 <d2c1f979-7ff2-946e-4863-c1be19c5f003@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <16f26b7f-2435-aa05-66a3-073e8310d5c8@linaro.org>
Date: Wed, 26 Jun 2019 09:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d2c1f979-7ff2-946e-4863-c1be19c5f003@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 7:55 PM, Mark Cave-Ayland wrote:
> And here's where we are blowing up according to -d in_asm,op_out_asm:
> 
> IN:
> 0x00f22ca0:  101ffc84  vor      v0, v31, v31
> 
> OP:
>  ld_i32 tmp0,env,$0xfffffff8
>  movi_i32 tmp1,$0x0
>  brcond_i32 tmp0,tmp1,lt,$L0
> 
>  ---- 00f22ca0
>  ld_vec v128,e8,tmp2,env,$0xd6b0
>  st_vec v128,e8,tmp2,env,$0xd4c0

Yep, that looks right.

As an aside, this does suggest to me that target/ppc might be well served in
moving the ppc_vsr_t members of CPUPPCState earlier, so that this offset is
smaller.

>  movi_i32 nip,$0xf22ca4
>  movi_i32 nip,$0xf22ca4
>  movi_i32 tmp0,$0x10002
>  call raise_exception,$0x2,$0,env,tmp0

And this, presumably is the single-step debug exception.

> 0xa4e7f12c:  3c400000  lis      r2, 0
> 0xa4e7f130:  6042d6b0  ori      r2, r2, 0xd6b0
> 0xa4e7f134:  7c5b10ce  lvx      v2, r27, r2

> 0xa4e7f138:  3c400000  lis      r2, 0
> 0xa4e7f13c:  6042d4c0  ori      r2, r2, 0xd4c0
> 0xa4e7f140:  7c5b11ce  stvx     v2, r27, r2

These also look correct.  Form an offset into r2, load or store from env+r2.

This also shows what I mention above re offset.  For a ppc host, the offset is
large enough to require two instructions to form them.

> Any ideas what might be going on here?

What is the observed problem that makes you think that this is the incorrect
instruction?


r~

