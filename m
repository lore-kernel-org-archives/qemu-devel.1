Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B1CC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 06:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20F520873
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 06:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJPJmhqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20F520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hETV3-0004Fw-La
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 02:47:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hETTk-0003gw-4z
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hETTj-0004wZ-4P
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:46:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hETTh-0004pK-H8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:46:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id d31so3034538pgl.7
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 23:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vphTg/5J9aJPu+UYhedTSJeU4r8aszPQKrw4V9Qscww=;
	b=jJPJmhqh4A1k5kC+vfIiLFDZKIJXLLwQPPKqloj3f2AesS1rFpnTSCXPdTNb15FnYz
	f6gyXSTySKQ5Logg76KCM7W/EbpFIURB+kp2ivkLDbJeYtY3U2nHJ7KTczuXqLqRpVx0
	+kkKckoG50gUfolrw3FwERInlZes5IdmrrSq7qgII3vP8MKyi7ucb5asajLiGQYbmDhv
	lHnMb4HiY8LCZs3+cUNbAgzT3U/9vLDkyo4zlGzt4S3x36rgVxE5ZGfQ5BaroX7f3aax
	kB745fh3xtYExv9Fo6vWHTYWcbq6aTbGOzgQpJv2uUfYXRbyXpCUb9PblE5OXK0hiRoY
	DPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=vphTg/5J9aJPu+UYhedTSJeU4r8aszPQKrw4V9Qscww=;
	b=e+J594QYCp/pknj0sWOIbeNBkIQUl38Lzx7udT08m+EiE/nlib9+IF01yQxy9XLswJ
	D5QK+zPtBPIUFCVkrPSRweJrQG8IRxkUTOKSKlX8xgidpxWjujBPtX5o8EFG2rHd30fJ
	9w0o9ZHi41OXu2JbI1Q1s7pKUmB8UFTqNdn/MqFQn7UmMflfo1Y0MPN0XUb7oBV1VRc6
	3WyPEomQf+cmIsntWIkzSsKU8rPC9fRWN5Kiwaqjwu6kpEjym/3rj99fEGrZ61ayzn6V
	j7S0W/tgVwxFmFqFVZcDnRBHEBhYC3vcM7y8i2q+oGW0hjfTvOYsOMvkFqias7QFk+Q2
	8u4A==
X-Gm-Message-State: APjAAAXRNCpPR+r7KwcDw6fQaNvhzTx0XlvwfJMYru+H1fotmTx1Gd8e
	wK8hN4zcSBUuwGB1QIRVT2k=
X-Google-Smtp-Source: APXvYqyNzZqUYWPZ1IBDnWQd24Q0cDcE1OrJunktwrG6rZ519qM0KFnZOAp6O0BTJ37RPprikMfpJQ==
X-Received: by 2002:a63:2c06:: with SMTP id s6mr45576805pgs.245.1554965184174; 
	Wed, 10 Apr 2019 23:46:24 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.googlemail.com with ESMTPSA id
	p66sm51502975pfb.4.2019.04.10.23.46.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Apr 2019 23:46:23 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20190410194838.10123-1-sw@weilnetz.de>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
	mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
	n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
	rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
	Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
	n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
	AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
	CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
	cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
	Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
	eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
	LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
	Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
	94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
	86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
	I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
	VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
	+PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
	AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
	Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
	prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
	/E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
	jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
	VcROBqvtH3ecaIL9iw==
Message-ID: <46e4ee2d-f991-1910-db15-0ec216ab9cab@twiddle.net>
Date: Wed, 10 Apr 2019 20:46:19 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410194838.10123-1-sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: Re: [Qemu-devel] [PATCH] tci: Add implementation for
 INDEX_op_ld16u_i64
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411064619.Tnu9JAYeg13mLZQDlm91b5BJo3D0fQse6d5m-4uOEls@z>

On 4/10/19 9:48 AM, Stefan Weil wrote:
> @@ -127,6 +127,12 @@ static void tci_write_reg8(tcg_target_ulong *regs, TCGReg index, uint8_t value)
>      tci_write_reg(regs, index, value);
>  }
>  
> +static void
> +tci_write_reg16(tcg_target_ulong *regs, TCGReg index, uint16_t value)
> +{
> +    tci_write_reg(regs, index, value);
> +}
> +
>  static void
>  tci_write_reg32(tcg_target_ulong *regs, TCGReg index, uint32_t value)
>  {
> @@ -854,7 +862,14 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
>              tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
>              break;
>          case INDEX_op_ld8s_i64:
> +            TODO();
> +            break;
>          case INDEX_op_ld16u_i64:
> +            t0 = *tb_ptr++;
> +            t1 = tci_read_r(regs, &tb_ptr);
> +            t2 = tci_read_s32(&tb_ptr);
> +            tci_write_reg16(regs, t0, *(uint16_t *)(t1 + t2));
> +            break;

Looks ok, I guess, although the introduction of tci_write_reg16 seems redundant
with the uint16_t value that is loaded.

Why not use tci_write_reg64, since that is the size of the register you're
modifying?  Let the zero-extension explicit in the name of the opcode to be
reflected in the zero-extension implied by the passing of a uint16_t value to a
uint64_t argument.


r~

