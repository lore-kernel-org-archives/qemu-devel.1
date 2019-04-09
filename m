Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741B0C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 17:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8262084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 17:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alpAA/+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8262084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDuOG-00051L-FJ
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 13:18:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDuNL-0004jd-8W
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDuNH-00076b-IW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:17:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDuNF-00072n-G6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:17:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id a6so14237904oie.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=uEAvccO/yM4QJsRT42Ti+l6/7cgrQIjkSF+DXdmggIg=;
	b=alpAA/+v+dBfbREUKNkJsjdVw9lik37BlTxvgQ9X79HP0anzGgmYkhYjCzkOLcFmmP
	806zwnNXvCWSIOaQp4nqmXy9gJsP6D8ZksiGfEHggDPeloUcWOY4R9Um4rTmNfmW5C+o
	Ob8XXOdDP+zeIQEllMyTy1kNH2kdIHP1izqZnuLaZXfzGJqgw5MC39ho1zgqvmM56GLB
	0D5O9FFlensxH4EWVjlrqT41JUI0UWSmABHfSB9nrhERo90VwCTLhPYgwUn5zrHlccz2
	ttodKBPooOViiJytm0ynitwdfbuUpB1Zt3fmyTgxrL4a2/TtuLEKWvKPxto6IM2zAVQk
	IroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=uEAvccO/yM4QJsRT42Ti+l6/7cgrQIjkSF+DXdmggIg=;
	b=oNiRZBRqLqheXWzX06MzI+IXEsXK8qLVO3DkEb2Pp/RqGL3c3Kul601VFXVBwavLiG
	O3C48hSmflhRxEPa3TAe6kH33fYVu/XnzTKRFqRzaq3rrtUyAFm5ojvGMPQ3ThenVhjg
	QdWr3gp1qHbAL24Ti/mPOTEexeBTxGKxT7CjvvYFrlk62rc6fXLlCXVv5SQ4joIBmMor
	SEp3Lcr2rK9LkT7Zcw0FNt6SEYPvUWoqNi1JtPuaDj0z5Erm56v6Z2LJ0Demfkl26NZu
	JDNP0XMZCiGNyb8JheCZ50G7xbaACqZn6D8aa1mnRjjk2bfHtDuGAiCokAyWrYsJbo6M
	L7VA==
X-Gm-Message-State: APjAAAUcWJgzMkIAVbz96qcLUeNadKiADLwIMbeEgyxwuVbvcBt3WLhL
	VjFWQFD/aDC3Qf+a3Hpf9Zbrz1xvlFW1aORFZI7Auw==
X-Google-Smtp-Source: APXvYqy13xB6eS/f8Lv6kyZ1ZV9UzVTaNH4TNktFBoVYezbQiyEhFyYjlT2w9IGIkBtfp42Ym2926DtQlbq2D4JnG/k=
X-Received: by 2002:aca:e054:: with SMTP id x81mr20255619oig.146.1554830246202;
	Tue, 09 Apr 2019 10:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190409060435.22801-1-sw@weilnetz.de>
	<4a16a810-9806-3a76-7d17-1b6282296502@linaro.org>
	<69be6fec-e9b5-d72b-d626-cf3d4b9f3720@weilnetz.de>
In-Reply-To: <69be6fec-e9b5-d72b-d626-cf3d4b9f3720@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 18:17:15 +0100
Message-ID:
 <CAFEAcA8=uuxAOS5PxXmuEGYqiXA+CAto-AZHSnBsQr6fbtwMYw@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] tci: Fix some unaligned memory accesses
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409171715.054zOE0SYrRkHwIFa-MKL9bcUmbr_jLaUKAdXitqhes@z>

On Tue, 9 Apr 2019 at 18:04, Stefan Weil <sw@weilnetz.de> wrote:
>
> On 09.04.19 08:58, Richard Henderson wrote:
> > On 4/8/19 8:04 PM, Stefan Weil wrote:
> >>  static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
> >>  {
> >> -    tcg_target_ulong value = *(tcg_target_ulong *)(*tb_ptr);
> >> +    tcg_target_ulong value;
> >
> > Ideally these would use the helpers from "qemu/bswap.h", ldl_he_p(), etc.

> That would require adding a helper for tcg_target_ulong to qemu/bswap.h.
> Or tci.c would need conditional code for reading a tcg_target_ulong.
>
> Those helpers in qemu/bswap.h are also a little bit strange:
>
> - Why does lduw_he_p return an int instead of an uint16_t?
> - Why does ldsw_he_p return an int instead of an int16_t?
> - Why does ldl_he_p return an int instead of an int32_t?

Some of these are for historical reasons (ie their API was
designed in a world where the callers were typically throwing
values around in "int"s rather than carefully using exact
right-sized types). If you want to assign the results to a
uint16_t/int16_t/int32_t this will work fine (and no cast is
required).

> - Should ldl_he_p be renamed into ldsl_he_p?
>   And why is ldul_he_p missing?

The assumption is that for 32-bit accesses there is no need
to care about the signedness of the load because the result
is going into a 32-bit variable anyway and so there is no
extension of any kind to be done.

> - Should ldq_he_p be renamed into lduq_he_p?
>   And why is ldsq_he_p missing?

Similarly here the value is being returned as a 64-bit
quantity, so there is no question of whether it should
be sign or zero extended as it isn't being extended at all.

> Using the helpers might require nasty type casts to avoid compiler
> warnings because of signed / unsigned and size mismatches.
>
> Aren't the few memcpy statements in the TCI helpers much more direct and
> understandable?

In general, no. "memcpy is a way to do an efficient possibly-unaligned
access" is an obscure bit of knowledge. We deliberately abstract this
away into these helper functions which provide APIs which are more
clearly "we need to perform a possibly-unaligned load of a specified
endianness". (It also means that if it turns out that we would
rather use __builtin_memcpy() rather than memcpy(), as we've just
discovered we need to, then there's only one file to change rather
than many.)

thanks
-- PMM

