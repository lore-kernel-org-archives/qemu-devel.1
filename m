Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BB3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6582F207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6582F207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjf7z-00036k-Ob
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jjf6f-0001bp-LZ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:32:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53131)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jjf6d-0003Gs-Hr
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:32:09 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MuUvU-1isWYB2ifq-00rX4M; Fri, 12 Jun 2020 10:31:50 +0200
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
Message-ID: <1f4d93eb-0b89-5189-0147-3a456197cc0d@vivier.eu>
Date: Fri, 12 Jun 2020 10:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+7G2Q3lFLjnBJE0K1Iiqcq4DTiJMKk+ReL076jH0NEPQdiGDzbS
 QUTqmZ0j1nsq0DitPXI9jOT0G23HCaiBR4pQQHcNL5MWNkX8MBX72zGRU7BQq7vfaOdOBfI
 L4i50+h9Ff9Kx/0LSXcd+kFnJa+ys6pDQ5IIeNO0yQmvQ0pPo2I49PQ26ZSZn8x+sOvfopl
 lnvxypVl92tXIh6yLqL1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s/XgXOyXC80=:HNp94Mv6aDI8TqfPMZiYyL
 inwecXmKkGDELJPL6cVZa+xLXOTETk/ZvwsxwhdUbJk55mUjLTvC/uTfXxbZ7dROX3MXMQOm2
 rST74Yj8lAcHbaWcbXR7vgXwP5TGcxqLIBk887cNV2FpWXWzvwNpcBBc21auKP1jMn0Tjqb6w
 y4UcXgYul4szsBvqjvQ0kb2q+BlMZMEfYf30gRXSK/kzS0lLcnzsaGYoSpo+rkbKnlyqzjhcL
 gXF/jmrv1xMYSsAQFmkLDf0/TlSuo08b9Zm/RUgQLeegbSHb+h0y+LaDc0HvkO32t0u/IGvNU
 qTjnKIcTHiOyv7oRoJdcbmcwMUPTISUPLVSOk3GYuQ+F9cMgDDmEzrYOTTSxlufJ0cEHZQNz+
 hWZBP7R7VWDsQMM5XtCNlxx4eh4vHWtrgz5kDwDDt8ZEM7fAfRsky4Zlxahm0VIbtiSz/wbBi
 6x6XUv9a3/1b99QDrnTWgp78wMmv6woX63iNDavvQbZwSEXFoXdht6TzDtp+s08+jjH+W5FuV
 uy7dRxH/aYQcETiPenUutwLCqNUuHTrPLn/R7hXWYgCbZ4S5GvLaZIJ41nqZ6owlKqQn1pbSs
 AImMntmQXV0bQcXHa7f8DFFZXr3cyHsvKfN4cOLpzzLhqqvHpsSHbWtIqVccI/7R/Zsu8diHa
 Yu5XP3ML4CCHqDfCH7T+nVz5ceMMeQ2WnQaD2nsPchOYpmUPy88JWaG2hlTFjcYMgYDKoEXdY
 92YA5lpBfjYmTjkCb7bLVtTUn83pi5IPUSFkAd15fEAzp+fvuJnuUeWBVXcXsABjLr0LAOuNV
 57KDjQ9VlllCMv5jXtsVZY+CbZSRLZbWxYDqXaCh4BzhnxY7lHP34S4E8d/F6p6ReMyJqai
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:32:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/04/2020 à 19:17, KONRAD Frederic a écrit :
> The MC68881 say about infinities (3.2.4):
> 
> "*For the extended precision format, the most significant bit of the
> mantissa (the integer bit) is a don't care."
> 
> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
> 
> The m68k extended format is implemented with the floatx80 and
> floatx80_invalid_encoding currently treats 0x7fff00000000000000000000 as
> an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
> accepts that the most significant bit of the mantissa can be 0.
> 
> This bug can be revealed with the following code which pushes extended
> infinity on the stack as a double and then reloads it as a double.  It
> should normally be converted and read back as infinity and is currently
> read back as nan:
> 
>         .global _start
>         .text
> _start:
>         lea val, %a0
>         lea fp, %fp
>         fmovex (%a0), %fp0
>         fmoved %fp0, %fp@(-8)
>         fmoved %fp@(-8), %fp0
> end:
>         bra end
> 
> .align 0x4
> val:
>         .fill 1, 4, 0x7fff0000
>         .fill 1, 4, 0x00000000
>         .fill 1, 4, 0x00000000
> .align 0x4
>         .fill 0x100, 1, 0
> fp:
> 
> -------------
> 
> (gdb) tar rem :1234
> Remote debugging using :1234
> _start () at main.S:5
> 5              lea val, %a0
> (gdb) display $fp0
> 1: $fp0 = nan(0xffffffffffffffff)
> (gdb) si
> 6             lea fp, %fp
> 1: $fp0 = nan(0xffffffffffffffff)
> (gdb) si
> _start () at main.S:7
> 7              fmovex (%a0), %fp0
> 1: $fp0 = nan(0xffffffffffffffff)
> (gdb) si
> 8             fmoved %fp0, %fp@(-8)
> 1: $fp0 = inf
> (gdb) si
> 9             fmoved %fp@(-8), %fp0
> 1: $fp0 = inf
> (gdb) si
> end () at main.S:12
> 12          bra end
> 1: $fp0 = nan(0xfffffffffffff800)
> (gdb) x/1xg $fp-8
> 0x40000120 <val+260>:   0x7fffffffffffffff
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  include/fpu/softfloat.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index ecb8ba0..dc80298 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -688,7 +688,12 @@ static inline int floatx80_is_any_nan(floatx80 a)
>  *----------------------------------------------------------------------------*/
>  static inline bool floatx80_invalid_encoding(floatx80 a)
>  {
> +#if defined(TARGET_M68K)
> +    return (a.low & (1ULL << 63)) == 0 && (((a.high & 0x7FFF) != 0)
> +                                           && (a.high != 0x7FFF));
> +#else
>      return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
> +#endif
>  }
>  
>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
> 

According to "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL" the explicit
integer bit is "Don't care" for signed infinite (a.high == 0x7FFF) (this
is the case this patch manages).

But wit a zero exponent and a non zero mantissa, it's a denormal number,
and a signed zero has also a zero explicit integer bit but a zero
mantissa. (both cases are already managed in the existing code).

with a non zero exponent less than the maximum value it's an unnormal
number.

The denormal and unnormal numbers must be managed during the load
operation in the m68k TCG emulation to generate directly the FP_UNIMP
exception.

So I think, in the end, we don't have invalid number at softfloat level
and floatx80_invalid_encoding() should always return "false" for
TARGET_M68K.

Thanks,
Laurent

