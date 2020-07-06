Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC66C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E3320722
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E3320722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsQdi-00080E-AP
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 08:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsQdB-0007aG-Dr
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:53:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsQd9-0005jb-GI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:53:57 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MrgcU-1kg4jK3mXE-00ndvW; Mon, 06 Jul 2020 14:53:35 +0200
Subject: Re: [PATCH] softfloat,m68k: disable floatx80_invalid_encoding() for
 m68k
To: qemu-devel@nongnu.org
References: <20200612140400.2130118-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0de98ebb-288b-1831-6c1b-cdc64690df92@vivier.eu>
Date: Mon, 6 Jul 2020 14:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612140400.2130118-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tIBnlx64Zr/BTuJ8Uy/ve3I6LTeCHnPCYPhJ6tCpPjToKNoju3t
 ll8QuguPSaWgvSsASxcF2IicnTguEfUAJrZeLVWX41nCbb3LXTYWZuhJFaCzxLQ8V2LSbzO
 qI1QJ+qg+9wx6Q8kggX4gN87U7zACwItMA/lFrnd4LjtOhD1ja/iCr2S4SRwpL/I6ivQB3M
 1W/WDr7RIivuJc+F0nMWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1ts8SeVOayQ=:AxuRMB49TueREeR94fCmfI
 BKVWf6VF+ZXyLE6PvyY+phQZv1TRjtCFS0Eu2Eoh+rDmGw0zb784f0Iv9uN3V4pTBKDmd3K53
 zQUFB8Y61J+U/8FxrJSftLDOq8V2afIEFVZKhlr9u/XcdMPp9GtjIOOLOO25tpMrgFdwGRvIi
 92hlID6SSBy/a0XOPSYYY9tp87SkDPDtCTqstJLZv2U4pJzqFIIVMRrh3wBaxGUOWLCStui0D
 ByZKQzQV7GZ6sKsI2TdmWq5ONhOP1Iz0tEhQsn8flgh3tNlR8QPbwh9F6PbG48rpBA01cp8Eq
 90sKxqWAxaHqf23uHWd3CUEP1UV55dsqoh3iZWA4lKv6uLzWgMZzqcyM4B6wtyX3PxlIdIYW6
 iPJYjzM/9C5dR3b+c5jI7zUa2EHfqWFNYROkZ2uBDRo4HIY7ienGFGp+ksvHeKIIPaP3w7mWN
 769O0jzNDCvWORu1rY8MnMgZ/yL0oFQ7745Dg09Jy+4zFAC4ITe6OqtFmQr1Ilkd19QLN/Ng9
 6hBsx6wveS8rIhfxcDZJ1Gfs0EGABwk9sNhZ5Cb0BPJZ58ec6r5LBmgCqWqJMcK4e8lNoHe7O
 zMb8v3F7BFZWC6TBsVb+dP98GheAZj5ahyiPvB8GYVwmWvdldViB6amlysnHKqgnh6XnbhLkY
 NbXHZ8tqZrYVL4xUzCRCEGygwz38TUseaK12t1jBUcqIdDvJ64hBjztyVts+2DFIpXU7UZlGC
 SA2Qw+bPDpCaA3kznl6DRBRZMTx7o+T4sRE+2lXnlLY5EA8pIZEVYly71cHyCdDIZ3SjK8/yf
 pZLyTYLzBC4+aZY+5ocCMbagex0xJw3jqUUzdCNUk6AX41LMG8N5GdQqAo2FAuq4OFoGa0j
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 08:53:52
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Pierre Muller <pierre@freepascal.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

any comments from FPU emulation maintainers?

Thanks,
Laurent

Le 12/06/2020 à 16:04, Laurent Vivier a écrit :
> According to the comment, this definition of invalid encoding is given
> by intel developer's manual, and doesn't comply with 680x0 FPU.
> 
> With m68k, the explicit integer bit can be zero in the case of:
>  - zeros                (exp == 0, mantissa == 0)
>  - denormalized numbers (exp == 0, mantissa != 0)
>  - unnormalized numbers (exp != 0, exp < 0x7FFF)
>  - infinities           (exp == 0x7FFF, mantissa == 0)
>  - not-a-numbers        (exp == 0x7FFF, mantissa != 0)
> 
> For infinities and NaNs, the explicit integer bit can be either one or
> zero.
> 
> The IEEE 754 standard does not define a zero integer bit. Such a number
> is an unnormalized number. Hardware does not directly support
> denormalized and unnormalized numbers, but implicitly supports them by
> trapping them as unimplemented data types, allowing efficient conversion
> in software.
> 
> See "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL",
>     "1.6 FLOATING-POINT DATA TYPES"
> 
> We will implement in the m68k TCG emulator the FP_UNIMP exception to
> trap into the kernel to normalize the number. In case of linux-user,
> the number will be normalized by QEMU.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  include/fpu/softfloat.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 16ca697a73b7..f6eda4ca8e6c 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -791,7 +791,31 @@ static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
>  *----------------------------------------------------------------------------*/
>  static inline bool floatx80_invalid_encoding(floatx80 a)
>  {
> +#if defined(TARGET_M68K)
> +    /*-------------------------------------------------------------------------
> +    | With m68k, the explicit integer bit can be zero in the case of:
> +    | - zeros                (exp == 0, mantissa == 0)
> +    | - denormalized numbers (exp == 0, mantissa != 0)
> +    | - unnormalized numbers (exp != 0, exp < 0x7FFF)
> +    | - infinities           (exp == 0x7FFF, mantissa == 0)
> +    | - not-a-numbers        (exp == 0x7FFF, mantissa != 0)
> +    |
> +    | For infinities and NaNs, the explicit integer bit can be either one or
> +    | zero.
> +    |
> +    | The IEEE 754 standard does not define a zero integer bit. Such a number
> +    | is an unnormalized number. Hardware does not directly support
> +    | denormalized and unnormalized numbers, but implicitly supports them by
> +    | trapping them as unimplemented data types, allowing efficient conversion
> +    | in software.
> +    |
> +    | See "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL",
> +    |     "1.6 FLOATING-POINT DATA TYPES"
> +    *------------------------------------------------------------------------*/
> +    return false;
> +#else
>      return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
> +#endif
>  }
>  
>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
> 


