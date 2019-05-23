Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F6AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7151720879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JW6Cqw1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7151720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnIj-0005H0-Mi
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:58:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnGZ-0003dW-U7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTn7R-0004XM-H8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:46:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTn7R-0004WE-AQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:46:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id u199so4238558oie.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=AsBS4oVOeojYbjuWUdTap0VWJ4pMUj7Q0i0CJbRKnJU=;
	b=JW6Cqw1ANEYIuDxcIjTs9Lbk2D8qgaoanjCRdllbTEM34FP2X9NfW5QAMnC3oI1MDl
	ab8hki7tWZkvcQWRf1sy2ndpMhJx7MBtex+YH6hBemiFasWf06q93FGRPLJSouzrxyV4
	Vm9Rdo156Z4mjS9W0Ef3k9tvacBNZya7V8ZCS2TBKlp8dTz567rgba4uyf7Vl4mef6db
	2pULHjJH8V25Ex3nuMa8qaevrmKK5hZg0TNHGovUraNCedmRKobBOaWZq3nPloCNtajK
	vfp5XkWFK4rrr6PBoP9ETO5l/ZraS966SLkPTRwvA4Qcty8vIOUSuIW44nZFoSab1OvS
	Zhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=AsBS4oVOeojYbjuWUdTap0VWJ4pMUj7Q0i0CJbRKnJU=;
	b=AhhO6VYuGeUfQdjzwwwYAc8BC1SFqfM7ho5hWWf1j9R2VB8G4omFk+5bEzotZu0/Oy
	xHt5Y4hhfMIQQjOd59ZetG18ulOv+npSJrPUC8isRRXrhmR5icGjChrSH0hiqFajZ+p5
	r3d5ONMU6BP1KP0yjN/kDWyyVBa4ymT2xsBkwNYjB+Wce/sr9KLglAa3DwrdYHg0b2gi
	c+F9Nq5be3WXpjFF4fS8puvpJhlNku82Y8qSOQ4mza58ZmzRM9Fom+e2Umr7J3PsSyIz
	/h6fM1QLqiO18dTP+jbYK9sDsc0C/kHaWNljzb+uCtia2VkRICazAL8MqfjfEYb7h8z4
	G1OA==
X-Gm-Message-State: APjAAAX8hn4J7e01u6KcYjypl7kFWjOFz0z2QB2mi5J+89uH5KSbxSer
	FeCpT/XLhOe/gid2BkTgWnTrQuc5rkjSiZjtob+6bQ==
X-Google-Smtp-Source: APXvYqyPFcqYHAUEMQ5az4AyU2zuLxDymgJszY0HR8ImCCahTF2Xk7tJrhYDUzx7qvHlxDWV0ZPsYM0OmTyQjDbrA8Q=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr2668566oib.170.1558615607104; 
	Thu, 23 May 2019 05:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190518191934.21887-1-richard.henderson@linaro.org>
	<20190518191934.21887-3-richard.henderson@linaro.org>
In-Reply-To: <20190518191934.21887-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 13:46:36 +0100
Message-ID: <CAFEAcA88nA_2u1Yc-9ZPAy2w6LVk5f9Rrss0e53E11W4Xb4YpA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Use tcg_gen_gvec_bitsel
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 May 2019 at 20:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This replaces 3 target-specific implementations for BIT, BIF, and BSL.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> @@ -10916,13 +10925,13 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
>          return;
>
>      case 5: /* BSL bitwise select */
> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bsl_op);
> +        gen_gvec_fn4(s, is_q, rd, rd, rn, rm, tcg_gen_gvec_bitsel, 0);
>          return;
>      case 6: /* BIT, bitwise insert if true */
> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bit_op);
> +        gen_gvec_fn4(s, is_q, rd, rm, rn, rd, tcg_gen_gvec_bitsel, 0);
>          return;
>      case 7: /* BIF, bitwise insert if false */
> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bif_op);
> +        gen_gvec_fn4(s, is_q, rd, rm, rd, rn, tcg_gen_gvec_bitsel, 0);
>          return;

We were previously doing different operations for these three
different instructions. Now we seem to always be doing the same
thing but with randomly reshuffled register arguments. How
does this work ?


thanks
-- PMM

